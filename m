Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D16C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A0A420890
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A0A420890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732081AbeGaA1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 20:27:38 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57866 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbeGaA1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 20:27:38 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fkGzd-0008J7-S2; Tue, 31 Jul 2018 00:50:22 +0200
Date:   Tue, 31 Jul 2018 00:50:21 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Reichel <sre@kernel.org>, Milo Kim <milo.kim@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] PCI: let pci_request_irq properly deal with threaded
 interrupts
In-Reply-To: <20180730224252.GE45322@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <alpine.DEB.2.21.1807310047320.1725@nanos.tec.linutronix.de>
References: <d004975f-03a8-59f5-56ef-f4e1f8e12dfb@gmail.com> <20180730213028.GC45322@bhelgaas-glaptop.roam.corp.google.com> <20180730224252.GE45322@bhelgaas-glaptop.roam.corp.google.com>
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

On Mon, 30 Jul 2018, Bjorn Helgaas wrote:

> [+cc maintainers of possibly erroneous callers of request_threaded_irq()]
> 
> On Mon, Jul 30, 2018 at 04:30:28PM -0500, Bjorn Helgaas wrote:
> > [+cc Thomas, Christoph, LKML]
> > 
> > On Mon, Jul 30, 2018 at 12:03:42AM +0200, Heiner Kallweit wrote:
> > > If we have a threaded interrupt with the handler being NULL, then
> > > request_threaded_irq() -> __setup_irq() will complain and bail out
> > > if the IRQF_ONESHOT flag isn't set. Therefore check for the handler
> > > being NULL and set IRQF_ONESHOT in this case.
> > > 
> > > This change is needed to migrate the mei_me driver to
> > > pci_alloc_irq_vectors() and pci_request_irq().
> > > 
> > > Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> > 
> > I'd like an ack from Thomas because this requirement about IRQF_ONESHOT
> > usage isn't mentioned in the request_threaded_irq() function doc or
> > Documentation/
> 
> Possibly these other request_threaded_irq() callers are similarly
> broken?  I can't tell for sure about tda998x_create(), but all the
> others certainly call request_threaded_irq() with "handler == NULL"
> and irqflags that do not contain IRQF_ONESHOT:
> 
>   max8997_muic_probe()
>     request_threaded_irq(virq, NULL, ..., IRQF_NO_SUSPEND, ...)
> 
>   tda998x_create()
>     request_threaded_irq(client->irq, NULL, ..., irqd_get_trigger_type(), ...)
>     (I can't tell what irqd_get_trigger_type() does)

It reads the trigger type back from the irq chip (level/edge/polarity) but
does not return with the ONESHOT bit set.

>   ab8500_btemp_probe()
>   ab8500_charger_probe()
>     request_threaded_irq(irq, NULL, ..., IRQF_SHARED | IRQF_NO_SUSPEND, ...)

SHARED is interesting ....

>   lp8788_set_irqs()
>     request_threaded_irq(virq, NULL, ..., 0, ...)
> 
>   max77686_rtc_probe()
>     request_threaded_irq(info->virq, NULL, ..., 0, ...)
> 
>   wm8350_register_irq()
>     request_threaded_irq(irq + wm8350->irq_base, NULL, ..., flags, ...)
>     (I think all callers of wm8350_register_irq() supply 0 for "flags")

Indeed. This all looks pretty much wrong. No idea why nobody ever noticed.

Thanks,

	tglx
