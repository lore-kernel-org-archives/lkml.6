Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9C5C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1AD2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388199AbeLQQNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:13:02 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:56502 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727727AbeLQQNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 11:13:02 -0500
Received: (qmail 2063 invoked by uid 2102); 17 Dec 2018 11:13:01 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Dec 2018 11:13:01 -0500
Date:   Mon, 17 Dec 2018 11:13:01 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Paul Elder <paul.elder@ideasonboard.com>
cc:     laurent.pinchart@ideasonboard.com,
        <kieran.bingham@ideasonboard.com>, <b-liu@ti.com>, <rogerq@ti.com>,
        <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] usb: gadget: add mechanism to specify an explicit
 status stage
In-Reply-To: <20181217060216.26368-5-paul.elder@ideasonboard.com>
Message-ID: <Pine.LNX.4.44L0.1812171107290.1630-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018, Paul Elder wrote:

> A usb gadget function driver may or may not want to delay the status
> stage of a control OUT request. An instance it might want to is to
> asynchronously validate the data of a class-specific request.
> 
> A function driver that wants an explicit status stage should set the
> newly added explicit_status flag of the usb_request corresponding to the
> data stage. Later on the function driver can explicitly complete the
> status stage by enqueueing a usb_request also with the explicit_status
> flag set, and with the zero flag set to 1 for ACK, or 0 for STALL.

This last part seems awkward.  Why not have the function driver call
usb_ep_set_halt() to indicate ep0 should send a STALL?  That's already 
part of the API; no need to add another way of doing the same thing.

> To support both explicit and implicit status stages, a UDC driver must
> call the newly added usb_gadget_control_complete function right after
> calling usb_gadget_giveback_request. To support the explicit status
> stage, it might then check what stage the usb_request was queued in, or
> the explicit_status flag, and the zero flag for what status to send.
> 
> Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> v1 Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> Changes from v1:
> 
> Complete change of API. Now we use a flag that should be set in the
> usb_request that is queued for the data stage to signal to the UDC that
> we want to delay the status stage (as opposed to setting a flag in the
> UDC itself, that persists across all requests). We now also provide a
> function for UDC drivers to very easily allow implicit status stages, to
> mitigate the need to convert all function drivers to this new API at
> once, and to make it easier for UDC drivers to convert.
> 
>  drivers/usb/gadget/udc/core.c | 33 +++++++++++++++++++++++++++++++++
>  include/linux/usb/gadget.h    | 10 ++++++++++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> index af88b48c1cea..e99481ef9147 100644
> --- a/drivers/usb/gadget/udc/core.c
> +++ b/drivers/usb/gadget/udc/core.c
> @@ -894,6 +894,39 @@ EXPORT_SYMBOL_GPL(usb_gadget_giveback_request);
>  
>  /* ------------------------------------------------------------------------- */
>  
> +/**
> + * usb_gadget_control_complete - complete the status stage of a control
> + *	request, or delay it
> + * Context: in_interrupt()
> + *
> + * @gadget: gadget whose control request's status stage should be completed
> + * @explicit_status: true to delay status stage, false to complete here
> + *
> + * This is called by device controller drivers after returning the completed
> + * request back to the gadget layer, to either complete or delay the status
> + * stage.
> + */
> +void usb_gadget_control_complete(struct usb_gadget *gadget,
> +		unsigned int explicit_status)

This signature is incomplete.  You also need to know the status of the 
request that was just given back...

> +{
> +	struct usb_request *req;
> +
> +	if (explicit_status)
> +		return;
> +
> +	/* Send an implicit status-stage request for ep0 */
> +	req = usb_ep_alloc_request(gadget->ep0, GFP_ATOMIC);

... because none of this should happen if the previous request
completed unsuccessfully.

Alan Stern

