Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934317AbeEWV32 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 17:29:28 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34213 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933195AbeEWV30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 17:29:26 -0400
X-Google-Smtp-Source: AB8JxZrlTlHV2vsS0HZCEJPPXGwHvzsWHmxrkJCsFhSzf95+xcI35PbJ+erKPSDWA5xUshG7az4Wzg==
Subject: Re: [PATCH] bdi: Move cgroup bdi_writeback to a dedicated low
 concurrency workqueue
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Jan Kara <jack@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
        kernel-team@fb.com
References: <20180523175632.GO1718769@devbig577.frc2.facebook.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <82f07e3e-44a7-e05e-ed98-15cd7acba600@kernel.dk>
Date: Wed, 23 May 2018 15:29:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180523175632.GO1718769@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/18 11:56 AM, Tejun Heo wrote:
> From 0aa2e9b921d6db71150633ff290199554f0842a8 Mon Sep 17 00:00:00 2001
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

Applied, thanks.

-- 
Jens Axboe
