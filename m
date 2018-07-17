Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC4AECDFAA
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 01:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A29920C07
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 01:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PfMp8jcK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A29920C07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbeGQBx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 21:53:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:38450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729934AbeGQBx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 21:53:58 -0400
Received: from kernel.org (c-71-202-33-127.hsd1.ca.comcast.net [71.202.33.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 243CC208AD;
        Tue, 17 Jul 2018 01:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531790637;
        bh=iAwJzKg/GitRYyKqqgrXloPQ82Yjj21gjTZ4BUp5r9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PfMp8jcKoqnWG56F6P9B+oA+UYwMTVLpPRXQg/pHjvku+WvjWdPatyo43DDxLG8Yr
         fkJtFIX1MVPzfDcOFigZZ7j+rX8kxStNsXAPmzPFudgzZJuFzBkcvVzHmqvdPdJfSU
         uG52vvYnIlSSn0oEAy3c+kG0qWv92VFZORVcNq9s=
Date:   Mon, 16 Jul 2018 17:37:27 -0700
From:   Shaohua Li <shli@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        linux-raid@vger.kernel.org
Subject: Re: [PATCH 1/6] drivers/md/raid5: Use irqsave variant of
 atomic_dec_and_lock()
Message-ID: <20180717003727.GA128433@kernel.org>
References: <20180703200141.28415-1-bigeasy@linutronix.de>
 <20180703200141.28415-2-bigeasy@linutronix.de>
 <20180716122740.q7oim7te5bybcniz@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716122740.q7oim7te5bybcniz@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 02:27:40PM +0200, Sebastian Andrzej Siewior wrote:
> On 2018-07-03 22:01:36 [+0200], To linux-kernel@vger.kernel.org wrote:
> > From: Anna-Maria Gleixner <anna-maria@linutronix.de>
> > 
> > The irqsave variant of atomic_dec_and_lock handles irqsave/restore when
> > taking/releasing the spin lock. With this variant the call of
> > local_irq_save is no longer required.
> 
> Shaohua, are you with this?

Acked-by: Shaohua Li <shli@kernel.org> 
> > Cc: Shaohua Li <shli@kernel.org>
> > Cc: linux-raid@vger.kernel.org
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> >  drivers/md/raid5.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> > index 2031506a0ecd..e933bff9459e 100644
> > --- a/drivers/md/raid5.c
> > +++ b/drivers/md/raid5.c
> > @@ -409,16 +409,15 @@ void raid5_release_stripe(struct stripe_head *sh)
> >  		md_wakeup_thread(conf->mddev->thread);
> >  	return;
> >  slow_path:
> > -	local_irq_save(flags);
> >  	/* we are ok here if STRIPE_ON_RELEASE_LIST is set or not */
> > -	if (atomic_dec_and_lock(&sh->count, &conf->device_lock)) {
> > +	if (atomic_dec_and_lock_irqsave(&sh->count, &conf->device_lock, flags)) {
> >  		INIT_LIST_HEAD(&list);
> >  		hash = sh->hash_lock_index;
> >  		do_release_stripe(conf, sh, &list);
> >  		spin_unlock(&conf->device_lock);
> >  		release_inactive_stripe_list(conf, &list, hash);
> > +		local_irq_restore(flags);
> >  	}
> > -	local_irq_restore(flags);
> >  }
> >  
> >  static inline void remove_hash(struct stripe_head *sh)
> > -- 
> > 2.18.0
> > 
