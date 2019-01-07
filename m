Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A382C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54062087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfAGQvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 11:51:00 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:49771 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbfAGQu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 11:50:59 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ggY77-00068k-6r; Mon, 07 Jan 2019 17:50:57 +0100
Date:   Mon, 7 Jan 2019 17:50:57 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Scott Wood <swood@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Mikulas Patocka <mpatocka@redhat.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RT] rtmutex: Flush block plug on __down_read()
Message-ID: <20190107165056.2lhd53umgt4vod5o@linutronix.de>
References: <1546634001-4450-1-git-send-email-swood@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1546634001-4450-1-git-send-email-swood@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-04 15:33:21 [-0500], Scott Wood wrote:
> __down_read() bypasses the rtmutex frontend to call
> rt_mutex_slowlock_locked() directly, and thus it needs to call
> blk_schedule_flush_flug() itself.

we don't do this in the spin_lock() case because !RT doesn't do it. We
do it for rtmutex because !RT does it for mutex.
Now I can't remember why this was skipped for a rw_sem since it is
performed for !RT as part of the schedule() invocation.

If I don't come up with a plausible explanation then I will apply this
plus a hunk for the __down_write_common() case which should also be
required (right?).

> Signed-off-by: Scott Wood <swood@redhat.com>
> ---
>  kernel/locking/rwsem-rt.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/kernel/locking/rwsem-rt.c b/kernel/locking/rwsem-rt.c
> index 660e22caf709..f73cd4eda5cd 100644
> --- a/kernel/locking/rwsem-rt.c
> +++ b/kernel/locking/rwsem-rt.c
> @@ -1,5 +1,6 @@
>  /*
>   */
> +#include <linux/blkdev.h>
>  #include <linux/rwsem.h>
>  #include <linux/sched/debug.h>
>  #include <linux/sched/signal.h>
> @@ -88,6 +89,15 @@ static int __sched __down_read_common(struct rw_semaphore *sem, int state)
>  	if (__down_read_trylock(sem))
>  		return 0;
>  
> +	/*
> +	 * If sem->rtmutex blocks, the function sched_submit_work will not
> +	 * call blk_schedule_flush_plug (because tsk_is_pi_blocked would be
> +	 * true).  We must call blk_schedule_flush_plug here; if we don't
> +	 * call it, an I/O deadlock may occur.
> +	 */
> +	if (unlikely(blk_needs_flush_plug(current)))
> +		blk_schedule_flush_plug(current);
> +
>  	might_sleep();
>  	raw_spin_lock_irq(&m->wait_lock);
>  	/*

Sebastian
