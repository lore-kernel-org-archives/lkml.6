Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF1EECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E699520852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:19:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E699520852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388344AbeGWPVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 11:21:12 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:50394 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2388021AbeGWPVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 11:21:12 -0400
Received: (qmail 2969 invoked by uid 2102); 23 Jul 2018 10:19:42 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Jul 2018 10:19:42 -0400
Date:   Mon, 23 Jul 2018 10:19:42 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
cc:     arnd@arndb.de, <gregkh@linuxfoundation.org>,
        <ulf.hansson@linaro.org>, <bauer.chen@realtek.com>,
        <ricky_wu@realtek.com>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 1/5] misc: rtsx_usb: Use USB remote wakeup signaling for
 card insertion detection
In-Reply-To: <20180723102744.15140-2-kai.heng.feng@canonical.com>
Message-ID: <Pine.LNX.4.44L0.1807231018290.1644-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jul 2018, Kai-Heng Feng wrote:

> Although rtsx_usb doesn't support card removal detection, card insertion
> will resume rtsx_usb by USB remote wakeup signaling.
> 
> When rtsx_usb gets resumed, also resumes its child devices,
> rtsx_usb_sdmmc and rtsx_usb_ms, to notify them there's a card in its
> slot.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/misc/cardreader/rtsx_usb.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/misc/cardreader/rtsx_usb.c b/drivers/misc/cardreader/rtsx_usb.c
> index b97903ff1a72..fed83453e5c5 100644
> --- a/drivers/misc/cardreader/rtsx_usb.c
> +++ b/drivers/misc/cardreader/rtsx_usb.c
> @@ -723,8 +723,20 @@ static int rtsx_usb_suspend(struct usb_interface *intf, pm_message_t message)
>  	return 0;
>  }
>  
> +static int rtsx_usb_resume_child(struct device *dev, void *data)
> +{
> +	/* No need to wake up self again */
> +	if (dev == data)
> +		return 0;

Is this test actually needed?  device_for_each_child() won't enumerate 
the device it is called for, only that device's children.

> +
> +	dev_dbg(dev, "%s called\n", __func__);

Not necessary.  People can use ftrace if they want this information.

Alan Stern

> +	pm_request_resume(dev);
> +	return 0;
> +}
> +
>  static int rtsx_usb_resume(struct usb_interface *intf)
>  {
> +	device_for_each_child(&intf->dev, &intf->dev, rtsx_usb_resume_child);
>  	return 0;
>  }
>  
> @@ -734,6 +746,7 @@ static int rtsx_usb_reset_resume(struct usb_interface *intf)
>  		(struct rtsx_ucr *)usb_get_intfdata(intf);
>  
>  	rtsx_usb_reset_chip(ucr);
> +	device_for_each_child(&intf->dev, &intf->dev, rtsx_usb_resume_child);
>  	return 0;
>  }
>  
> 

