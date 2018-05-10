Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933443AbeEJCFy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 22:05:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40886 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756088AbeEJCFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 22:05:46 -0400
Date: Wed, 9 May 2018 19:04:51 -0700
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Mel Gorman <mgorman@techsingularity.net>
Cc: mingo@kernel.org, peterz@infradead.org, torvalds@linux-foundation.org,
        tglx@linutronix.de, hpa@zytor.com, efault@gmx.de,
        linux-kernel@vger.kernel.org, matt@codeblueprint.co.uk,
        ggherdovich@suse.cz, mpe@ellerman.id.au
Subject: Re: [PATCH] Revert "sched/numa: Delay retrying placement for
 automatic NUMA balance after wake_affine()"
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20180509163115.6fnnyeg4vdm2ct4v@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180509163115.6fnnyeg4vdm2ct4v@techsingularity.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18051002-0044-0000-0000-00000550FA4F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051002-0045-0000-0000-00002892448D
Message-Id: <20180510020451.GB41120@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-09_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805100017
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mel Gorman <mgorman@techsingularity.net> [2018-05-09 17:31:15]:

> This reverts commit 7347fc87dfe6b7315e74310ee1243dc222c68086.
> 
> Srikar Dronamra pointed out that while the commit in question did show
> a performance improvement on ppc64, it did so at the cost of disabling
> active CPU migration by automatic NUMA balancing which was not the intent.
> The issue was that a serious flaw in the logic failed to ever active balance
> if SD_WAKE_AFFINE was disabled on scheduler domains. Even when it's enabled,
> the logic is still bizarre and against the original intent.
> 
> Investigation showed that fixing the patch in either the way he suggested,
> using the correct comparison for jiffies values or introducing a new
> numa_migrate_deferred variable in task_struct all perform similarly to a
> revert with a mix of gains and losses depending on the workload, machine
> and socket count.
> 
> The original intent of the commit was to handle a problem whereby
> wake_affine, idle balancing and automatic NUMA balancing disagree on the
> appropriate placement for a task. This was particularly true for cases where
> a single task was a massive waker of tasks but where wake_wide logic did
> not apply.  This was particularly noticeable when a futex (a barrier) woke
> all worker threads and tried pulling the wakees to the waker nodes. In that
> specific case, it could be handled by tuning MPI or openMP appropriately,
> but the behavior is not illogical and was worth attempting to fix. However,
> the approach was wrong. Given that we're at rc4 and a fix is not obvious,
> it's better to play safe, revert this commit and retry later.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>


Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
