Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AA9ECDE3C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 921F2208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="bRVHuRao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 921F2208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbeJRHnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 03:43:31 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:42520 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbeJRHnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 03:43:31 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D5E03113F;
        Thu, 18 Oct 2018 01:45:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1539819923;
        bh=nrgNSl6XnGW1dTnQwMWeMSvsVMrfnOUKXSDmJy4THAM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bRVHuRaoTVln4fVvkmqMPPvi4SDqO5DvnjkV3+NOdQ2KWPJNnGVelF9QGMRxfL+OJ
         b1UsDw/t+ea0V637AyFxg93nsJagJYoexA4gBAsFWJK2t2dgn753HE6m1m1xpODRRV
         sJyxUYPoTYysJT8rjZ1b6tv3Dgc8nTd8X/fG2/ao=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Bin Liu <b-liu@ti.com>
Cc:     Paul Elder <paul.elder@ideasonboard.com>,
        kieran.bingham@ideasonboard.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        balbi@kernel.org, stern@rowland.harvard.edu, rogerq@ti.com
Subject: Re: [PATCH 4/6] usb: gadget: add functions to signal udc driver to delay status stage
Date:   Thu, 18 Oct 2018 02:45:32 +0300
Message-ID: <3055233.Lvy0NcWSZ5@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20181011161021.GB8763@uda0271908>
References: <20181010024903.1633-1-paul.elder@ideasonboard.com> <20181010024903.1633-5-paul.elder@ideasonboard.com> <20181011161021.GB8763@uda0271908>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bin,

On Thursday, 11 October 2018 19:10:21 EEST Bin Liu wrote:
> On Tue, Oct 09, 2018 at 10:49:01PM -0400, Paul Elder wrote:
> > A usb gadget function driver may or may not want to delay the status
> > stage of a control OUT request. An instance it might want to is to
> > asynchronously validate the data of a class-specific request.
> > 
> > Add a function usb_ep_delay_status to allow function drivers to choose
> > to delay the status stage in the request completion handler. The UDC
> > should then check the usb_ep->delayed_status flag and act accordingly to
> > delay the status stage.
> > 
> > Also add a function usb_ep_send_response as a wrapper for
> > usb_ep->ops->send_response, whose prototype is added as well. This
> > function should be called by function drivers to tell the UDC what to
> > reply in the status stage that it has requested to be delayed.
> > 
> > Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> > 
> >  drivers/usb/gadget/udc/core.c | 35 +++++++++++++++++++++++++++++++++++
> >  include/linux/usb/gadget.h    | 11 +++++++++++
> >  2 files changed, 46 insertions(+)
> > 
> > diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> > index af88b48c1cea..1ec5ce6b43cd 100644
> > --- a/drivers/usb/gadget/udc/core.c
> > +++ b/drivers/usb/gadget/udc/core.c
> > @@ -443,6 +443,41 @@ void usb_ep_fifo_flush(struct usb_ep *ep)
> >  }
> >  EXPORT_SYMBOL_GPL(usb_ep_fifo_flush);
> > 
> > +/**
> > + * usb_ep_ep_delay_status - set delay_status flag
> > + * @ep: the endpoint whose delay_status flag is being set
> > + *
> > + * This function instructs the UDC to delay the status stage of a control
> > + * request. It can only be called from the request completion handler of
> > a
> > + * control request.
> > + */
> > +void usb_ep_delay_status(struct usb_ep *ep)
> > +{
> > +	ep->delayed_status = true;
> > +}
> > +EXPORT_SYMBOL_GPL(usb_ep_delay_status);
> 
> Is usb_ep_set_delay_status() better? I thought it implies get/return
> action if a verb is missing in the function name.

For what it's worth, I understand the function name as "delay the status 
stage", with "delay" being a verb. Maybe the short description could be 
updated accordingly.

-- 
Regards,

Laurent Pinchart



