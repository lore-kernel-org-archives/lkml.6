Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E143C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CEFA2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550582047;
	bh=Nj8wYvrYGt6AFFklbquPJDKCs8yATrHLgz/YPxpA9AQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JWBbfBWCUbwZghrjIfRmUMq9Gh62E8z/T8oghs3smYfZ+z14Ya6JMyE8B1+cWg5mn
	 5yplcfJTwHHg0/XZi2HMrjbK8dxVJ77lfG/6D6mRs9xqj/huyP3UkwYbFkGFyB6S3X
	 QnjjOGRCAEy3MELxjsqNJX8tixIIFVzc/J7Z5aDk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbfBSNOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 08:14:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:33482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbfBSNOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 08:14:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 549822089F;
        Tue, 19 Feb 2019 13:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550582044;
        bh=Nj8wYvrYGt6AFFklbquPJDKCs8yATrHLgz/YPxpA9AQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nf4O6AfYsjvPzmi0HuFIX9iuGb39mwUvkcGB4iDoqM2pERABAbnmEDtH9B4hdH9xO
         gU1HRRD86dbUQiqYsVf0Yl4wo25wH6kXuNGnT1gBVP+mxDdXbCUA2UwQsT9G8HLCV3
         VBscCAmEPhwLAL13sSjvCwovqJAxD0mu10XBoGzs=
Date:   Tue, 19 Feb 2019 14:14:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     devicetree@vger.kernel.org, felipe.balbi@linux.intel.com,
        mark.rutland@arm.com, linux-usb@vger.kernel.org,
        hdegoede@redhat.com, heikki.krogerus@linux.intel.com,
        andy.shevchenko@gmail.com, robh+dt@kernel.org, rogerq@ti.com,
        linux-kernel@vger.kernel.org, jbergsagel@ti.com, nsekhar@ti.com,
        nm@ti.com, sureshp@cadence.com, peter.chen@nxp.com,
        kurahul@cadence.com
Subject: Re: [PATCH v4 2/6] usb:common Separated decoding functions from dwc3
 driver.
Message-ID: <20190219131402.GB20719@kroah.com>
References: <1550173514-23573-1-git-send-email-pawell@cadence.com>
 <1550173514-23573-3-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550173514-23573-3-git-send-email-pawell@cadence.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 07:45:10PM +0000, Pawel Laszczak wrote:
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
> Also, function's parameters has been extended according to the name
> of fields in standard SETUP packet.
> Additionally, patch adds usb_decode_ctrl function to
> include/linux/usb/ch9.h file.
> 
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/common/Makefile |   2 +-
>  drivers/usb/common/debug.c  | 270 ++++++++++++++++++++++++++++++++++++
>  drivers/usb/dwc3/debug.h    | 249 ---------------------------------
>  drivers/usb/dwc3/trace.h    |   2 +-
>  include/linux/usb/ch9.h     |  25 ++++
>  5 files changed, 297 insertions(+), 251 deletions(-)
>  create mode 100644 drivers/usb/common/debug.c
> 
> diff --git a/drivers/usb/common/Makefile b/drivers/usb/common/Makefile
> index fb4d5ef4165c..3d3d2962ea4b 100644
> --- a/drivers/usb/common/Makefile
> +++ b/drivers/usb/common/Makefile
> @@ -4,7 +4,7 @@
>  #
>  
>  obj-$(CONFIG_USB_COMMON)	  += usb-common.o
> -usb-common-y			  += common.o
> +usb-common-y			  += common.o debug.o

It's nice to have these in a common place, but you just bloated all of
the USB-enabled systems in the world for the use of 2 odd-ball system
controllers that almost no one has :)

So, any way to only pull in this file if you actually need these
functions?

thanks,

greg k-h
