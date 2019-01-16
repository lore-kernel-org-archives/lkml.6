Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEAFC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F0BD20859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbfAPCoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 21:44:01 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:56118 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728394AbfAPCoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 21:44:01 -0500
X-UUID: 8c7863f068fe41ce83799bc6bb1f0c7d-20190116
X-UUID: 8c7863f068fe41ce83799bc6bb1f0c7d-20190116
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <min.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 81010068; Wed, 16 Jan 2019 10:43:56 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 16 Jan
 2019 10:43:55 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 16 Jan 2019 10:43:54 +0800
Message-ID: <1547606634.4433.179.camel@mhfsdcap03>
Subject: Re: [PATCH v2 3/4] usb: musb: Extract set toggle as a separate
 interface
From:   Min Guo <min.guo@mediatek.com>
To:     Bin Liu <b-liu@ti.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        <chunfeng.yun@mediatek.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 16 Jan 2019 10:43:54 +0800
In-Reply-To: <20190115204049.GE18026@uda0271908>
References: <1547516626-5084-1-git-send-email-min.guo@mediatek.com>
         <1547516626-5084-4-git-send-email-min.guo@mediatek.com>
         <a4e71c59-8e25-b3e9-797f-46d918121dd4@gmail.com>
         <20190115204049.GE18026@uda0271908>
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

On Tue, 2019-01-15 at 14:40 -0600, Bin Liu wrote:
> Hi Min,
> 
> On Tue, Jan 15, 2019 at 04:19:42PM +0100, Matthias Brugger wrote:
> > 
> > 
> > On 15/01/2019 02:43, min.guo@mediatek.com wrote:
> > > From: Min Guo <min.guo@mediatek.com>
> > > 
> > > Add a common interface for set data toggle
> > > 
> > > Signed-off-by: Min Guo <min.guo@mediatek.com>
> > > ---
> > >  drivers/usb/musb/musb_host.c | 37 +++++++++++++++++++++++--------------
> > >  1 file changed, 23 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
> > > index b59ce9a..16d0ba4 100644
> > > --- a/drivers/usb/musb/musb_host.c
> > > +++ b/drivers/usb/musb/musb_host.c
> > > @@ -306,6 +306,25 @@ static inline void musb_save_toggle(struct musb_qh *qh, int is_in,
> > >  	usb_settoggle(urb->dev, qh->epnum, !is_in, csr ? 1 : 0);
> > >  }
> > >  
> > > +static inline u16 musb_set_toggle(struct musb_qh *qh, int is_in,
> > > +	struct urb *urb)
> > > +{
> > > +	u16 csr = 0;
> > > +	u16 toggle = 0;
> > > +
> > > +	toggle = usb_gettoggle(urb->dev, qh->epnum, !is_in);
> > > +
> > > +	if (is_in)
> > > +		csr = toggle ? (MUSB_RXCSR_H_WR_DATATOGGLE
> > > +				| MUSB_RXCSR_H_DATATOGGLE) : 0;
> > > +	else
> > > +		csr = toggle ? (MUSB_TXCSR_H_WR_DATATOGGLE
> > > +				| MUSB_TXCSR_H_DATATOGGLE)
> > > +				: MUSB_TXCSR_CLRDATATOG;
> > 
> > Can we switch the if and use is_out logic as function parameter. This would make
> > the code easier to understand.
> 
> based on the current implementation in patch 4/4, I don't think we need
> this separate patch any more, but Matthias' comments still apply.

Okay.

> Regards,
> -Bin.


