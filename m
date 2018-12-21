Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F6FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 23:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED932192C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 23:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2iG16Bv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392250AbeLUXcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 18:32:17 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41356 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389090AbeLUXcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 18:32:17 -0500
Received: by mail-pg1-f193.google.com with SMTP id m1so3138333pgq.8;
        Fri, 21 Dec 2018 15:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=972Q/ID6tNo1oexSU0q+tF0kQPjBVs+hkbKYzqx2eL4=;
        b=P2iG16BvKtu6NhjsbCJjDy6FbMyzMmb5A1WpzguYcAPTc65f95ztIO/QczOSriA76t
         8nHGk1kaa2FS5EVlcFoK4qn/aBUhUBx7B2SBRfkF3wXJfGeOSUc3+QrGhWkeczal2nKN
         6JBSViAdplRanQAaRwCIg+fvrLzd8C1XyGA1X//Q3g4AxK/oU+bX4lCTZ2iPhmGNLjkf
         MdijLrXiqU29adSMeBCmBEp/tgoIXHK/59smJKH5psl+BcfMu5RpTaDWF8W1pCmvTfhQ
         PkKqKjcbe+TXDSLCj8LQeEdrHJzHoHo7luOtcYT3x3Fsjfoy2zca7qZHu1qKEbdp1WBU
         eodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=972Q/ID6tNo1oexSU0q+tF0kQPjBVs+hkbKYzqx2eL4=;
        b=VoWUipk3WPdRTqq/votjKBMqtEd1xGRx8omiCSZihYTuskeXWE37zr4F/4tgNp6q0K
         paM62IXfLON6zEhLE9u3rZd6R9bdH1dwzrHblhZDZQEDrBRsuh0lAIEiUn+DT0n4wWAx
         Y4dVpQ+8CQA733oWpjgyUVNHTfvxu+vJpn/BsMEfW5Rq78EI/y9PULxEt5yVN9/ccIdl
         p9e2TBioUrZAWIdq6o7zYYyym9+Ptk0v2Mfzflfz37w156fbuVYVkLJZtGk2n07Reory
         e/2z2yrmSlKFbl2/BpEfYlHuqJpqE2A345P4yuSpmFgUVcVuC8M9oGA6KBN/iZZkhes/
         ce7Q==
X-Gm-Message-State: AJcUukfsgytG2xMZDpN2UjXzDKKQRJtK9/9QzciTvoBZojzPwNAEaXZg
        tb8zoA/kawaI+aikyqjSfgg=
X-Google-Smtp-Source: ALg8bN6DWmet/Fg4xrOap/XRUyK7XMbf8IrqzeTprqNAeF9v8KdR+bLIWFF9K2YAn5c9NYVpzL6zkw==
X-Received: by 2002:a63:1f4e:: with SMTP id q14mr4101073pgm.88.1545435136215;
        Fri, 21 Dec 2018 15:32:16 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n21sm34682480pfg.84.2018.12.21.15.32.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 15:32:15 -0800 (PST)
Date:   Fri, 21 Dec 2018 15:32:14 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (lm80) fix a missing check of the status of
 SMBus read
Message-ID: <20181221233214.GA10894@roeck-us.net>
References: <20181221190134.930-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221190134.930-1-kjlu@umn.edu>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 01:01:33PM -0600, Kangjie Lu wrote:
> If lm80_read_value() fails, it returns a negative number instead of the
> correct read data. Therefore, we should avoid using the data if it
> fails.
> 
> The fix checks if lm80_read_value() fails, and if so, returns with the
> error number.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
[ change log goes here ]

>  drivers/hwmon/lm80.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
> index 08e3945a6fbf..d91333557f04 100644
> --- a/drivers/hwmon/lm80.c
> +++ b/drivers/hwmon/lm80.c
> @@ -360,6 +360,7 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
>  	struct i2c_client *client = data->client;
>  	unsigned long min, val;
>  	u8 reg;
> +	int rv;
>  	int err = kstrtoul(buf, 10, &val);
>  	if (err < 0)
>  		return err;

Now we have 'rv' and 'err'.

My earlier comments didn't mean to suggest that we should now have two
different variables to handle errors.

Never mind, I'll fix it all up myself. No need to resend.

Guenter

> @@ -390,8 +391,11 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
>  		return -EINVAL;
>  	}
>  
> -	reg = (lm80_read_value(client, LM80_REG_FANDIV) &
> -	       ~(3 << (2 * (nr + 1)))) | (data->fan_div[nr] << (2 * (nr + 1)));
> +	rv = lm80_read_value(client, LM80_REG_FANDIV);
> +	if (rv < 0)
> +		return rv;
> +	reg = (rv & ~(3 << (2 * (nr + 1))))
> +	    | (data->fan_div[nr] << (2 * (nr + 1)));
>  	lm80_write_value(client, LM80_REG_FANDIV, reg);
>  
>  	/* Restore fan_min */
