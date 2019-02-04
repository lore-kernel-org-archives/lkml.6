Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6767C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEDF52087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549291654;
	bh=ldXEDQKyBRAgR15YZM4pQUgu/UCWnHKBYzHixKqx5P0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J5tjUIfq1HXMm00DWUb53J+Nrj1u5yNspkt8eZOwXFoDOAT6gSX/XNEEzLHOGtPib
	 FyXCV4n5G7mDTIM4DdWiZKjUWVqBInAmngU40GI0soopuF25k+4nGY55hUpq0OpbX9
	 A1IXEQFBLGJrudJHmrp1gZrnfb74SZChJHIDZ4sw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbfBDOrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:47:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:48278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfBDOrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 09:47:32 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 909242087C;
        Mon,  4 Feb 2019 14:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549291651;
        bh=ldXEDQKyBRAgR15YZM4pQUgu/UCWnHKBYzHixKqx5P0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fj8V+4PTunrjkpKuOD8F19QEzJiWxcFLNYLKNPwrOJzfkTbIDTp0MNalD1LqDwSYl
         lBa8AvfmZx1iYMCDW5l+zAKSZ8wjz8CHvjY/kGKpANZ/T5Ez6UtG0hdyUr7DHxNepS
         YCvK+13Vuj/UbOD3AOLdw1y9lXmBMgJLtz1dEoew=
Date:   Mon, 4 Feb 2019 15:47:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     Pawel Laszczak <pawell@cadence.com>, devicetree@vger.kernel.org,
        mark.rutland@arm.com, linux-usb@vger.kernel.org,
        hdegoede@redhat.com, heikki.krogerus@linux.intel.com,
        andy.shevchenko@gmail.com, robh+dt@kernel.org, rogerq@ti.com,
        linux-kernel@vger.kernel.org, jbergsagel@ti.com, nsekhar@ti.com,
        nm@ti.com, sureshp@cadence.com, peter.chen@nxp.com,
        pjez@cadence.com, kurahul@cadence.com
Subject: Re: [PATCH v3 2/6] usb:common Separated decoding functions from dwc3
 driver.
Message-ID: <20190204144725.GA31360@kroah.com>
References: <1548935553-452-1-git-send-email-pawell@cadence.com>
 <1548935553-452-3-git-send-email-pawell@cadence.com>
 <20190204114502.GA28608@kroah.com>
 <87y36vmyeb.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y36vmyeb.fsf@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 04:17:00PM +0200, Felipe Balbi wrote:
> 
> Hi,
> 
> Greg KH <gregkh@linuxfoundation.org> writes:
> > On Thu, Jan 31, 2019 at 11:52:29AM +0000, Pawel Laszczak wrote:
> >> Patch moves some decoding functions from driver/usb/dwc3/debug.h driver
> >> to driver/usb/common/debug.c file. These moved functions include:
> >>     dwc3_decode_get_status
> >>     dwc3_decode_set_clear_feature
> >>     dwc3_decode_set_address
> >>     dwc3_decode_get_set_descriptor
> >>     dwc3_decode_get_configuration
> >>     dwc3_decode_set_configuration
> >>     dwc3_decode_get_intf
> >>     dwc3_decode_set_intf
> >>     dwc3_decode_synch_frame
> >>     dwc3_decode_set_sel
> >>     dwc3_decode_set_isoch_delay
> >>     dwc3_decode_ctrl
> >> 
> >> These functions are used also in inroduced cdns3 driver.
> >> 
> >> All functions prefixes were changed from dwc3 to usb.
> >
> > Ick, why?
> 
> moving dwc3-specific code into generic code.

That says what it does, but not why :)

And if this really was just moving things around, why was only one
symbol needed to be exported and not all of them?

> >> + * @bRequestType: matches the USB bmRequestType field
> >> + * @bRequest: matches the USB bRequest field
> >> + * @wValue: matches the USB wValue field (CPU byte order)
> >> + * @wIndex: matches the USB wIndex field (CPU byte order)
> >> + * @wLength: matches the USB wLength field (CPU byte order)
> >> + *
> >> + * Function returns decoded, formatted and human-readable description of
> >> + * control request packet.
> >> + *
> >> + * Important: wValue, wIndex, wLength parameters before invoking this function
> >> + * should be processed by le16_to_cpu macro.
> >> + */
> >> +const char *usb_decode_ctrl(char *str, __u8 bRequestType, __u8 bRequest,
> >> +			    __u16 wValue,  __u16 wIndex, __u16 wLength);
> >
> > Why are you returning a value, isn't the data stored in str?  Why not
> > just return an int saying if the call succeeded or not?
> 
> There is one detail here. The usage scenario for this is for
> tracepoints. When dealing with tracepoints we want to delay decoding of
> the data into strings until print-time. I guess it's best to illustrate
> with an example:
> 
> DECLARE_EVENT_CLASS(dwc3_log_ctrl,
> 	TP_PROTO(struct usb_ctrlrequest *ctrl),
> 	TP_ARGS(ctrl),
> 	TP_STRUCT__entry(
> 		__field(__u8, bRequestType)
> 		__field(__u8, bRequest)
> 		__field(__u16, wValue)
> 		__field(__u16, wIndex)
> 		__field(__u16, wLength)
> 		__dynamic_array(char, str, DWC3_MSG_MAX)
> 	),
> 	TP_fast_assign(
> 		__entry->bRequestType = ctrl->bRequestType;
> 		__entry->bRequest = ctrl->bRequest;
> 		__entry->wValue = le16_to_cpu(ctrl->wValue);
> 		__entry->wIndex = le16_to_cpu(ctrl->wIndex);
> 		__entry->wLength = le16_to_cpu(ctrl->wLength);
> 	),
> 	TP_printk("%s", dwc3_decode_ctrl(__get_str(str), DWC3_MSG_MAX,
> 					__entry->bRequestType,
> 					__entry->bRequest, __entry->wValue,
> 					__entry->wIndex, __entry->wLength)
> 	)
> );
> 
> The above is the code is today (well, I've added buffer size as an
> argument). If I make dwc3_decode_ctrl() return an integer, I can't call
> it from TP_printk() time. I'd have to move it to TP_fast_assign() time
> which is supposed to be, simply, a copy of the necessary data. IOW, I
> would have this:
> 
> DECLARE_EVENT_CLASS(dwc3_log_ctrl,
> 	TP_PROTO(struct usb_ctrlrequest *ctrl),
> 	TP_ARGS(ctrl),
> 	TP_STRUCT__entry(
> 		__dynamic_array(char, str, DWC3_MSG_MAX)
> 	),
> 	TP_fast_assign(
> 		dwc3_decode_ctrl(__get_str(str), DWC3_MSG_MAX,
> 				ctrl->bRequestType,
> 				ctrl->bRequest,
>                                 le16_to_cpu(ctrl->wValue),
> 				le16_to_cpu(ctrl->wIndex),
>                                 le16_to_cpu(ctrl->wLength));
> 	),
> 	TP_printk("%s", __get_str(str)
> 	)
> );
> 
> Essentially, we end up moving decoding of the tracepoint to the time it
> is captured; IOW, we reintroduce regular latency of string formatting.
> 
> What we could do, is move all functions called by dwc3_decode_ctrl() to
> return int, but leave dwc3_decode_ctrl() returning a pointer to str just
> so we continue decoding the data at printing time.

Ok, it wasn't obvious that this was used in a tracepoint like this, that
makes more sense.

So, it should be documented as well :)

thanks,

greg k-h
