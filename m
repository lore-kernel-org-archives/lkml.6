Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F570C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 001142146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hiy4rLnG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfBTOpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:45:21 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43376 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfBTOpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:45:21 -0500
Received: by mail-pl1-f196.google.com with SMTP id m10so2671792plt.10;
        Wed, 20 Feb 2019 06:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cmveUU1OUg9qtSUEVNZ76jXR0tE7q1+Z82z6f7l45k8=;
        b=Hiy4rLnGI+kGN+YFHhuUP4DIReh2IOGTewBthuedAaNWUuv3n39rFpLl7fJhgWpqcC
         E2+aIVCmdACzef/fYqQZAclvAzpujn12JHCVqU0km/70HlClaZzyqZPr9WEQcXnu8X1h
         ClE5VjgsNQXgN0KSuGhndMSyrBqbgBwWIXQvABaEPWne/s6paL7/pbOhz8MPJGi2p4fB
         SeTdE8RiRUFthAiJkKdA8nFdBGvWJkRKviXd+zAXDN3yVjw6WNRfOWCmVjcAsWFO9OW6
         uTFsYL558rPUcUaWuOPqgmuIhhtIbFQIpiV342vVCEo484xFZqx+/rP/z8j1sjvSv9rd
         Jebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cmveUU1OUg9qtSUEVNZ76jXR0tE7q1+Z82z6f7l45k8=;
        b=fN9CZzSlBnWe0qQRXvpSQ4WByoQOuOjDmxzIBbJMNzL1ZB+CBAdqyUbQO0dfRMKQB7
         B4KuxPTbjvaCzO/RA+Sto1cQodCT+X6vFLE8YXfZvDrxJCVhKi7ezXy1hC+0/+z66w2M
         5YSpk860WwR31qkifR3Yrj9ZGSrMnYkcwfKUdy45kfcrJ5jt9Cl2865pc+26hQBefGFD
         Owx2usNyevQFC+rfwhYWmQyfdOPg5TJkW5u7AhLJOSLg6Z60vAkfmvfCPWSkxhVH1xxl
         haJw42Y3O9Gjgjczm5u6BdOCgsw96d0QmKUFyf+Gl0DoInpKUTUKCjktOEYcA9Cwy8K9
         Aftw==
X-Gm-Message-State: AHQUAuaUPSmPNYXXoq7KvRW3RD/yDx3IxElMwyP4j0qb630DDenI+gDg
        rQWzVIumT0m0iZYKW/BaUPY8f2cX
X-Google-Smtp-Source: AHgI3IbWfvYaraOm5fGXxMoKNjvBPAuwaxWCzCyS3p9n+GxmU5+p5nwvJK+IDj1eaXv2BAmgvaElog==
X-Received: by 2002:a17:902:207:: with SMTP id 7mr31596536plc.142.1550673920344;
        Wed, 20 Feb 2019 06:45:20 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n6sm21251116pgv.86.2019.02.20.06.45.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 06:45:19 -0800 (PST)
Subject: Re: [PATCHv2] usb: typec: tps6598x: handle block writes separately
 with plain-I2C adapters
To:     Nikolaus Voss <nv@vosn.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        nikolaus.voss@loewensteinmedical.de
References: <20180425142209.30745-1-heikki.krogerus@linux.intel.com>
 <20190220110017.BFA344CE86@mail.steuer-voss.de>
 <20190220125731.02E274CFE0@mail.steuer-voss.de>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <be1f988c-5b2f-91cf-d210-1e28c09f106f@roeck-us.net>
Date:   Wed, 20 Feb 2019 06:45:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190220125731.02E274CFE0@mail.steuer-voss.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/19 4:57 AM, Nikolaus Voss wrote:
> Commit 1a2f474d328f handles block _reads_ separately with plain-I2C
> adapters, but the problem described with regmap-i2c not handling
> SMBus block transfers (i.e. read and writes) correctly also exists
> with writes.
> 
> As workaround, this patch adds a block write function the same way
> 1a2f474d328f adds a block read function.
> 
> Fixes: 1a2f474d328f ("usb: typec: tps6598x: handle block reads separately with plain-I2C adapters")
> Fixes: 0a4c005bd171 ("usb: typec: driver for TI TPS6598x USB Power Delivery controllers")
> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
> ---
> v2: fix tps6598x_exec_cmd also
> ---
>   drivers/usb/typec/tps6598x.c | 26 ++++++++++++++++++++------
>   1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/typec/tps6598x.c b/drivers/usb/typec/tps6598x.c
> index c84c8c189e90..c54b73fb2a2f 100644
> --- a/drivers/usb/typec/tps6598x.c
> +++ b/drivers/usb/typec/tps6598x.c
> @@ -110,6 +110,20 @@ tps6598x_block_read(struct tps6598x *tps, u8 reg, void *val, size_t len)
>   	return 0;
>   }
>   
> +static int tps6598x_block_write(struct tps6598x *tps, u8 reg,
> +				void *val, size_t len)
> +{
> +	u8 data[len + 1];
> +

You should use TPS_MAX_LEN + 1 here to avoid the variable length array.
See upstream commit 0bb95f80a38f8 ("Makefile: Globally enable VLA warning")
and 8d361fa2c29dc ("usb: typec: tps6598x: Remove VLA usage"). Not sure if
the WARN_ON introduced by 8d361fa2c29dc is really needed; I dislike
unnecessary runtime checks.

Guenter

> +	if (!tps->i2c_protocol)
> +		return regmap_raw_write(tps->regmap, reg, val, len);
> +
> +	data[0] = len;
> +	memcpy(&data[1], val, len);
> +
> +	return regmap_raw_write(tps->regmap, reg, data, sizeof(data));
> +}
> +
>   static inline int tps6598x_read16(struct tps6598x *tps, u8 reg, u16 *val)
>   {
>   	return tps6598x_block_read(tps, reg, val, sizeof(u16));
> @@ -127,23 +141,23 @@ static inline int tps6598x_read64(struct tps6598x *tps, u8 reg, u64 *val)
>   
>   static inline int tps6598x_write16(struct tps6598x *tps, u8 reg, u16 val)
>   {
> -	return regmap_raw_write(tps->regmap, reg, &val, sizeof(u16));
> +	return tps6598x_block_write(tps, reg, &val, sizeof(u16));
>   }
>   
>   static inline int tps6598x_write32(struct tps6598x *tps, u8 reg, u32 val)
>   {
> -	return regmap_raw_write(tps->regmap, reg, &val, sizeof(u32));
> +	return tps6598x_block_write(tps, reg, &val, sizeof(u32));
>   }
>   
>   static inline int tps6598x_write64(struct tps6598x *tps, u8 reg, u64 val)
>   {
> -	return regmap_raw_write(tps->regmap, reg, &val, sizeof(u64));
> +	return tps6598x_block_write(tps, reg, &val, sizeof(u64));
>   }
>   
>   static inline int
>   tps6598x_write_4cc(struct tps6598x *tps, u8 reg, const char *val)
>   {
> -	return regmap_raw_write(tps->regmap, reg, &val, sizeof(u32));
> +	return tps6598x_block_write(tps, reg, &val, sizeof(u32));
>   }
>   
>   static int tps6598x_read_partner_identity(struct tps6598x *tps)
> @@ -229,8 +243,8 @@ static int tps6598x_exec_cmd(struct tps6598x *tps, const char *cmd,
>   		return -EBUSY;
>   
>   	if (in_len) {
> -		ret = regmap_raw_write(tps->regmap, TPS_REG_DATA1,
> -				       in_data, in_len);
> +		ret = tps6598x_block_write(tps, TPS_REG_DATA1,
> +					   in_data, in_len);
>   		if (ret)
>   			return ret;
>   	}
> 

