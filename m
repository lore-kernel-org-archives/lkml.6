Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBE6ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE0A21479
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:23:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEE0A21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbeJSX3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 19:29:44 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:36775 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbeJSX3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 19:29:44 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id BF9B6101E6845;
        Fri, 19 Oct 2018 17:23:07 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 64D3923FCD1; Fri, 19 Oct 2018 17:23:07 +0200 (CEST)
Date:   Fri, 19 Oct 2018 17:23:07 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Mathias Duckeck <m.duckeck@kunbus.de>,
        Akshay Bhat <akshay.bhat@timesys.com>,
        Casey Fitzpatrick <casey.fitzpatrick@timesys.com>
Subject: Re: [PATCH] genirq: Fix race on spurious interrupt detection
Message-ID: <20181019152307.62t6al6ney5ofo36@wunner.de>
References: <1dfd8bbd16163940648045495e3e9698e63b50ad.1539867047.git.lukas@wunner.de>
 <alpine.DEB.2.21.1810191554030.6075@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1810191554030.6075@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 04:31:30PM +0200, Thomas Gleixner wrote:
> On Thu, 18 Oct 2018, Lukas Wunner wrote:
> > Commit 1e77d0a1ed74 ("genirq: Sanitize spurious interrupt detection of
> > threaded irqs") made detection of spurious interrupts work for threaded
> > handlers by:
> > 
> > a) incrementing a counter every time the thread returns IRQ_HANDLED, and
> > b) checking whether that counter has increased every time the thread is
> >    woken.
> > 
> > However for oneshot interrupts, the commit unmasks the interrupt before
> > incrementing the counter.  If another interrupt occurs right after
> > unmasking but before the counter is incremented, that interrupt is
> > incorrectly considered spurious:
> > 
> > time
> >  |  irq_thread()
> >  |    irq_thread_fn()
> >  |      action->thread_fn()
> >  |      irq_finalize_oneshot()
> >  |        unmask_threaded_irq()            /* interrupt is unmasked */
> >  |
> >  |                  /* interrupt fires, incorrectly deemed spurious */
> >  |
> >  |    atomic_inc(&desc->threads_handled); /* counter is incremented */
> >  v
> > 
> > I am seeing this with a hi3110 CAN controller receiving data at high
> > volume (from a separate machine sending with "cangen -g 0 -i -x"):
> > The controller signals a huge number of interrupts (hundreds of millions
> > per day) and every second there are about a dozen which are deemed
> > spurious.  The issue is benign in this case, mostly just an irritation,
> > but I'm worrying that at high CPU load and in the presence of higher
> > priority tasks, the number of incorrectly detected spurious interrupts
> > might increase beyond the 99,900 threshold and cause disablement of the
> > IRQ.
> 
> I doubt that this can happen in reality, so I'd rather reword that
> paragraph slightly:
> 
>   In theory high CPU load and in the presence of higher priority tasks, the
>   number of incorrectly detected spurious interrupts might increase beyond
>   the 99,900 threshold and cause disablement of the interrupt.
> 
>   In practice it just increments the spurious interrupt count. But that can
>   cause people to waste time investigating it over and over.
> 
> Hmm?

Sure, fine by me.  Would you prefer me to resend with that change or
can you fold it in when applying?

FWIW I did manage to reach the 99,900 threshold once because I had
added copious amounts of printk() to the hi3110 IRQ thread to debug
another issue.  But I never experienced that without those printk()'s.
Here's the resulting splat:

irq 194: nobody cared (try booting with the "irqpoll" option)
CPU: 0 PID: 1929 Comm: candump Tainted: G           O    4.9.76-rt60-v7+ #1
Hardware name: BCM2835
[<8011106c>] (unwind_backtrace) from [<8010cdd8>] (show_stack+0x20/0x24)
[<8010cdd8>] (show_stack) from [<8047cb2c>] (dump_stack+0xc8/0x10c)
[<8047cb2c>] (dump_stack) from [<8018192c>] (__report_bad_irq+0x3c/0xdc)
[<8018192c>] (__report_bad_irq) from [<80181d94>] (note_interrupt+0x29c/0x2ec)
[<80181d94>] (note_interrupt) from [<8017ec9c>] (handle_irq_event_percpu+0x78/0x84)
[<8017ec9c>] (handle_irq_event_percpu) from [<8017ed20>] (handle_irq_event+0x78/0xbc)
[<8017ed20>] (handle_irq_event) from [<80182ad8>] (handle_edge_irq+0x13c/0x1e8)
[<80182ad8>] (handle_edge_irq) from [<8017db64>] (generic_handle_irq+0x34/0x44)
[<8017db64>] (generic_handle_irq) from [<804ae1a0>] (bcm2835_gpio_irq_handle_bank+0x88/0xac)
[<804ae1a0>] (bcm2835_gpio_irq_handle_bank) from [<804ae2ac>] (bcm2835_gpio_irq_handler+0xe8/0x154)
[<804ae2ac>] (bcm2835_gpio_irq_handler) from [<8017db64>] (generic_handle_irq+0x34/0x44)
[<8017db64>] (generic_handle_irq) from [<804a7720>] (bcm2836_chained_handle_irq+0x38/0x50)
[<804a7720>] (bcm2836_chained_handle_irq) from [<8017db64>] (generic_handle_irq+0x34/0x44)
[<8017db64>] (generic_handle_irq) from [<8017e144>] (__handle_domain_irq+0x6c/0xc4)
[<8017e144>] (__handle_domain_irq) from [<8010155c>] (bcm2836_arm_irqchip_handle_irq+0xac/0xb0)
[<8010155c>] (bcm2836_arm_irqchip_handle_irq) from [<80775dec>] (__irq_usr+0x4c/0x60)
Exception stack(0xb6b15fb0 to 0xb6b15ff8)
5fa0:                                     76ec1d50 0000000a 011f8026 fbad2aa4
5fc0: 76ec1d50 0000000a 76f1a000 000263bc 00000000 000263fc 00000001 7ec3f470
5fe0: 00000444 7ec3f2e8 76de5b90 76def528 40000010 ffffffff
handlers:
[<8017edc0>] irq_default_primary_handler threaded [<7f37c734>] hi3110_can_ist [hi311x]
Disabling IRQ #194

Thanks,

Lukas
