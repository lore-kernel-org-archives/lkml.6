Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933943AbeEIK61 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 06:58:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36512 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933858AbeEIK6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 06:58:25 -0400
Date: Wed, 9 May 2018 03:58:14 -0700
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Mel Gorman <mgorman@techsingularity.net>
Cc: torvalds@linux-foundation.org, tglx@linutronix.de, mingo@kernel.org,
        hpa@zytor.com, efault@gmx.de, linux-kernel@vger.kernel.org,
        matt@codeblueprint.co.uk, peterz@infradead.org, ggherdovich@suse.cz,
        linux-tip-commits@vger.kernel.org, mpe@ellerman.id.au
Subject: Re: [tip:sched/core] sched/numa: Delay retrying placement for
 automatic NUMA balance after wake_affine()
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20180213133730.24064-7-mgorman@techsingularity.net>
 <tip-7347fc87dfe6b7315e74310ee1243dc222c68086@git.kernel.org>
 <20180507110607.GA3828@linux.vnet.ibm.com>
 <20180509084148.qzpsetz74pkg7g33@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180509084148.qzpsetz74pkg7g33@techsingularity.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18050910-0044-0000-0000-00000550BE43
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050910-0045-0000-0000-000028920575
Message-Id: <20180509105814.GA41120@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-09_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805090105
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mel Gorman <mgorman@techsingularity.net> [2018-05-09 09:41:48]:

> On Mon, May 07, 2018 at 04:06:07AM -0700, Srikar Dronamraju wrote:
> > > @@ -1876,7 +1877,18 @@ static void numa_migrate_preferred(struct task_struct *p)
> > >
> > >  	/* Periodically retry migrating the task to the preferred node */
> > >  	interval = min(interval, msecs_to_jiffies(p->numa_scan_period) / 16);
> > > -	p->numa_migrate_retry = jiffies + interval;
> > > +	numa_migrate_retry = jiffies + interval;
> > > +
> > > +	/*
> > > +	 * Check that the new retry threshold is after the current one. If
> > > +	 * the retry is in the future, it implies that wake_affine has
> > > +	 * temporarily asked NUMA balancing to backoff from placement.
> > > +	 */
> > > +	if (numa_migrate_retry > p->numa_migrate_retry)
> > > +		return;
> > 
> > The above check looks wrong. This check will most likely to be true,
> > numa_migrate_preferred() itself is called either when jiffies >
> > p->numa_migrate_retry or if the task's numa_preferred_nid has changed.
> > 
> 
> You're right, without affine wakeups with a wakeup-intensive workload
> the path may never be hit and with the current code, it effectively acts
> as a broken throttling mechanism.

I haven't tried on an x86 box, but still trying to get my head around
that check. How does affine wakeups differ for this check.

Lets say p->numa_migrate_retry was set by wake_affine and task has
crossed that temporary period where we dont want the task to undergo
numa balancing.

Now the task is back at numa_migrate_preferred(); p->numa_migrate_retry
is lesser than jiffies (something like "current jiffies - 100"). It
would always return back from that check.

In the other scenario, where wake_affine set p->numa_migrate_preferred to a
bigger value, the task calls numa_migrate_preferred(),
numa_migrate_preferred  could be before p->numa_migrate_preferred. In
such a case, we should have stopped the task from migration.
However we overwrite p->numa_migrate_preferred and do the
task_numa_migrate(). Somehow this doesn't seem to achieve what the
commit intended.

Or did I misunderstand?

--
Thanks and Regards
Srikar
