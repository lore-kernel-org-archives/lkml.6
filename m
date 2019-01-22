Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CEDC37122
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 01:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D76EB20870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 01:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfAVBnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 20:43:50 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:3477 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726435AbfAVBnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 20:43:49 -0500
X-UUID: c565f9240bde470195deceea2951c217-20190122
X-UUID: c565f9240bde470195deceea2951c217-20190122
Received: from mtkcas35.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <min.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1515821922; Tue, 22 Jan 2019 09:43:37 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 22 Jan
 2019 09:43:36 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 22 Jan 2019 09:43:35 +0800
Message-ID: <1548121414.4433.257.camel@mhfsdcap03>
Subject: Re: [PATCH v4 5/6] usb: musb: Add musb_clearb/w() interface
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
        <hdegoede@redhat.com>
Date:   Tue, 22 Jan 2019 09:43:34 +0800
In-Reply-To: <20190121155929.GC30080@uda0271908>
References: <1548073351-13739-1-git-send-email-min.guo@mediatek.com>
         <1548073351-13739-6-git-send-email-min.guo@mediatek.com>
         <20190121155929.GC30080@uda0271908>
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

On Mon, 2019-01-21 at 09:59 -0600, Bin Liu wrote:
> Hi Min,
> 
> On Mon, Jan 21, 2019 at 08:22:30PM +0800, min.guo@mediatek.com wrote:
> > From: Min Guo <min.guo@mediatek.com>
> > 
> > Delete the const attribute of addr parameter in readb/w/l hooks, these
> > changes are for implementing clearing W1C registers.
> > Replace musb_readb/w with musb_clearb/w to clear the interrupt status.
> > 
> > Signed-off-by: Min Guo <min.guo@mediatek.com>
> > ---
> > new patch based on v3:
> > ---
> >  drivers/usb/musb/musb_core.c | 32 +++++++++++++++++++++++---------
> >  drivers/usb/musb/musb_core.h |  8 ++++++--
> >  drivers/usb/musb/musb_io.h   |  8 +++++---
> >  drivers/usb/musb/musbhsdma.c |  3 +++
> >  drivers/usb/musb/sunxi.c     |  4 ++--
> >  drivers/usb/musb/tusb6010.c  |  2 +-
> >  6 files changed, 40 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> > index 2fe5225..5ef8848 100644
> > --- a/drivers/usb/musb/musb_core.c
> > +++ b/drivers/usb/musb/musb_core.c
> 
> [snip]
> 
> > diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
> > index b2394a7..7bf91cb 100644
> > --- a/drivers/usb/musb/musbhsdma.c
> > +++ b/drivers/usb/musb/musbhsdma.c
> > @@ -286,6 +286,9 @@ irqreturn_t dma_controller_irq(int irq, void *private_data)
> >  
> >  	int_hsdma = musb_readb(mbase, MUSB_HSDMA_INTR);
> >  
> > +	/* clear pending interrupts by manual */
> > +	musb_clearb(musb->mregs, MUSB_HSDMA_INTR);
> > +
> 
> Make musb_clearb/w() return the value of the _read() instead of
> _write(), so that we don't have to read twice here. The value of
> _write() is not used anyway.
> 
> The change above can be:
> 
> 	int_hsdma = musb_clearb(mbase, MUSB_HSDMA_INTR);
> 
> Please see my comments in 6/6 for details.

Okay.

> Regards,
> -Bin.


