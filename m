Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17C6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A939F2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:13:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A939F2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbeKTAhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 19:37:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:56474 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728252AbeKTAhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 19:37:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B3A7AAC3C;
        Mon, 19 Nov 2018 14:13:52 +0000 (UTC)
Message-ID: <1542636268.945.4.camel@suse.com>
Subject: Re: [PATCH v2] usb: hub: add retry routine after intr URB sumbit
 error
From:   Oliver Neukum <oneukum@suse.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        stern@rowland.harvard.edu
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Date:   Mon, 19 Nov 2018 15:04:28 +0100
In-Reply-To: <20181119140208.11590-1-nsaenzjulienne@suse.de>
References: <20181119140208.11590-1-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mo, 2018-11-19 at 15:02 +0100, Nicolas Saenz Julienne wrote:
> 
> +static void hub_retry_irq_urb(struct timer_list *t)
> +{
> +	struct usb_hub *hub = from_timer(hub, t, irq_urb_retry);
> +	int status;
> +
> +	if (hub->disconnected || hub->quiescing)
> +		return;
> +
> +	dev_err(hub->intfdev, "retrying int urb\n");
> +	status = usb_submit_urb(hub->urb, GFP_ATOMIC);
> +	if (status && status != -ENODEV && status != -EPERM &&
> +	    status != -ESHUTDOWN)
> +		mod_timer(&hub->irq_urb_retry,
> +			  jiffies + msecs_to_jiffies(MSEC_PER_SEC));
> +}
> +
>  static void kick_hub_wq(struct usb_hub *hub)
>  {
>  	struct usb_interface *intf;
> @@ -713,8 +729,12 @@ static void hub_irq(struct urb *urb)
>  		return;
>  
>  	status = usb_submit_urb(hub->urb, GFP_ATOMIC);
> -	if (status != 0 && status != -ENODEV && status != -EPERM)
> +	if (status != 0 && status != -ENODEV && status != -EPERM &&
> +	    status != -ESHUTDOWN) {
>  		dev_err(hub->intfdev, "resubmit --> %d\n", status);
> +		mod_timer(&hub->irq_urb_retry,
> +			  jiffies + msecs_to_jiffies(MSEC_PER_SEC));
> +	}
>  }
>  
>  /* USB 2.0 spec Section 11.24.2.3 */
> @@ -1268,6 +1288,7 @@ static void hub_quiesce(struct usb_hub *hub, enum hub_quiescing_type type)
>  	}
>  
>  	/* Stop hub_wq and related activity */
> +	del_timer_sync(&hub->irq_urb_retry);

That is a race condition. You kill the timer here, but the URB may
still be in flight. And if it fails, it will restart the error
handler. You have to introduce a flag or poison the URB.

>  	usb_kill_urb(hub->urb);
>  	if (hub->has_indicators)
>  		cancel_delayed_work_sync(&hub->leds);
> 

	Regards
		Oliver

