Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9CBC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 515012170D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:10:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 515012170D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732294AbeHCQGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 12:06:30 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39902 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731781AbeHCQGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 12:06:30 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1flam9-0001Xc-KE; Fri, 03 Aug 2018 16:09:53 +0200
Date:   Fri, 3 Aug 2018 16:09:53 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Heiner Kallweit <hkallweit1@gmail.com>
cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: let pci_request_irq properly deal with threaded
 interrupts
In-Reply-To: <0799ea22-70ed-3be6-cb80-449f53fef819@gmail.com>
Message-ID: <alpine.DEB.2.21.1808031605160.1745@nanos.tec.linutronix.de>
References: <d004975f-03a8-59f5-56ef-f4e1f8e12dfb@gmail.com> <20180730213028.GC45322@bhelgaas-glaptop.roam.corp.google.com> <alpine.DEB.2.21.1807310015170.1725@nanos.tec.linutronix.de> <86d0v4x75x.wl-marc.zyngier@arm.com>
 <0799ea22-70ed-3be6-cb80-449f53fef819@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Aug 2018, Heiner Kallweit wrote:
> On 31.07.2018 08:15, Marc Zyngier wrote:
> > On Mon, 30 Jul 2018 23:36:57 +0100,
> > Thomas Gleixner <tglx@linutronix.de> wrote:
> >>
> >> Yes, request for pure threaded interrupts are rejected if the oneshot flag
> >> is not set. The reason is that this would be deadly especially with level
> >> triggered interrupts because the primary default handler just wakes the
> >> thread and then reenables interrupts, which will make the interrupt come
> >> back immediately and the thread won't have a chance to actually shut it up
> >> in the device.
> >>
> >> That made me look into that code again and I found that we added a flag for
> >> irq chips to tell the core that the interrupt is one shot safe, i.e. that
> >> it can be requested w/o IRQF_ONESHOT. That was initially added to optimize
> >> MSI based interrupts which are oneshot safe by implementation.
> >>
> >>   dc9b229a58dc ("genirq: Allow irq chips to mark themself oneshot safe")
> >>
> >> The original patch added that flag to the x86 MSI irqchip code, but that
> >> part was not applied for reasons which slipped from memory. It might be
> >> worthwhile to revisit that in order to avoid the mask/unmask overhead for
> >> such cases.
> > 
> > Yup, that would actually be beneficial to a range of interrupt
> > controllers (only an obscure GPIO driver makes use of this flag).
> > 
> 
> I'm not an expert on that area, but if MSI is oneshot-safe in general,
> then we could do the following in the framework instead of touching
> every MSI irq_chip. Opinions?
> I tested on X86 and at least my system is still running.
> 
> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
> index 4ca2fd46..ba6da943 100644
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -289,6 +289,9 @@ struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
>         if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
>                 msi_domain_update_chip_ops(info);
> 
> +       /* MSI is oneshot-safe in general */
> +       info->chip->flags |= IRQCHIP_ONESHOT_SAFE;
> +
>         domain = irq_domain_create_hierarchy(parent, IRQ_DOMAIN_FLAG_MSI, 0,

Looks about right, though there might be dragons. MSI is not always as sane
as it should be...

> > We could also consider extending this to support interrupt
> > hierarchies, as __setup_irq() seems only concerned with the top of the
> > stack (an IRQ provided by a generic MSI stack and backed by an irqchip
> > providing IRQCHIP_ONESHOT_SAFE would go unnoticed).
> > 
> 
> Would it be sufficient if one irq_chip in the hierarchy is oneshot-safe?
> Or what do we have to check for?

I think the top most chip is the key, the rest of the hierarchy is
irrelevant because the top most chip is the one which is responsible for
not creating an interrupt storm after the interrupt got acknowledged.

Thanks,

	tglx
