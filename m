Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B21EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7422520872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbfAKBSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 20:18:22 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:52357 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726369AbfAKBSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 20:18:22 -0500
X-UUID: 14cf770aefae49cb8b22b993901eab9d-20190111
X-UUID: 14cf770aefae49cb8b22b993901eab9d-20190111
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <min.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1897669074; Fri, 11 Jan 2019 09:18:12 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 11 Jan
 2019 09:18:11 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 11 Jan 2019 09:18:10 +0800
Message-ID: <1547169490.4433.147.camel@mhfsdcap03>
Subject: Re: [PATCH 4/4] usb: musb: Add support for MediaTek musb controller
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
        <linux-mediatek@lists.infradead.org>,
        Yonglong Wu <yonglong.wu@mediatek.com>
Date:   Fri, 11 Jan 2019 09:18:10 +0800
In-Reply-To: <20190110141840.GA18026@uda0271908>
References: <1545896066-897-1-git-send-email-min.guo@mediatek.com>
         <1545896066-897-5-git-send-email-min.guo@mediatek.com>
         <20190108154441.GG25910@uda0271908> <1547037068.4433.122.camel@mhfsdcap03>
         <20190109140144.GI25910@uda0271908> <1547105062.4433.144.camel@mhfsdcap03>
         <20190110141840.GA18026@uda0271908>
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

On Thu, 2019-01-10 at 08:18 -0600, Bin Liu wrote:
> Hi Min,
> 
> Please briefly summarize the controller differences in the commit log,
> such as
> 
> - WIC interrupt registers;
> - data toggle bit;
> - no dedicated DMA interrupt line;
> 
> so that we can quickly understand the core driver is modified
> accordingly to handle the differences.

Okay, tkanks.

> On Thu, Jan 10, 2019 at 03:24:22PM +0800, Min Guo wrote:
> > Hi Bin,
> 
> [snip]
> 
> > > > > > +		musb_writeb(mbase, MUSB_INTRUSB,
> > > > > > +			musb_readb(mbase, MUSB_INTRUSB));
> > > > > 
> > > > > For this clearing register bit operation, please create platform hooks
> > > > > musb_clearb() and musb_clearw() in struct musb_platform_ops instead,
> > > > > then follow how musb_readb() pointer is assigned in
> > > > > musb_init_controller() to use the W1C version for mtk platform.
> > > > 
> > > > I have tried implementing musb_readb(), musb_readw() interface with
> > > > interrupt status W1C function in struct musb_platform_ops. But this
> > > > interface will require a global variable to hold MAC basic address for
> > > > judgment, and then special handling of the interrupt state. A global
> > > > variable will make the driver work with only a single instance, so it
> > > > can't work on some MTK platforms which have two instances.
> > > 
> > > I didn't mean to modify musb_read*(), but
> > > 
> > > > How about creating musb_clearb/w() as following:
> > > > void (*clearb)(void __iomem *addr, unsigned offset, u8 data);
> > > > void (*clearw)(void __iomem *addr, unsigned offset, u16 data);
> > > 
> > > this is what I was asking for, similar to what musb_readb/w() is
> > > implemented.
> > 
> > I will prepare a patch for musb_clearb/w().
> 
> This doesn't have to be a separate patch.

Okay.

> > > > > > +		musb_writew(mbase, MUSB_INTRRX,
> > > > > > +			musb_readw(mbase, MUSB_INTRRX));
> > > > > > +		musb_writew(mbase, MUSB_INTRTX,
> > > > > > +			musb_readw(mbase, MUSB_INTRTX));
> > > > > > +	}
> 
> [snip]
> 
> > > > > > +	/* MediaTek controller has private toggle register */
> > > > > 
> > > > > only one toggle register for all endpoints? how does it handle
> > > > > difference toggle values for different endpoints?
> > > > 
> > > > MediaTek controller has separate registers to describe TX/RX toggle.
> > > 
> > > Is it one register per endpoint?
> > 
> > MUSB_RXTOG/MUSB_TXTOG is common register, each bit reflects the toggle
> > state of an endpoint. bit[0] not used,bit[1~8] corresponds to ep[1~8]
> > 
> > > > 
> > > > > > +	if (musb->ops->quirks & MUSB_MTK_QUIRKS) {
> > > > > > +		u16 toggle;
> > > > > > +		u8 epnum = qh->hw_ep->epnum;
> > > > > > +
> > > > > > +		if (is_in)
> > > > > > +			toggle = musb_readl(musb->mregs, MUSB_RXTOG);
> > > 
> > > this line seems telling there is just *one* register for all endpoints.
> > 
> > Yes, all endpoint share this register, endpoint and bit are one-to-one
> > correspondence.
> 
> Okay, thanks. Sorry I missed the bit operation in the code below.
> 
> > 
> > > > > 
> > > > > should use musb_readw() instead? MUSB_RXTOG seems to be 16bit.
> > > > 
> > > > Ok
> > > > 
> > > > > > +		else
> > > > > > +			toggle = musb_readl(musb->mregs, MUSB_TXTOG);
> > > > > > +
> > > > > > +		csr = toggle & (1 << epnum);
> 
> Regards,
> -Bin.


