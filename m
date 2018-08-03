Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A409DC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 19:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B58217AC
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 19:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51B58217AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731014AbeHCVik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 17:38:40 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:40786 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbeHCVik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 17:38:40 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1flfwU-0005Qb-1h; Fri, 03 Aug 2018 21:40:54 +0200
Date:   Fri, 3 Aug 2018 21:40:53 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Heiner Kallweit <hkallweit1@gmail.com>
cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: let pci_request_irq properly deal with threaded
 interrupts
In-Reply-To: <420d6476-8ea4-0b37-e94a-f5842b7b0ff7@gmail.com>
Message-ID: <alpine.DEB.2.21.1808032136490.1658@nanos.tec.linutronix.de>
References: <d004975f-03a8-59f5-56ef-f4e1f8e12dfb@gmail.com> <20180730213028.GC45322@bhelgaas-glaptop.roam.corp.google.com> <alpine.DEB.2.21.1807310015170.1725@nanos.tec.linutronix.de> <86d0v4x75x.wl-marc.zyngier@arm.com> <0799ea22-70ed-3be6-cb80-449f53fef819@gmail.com>
 <alpine.DEB.2.21.1808031605160.1745@nanos.tec.linutronix.de> <420d6476-8ea4-0b37-e94a-f5842b7b0ff7@gmail.com>
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

On Fri, 3 Aug 2018, Heiner Kallweit wrote:
> On 03.08.2018 16:09, Thomas Gleixner wrote:
> > On Wed, 1 Aug 2018, Heiner Kallweit wrote:
> >> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
> >> index 4ca2fd46..ba6da943 100644
> >> --- a/kernel/irq/msi.c
> >> +++ b/kernel/irq/msi.c
> >> @@ -289,6 +289,9 @@ struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
> >>         if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
> >>                 msi_domain_update_chip_ops(info);
> >>
> >> +       /* MSI is oneshot-safe in general */
> >> +       info->chip->flags |= IRQCHIP_ONESHOT_SAFE;
> >> +
> >>         domain = irq_domain_create_hierarchy(parent, IRQ_DOMAIN_FLAG_MSI, 0,
> > 
> > Looks about right, though there might be dragons. MSI is not always as sane
> > as it should be...
> > 
> When saying "MSI isn't always sane", are you referring to the hardware or
> the controller driver implementation? Basically for me the question is
> whether we would be able to fix the issue if we meet such a dragon,
> or whether we would have to revert the change.

It's hardware unfortunately, so it might be a revert. PCI-MSI should be
safe, but the wild MSI variants in SoCs might be the actual dragon caves.

> Do you think the chance of a dragon is low enough? Or better add the
> flag only to the X86 PCI MSI irqchip for now?

I think PCI-MSI in general would be not too risky. Famous last words.

Thanks,

	tglx
