Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C51C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F70208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZXl8g5aW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44F70208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbeGaJIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 05:08:47 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35648 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbeGaJIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 05:08:47 -0400
Received: by mail-wr1-f66.google.com with SMTP id a3-v6so15468628wrt.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 00:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xwUjl8S0V+k9vEsEOJ8G0vl/IVJCGGJD6TgbJaIuK1g=;
        b=ZXl8g5aWRoXfOKnzcdh5WiAifPQ39ZHyKAUlEoaHZN/gdcdYo1qlKLfbp8WuGYkyho
         kdke+OnG3sgEuIZ1jyqnP/Bwtud1qtpbz7xMJTUSPqkc5WYjjmDBLl7C1iHbGjNoUsKq
         VQX+9fs9WV3xiDOV5K0FusnJETIL+vMw5/3HY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xwUjl8S0V+k9vEsEOJ8G0vl/IVJCGGJD6TgbJaIuK1g=;
        b=ZZFDrLiTV4IjpNHWVEbq5Xmnx90XDSPnmCjREEQArLcbe+j1e+Zta5Y7KxRbS/EXW6
         2y6s7E1ZDAM3i81wAPr5AtQ7wBcWxRlFgcqIv9LOmsLISAbdmzNzxfXBmAp2FAv51oCN
         xwpZHsmunxI6lMTcrdsNW50yoZKt3mRNzEGHtl6Z1xV51UVybqiBOAPUScFm1gTTX/Bu
         lNaC3xxB4w6lWyqMo+Ho2G5yAIQUsK9I26s7DWzh79E/3EvZgWeYKfyaejsvdEk0S1SV
         M9NTX/yTSQbHsyFMpFdSOTCRBMPlYED4U3rE00mvp6jiQPlwUZziKeag6aMJ7dJ1MUR4
         Xa8Q==
X-Gm-Message-State: AOUpUlEPlNyaB/wOz78xvbGdYsIOsdUgDt29pVaqVDg2s8zY6ZrPTZlB
        hfOiSXZYvih2CspIaxG3rnku0g==
X-Google-Smtp-Source: AAOMgpcFIIbRolyLfjhbfWRR0JxB5DCb0gxHGflSg9/Abma0EGOfFfnG9HuUw0V0lvFMxjdzYKlxcA==
X-Received: by 2002:adf:93a3:: with SMTP id 32-v6mr19604925wrp.140.1533022188372;
        Tue, 31 Jul 2018 00:29:48 -0700 (PDT)
Received: from dell ([95.149.160.4])
        by smtp.gmail.com with ESMTPSA id q188-v6sm2448794wmd.36.2018.07.31.00.29.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 00:29:47 -0700 (PDT)
Date:   Tue, 31 Jul 2018 08:29:45 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Reichel <sre@kernel.org>, Milo Kim <milo.kim@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] PCI: let pci_request_irq properly deal with threaded
 interrupts
Message-ID: <20180731072945.GF4662@dell>
References: <d004975f-03a8-59f5-56ef-f4e1f8e12dfb@gmail.com>
 <20180730213028.GC45322@bhelgaas-glaptop.roam.corp.google.com>
 <20180730224252.GE45322@bhelgaas-glaptop.roam.corp.google.com>
 <alpine.DEB.2.21.1807310047320.1725@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.1807310047320.1725@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jul 2018, Thomas Gleixner wrote:

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
> >   max8997_muic_probe()
> >     request_threaded_irq(virq, NULL, ..., IRQF_NO_SUSPEND, ...)
> > 
> >   tda998x_create()
> >     request_threaded_irq(client->irq, NULL, ..., irqd_get_trigger_type(), ...)
> >     (I can't tell what irqd_get_trigger_type() does)
> 
> It reads the trigger type back from the irq chip (level/edge/polarity) but
> does not return with the ONESHOT bit set.
> 
> >   ab8500_btemp_probe()
> >   ab8500_charger_probe()
> >     request_threaded_irq(irq, NULL, ..., IRQF_SHARED | IRQF_NO_SUSPEND, ...)
> 
> SHARED is interesting ....
> 
> >   lp8788_set_irqs()
> >     request_threaded_irq(virq, NULL, ..., 0, ...)
> > 
> >   max77686_rtc_probe()
> >     request_threaded_irq(info->virq, NULL, ..., 0, ...)
> > 
> >   wm8350_register_irq()
> >     request_threaded_irq(irq + wm8350->irq_base, NULL, ..., flags, ...)
> >     (I think all callers of wm8350_register_irq() supply 0 for "flags")
> 
> Indeed. This all looks pretty much wrong. No idea why nobody ever noticed.

I guess not many people (myself included) know the intricacies well
enough to have noticed.  This probably coupled with insufficient
checking/warning about such practices in the IRQ subsystem.

There are quite a few different devices here, so my assumption would
be that interrupt handling still works in these cases.

If we know certain configurations are incorrect or incompatible, might
I suggest we add some form of alert to bring these to the attention of
unknowing contributors?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
