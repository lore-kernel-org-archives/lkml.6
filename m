Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0F4C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AAD22087D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:04:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AAD22087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbeJEWD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 18:03:58 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38463 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbeJEWD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 18:03:57 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1g8Ren-0002aT-46; Fri, 05 Oct 2018 17:04:45 +0200
Date:   Fri, 5 Oct 2018 17:04:45 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     klassert@kernel.org, davem@davemloft.net, anna-maria@linutronix.de,
        nhorman@tuxdriver.com, keescook@chromium.org,
        netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [REPORT] net: 3com: 3c59x: Possible data races
Message-ID: <20181005150444.pe46gjvd4434xfso@linutronix.de>
References: <412162cd-8fab-104b-ce73-6f70f108218f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <412162cd-8fab-104b-ce73-6f70f108218f@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-03 21:52:14 [+0800], Jia-Ju Bai wrote:
> ****** Possible race0 ******
> CPU0:
> vortex_boomerang_interrupt
>     line 2510: spin_lock_irqsave()
>     _boomerang_interrupt
>         line 2432: vp->tx_skbuff[entry] [READ]
>         line 2433: vp->tx_skbuff[entry] [READ]
>         line 2453: vp->tx_skbuff[entry] = NULL [WRITE]
> 
> CPU1:
> boomerang_start_xmit
>     line 2145: vp->tx_skbuff[entry] = skb [WRITE]
> 
> As for vp->tx_skbuff[entry], the WRITE and READ operations in CPU0
> are performed with holding a spinlock, but the WRITE operation in CPU1
> is performed without holding this spinlock, so there may exist data races.

not really. One side fills the ring buffer (cur_tx++) and the other side
purges it (dirty_tx++). Don't see a overlap here.

> ****** Possible race1 ******
> CPU0:
> vortex_boomerang_interrupt
>     line 2510: spin_lock_irqsave()
>     _boomerang_interrupt
>         line 2421: vp->dirty_tx = dirty_tx [WRITE]
> 
> CPU1:
> boomerang_start_xmit
>     line 2137: vp->dirty_tx [READ]
> 
> As for vp->dirty_tx, the WRITE operation in CPU0 is performed
> with holding a spinlock, but the READ operation in CPU1 is performed
> without holding this spinlock, so there may exist a data race.

basically the same thing as race0

> ****** Possible race2 ******
> CPU0:
> vortex_boomerang_interrupt
>     line 2510: spin_lock_irqsave()
>     _boomerang_interrupt
>         line 2381: vp->handling_irq = 1 [WRITE]
>         line 2498: vp->handling_irq = 0 [WRITE]
> 
> CPU1:
> boomerang_start_xmit
>     line 2134: vp->handling_irq [READ]
> 
> As for vp->handling_irq, the WRITE operations in CPU0 are performed
> with holding a spinlock, but the READ operation in CPU1 is performed
> without holding this spinlock, so there may exist data races.

It might but it is not serious. As the comment explains, if CPU1 would
miss to then it would spin the lock while CPU0 would deadlock.
However, I doubt that this happens because the core should hold the
queue lock.

> ****** Possible race3 ******
> CPU0:
> vortex_boomerang_interrupt
>     line 2510: spin_lock_irqsave()
>     _boomerang_interrupt
>         boomerang_rx
>             line 2669: skb->ip_summed = ... [WRITE]
> 
> CPU1:
> boomerang_start_xmit
>     line 2149: skb->ip_summed [READ]
> 
> As for skb->ip_summed, the WRITE operation in CPU0 is performed
> with holding a spinlock, but the READ operation in CPU1 is performed
> without holding this spinlock, so there may exist data races.

This race would exist if the skb would be simultaneously on RX and TX
side. Otherwise we good.

> 
> These possible races are detected by a runtime testing.

Could you please define runtime testing? Did something happen or did you
just instrument the code and assumed that it might happen?cG

> A possible fix of these races is protecting the code in
> boomerang_start_xmit()
> using the spinlock in vortex_boomerang_interrupt().
> But I am not sure whether this fix is correct, so I only report these races.

Okay. As explained above, I don't think the races are real.

> Best wishes,
> Jia-Ju Bai

Sebastian
