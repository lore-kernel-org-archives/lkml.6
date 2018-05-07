Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751960AbeEGLGV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 07:06:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47940 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751818AbeEGLGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 07:06:20 -0400
Date: Mon, 7 May 2018 04:06:07 -0700
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: mgorman@techsingularity.net, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com, efault@gmx.de,
        linux-kernel@vger.kernel.org, matt@codeblueprint.co.uk,
        peterz@infradead.org, ggherdovich@suse.cz
Cc: linux-tip-commits@vger.kernel.org, mpe@ellerman.id.au
Subject: Re: [tip:sched/core] sched/numa: Delay retrying placement for
 automatic NUMA balance after wake_affine()
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20180213133730.24064-7-mgorman@techsingularity.net>
 <tip-7347fc87dfe6b7315e74310ee1243dc222c68086@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <tip-7347fc87dfe6b7315e74310ee1243dc222c68086@git.kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18050711-0040-0000-0000-00000436E8DF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050711-0041-0000-0000-0000263B1CC7
Message-Id: <20180507110607.GA3828@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-07_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805070114
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel,

I do see performance improving with this commit 7347fc87df "sched/numa:
Delay retrying placement for automatic NUMA balance after wake_affine()"
even on powerpc where we have SD_WAKE_AFFINE *disabled* on numa sched
domains. Ideally this commit should not have affected powerpc machines.
That made me to look a bit deeper.

> @@ -1876,7 +1877,18 @@ static void numa_migrate_preferred(struct task_struct *p)
>
>  	/* Periodically retry migrating the task to the preferred node */
>  	interval = min(interval, msecs_to_jiffies(p->numa_scan_period) / 16);
> -	p->numa_migrate_retry = jiffies + interval;
> +	numa_migrate_retry = jiffies + interval;
> +
> +	/*
> +	 * Check that the new retry threshold is after the current one. If
> +	 * the retry is in the future, it implies that wake_affine has
> +	 * temporarily asked NUMA balancing to backoff from placement.
> +	 */
> +	if (numa_migrate_retry > p->numa_migrate_retry)
> +		return;

The above check looks wrong. This check will most likely to be true,
numa_migrate_preferred() itself is called either when jiffies >
p->numa_migrate_retry or if the task's numa_preferred_nid has changed.

Hence we never end up calling task_numa_migrate() i.e we never go thro
the active cpu balancing path in numa balancing.

Reading the comments just above the check, makes me think the check
should have been

	if (numa_migrate_retry < p->numa_migrate_retry)
		return;

Here is perf stat output with 7347fc87df running perf bench numa mem
--no-data_rand_walk 96 -p 2 -t 48 -G 0 -P 3072 -T 0 -l 50 -c -s 1000

          2,13,898      cs                                                            ( +-  2.65% )
            10,228      migrations                                                    ( +- 14.61% )
         21,86,406      faults                                                        ( +-  9.69% )
   40,65,84,68,026      cache-misses                                                  ( +-  0.31% )
                 0      sched:sched_move_numa   <---------------
                 0      sched:sched_stick_numa   <---------------
                 0      sched:sched_swap_numa   <---------------
          1,41,780      migrate:mm_migrate_pages                                      ( +- 24.11% )
                 0      migrate:mm_numa_migrate_ratelimit

     778.331602169 seconds time elapsed


If you look at sched_move_numa, sched_stick_numa, sched_swap_numa
numbers, its very clear that we did try any active cpu migrations.

Same command with the commit reverted

       2,38,685      cs                                                            ( +-  2.93% )
            25,127      migrations                                                    ( +- 13.22% )
         17,27,858      faults                                                        ( +-  2.61% )
   34,77,06,21,298      cache-misses                                                  ( +-  0.61% )
               560      sched:sched_move_numa                                         ( +-  2.05% )
                16      sched:sched_stick_numa                                        ( +- 33.33% )
               310      sched:sched_swap_numa                                         ( +- 15.16% )
          1,25,062      migrate:mm_migrate_pages                                      ( +-  0.91% )
                 0      migrate:mm_numa_migrate_ratelimit

     916.777315465 seconds time elapsed

(numbers are almost same with just that check commented/modified)

So we are seeing an improvement, but the improvement is because of
bypassing the active cpu balancing. Do we really want to by-pass this
code?

> +
> +	/* Safe to try placing the task on the preferred node */
> +	p->numa_migrate_retry = numa_migrate_retry;
>
>  	/* Success if task is already running on preferred CPU */
>  	if (task_node(p) == p->numa_preferred_nid)
> @@ -5759,6 +5771,48 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
