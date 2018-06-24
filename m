Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60634C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 09:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E13A24E70
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 09:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E13A24E70
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752127AbeFXJrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 05:47:37 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44789 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751900AbeFXJrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 05:47:36 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fX1cK-0003JY-Bg; Sun, 24 Jun 2018 11:47:32 +0200
Date:   Sun, 24 Jun 2018 11:47:31 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Lukas Wunner <lukas@wunner.de>
cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/2] genirq: Update code comments wrt recycled
 thread_mask
In-Reply-To: <32fc25aa35ecef4b2692f57687bb7fc2a57230e2.1529828292.git.lukas@wunner.de>
Message-ID: <alpine.DEB.2.21.1806241145320.8650@nanos.tec.linutronix.de>
References: <32fc25aa35ecef4b2692f57687bb7fc2a57230e2.1529828292.git.lukas@wunner.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas,

On Sun, 24 Jun 2018, Lukas Wunner wrote:

> Previously a race existed between __free_irq() and __setup_irq() wherein
> the thread_mask of a just removed action could be handed out to a newly
> added action and the freed irq thread would then tread on the oneshot
> mask bit of the newly added irq thread in irq_finalize_oneshot():
> 
> time
>  |  __free_irq()
>  |    raw_spin_lock_irqsave(&desc->lock, flags);
>  |    <remove action from linked list>
>  |    raw_spin_unlock_irqrestore(&desc->lock, flags);
>  |
>  |  __setup_irq()
>  |    raw_spin_lock_irqsave(&desc->lock, flags);
>  |    <traverse linked list to determine oneshot mask bit>
>  |    raw_spin_unlock_irqrestore(&desc->lock, flags);
>  |
>  |  irq_thread() of freed irq (__free_irq() waits in synchronize_irq())
>  |    irq_thread_fn()
>  |      irq_finalize_oneshot()
>  |        raw_spin_lock_irq(&desc->lock);
>  |        desc->threads_oneshot &= ~action->thread_mask;
>  |        raw_spin_unlock_irq(&desc->lock);
>  v
> 
> The race was known at least since 2012 when it was documented in a code
> comment by commit e04268b0effc ("genirq: Remove paranoid warnons and
> bogus fixups").

The race was known, but it was also harmless as nothing would touch stuff
after synchronize_irq().

> But it wasn't until 2017 that it was fixed by commit 9114014cf4e6
> ("genirq: Add mutex to irq desc to serialize request/free_irq()"),
> apparently inadvertantly so because the race is neither mentioned in the
> commit message nor was the code comment updated.  Make up for that.

Thanks for following up. This update is very well done.

       tglx
