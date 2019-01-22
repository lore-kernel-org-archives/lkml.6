Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5231DC37122
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 01:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2826F20870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 01:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfAVBpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 20:45:24 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:38279 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726435AbfAVBpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 20:45:23 -0500
X-UUID: 248165485f244c918a30da0181075cfd-20190122
X-UUID: 248165485f244c918a30da0181075cfd-20190122
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <min.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 472872819; Tue, 22 Jan 2019 09:45:17 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 22 Jan
 2019 09:45:15 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 22 Jan 2019 09:45:15 +0800
Message-ID: <1548121515.4433.259.camel@mhfsdcap03>
Subject: Re: [PATCH v4 6/6] usb: musb: Add support for MediaTek musb
 controller
From:   Min Guo <min.guo@mediatek.com>
To:     Bin Liu <b-liu@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        <chunfeng.yun@mediatek.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <tony@atomide.com>,
        <hdegoede@redhat.com>, Yonglong Wu <yonglong.wu@mediatek.com>
Date:   Tue, 22 Jan 2019 09:45:15 +0800
In-Reply-To: <20190121160749.GD30080@uda0271908>
References: <1548073351-13739-1-git-send-email-min.guo@mediatek.com>
         <1548073351-13739-7-git-send-email-min.guo@mediatek.com>
         <20190121160749.GD30080@uda0271908>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bin,

On Mon, 2019-01-21 at 10:07 -0600, Bin Liu wrote:
> Hi Min,
> 
> On Mon, Jan 21, 2019 at 08:22:31PM +0800, min.guo@mediatek.com wrote:
> > From: Min Guo <min.guo@mediatek.com>
> > 
> > This adds support for MediaTek musb controller in
> > host, peripheral and otg mode.
> > There are some quirk of MediaTek musb controller, such as:
> >  -W1C interrupt status registers
> >  -Private data toggle registers
> >  -No dedicated DMA interrupt line
> > 
> > Signed-off-by: Min Guo <min.guo@mediatek.com>
> > Signed-off-by: Yonglong Wu <yonglong.wu@mediatek.com>
> > ---
> > changes in v4:
> > 1. no changes
> > 
> > changes in v3:
> > suggested by Bin:
> > 1. Remove 'u8/u16 data' parameter in clearb/w() hooks
> > 2. Replace musb_readb/w() with musb_clearb/w() to clear interrupts status
> > 
> > changes in v2:
> > suggested by Bin:
> > 1. Add summarize of MediaTek musb controller differences in the commit log
> > 2. Add "|| COMPILE_TEST" in Kconfig
> > 3. Move MediaTek's private toggle registers from musb_regs.h to mediatek.c
> > 4. Replace musb_readl() with musb_readw() to read 16bit toggle register
> > ---
> >  drivers/usb/musb/Kconfig    |   8 +-
> >  drivers/usb/musb/Makefile   |   1 +
> >  drivers/usb/musb/mediatek.c | 624 ++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 632 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/usb/musb/mediatek.c
> > 
> 
> [snip]
> 
> > +static irqreturn_t generic_interrupt(int irq, void *__hci)
> > +{
> > +	unsigned long flags;
> > +	irqreturn_t retval = IRQ_NONE;
> > +	struct musb *musb = __hci;
> > +
> > +	spin_lock_irqsave(&musb->lock, flags);
> > +	musb->int_usb = musb_readb(musb->mregs, MUSB_INTRUSB) &
> > +	    musb_readb(musb->mregs, MUSB_INTRUSBE);
> > +	musb->int_tx = musb_readw(musb->mregs, MUSB_INTRTX)
> > +	    & musb_readw(musb->mregs, MUSB_INTRTXE);
> > +	musb->int_rx = musb_readw(musb->mregs, MUSB_INTRRX)
> > +	    & musb_readw(musb->mregs, MUSB_INTRRXE);
> 
> Based on my comment in 5/6, the above 3 musb_readb/w() can be changed to
> 
> > +	/* MediaTek controller interrupt status is W1C */
> > +	musb_clearw(musb->mregs, MUSB_INTRRX);
> > +	musb_clearw(musb->mregs, MUSB_INTRTX);
> > +	musb_clearb(musb->mregs, MUSB_INTRUSB);
> 
> 	musb->int_usb = musb_clearb(musb->mregs, MUSB_INTRUSB)
> 	musb->int_tx = musb_clearw(musb->mregs, MUSB_INTRTX);
> 	musb->int_rx = musb_clearw(musb->mregs, MUSB_INTRRX);

Okay.

> > +
> > +	if (musb->int_usb || musb->int_tx || musb->int_rx)
> > +		retval = musb_interrupt(musb);
> > +
> > +	spin_unlock_irqrestore(&musb->lock, flags);
> > +
> > +	return retval;
> > +}
> > +
> 
> [snip]
> 
> > +
> > +static u8 mtk_musb_clearb(void __iomem *addr, unsigned int offset)
> > +{
> > +	u8 data;
> > +
> > +	/* W1C */
> > +	data = musb_readb(addr, offset);
> > +	musb_writeb(addr, offset, data);
> > +	return musb_readb(addr, offset);
> 
> 	return data;

Okay.

> > +}
> > +
> > +static u16 mtk_musb_clearw(void __iomem *addr, unsigned int offset)
> > +{
> > +	u16 data;
> > +
> > +	/* W1C */
> > +	data = musb_readw(addr, offset);
> > +	musb_writew(addr, offset, data);
> > +	return musb_readw(addr, offset);
> 
> 	return data;

Okay.

> 
> Regards,
> -Bin.


