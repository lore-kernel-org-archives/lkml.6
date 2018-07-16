Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B53BECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E36D20864
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:27:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E36D20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730304AbeGPMy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 08:54:59 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51715 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbeGPMy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 08:54:59 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ff2bN-0004oD-0g; Mon, 16 Jul 2018 14:27:41 +0200
Date:   Mon, 16 Jul 2018 14:27:40 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org, Shaohua Li <shli@kernel.org>
Cc:     tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        linux-raid@vger.kernel.org
Subject: Re: [PATCH 1/6] drivers/md/raid5: Use irqsave variant of
 atomic_dec_and_lock()
Message-ID: <20180716122740.q7oim7te5bybcniz@linutronix.de>
References: <20180703200141.28415-1-bigeasy@linutronix.de>
 <20180703200141.28415-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180703200141.28415-2-bigeasy@linutronix.de>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-03 22:01:36 [+0200], To linux-kernel@vger.kernel.org wrote:
> From: Anna-Maria Gleixner <anna-maria@linutronix.de>
> 
> The irqsave variant of atomic_dec_and_lock handles irqsave/restore when
> taking/releasing the spin lock. With this variant the call of
> local_irq_save is no longer required.

Shaohua, are you with this?

> Cc: Shaohua Li <shli@kernel.org>
> Cc: linux-raid@vger.kernel.org
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/md/raid5.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 2031506a0ecd..e933bff9459e 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -409,16 +409,15 @@ void raid5_release_stripe(struct stripe_head *sh)
>  		md_wakeup_thread(conf->mddev->thread);
>  	return;
>  slow_path:
> -	local_irq_save(flags);
>  	/* we are ok here if STRIPE_ON_RELEASE_LIST is set or not */
> -	if (atomic_dec_and_lock(&sh->count, &conf->device_lock)) {
> +	if (atomic_dec_and_lock_irqsave(&sh->count, &conf->device_lock, flags)) {
>  		INIT_LIST_HEAD(&list);
>  		hash = sh->hash_lock_index;
>  		do_release_stripe(conf, sh, &list);
>  		spin_unlock(&conf->device_lock);
>  		release_inactive_stripe_list(conf, &list, hash);
> +		local_irq_restore(flags);
>  	}
> -	local_irq_restore(flags);
>  }
>  
>  static inline void remove_hash(struct stripe_head *sh)
> -- 
> 2.18.0
> 
