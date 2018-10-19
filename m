Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4588FECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F152621470
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F152621470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbeJTCsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 22:48:55 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:40024 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbeJTCsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 22:48:55 -0400
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gDZiF-0004XZ-0Q; Fri, 19 Oct 2018 20:41:31 +0200
Date:   Fri, 19 Oct 2018 20:41:30 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     David Laight <David.Laight@ACULAB.COM>
cc:     "casey.fitzpatrick@timesys.com" <casey.fitzpatrick@timesys.com>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "m.duckeck@kunbus.de" <m.duckeck@kunbus.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "akshay.bhat@timesys.com" <akshay.bhat@timesys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>
Subject: RE: [tip:irq/core] genirq: Fix race on spurious interrupt
 detection
In-Reply-To: <2bbbe6ba27424b3b83d7f22bafea13ad@AcuMS.aculab.com>
Message-ID: <alpine.DEB.2.21.1810192039200.1651@nanos.tec.linutronix.de>
References: <1dfd8bbd16163940648045495e3e9698e63b50ad.1539867047.git.lukas@wunner.de> <tip-746a923b863a1065ef77324e1e43f19b1a3eab5c@git.kernel.org> <2bbbe6ba27424b3b83d7f22bafea13ad@AcuMS.aculab.com>
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

David,

On Fri, 19 Oct 2018, David Laight wrote:
> From: Lukas Wunner
> > Sent: 19 October 2018 16:34
> > 
> > genirq: Fix race on spurious interrupt detection
> > 
> > Commit 1e77d0a1ed74 ("genirq: Sanitize spurious interrupt detection of
> > threaded irqs") made detection of spurious interrupts work for threaded
> > handlers by:
> > 
> > a) incrementing a counter every time the thread returns IRQ_HANDLED, and
> > b) checking whether that counter has increased every time the thread is
> >    woken.
> 
> That seems horribly broken.
> What is it trying to achieve?
> 
> There are (at least) two common cases where IRQ_HANDLED doesn't get returned.
> (Unless the driver always returns it to avoid the message.)
> 
> 1) The IOW that causes the hardware to drop a level sensitive IRQ is posted
>    on the bus (etc) and happens late enough that the IRQ line is still
>    asserted when the iret executes.
>    If this happens all the time you need to flush the IOW, but if only
>    occasionally it doesn't matter and you don't want a message.
>
> 2) Typically an ethernet driver ISR has to enable the interrupt and then
>    check the ring for work before returning from the interrupt.
>    If a packet arrives at this time it might be processed by the 'old'
>    ISR invocation but still generate another interrupt.
>    If no more packets arrive the second ISR invocation will find no work.
>    Again this is normal behaviour.
>    (Deferring everything with NAPI might make this not happen - but other
>    interrupts end up working the same way.)
> 
> If you are really trying to detect 'stuck' interrupts then you probably
> want to count un-handled ones and zero the count on handled ones.
> I'm also pretty sure you don't need an atomic counter.

Care to look at the logic which handles all of this including the
interaction with threaded interrupt handlers?

Thanks,

	tglx




