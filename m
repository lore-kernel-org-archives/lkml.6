Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CA3C67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 829912145D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 829912145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbeJSIRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 04:17:09 -0400
Received: from gate.crashing.org ([63.228.1.57]:40435 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbeJSIRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 04:17:08 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w9INWO4S009643;
        Thu, 18 Oct 2018 18:32:27 -0500
Message-ID: <a3fecf7913d6a85a6294afbc5a1a18b7714d6756.camel@kernel.crashing.org>
Subject: Re: [[PATCH] 8/9] DMA-UART-Driver-for-AST2500
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Vinod <vkoul@kernel.org>
Cc:     "sudheer.v" <open.sudheer@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Russell King <linux@armlinux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Jiri Slaby <jslaby@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Michael Moese <mmoese@suse.de>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org,
        Sudheer V <sudheer.veliseti@aspeedtech.com>,
        ShivahShankar Shakarnarayan rao 
        <shivahshankar.shankarnarayanrao@aspeedtech.com>
Date:   Fri, 19 Oct 2018 10:32:24 +1100
In-Reply-To: <20181018095507.GC2400@vkoul-mobl>
References: <1539749466-3912-1-git-send-email-open.sudheer@gmail.com>
         <1539749466-3912-9-git-send-email-open.sudheer@gmail.com>
         <20181017060531.GU2400@vkoul-mobl>
         <351eecd5b1b21893e94f76b34c058c6257b7f837.camel@kernel.crashing.org>
         <20181018095507.GC2400@vkoul-mobl>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-18 at 15:25 +0530, Vinod wrote:
> 
> > It's not a dmaengine driver. It's a serial UART driver that happens to
> > use a dedicated DMA engine.
> 
> Then I see no reason for it to use dmaengine APIs. The framework allows
> people to share a controller for many clients, but if you have dedicated
> one then you may use it directly

Well... the engine is shared by a few UARTs, they have dedicated rings
but there's a common set of regs for interrupt handling etc.

That said, I still think it could be contained within a UART driver,
there's little benefit in adding the framework overhead, esp since
these are really weak cores, any overhead will be felt.

Ben.

> > It's unclear whether it should be split into two drivers, or just have
> > the serial driver directly use the dma engine since that engine is
> > dedicated in HW to only work on those UARTs and nothing else...
> > 
> > Cheers,
> > Ben.
> > 
> > 
> > > While doing resubmission please take some time to understand subsystem
> > > tags to use. (hint git log <subsystem> will tell you)
> > > 
> > > Also series has [[PATCH] 8/9] whereas it should be [PATCH 8/9] please
> > > let git generate that for you (hint git format-patch start..end does a
> > > good job)
> > > 
> > > > @@ -0,0 +1,1594 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + *   drivers/tty/serial/8250/8250_aspeed_uart_dma.c
> > > > + *    1. 2018/07/01 Shivah Shankar created
> > > > + *    2. 2018/08/25 sudheer.veliseti<open.sudheer@gmail.com> modified
> > > 
> > > we dont use this log in kernel. I do not see s-o-b by Shivah, that
> > > should be added. I think he should be author and you need to list
> > > changes you did..
> > > 
> 
> 

