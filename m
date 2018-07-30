Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229B5C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B9E20881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B9E20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731827AbeGaAOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 20:14:10 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57846 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726966AbeGaAOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 20:14:10 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fkGmg-0008DK-8N; Tue, 31 Jul 2018 00:36:58 +0200
Date:   Tue, 31 Jul 2018 00:36:57 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH] PCI: let pci_request_irq properly deal with threaded
 interrupts
In-Reply-To: <20180730213028.GC45322@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <alpine.DEB.2.21.1807310015170.1725@nanos.tec.linutronix.de>
References: <d004975f-03a8-59f5-56ef-f4e1f8e12dfb@gmail.com> <20180730213028.GC45322@bhelgaas-glaptop.roam.corp.google.com>
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

> [+cc Thomas, Christoph, LKML]

+ Marc

> On Mon, Jul 30, 2018 at 12:03:42AM +0200, Heiner Kallweit wrote:
> > If we have a threaded interrupt with the handler being NULL, then
> > request_threaded_irq() -> __setup_irq() will complain and bail out
> > if the IRQF_ONESHOT flag isn't set. Therefore check for the handler
> > being NULL and set IRQF_ONESHOT in this case.
> > 
> > This change is needed to migrate the mei_me driver to
> > pci_alloc_irq_vectors() and pci_request_irq().
> > 
> > Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> I'd like an ack from Thomas because this requirement about IRQF_ONESHOT
> usage isn't mentioned in the request_threaded_irq() function doc or
> Documentation/

Right. The documentation really needs some love and care. :(

Yes, request for pure threaded interrupts are rejected if the oneshot flag
is not set. The reason is that this would be deadly especially with level
triggered interrupts because the primary default handler just wakes the
thread and then reenables interrupts, which will make the interrupt come
back immediately and the thread won't have a chance to actually shut it up
in the device.

That made me look into that code again and I found that we added a flag for
irq chips to tell the core that the interrupt is one shot safe, i.e. that
it can be requested w/o IRQF_ONESHOT. That was initially added to optimize
MSI based interrupts which are oneshot safe by implementation.

  dc9b229a58dc ("genirq: Allow irq chips to mark themself oneshot safe")

The original patch added that flag to the x86 MSI irqchip code, but that
part was not applied for reasons which slipped from memory. It might be
worthwhile to revisit that in order to avoid the mask/unmask overhead for
such cases.

Anyway for the patch in question:

       Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Thanks,

	tglx
