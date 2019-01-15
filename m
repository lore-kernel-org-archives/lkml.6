Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417E8C43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F9AD20656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TTui+AhO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389940AbfAOUlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 15:41:02 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42714 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730179AbfAOUlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 15:41:01 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0FKenc1052494;
        Tue, 15 Jan 2019 14:40:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547584849;
        bh=X4grtUrF6wqcq5kqJD3bJfYhoCsb92MFlX7qUAKo160=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=TTui+AhOHOV2EB5QSHzf4ji9t9TQ2eGDPSs8ud/Dunz2iADa3MR2oqBJwXuA/HaLF
         mXa+IFRSKbBUU0f8G/6THc/VfniLnyXy+I+cKvQVzuYngPTEDBAhISvvJpk3H8kRQf
         voQwBFddkxxiyc8MIup2bd8FeX/LsgZwpWYu0yIg=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0FKenHS103063
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Jan 2019 14:40:49 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 15
 Jan 2019 14:40:49 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 15 Jan 2019 14:40:49 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0FKenXn006500;
        Tue, 15 Jan 2019 14:40:49 -0600
Date:   Tue, 15 Jan 2019 14:40:49 -0600
From:   Bin Liu <b-liu@ti.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     <min.guo@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        <chunfeng.yun@mediatek.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v2 3/4] usb: musb: Extract set toggle as a separate
 interface
Message-ID: <20190115204049.GE18026@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>, min.guo@mediatek.com,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>, chunfeng.yun@mediatek.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <1547516626-5084-1-git-send-email-min.guo@mediatek.com>
 <1547516626-5084-4-git-send-email-min.guo@mediatek.com>
 <a4e71c59-8e25-b3e9-797f-46d918121dd4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a4e71c59-8e25-b3e9-797f-46d918121dd4@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Min,

On Tue, Jan 15, 2019 at 04:19:42PM +0100, Matthias Brugger wrote:
> 
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

based on the current implementation in patch 4/4, I don't think we need
this separate patch any more, but Matthias' comments still apply.

Regards,
-Bin.
