Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15CEC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 22:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D542083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 22:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FY8z80Jt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5D542083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbeLGWWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 17:22:31 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34828 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbeLGWWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 17:22:30 -0500
Received: by mail-pf1-f196.google.com with SMTP id z9so2579326pfi.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 14:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5m7KEMyhh7rRvoKE789Yidm2v9HKTvk/rpddkG2S/jI=;
        b=FY8z80JtFdluY+Hqs2Kv2P092MiI9O1jM/f6rNyb9hq+hVA+brKUkLEyjxe4QZ6bfW
         pEYwW7cgpAQeJ5i7gIbz5hsRVv5aiuPz3mcNX7FUlPpqn6u0BPTIPhE00k+V/JKzAL9T
         lrqCEunSlINfH1w6mUwEdo+3azS7aTqxTGnCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5m7KEMyhh7rRvoKE789Yidm2v9HKTvk/rpddkG2S/jI=;
        b=cCp8aJ+R/t/8jU0mTyVKjyXknRK3v93BcKjyzF/M7NCMJoFUlAx+LXqPCBlCvRhQlX
         a/chlLN2SMEluxz+UT92bu/PPQ0LpAqghoapjcI+PVVYFqxHOBe18m+HnBdHOUBjHt0G
         ZHpS/NIh2y/WyDjbaB/ILn85UCpDcl6iSU8dAY0yKVddOLWOndFiiiKnLvAxIdOKgdtp
         chIeVLN/kzqYz0KOnfGVLxK7whij2syF1Y3l5mzgOqKTtx8yIJTCvUfLqrTYbKaJghRv
         2whIViHIDY0Qsvt6E/7Y/fWAECj7XnyT7GPdSVBoIX/340bbyrBD1qteBO6a0KzdDix8
         ztog==
X-Gm-Message-State: AA+aEWa4y6an/rHDgYbE0hJiLAEAO8jkTdIB8HFjt2rV7CoPn2CBkXkk
        MnXomkfaoPk8LYadYKEg+n0Vyg==
X-Google-Smtp-Source: AFSGD/XWQyYiTNKYytFdMsvsdsNhT+tpooZVzsYyhlw1W/tse0u0N2yaoUbM/bIX746zG4xVkJcUqw==
X-Received: by 2002:a63:4101:: with SMTP id o1mr3453928pga.447.1544221349316;
        Fri, 07 Dec 2018 14:22:29 -0800 (PST)
Received: from google.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id v89sm5794399pfk.12.2018.12.07.14.22.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 14:22:27 -0800 (PST)
Date:   Fri, 7 Dec 2018 14:22:25 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     egranata@google.com
Cc:     Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@google.com>,
        Enrico Granata <egranata@chromium.org>
Subject: Re: [PATCH] mfd: cros_ec: Add support for MKBP more event flags
Message-ID: <20181207222223.GA240898@google.com>
References: <20181129195548.204153-1-egranata@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129195548.204153-1-egranata@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enrico,

On Thu, Nov 29, 2018 at 11:55:48AM -0800, egranata@google.com wrote:
> From: Enrico Granata <egranata@chromium.org>
> 
> The ChromeOS EC has support for signaling to the host that
> a single IRQ can serve multiple MKBP events.
> 
> Doing this serves an optimization purpose, as it minimizes the
> number of round-trips into the interrupt handling machinery, and
> it proves beneficial to sensor timestamping as it keeps the desired
> synchronization of event times between the two processors.
> 
> This patch adds kernel support for this EC feature, allowing the
> ec_irq to loop until all events have been served.

Might be worth being more explicit in this commit message to say that
you're adding support for EC_CMD_GET_NEXT_EVENT version 2?

> Signed-off-by: Enrico Granata <egranata@chromium.org>

Mostly looks fine; thanks for sending. I have a few small notes (and
some of that is not necessarily something resolve in this patch), but
with at least the cros_ec.h comment fixup, feel free to add my:

Reviewed-by: Brian Norris <briannorris@chromium.org>

> ---
>  drivers/mfd/cros_ec.c                   | 20 +++++++++++++--
>  drivers/platform/chrome/cros_ec_proto.c | 33 +++++++++++--------------
>  include/linux/mfd/cros_ec.h             |  3 ++-
>  include/linux/mfd/cros_ec_commands.h    | 15 +++++++++++
>  4 files changed, 50 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
> index fe6f83766144f..17903a378aa1a 100644
> --- a/drivers/mfd/cros_ec.c
> +++ b/drivers/mfd/cros_ec.c
> @@ -51,13 +51,16 @@ static const struct mfd_cell ec_pd_cell = {
>  	.pdata_size = sizeof(pd_p),
>  };
>  
> -static irqreturn_t ec_irq_thread(int irq, void *data)
> +static bool ec_handle_event(struct cros_ec_device *ec_dev)
>  {
> -	struct cros_ec_device *ec_dev = data;
>  	bool wake_event = true;
>  	int ret;
> +	bool ec_has_more_events = false;
>  
>  	ret = cros_ec_get_next_event(ec_dev, &wake_event);
> +	if (ret > 0)
> +		ec_has_more_events =
> +			ec_dev->event_data.event_type & EC_MKBP_HAS_MORE_EVENTS;
>  
>  	/*
>  	 * Signal only if wake host events or any interrupt if
> @@ -70,6 +73,19 @@ static irqreturn_t ec_irq_thread(int irq, void *data)
>  	if (ret > 0)
>  		blocking_notifier_call_chain(&ec_dev->event_notifier,
>  					     0, ec_dev);
> +
> +	return ec_has_more_events;
> +}
> +
> +static irqreturn_t ec_irq_thread(int irq, void *data)
> +{
> +	struct cros_ec_device *ec_dev = data;
> +	bool ec_has_more_events;
> +
> +	do {
> +		ec_has_more_events = ec_handle_event(ec_dev);
> +	} while (ec_has_more_events);
> +
>  	return IRQ_HANDLED;
>  }
>  
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index b6fd4838f60f3..bb126d95b2fd4 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -420,10 +420,14 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
>  	ret = cros_ec_get_host_command_version_mask(ec_dev,
>  						    EC_CMD_GET_NEXT_EVENT,
>  						    &ver_mask);

It's not exactly new here (although you're using 'ver_mask' in new
ways), but cros_ec_get_host_command_version_mask() doesn't look 100%
right. It doesn't look at msg->result, and instead just assumes that if
we got some data back (send_command() > 0), then it must have been a
success. I don't think that's really guaranteed in general, although it
might be for the specific case of EC_CMD_GET_CMD_VERSIONS.

IOW, to be definitely sure we're not looking at a garbage result in
'ver_mask', we should probably fixup
cros_ec_get_host_command_version_mask().

> -	if (ret < 0 || ver_mask == 0)
> +	if (ret < 0 || ver_mask == 0) {
>  		ec_dev->mkbp_event_supported = 0;
> -	else
> -		ec_dev->mkbp_event_supported = 1;
> +		dev_info(ec_dev->dev, "MKBP not supported\n");
> +	} else {
> +		ec_dev->mkbp_event_supported = fls(ver_mask);
> +		dev_info(ec_dev->dev, "MKBP support version %u\n",
> +			ec_dev->mkbp_event_supported - 1);
> +	}
>  
>  	/*
>  	 * Get host event wake mask, assume all events are wake events
> @@ -530,28 +534,19 @@ static int get_next_event(struct cros_ec_device *ec_dev)
>  {
>  	u8 buffer[sizeof(struct cros_ec_command) + sizeof(ec_dev->event_data)];
>  	struct cros_ec_command *msg = (struct cros_ec_command *)&buffer;
> -	static int cmd_version = 1;
> -	int ret;
> +	const int cmd_version = ec_dev->mkbp_event_supported - 1;
>  
>  	if (ec_dev->suspended) {
>  		dev_dbg(ec_dev->dev, "Device suspended.\n");
>  		return -EHOSTDOWN;
>  	}
>  
> -	if (cmd_version == 1) {
> -		ret = get_next_event_xfer(ec_dev, msg, cmd_version,
> -				sizeof(struct ec_response_get_next_event_v1));
> -		if (ret < 0 || msg->result != EC_RES_INVALID_VERSION)
> -			return ret;
> -
> -		/* Fallback to version 0 for future send attempts */
> -		cmd_version = 0;
> -	}
> -
> -	ret = get_next_event_xfer(ec_dev, msg, cmd_version,
> +	if (cmd_version == 0)
> +		return get_next_event_xfer(ec_dev, msg, 0,
>  				  sizeof(struct ec_response_get_next_event));
>  
> -	return ret;
> +	return get_next_event_xfer(ec_dev, msg, cmd_version,
> +				sizeof(struct ec_response_get_next_event_v1));
>  }
>  
>  static int get_keyboard_state_event(struct cros_ec_device *ec_dev)
> @@ -607,11 +602,13 @@ EXPORT_SYMBOL(cros_ec_get_next_event);
>  
>  u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev)
>  {
> +	u32 event_type =
> +		ec_dev->event_data.event_type & EC_MKBP_EVENT_TYPE_MASK;
>  	u32 host_event;
>  
>  	BUG_ON(!ec_dev->mkbp_event_supported);
>  
> -	if (ec_dev->event_data.event_type != EC_MKBP_EVENT_HOST_EVENT)
> +	if (event_type != EC_MKBP_EVENT_HOST_EVENT)
>  		return 0;
>  
>  	if (ec_dev->event_size != sizeof(host_event)) {
> diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
> index e44e3ec8a9c7d..eb771ceeaeed1 100644
> --- a/include/linux/mfd/cros_ec.h
> +++ b/include/linux/mfd/cros_ec.h
> @@ -152,7 +152,8 @@ struct cros_ec_device {
>  	int (*pkt_xfer)(struct cros_ec_device *ec,
>  			struct cros_ec_command *msg);
>  	struct mutex lock;
> -	bool mkbp_event_supported;
> +	/* 0 == not supported, otherwise it supports version x - 1 */

This comment belongs in the kerneldoc, which is above the struct
definition. You're invalidating the existing comment:

 * @mkbp_event_supported: True if this EC supports the MKBP event protocol.

Brian


> +	u8 mkbp_event_supported;
>  	struct blocking_notifier_head event_notifier;
>  
>  	struct ec_response_get_next_event_v1 event_data;

...
