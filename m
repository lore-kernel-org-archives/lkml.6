Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934144AbeEWSsz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 14:48:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55876 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933944AbeEWSsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 14:48:53 -0400
Date: Wed, 23 May 2018 11:39:07 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
        kernel-team@fb.com
Subject: Re: [PATCH] bdi: Move cgroup bdi_writeback to a dedicated low
 concurrency workqueue
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180523175632.GO1718769@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523175632.GO1718769@devbig577.frc2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18052318-0016-0000-0000-000008C9CA85
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009073; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01036609; UDB=6.00530312; IPR=6.00815736;
 MB=3.00021262; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-23 18:48:51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052318-0017-0000-0000-00003EDFE9E0
Message-Id: <20180523183907.GZ3803@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-23_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805230183
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 10:56:32AM -0700, Tejun Heo wrote:
> >From 0aa2e9b921d6db71150633ff290199554f0842a8 Mon Sep 17 00:00:00 2001
> From: Tejun Heo <tj@kernel.org>
> Date: Wed, 23 May 2018 10:29:00 -0700
> 
> cgwb_release() punts the actual release to cgwb_release_workfn() on
> system_wq.  Depending on the number of cgroups or block devices, there
> can be a lot of cgwb_release_workfn() in flight at the same time.
> 
> We're periodically seeing close to 256 kworkers getting stuck with the
> following stack trace and overtime the entire system gets stuck.
> 
>   [<ffffffff810ee40c>] _synchronize_rcu_expedited.constprop.72+0x2fc/0x330
>   [<ffffffff810ee634>] synchronize_rcu_expedited+0x24/0x30
>   [<ffffffff811ccf23>] bdi_unregister+0x53/0x290
>   [<ffffffff811cd1e9>] release_bdi+0x89/0xc0
>   [<ffffffff811cd645>] wb_exit+0x85/0xa0
>   [<ffffffff811cdc84>] cgwb_release_workfn+0x54/0xb0
>   [<ffffffff810a68d0>] process_one_work+0x150/0x410
>   [<ffffffff810a71fd>] worker_thread+0x6d/0x520
>   [<ffffffff810ad3dc>] kthread+0x12c/0x160
>   [<ffffffff81969019>] ret_from_fork+0x29/0x40
>   [<ffffffffffffffff>] 0xffffffffffffffff
> 
> The events leading to the lockup are...
> 
> 1. A lot of cgwb_release_workfn() is queued at the same time and all
>    system_wq kworkers are assigned to execute them.
> 
> 2. They all end up calling synchronize_rcu_expedited().  One of them
>    wins and tries to perform the expedited synchronization.
> 
> 3. However, that invovles queueing rcu_exp_work to system_wq and
>    waiting for it.  Because #1 is holding all available kworkers on
>    system_wq, rcu_exp_work can't be executed.  cgwb_release_workfn()
>    is waiting for synchronize_rcu_expedited() which in turn is waiting
>    for cgwb_release_workfn() to free up some of the kworkers.
> 
> We shouldn't be scheduling hundreds of cgwb_release_workfn() at the
> same time.  There's nothing to be gained from that.  This patch
> updates cgwb release path to use a dedicated percpu workqueue with
> @max_active of 1.
> 
> While this resolves the problem at hand, it might be a good idea to
> isolate rcu_exp_work to its own workqueue too as it can be used from
> various paths and is prone to this sort of indirect A-A deadlocks.

Commit ad7c946b35ad4 ("rcu: Create RCU-specific workqueues with rescuers")
was accepted into mainline this past merge window.  Does that do what
you want, or are you looking for something else?

							Thanx, Paul
