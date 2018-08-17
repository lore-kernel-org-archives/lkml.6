Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E802EC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A91BF218DB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:19:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A91BF218DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbeHQRWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 13:22:53 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:60928 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726356AbeHQRWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 13:22:53 -0400
Received: (qmail 1614 invoked by uid 2102); 17 Aug 2018 10:19:19 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Aug 2018 10:19:19 -0400
Date:   Fri, 17 Aug 2018 10:19:19 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Zeng Tao <prime.zeng@hisilicon.com>
cc:     gregkh@linuxfoundation.org, <mathias.nyman@linux.intel.com>,
        <drinkcat@chromium.org>, <felipe.balbi@linux.intel.com>,
        <drake@endlessm.com>, <mike.looijmans@topic.nl>, <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Thymo van Beers <thymovanbeers@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Rientjes <rientjes@google.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v2] usb: hub: try old enumeration scheme first for high
 speed devices
In-Reply-To: <1534503120-1226-1-git-send-email-prime.zeng@hisilicon.com>
Message-ID: <Pine.LNX.4.44L0.1808171018220.1451-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Aug 2018, Zeng Tao wrote:

> The new scheme is required just to support legacy low and full-speed
> devices. For high speed devices, it will slower the enumeration speed.
> So in this patch we try the "old" enumeration scheme first for high speed
> devices, and this is what Windows does since Windows 8.
> 
> Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>
> ---
> Changes in v2:
> 1. As suggested by Alan, mention in the commit log that this change is
> follow what the Window does.
> 2. As suggested by Roger, update the kernel-parameter description.
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 3 ++-
>  drivers/usb/core/hub.c                          | 5 ++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 533ff5c..95db23c 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4453,7 +4453,8 @@
>  
>  	usbcore.old_scheme_first=
>  			[USB] Start with the old device initialization
> -			scheme (default 0 = off).
> +			scheme,  applies only to low and full-speed devices
> +			 (default 0 = off).
>  
>  	usbcore.usbfs_memory_mb=
>  			[USB] Memory limit (in MB) for buffers allocated by
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 1fb2668..d265b19 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -2661,10 +2661,13 @@ static bool use_new_scheme(struct usb_device *udev, int retry,
>  	int old_scheme_first_port =
>  		port_dev->quirks & USB_PORT_QUIRK_OLD_SCHEME;
>  
> +	int quick_enumeration = (udev->speed == USB_SPEED_HIGH);

Minor style point: the preceding blank line should be eliminated.

> +
>  	if (udev->speed >= USB_SPEED_SUPER)
>  		return false;
>  
> -	return USE_NEW_SCHEME(retry, old_scheme_first_port || old_scheme_first);
> +	return USE_NEW_SCHEME(retry, old_scheme_first_port || old_scheme_first
> +			      || quick_enumeration);
>  }
>  
>  /* Is a USB 3.0 port in the Inactive or Compliance Mode state?

Aside from that:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

