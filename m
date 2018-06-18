Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=BODY_8BITS,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12ED2C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 07:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D41208E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 07:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IKHMMYfF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D41208E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755240AbeFRHou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 03:44:50 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38943 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754636AbeFRHor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 03:44:47 -0400
Received: by mail-wm0-f67.google.com with SMTP id p11-v6so13568895wmc.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 00:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4GGfxzmuxipuT1gKbZviJZawPvwar4wBFaLDWRO1nI8=;
        b=IKHMMYfFVYxKL5a04cbaiT0WEpkWknz3l2/YcE2NCMhwS5fSiA8OAF6od+7LEUigyd
         dMPsmDPEjWJjbFxEtSk1M5vRtPOw+gQDh4bs1wPxzP9kwqaAp+FiSm3ImfmvHd3gKKj6
         ogZU+f7pYvFley+g2snC082fQmR7xCg5sCbNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4GGfxzmuxipuT1gKbZviJZawPvwar4wBFaLDWRO1nI8=;
        b=OwStdNzK3T81mH/Os6/F0TZC4APTpgopr5V0rn4G2L2K/MPAo/XpwBnWJyYIIvwAHo
         +K2Ke81J44IpZ95Vd6bbgP6YnYVOW14PvLfigJ9MtrZjHXzTVF02ZDoLxT7XTgoMlPmf
         Y8sPnXnW/bww/wo4I8NbfDObutJY4tny4KdOaJH8+k5dqf3grY1/cpsoz4Ah6OAfe+TV
         kNYraGpWKGPBPER7u6NyBXWNvnD4IyaZ1XARd/dH/EdZ4VG2/MoVoGHzp6w9UpKLwcTL
         jukA54HpklIK1NUlFpQuvrvfozuUQ93CD9qTURAuk5sGGHHEdNBO9KCpWXyAFhpTqucl
         sA3Q==
X-Gm-Message-State: APt69E2xM8cUiAHyF4D4ZfXG2teps1HffGtT2I0/T3ZR70NKyvM6A73j
        l43fmcZ+8hfOZxLz3f6qpVeomg==
X-Google-Smtp-Source: ADUXVKLlDZn0XG1pcz7yIckyrbN0hYfXaJoC7gKlfQyW/2LNCYgXLJQJ9GRvT55sOBUFl1KtvSMwdQ==
X-Received: by 2002:a1c:3bc4:: with SMTP id i187-v6mr8198847wma.57.1529307886624;
        Mon, 18 Jun 2018 00:44:46 -0700 (PDT)
Received: from dell ([95.149.160.78])
        by smtp.gmail.com with ESMTPSA id q201-v6sm7576079wmd.20.2018.06.18.00.44.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 00:44:45 -0700 (PDT)
Date:   Mon, 18 Jun 2018 08:44:43 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     airlied@linux.ie, hans.verkuil@cisco.com, olof@lixom.net,
        seanpaul@google.com, sadolfsson@google.com, felixe@google.com,
        bleung@google.com, darekm@google.com, marcheu@chromium.org,
        fparent@baylibre.com, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, eballetbo@gmail.com,
        Stefan Adolfsson <sadolfsson@chromium.org>
Subject: Re: [PATCH v7 3/6] mfd: cros-ec: Increase maximum mkbp event size
Message-ID: <20180618074443.GK31141@dell>
References: <1527841154-24832-1-git-send-email-narmstrong@baylibre.com>
 <1527841154-24832-4-git-send-email-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1527841154-24832-4-git-send-email-narmstrong@baylibre.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Jun 2018, Neil Armstrong wrote:

> Having a 16 byte mkbp event size makes it possible to send CEC
> messages from the EC to the AP directly inside the mkbp event
> instead of first doing a notification and then a read.
> 
> Signed-off-by: Stefan Adolfsson <sadolfsson@chromium.org>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>  drivers/platform/chrome/cros_ec_proto.c | 40 +++++++++++++++++++++++++--------
>  include/linux/mfd/cros_ec.h             |  2 +-
>  include/linux/mfd/cros_ec_commands.h    | 19 ++++++++++++++++
>  3 files changed, 51 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index e7bbdf9..c4f6c44 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -504,10 +504,31 @@ int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
>  }
>  EXPORT_SYMBOL(cros_ec_cmd_xfer_status);
>  
> +static int get_next_event_xfer(struct cros_ec_device *ec_dev,
> +			       struct cros_ec_command *msg,
> +			       int version, uint32_t size)
> +{
> +	int ret;
> +
> +	msg->version = version;
> +	msg->command = EC_CMD_GET_NEXT_EVENT;
> +	msg->insize = size;
> +	msg->outsize = 0;
> +
> +	ret = cros_ec_cmd_xfer(ec_dev, msg);
> +	if (ret > 0) {
> +		ec_dev->event_size = ret - 1;
> +		memcpy(&ec_dev->event_data, msg->data, ec_dev->event_size);
> +	}
> +
> +	return ret;
> +}
> +
>  static int get_next_event(struct cros_ec_device *ec_dev)
>  {
>  	u8 buffer[sizeof(struct cros_ec_command) + sizeof(ec_dev->event_data)];
>  	struct cros_ec_command *msg = (struct cros_ec_command *)&buffer;
> +	static int cmd_version = 1;
>  	int ret;
>  
>  	if (ec_dev->suspended) {
> @@ -515,18 +536,19 @@ static int get_next_event(struct cros_ec_device *ec_dev)
>  		return -EHOSTDOWN;
>  	}
>  
> -	msg->version = 0;
> -	msg->command = EC_CMD_GET_NEXT_EVENT;
> -	msg->insize = sizeof(ec_dev->event_data);
> -	msg->outsize = 0;
> +	if (cmd_version == 1) {
> +		ret = get_next_event_xfer(ec_dev, msg, cmd_version,
> +				sizeof(struct ec_response_get_next_event_v1));
> +		if (ret < 0 || msg->result != EC_RES_INVALID_VERSION)
> +			return ret;
>  
> -	ret = cros_ec_cmd_xfer(ec_dev, msg);
> -	if (ret > 0) {
> -		ec_dev->event_size = ret - 1;
> -		memcpy(&ec_dev->event_data, msg->data,
> -		       sizeof(ec_dev->event_data));
> +		/* Fallback to version 0 for future send attempts */
> +		cmd_version = 0;
>  	}
>  
> +	ret = get_next_event_xfer(ec_dev, msg, cmd_version,
> +				  sizeof(struct ec_response_get_next_event));
> +
>  	return ret;
>  }
>  
> diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
> index f36125e..32caef3 100644
> --- a/include/linux/mfd/cros_ec.h
> +++ b/include/linux/mfd/cros_ec.h
> @@ -147,7 +147,7 @@ struct cros_ec_device {
>  	bool mkbp_event_supported;
>  	struct blocking_notifier_head event_notifier;
>  
> -	struct ec_response_get_next_event event_data;
> +	struct ec_response_get_next_event_v1 event_data;
>  	int event_size;
>  	u32 host_event_wake_mask;
>  };
> diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
> index f2edd99..cc0768e 100644
> --- a/include/linux/mfd/cros_ec_commands.h
> +++ b/include/linux/mfd/cros_ec_commands.h
> @@ -2093,12 +2093,31 @@ union ec_response_get_next_data {
>  	uint32_t   sysrq;
>  } __packed;
>  
> +union ec_response_get_next_data_v1 {
> +	uint8_t   key_matrix[16];
> +
> +	/* Unaligned */

That's funny!

> +	uint32_t  host_event;
> +
> +	uint32_t   buttons;
> +	uint32_t   switches;
> +	uint32_t   sysrq;
> +	uint32_t   cec_events;
> +	uint8_t    cec_message[16];

Since there are some whitespace alignment issues in here.

> +} __packed;

How come these guys have kerneldoc headers?

>  struct ec_response_get_next_event {
>  	uint8_t event_type;
>  	/* Followed by event data if any */
>  	union ec_response_get_next_data data;
>  } __packed;
>  
> +struct ec_response_get_next_event_v1 {
> +	uint8_t event_type;
> +	/* Followed by event data if any */
> +	union ec_response_get_next_data_v1 data;
> +} __packed;
> +
>  /* Bit indices for buttons and switches.*/
>  /* Buttons */
>  #define EC_MKBP_POWER_BUTTON	0

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
