Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3915BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 131412082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbfAPCoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 21:44:16 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:33985 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728309AbfAPCoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 21:44:15 -0500
X-UUID: af8c322969e444708d0ffa7c17f045fa-20190116
X-UUID: af8c322969e444708d0ffa7c17f045fa-20190116
Received: from mtkcas35.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <min.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 68905317; Wed, 16 Jan 2019 10:44:09 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 16 Jan
 2019 10:44:08 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 16 Jan 2019 10:44:07 +0800
Message-ID: <1547606647.4433.180.camel@mhfsdcap03>
Subject: Re: [PATCH v2 3/4] usb: musb: Extract set toggle as a separate
 interface
From:   Min Guo <min.guo@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Bin Liu <b-liu@ti.com>, Rob Herring <robh+dt@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        <chunfeng.yun@mediatek.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 16 Jan 2019 10:44:07 +0800
In-Reply-To: <a4e71c59-8e25-b3e9-797f-46d918121dd4@gmail.com>
References: <1547516626-5084-1-git-send-email-min.guo@mediatek.com>
         <1547516626-5084-4-git-send-email-min.guo@mediatek.com>
         <a4e71c59-8e25-b3e9-797f-46d918121dd4@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On Tue, 2019-01-15 at 16:19 +0100, Matthias Brugger wrote:
> 
> On 15/01/2019 02:43, min.guo@mediatek.com wrote:
> > From: Min Guo <min.guo@mediatek.com>
> > 
> > Add a common interface for set data toggle
> > 
> > Signed-off-by: Min Guo <min.guo@mediatek.com>
> > ---
> >  drivers/usb/musb/musb_host.c | 37 +++++++++++++++++++++++--------------
> >  1 file changed, 23 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
> > index b59ce9a..16d0ba4 100644
> > --- a/drivers/usb/musb/musb_host.c
> > +++ b/drivers/usb/musb/musb_host.c
> > @@ -306,6 +306,25 @@ static inline void musb_save_toggle(struct musb_qh *qh, int is_in,
> >  	usb_settoggle(urb->dev, qh->epnum, !is_in, csr ? 1 : 0);
> >  }
> >  
> > +static inline u16 musb_set_toggle(struct musb_qh *qh, int is_in,
> > +	struct urb *urb)
> > +{
> > +	u16 csr = 0;
> > +	u16 toggle = 0;
> > +
> > +	toggle = usb_gettoggle(urb->dev, qh->epnum, !is_in);
> > +
> > +	if (is_in)
> > +		csr = toggle ? (MUSB_RXCSR_H_WR_DATATOGGLE
> > +				| MUSB_RXCSR_H_DATATOGGLE) : 0;
> > +	else
> > +		csr = toggle ? (MUSB_TXCSR_H_WR_DATATOGGLE
> > +				| MUSB_TXCSR_H_DATATOGGLE)
> > +				: MUSB_TXCSR_CLRDATATOG;
> 
> Can we switch the if and use is_out logic as function parameter. This would make
> the code easier to understand.

Okay.

> Regards,
> Matthias
> 
> > +
> > +	return csr;
> > +}
> > +
> >  /*
> >   * Advance this hardware endpoint's queue, completing the specified URB and
> >   * advancing to either the next URB queued to that qh, or else invalidating
> > @@ -772,13 +791,8 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
> >  					);
> >  			csr |= MUSB_TXCSR_MODE;
> >  
> > -			if (!hw_ep->tx_double_buffered) {
> > -				if (usb_gettoggle(urb->dev, qh->epnum, 1))
> > -					csr |= MUSB_TXCSR_H_WR_DATATOGGLE
> > -						| MUSB_TXCSR_H_DATATOGGLE;
> > -				else
> > -					csr |= MUSB_TXCSR_CLRDATATOG;
> > -			}
> > +			if (!hw_ep->tx_double_buffered)
> > +				csr |= musb_set_toggle(qh, !is_out, urb);
> >  
> >  			musb_writew(epio, MUSB_TXCSR, csr);
> >  			/* REVISIT may need to clear FLUSHFIFO ... */
> > @@ -860,17 +874,12 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
> >  
> >  	/* IN/receive */
> >  	} else {
> > -		u16	csr;
> > +		u16 csr = 0;
> >  
> >  		if (hw_ep->rx_reinit) {
> >  			musb_rx_reinit(musb, qh, epnum);
> > +			csr |= musb_set_toggle(qh, !is_out, urb);
> >  
> > -			/* init new state: toggle and NYET, maybe DMA later */
> > -			if (usb_gettoggle(urb->dev, qh->epnum, 0))
> > -				csr = MUSB_RXCSR_H_WR_DATATOGGLE
> > -					| MUSB_RXCSR_H_DATATOGGLE;
> > -			else
> > -				csr = 0;
> >  			if (qh->type == USB_ENDPOINT_XFER_INT)
> >  				csr |= MUSB_RXCSR_DISNYET;
> >  
> > 


