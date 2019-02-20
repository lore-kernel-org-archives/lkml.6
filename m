Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F8EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3060F2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDkVLYh7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfBTPfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:35:30 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35594 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbfBTPfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:35:30 -0500
Received: by mail-pg1-f194.google.com with SMTP id s198so12054054pgs.2;
        Wed, 20 Feb 2019 07:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WmAAGsSCPamxS6QsYyp6MZrdJ8c46CKOqUNG+Yp75Gc=;
        b=XDkVLYh7DQl04ReMszpW+QSQAypNERQT268eUtkAnB4PerqFqZkYQZmjTHp6rYKquJ
         AXN+8rgrL63ZJPUjGJQ9MgIYkM9n5g1EJuOEMXZUyCIAfrhmqLJRLJj8i4lCtnKj5EFy
         WSHp+rfJau1XAbPSRNM+OV4N8YUcou5gWl7UB8VF5dGPTOOXA9DhWOMP5fMLgXkSV3C2
         xHNPu635NcFY66QfNcrP7VjLZ5KIM3pn28iWnvWgZaGore4Xf2faAJcTZIlzVAntHD6u
         d/yp3XEUbWznY1SvUqscfur90mWOFrX6hD1yU6jrMpXNAKXfFvbiLk+dhNbfSKKxKzcw
         JVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WmAAGsSCPamxS6QsYyp6MZrdJ8c46CKOqUNG+Yp75Gc=;
        b=LQ2+Lww+oN60y9mx1ZNLUoUvB74jOSCexMFRC3l9Pihs3Yaqs/JjejorWPHNVh0cC4
         YXAa75dIUzHlG0NDFMNkp/SouhiH2fGTto7caTOMXxQYnjOjRLQY/lxxqWfzIAJmMzr9
         z1qFmyx06MX4TmFHw4HcbRmlaHUYb3SypQkRzJBGscfFBhBsH5WspgK4Mq1IAt8Xrncp
         bz64y4FdLE/FaO013bYpdM27VLKy3Bu+AniEbbfdTIg5J3jELYb1r25xhEPdbC09lDcd
         U6iZKNYOkMR8M3D9MdoX+Ea1ErCttIVCdpAiTY1bvYEGYZgZ1wvSsevimQOwzBOx1fuK
         uE/g==
X-Gm-Message-State: AHQUAuZgeJKKt3Ap1J8rifU43l08ls8kbVDVFh3ZEyGi3xvOQJaQ9D15
        D0jMo5b9LYkwlRtPe4ve5T0=
X-Google-Smtp-Source: AHgI3IYoSEIXLXzrTZ3YDQvM2tabI8SX2a7fO4zaTNRLizQd78p/TJK6REQyVo6IyCA3wwC4sVs9Bw==
X-Received: by 2002:a63:cc15:: with SMTP id x21mr6565927pgf.380.1550676929247;
        Wed, 20 Feb 2019 07:35:29 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w4sm40282408pgk.16.2019.02.20.07.35.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 07:35:27 -0800 (PST)
Subject: Re: [PATCHv3] usb: typec: tps6598x: handle block writes separately
 with plain-I2C adapters
To:     Nikolaus Voss <nv@vosn.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
References: <20190220110017.BFA344CE86@mail.steuer-voss.de>
 <20190220151138.12332-1-nv@vosn.de>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <8dc1a931-c9f7-a46a-42dc-fdcd2274343b@roeck-us.net>
Date:   Wed, 20 Feb 2019 07:35:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190220151138.12332-1-nv@vosn.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/19 7:11 AM, Nikolaus Voss wrote:
> From: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
> 
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

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Note that tps6598x_exec_cmd() is only called with in_len == out_len == 0
and NULL data pointers. It might make sense to simplify the function and
drop the unused parameters as well as the associated code.

Guenter

> ---
> v2: fix tps6598x_exec_cmd also
> v3: use fixed length for stack buffer
> ---
>   drivers/usb/typec/tps6598x.c | 26 ++++++++++++++++++++------
>   1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/typec/tps6598x.c b/drivers/usb/typec/tps6598x.c
> index c84c8c189e90..eb8046f87a54 100644
> --- a/drivers/usb/typec/tps6598x.c
> +++ b/drivers/usb/typec/tps6598x.c
> @@ -110,6 +110,20 @@ tps6598x_block_read(struct tps6598x *tps, u8 reg, void *val, size_t len)
>   	return 0;
>   }
>   
> +static int tps6598x_block_write(struct tps6598x *tps, u8 reg,
> +				void *val, size_t len)
> +{
> +	u8 data[TPS_MAX_LEN + 1];
> +
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

