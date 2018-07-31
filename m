Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF5DC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 016D9208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fkHGFiOa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 016D9208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbeGaJkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 05:40:37 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:47636 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbeGaJkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 05:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qX+loTIq+4HCAHJa7NnxjbHhVRNvu2lvwF34f2Rvmvc=; b=fkHGFiOaZR1ftVkAWFgjVtAsX
        tVD0doM+hhd2aIP3vGiOZGASmHl5guBukbPpKlkvviRBG+iE8Hzp9okq4u30Vd4TECjeadhFaSHxs
        uRanZint1iGaeOZLARTxXz5ckfXAL75pZB+ySPyPSVaLG+w/ouBe/eI3S1x9dwQN/LQ0U=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:50170)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1fkPaq-00055k-HX; Tue, 31 Jul 2018 09:01:20 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1fkPal-0002UN-0v; Tue, 31 Jul 2018 09:01:15 +0100
Date:   Tue, 31 Jul 2018 09:01:12 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sebastian Reichel <sre@kernel.org>, Milo Kim <milo.kim@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] PCI: let pci_request_irq properly deal with threaded
 interrupts
Message-ID: <20180731080111.GG17271@n2100.armlinux.org.uk>
References: <d004975f-03a8-59f5-56ef-f4e1f8e12dfb@gmail.com>
 <20180730213028.GC45322@bhelgaas-glaptop.roam.corp.google.com>
 <20180730224252.GE45322@bhelgaas-glaptop.roam.corp.google.com>
 <alpine.DEB.2.21.1807310047320.1725@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1807310047320.1725@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 12:50:21AM +0200, Thomas Gleixner wrote:
> On Mon, 30 Jul 2018, Bjorn Helgaas wrote:
> 
> > [+cc maintainers of possibly erroneous callers of request_threaded_irq()]
> > 
> > On Mon, Jul 30, 2018 at 04:30:28PM -0500, Bjorn Helgaas wrote:
> > > [+cc Thomas, Christoph, LKML]
> > > 
> > > On Mon, Jul 30, 2018 at 12:03:42AM +0200, Heiner Kallweit wrote:
> > > > If we have a threaded interrupt with the handler being NULL, then
> > > > request_threaded_irq() -> __setup_irq() will complain and bail out
> > > > if the IRQF_ONESHOT flag isn't set. Therefore check for the handler
> > > > being NULL and set IRQF_ONESHOT in this case.
> > > > 
> > > > This change is needed to migrate the mei_me driver to
> > > > pci_alloc_irq_vectors() and pci_request_irq().
> > > > 
> > > > Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> > > 
> > > I'd like an ack from Thomas because this requirement about IRQF_ONESHOT
> > > usage isn't mentioned in the request_threaded_irq() function doc or
> > > Documentation/
> > 
> > Possibly these other request_threaded_irq() callers are similarly
> > broken?  I can't tell for sure about tda998x_create(), but all the
> > others certainly call request_threaded_irq() with "handler == NULL"
> > and irqflags that do not contain IRQF_ONESHOT:
> > 
> >   tda998x_create()
> >     request_threaded_irq(client->irq, NULL, ..., irqd_get_trigger_type(), ...)
> >     (I can't tell what irqd_get_trigger_type() does)
> 
> It reads the trigger type back from the irq chip (level/edge/polarity) but
> does not return with the ONESHOT bit set.

What tree are you (Bjorn) using there?  Looking in my git history,
request_threaded_irq() was added in January 2014, as:

+               irqf_trigger =
+                       irqd_get_trigger_type(irq_get_irq_data(client->irq));
+               ret = request_threaded_irq(client->irq, NULL,
+                                          tda998x_irq_thread,
+                                          irqf_trigger | IRQF_ONESHOT,
+                                          "tda998x", priv);

and updated more recently for the CEC support in ae81553c30ef
("drm/i2c: tda998x: allow interrupt to be shared") to be:

-               irqf_trigger =
+               irq_flags =
                        irqd_get_trigger_type(irq_get_irq_data(client->irq));
+               irq_flags |= IRQF_SHARED | IRQF_ONESHOT;
                ret = request_threaded_irq(client->irq, NULL,
-                                          tda998x_irq_thread,
-                                          irqf_trigger | IRQF_ONESHOT,
+                                          tda998x_irq_thread, irq_flags,
                                           "tda998x", priv);

In all cases, IRQF_ONESHOT has been set for this threaded interrupt.

I've also checked drm-next, and it doesn't show anything like what
Bjorn quoted.

Confused.  Bjorn, can you double check that what you think are
erroneous request_threaded_irq() calls are actually as per what
you quoted please?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
