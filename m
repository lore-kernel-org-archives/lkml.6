Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1CAC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F1D2224E0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F1D2224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387619AbeKMXuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 18:50:09 -0500
Received: from mga18.intel.com ([134.134.136.126]:46233 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732959AbeKMXuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 18:50:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 05:51:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,499,1534834800"; 
   d="scan'208";a="249340710"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by orsmga004.jf.intel.com with ESMTP; 13 Nov 2018 05:51:51 -0800
Subject: Re: [PATCH] usb: core: Fix hub port connection events lost
To:     Dennis Wassenberg <dennis.wassenberg@secunet.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bin Liu <b-liu@ti.com>,
        Maxim Moseychuk <franchesko.salias.hudro.pedros@gmail.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Dominik Bozek <dominikx.bozek@intel.com>,
        USB list <linux-usb@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.1810261000040.1467-100000@iolanthe.rowland.org>
 <ac4ea7fa-9fd7-0987-a70c-11a26465e680@linux.intel.com>
 <4140fee5-8935-daed-8438-d04d7f1198b2@secunet.com>
 <0427ea9d-a04c-61bf-9f64-5f2a42ab0072@linux.intel.com>
 <414018c4-60ed-279f-f77e-b31f4813a540@secunet.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <1573e062-d095-a8d0-5b1b-e2364ad0729b@linux.intel.com>
Date:   Tue, 13 Nov 2018 15:55:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <414018c4-60ed-279f-f77e-b31f4813a540@secunet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.11.2018 15:40, Dennis Wassenberg wrote:
> This will clear the USB_PORT_FEAT_C_CONNECTION bit in case of a hub port reset
> only if a device is was attached to the hub port before resetting the hub port.
> 
> Using a Lenovo T480s attached to the ultra dock it was not possible to detect
> some usb-c devices at the dock usb-c ports because the hub_port_reset code
> will clear the USB_PORT_FEAT_C_CONNECTION bit after the actual hub port reset.
> Using this device combo the USB_PORT_FEAT_C_CONNECTION bit was set between the
> actual hub port reset and the clear of the USB_PORT_FEAT_C_CONNECTION bit.
> This ends up with clearing the USB_PORT_FEAT_C_CONNECTION bit after the
> new device was attached such that it was not detected.
> 
> This patch will not clear the USB_PORT_FEAT_C_CONNECTION bit if there is
> currently no device attached to the port before the hub port reset.
> This will avoid clearing the connection bit for new attached devices.
> 
> Signed-off-by: Dennis Wassenberg <dennis.wassenberg@secunet.com>
> ---
>   drivers/usb/core/hub.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index c6077d582d29..2731fad6f659 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -2849,7 +2849,9 @@ static int hub_port_reset(struct usb_hub *hub, int port1,
>   					USB_PORT_FEAT_C_BH_PORT_RESET);
>   			usb_clear_port_feature(hub->hdev, port1,
>   					USB_PORT_FEAT_C_PORT_LINK_STATE);
> -			usb_clear_port_feature(hub->hdev, port1,
> +
> +			if (udev)
> +				usb_clear_port_feature(hub->hdev, port1,
>   					USB_PORT_FEAT_C_CONNECTION);
>   
>   			/*
> 

Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>
