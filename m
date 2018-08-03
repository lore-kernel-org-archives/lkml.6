Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5267C4646D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 22:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B8442178D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 22:13:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B8442178D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731991AbeHDALb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 20:11:31 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:40896 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729968AbeHDALa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 20:11:30 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fliJx-00073C-8K; Sat, 04 Aug 2018 00:13:17 +0200
Date:   Sat, 4 Aug 2018 00:13:16 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Heiner Kallweit <hkallweit1@gmail.com>
cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH] genirq: Consider domain hierarchy when checking for
 IRQCHIP_ONESHOT_SAFE
In-Reply-To: <483980a3-bd1a-1a05-0372-d608db941251@gmail.com>
Message-ID: <alpine.DEB.2.21.1808040012260.1658@nanos.tec.linutronix.de>
References: <a0407813-dbc3-4d4a-4feb-2c4865dfd4f5@gmail.com> <alpine.DEB.2.21.1808032155570.1658@nanos.tec.linutronix.de> <483980a3-bd1a-1a05-0372-d608db941251@gmail.com>
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
> On 03.08.2018 22:00, Thomas Gleixner wrote:
> > On Fri, 3 Aug 2018, Heiner Kallweit wrote:
> > 
> >> In case of a domain hierarchy we may miss the IRQCHIP_ONESHOT_SAFE
> >> flag because we look at top of the stack only. See also discussion
> >> here: https://marc.info/?l=linux-kernel&m=153301773524685&w=2
> > 
> > I think you misunderstood:
> > 
> >> I think the top most chip is the key, the rest of the hierarchy is
> >> irrelevant because the top most chip is the one which is responsible for
> >> not creating an interrupt storm after the interrupt got acknowledged.
> > 
> > The top most chip in the hierarchy, e.g. the PCI MSI one, is the key. If
> > that one is badly implemented and starts to resend after ack/eoi then the
> > interrupt storm happens. The lower layers in the hierarchy down to the
> > vector domain are just transporting what the top level chip does. So it is
> > actively wrong to flag the lower layers.
> > 
> >  	 if (desc->irq_data.chip->flags & IRQCHIP_ONESHOT_SAFE)
> > 
> > is the correct check as it looks at the topmost irq chip which is the one
> > which initiates the interrupt.
> > 
> 
> So you're saying it's correct as it is now in __setup_irq(). Then I don't
> really understand Marc's following comment from earlier in the discussion.
> What else needs to be done if it is correct already?
> 
> "We could also consider extending this to support interrupt
> hierarchies, as __setup_irq() seems only concerned with the top of the
> stack (an IRQ provided by a generic MSI stack and backed by an irqchip
> providing IRQCHIP_ONESHOT_SAFE would go unnoticed)."

I think Marc is wrong there, but I'm not sure what he had in mind.

Thanks,

	tglx
