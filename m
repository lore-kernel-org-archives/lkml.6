Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29A1C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B5D20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549280708;
	bh=bPuflJNOz60O+F3KqUmIB84EZof99yA9gKu3R5BA3zI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=INfcJu7vvqDWX3/kHD6wqlcwYMqReaHTb5jdwREZPhWCjB9oPoRtPzLxkbclmRaLH
	 DHKViCZwMMecOe6QXc261OFdD+ui8FU3F2ADy5aoZw/pukKcoiLsCWbuuvbhKOy8x/
	 ndNs0d+TZfM8uyz6jKROqciGndyonfzCHxETSeJs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbfBDLpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 06:45:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:34634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbfBDLpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 06:45:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C326620811;
        Mon,  4 Feb 2019 11:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549280705;
        bh=bPuflJNOz60O+F3KqUmIB84EZof99yA9gKu3R5BA3zI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=We9gJsvp3ewGnmgl+jbXBgYAka47aGJ62bKaAhnPI4qDTc6gCWTBgCPf3n+LdtT9o
         Rc//lChcWETjlkWSGv8wnOR+JTLxAVC/lnfiy2IfgeTjQVA5N9MnZSgcPOFh0p/j4R
         +HUvUliggaYU6A+bxuNrG/pFmsHk/hC3cuFpC77M=
Date:   Mon, 4 Feb 2019 12:45:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     devicetree@vger.kernel.org, mark.rutland@arm.com,
        linux-usb@vger.kernel.org, hdegoede@redhat.com,
        heikki.krogerus@linux.intel.com, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, rogerq@ti.com, linux-kernel@vger.kernel.org,
        jbergsagel@ti.com, nsekhar@ti.com, nm@ti.com, sureshp@cadence.com,
        peter.chen@nxp.com, pjez@cadence.com, kurahul@cadence.com
Subject: Re: [PATCH v3 2/6] usb:common Separated decoding functions from dwc3
 driver.
Message-ID: <20190204114502.GA28608@kroah.com>
References: <1548935553-452-1-git-send-email-pawell@cadence.com>
 <1548935553-452-3-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548935553-452-3-git-send-email-pawell@cadence.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 11:52:29AM +0000, Pawel Laszczak wrote:
> Patch moves some decoding functions from driver/usb/dwc3/debug.h driver
> to driver/usb/common/debug.c file. These moved functions include:
>     dwc3_decode_get_status
>     dwc3_decode_set_clear_feature
>     dwc3_decode_set_address
>     dwc3_decode_get_set_descriptor
>     dwc3_decode_get_configuration
>     dwc3_decode_set_configuration
>     dwc3_decode_get_intf
>     dwc3_decode_set_intf
>     dwc3_decode_synch_frame
>     dwc3_decode_set_sel
>     dwc3_decode_set_isoch_delay
>     dwc3_decode_ctrl
> 
> These functions are used also in inroduced cdns3 driver.
> 
> All functions prefixes were changed from dwc3 to usb.

Ick, why?

> Also, function's parameters has been extended according to the name
> of fields in standard SETUP packet.
> Additionally, patch adds usb_decode_ctrl function to
> include/linux/usb/ch9.h file.

Why ch9.h?  It's not something that is specified in the spec, it's a
usb-specific thing :)

Also, the api for that function is not ok.  If you are going to make
this something that the whole kernel can call, you have to fix it up:

> +/**
> + * usb_decode_ctrl - Returns human readable representation of control request.
> + * @str: buffer to return a human-readable representation of control request.
> + *       This buffer should have about 200 bytes.

"about 200 bytes" is not very specific.

Pass in the length so we know we don't overflow it.

> + * @bRequestType: matches the USB bmRequestType field
> + * @bRequest: matches the USB bRequest field
> + * @wValue: matches the USB wValue field (CPU byte order)
> + * @wIndex: matches the USB wIndex field (CPU byte order)
> + * @wLength: matches the USB wLength field (CPU byte order)
> + *
> + * Function returns decoded, formatted and human-readable description of
> + * control request packet.
> + *
> + * Important: wValue, wIndex, wLength parameters before invoking this function
> + * should be processed by le16_to_cpu macro.
> + */
> +const char *usb_decode_ctrl(char *str, __u8 bRequestType, __u8 bRequest,
> +			    __u16 wValue,  __u16 wIndex, __u16 wLength);

Why are you returning a value, isn't the data stored in str?  Why not
just return an int saying if the call succeeded or not?

thanks,

greg k-h
