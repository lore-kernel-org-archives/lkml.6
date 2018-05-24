Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969580AbeEXOAO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 10:00:14 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:36564 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965515AbeEXOAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 10:00:13 -0400
X-Google-Smtp-Source: AB8JxZpEho1l9EQle7La5SsE6iMAHoBmvgEnhtTpgWgF0SuzlFdKC33pQGWEp7BCU+kN0XZZitaNDA==
Date: Thu, 24 May 2018 07:00:09 -0700
From: Tejun Heo <tj@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Jan Kara <jack@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
        kernel-team@fb.com
Subject: Re: [PATCH] bdi: Move cgroup bdi_writeback to a dedicated low
 concurrency workqueue
Message-ID: <20180524140009.GB1351649@devbig577.frc2.facebook.com>
References: <20180523175632.GO1718769@devbig577.frc2.facebook.com>
 <20180524101900.m5vqd74rwaqw2pap@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524101900.m5vqd74rwaqw2pap@quack2.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Jan.

On Thu, May 24, 2018 at 12:19:00PM +0200, Jan Kara wrote:
> > We're periodically seeing close to 256 kworkers getting stuck with the
> > following stack trace and overtime the entire system gets stuck.
> 
> OK, but that means that you have to have 256 block devices, don't you? As

It'd be a product of the number of cgroups being deleted at the same
time and the number of block devices they were accessing.  With
multiple loop devices and multiple cgroup removals, it doesn't seem
too difficult to hit.  It's rare but we do see it happening repeatedly
in one of the setups.

> we have a bdi per device and we call synchronize_rcu_expedited() only when
> unregistering bdi (and the corresponding request queue must be gone at that
> point as well as that's otherwise holding a reference). Am I understanding
> the situation correctly?

Yeah, I think so.

> > We shouldn't be scheduling hundreds of cgwb_release_workfn() at the
> > same time.  There's nothing to be gained from that.  This patch
> > updates cgwb release path to use a dedicated percpu workqueue with
> > @max_active of 1.
> 
> As Rik wrote, some paralelism is good to reduce number of forced grace
> periods so raising this to 16 is good. I was thinking whether we could not
> batch rcu grace periods in some explicit way but that would be difficult to
> do.

Agreed, already sent a patch to increase @max_active to 16.

> But thinking a bit more about this, if we made bdi RCU freed, we could just
> avoid the synchronize_rcu_expedited() in bdi_remove_from_list() altogether.
> The uses of bdi list are pretty limited and everybody ends up testing
> WB_registered bit before doing anything anyway... What do you think?
>  
> Other than that you can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks.

-- 
tejun
