Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4015ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EFE820854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s3s5boXB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EFE820854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388263AbeGWXjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 19:39:01 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41227 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388153AbeGWXjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 19:39:01 -0400
Received: by mail-pg1-f195.google.com with SMTP id z8-v6so1368951pgu.8;
        Mon, 23 Jul 2018 15:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9z233ThksZMfrIixsN4BxqSmYmhEliqiUbc9JfcfznU=;
        b=s3s5boXBUomMfleXzWYF73ebm8m2B9+1BI4TLAZdkBDH/ADOjDGHELFiMTXWe33sUQ
         b4BSmyQW1t5sohWLqezbvR7FkFMyMF4RrkvdLn6DwCUZeSY/diTfAmDaXbzjSZO/WZlW
         If02jCmg5NHxShaJQAZB0E/RxDzzdbfMjnWzEH8ca4th4EGrEUlk7UCBkl4cP7NnciiA
         TqVWLesyu0ZsR8uEAaM7XhjU3YtCagWnSyhXJho2duBU2VeV/TGgBMj/uqbXTNcz7QHM
         XTx2lb5j+T/l84NBgLZz7yEKk+pzN3xDBQNKbaQDpUtiVWmsmfbFM/FwLA1jDTtEbQkt
         DM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9z233ThksZMfrIixsN4BxqSmYmhEliqiUbc9JfcfznU=;
        b=Vx9g5hng2fygcF8Sq8lkvi7kStR31vLcmOrpDxxfAcAlOK/jP0jKDf+75uhsJVJvOy
         j5ymsqDLp9j2b0YCk1zCymii0W0nU7lVbq0VyJ1r+vg/0Y3N2rcDA/jXVkrOF7aTZMXd
         io9xozGhbm20Abqov0X9f4rGKZYNoMK1R9UjfZoamdatFJ4Rb+XpufuNWBidxzimibL7
         6Uwc5y3YDL1WvgiXP7DKd1FEzL/4SjMCvGL5qGEXR+jz2M06l3HacATvZobhK2eN6NJW
         vuycyC+xdX9VNokMbCIa3oviMNDkHKPjg6ZhfXglriOjUIZOpqrnHRx3DyURc6CMDWEF
         IA1w==
X-Gm-Message-State: AOUpUlHxpeLtylPZTOYoZRTQQQN+aakyiGUWxb7iSReAwLelSIS/A7TL
        uK+bCwE1g4lSQXlC4iQRels=
X-Google-Smtp-Source: AAOMgpfemSKEf8w0Nol/7yxv3c7/DCai5EFTInINE2gx9XYsPhG72/I/BBF54fCV2lOQeSc/Lq5ciA==
X-Received: by 2002:a65:62cd:: with SMTP id m13-v6mr13765667pgv.280.1532385337864;
        Mon, 23 Jul 2018 15:35:37 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id a17-v6sm15530632pfg.106.2018.07.23.15.35.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 15:35:36 -0700 (PDT)
Date:   Mon, 23 Jul 2018 15:35:34 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Nick Dyer <nick@shmanahar.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Chris Healy <cphealy@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH v1 07/10] Input: atmel_mxt_ts - zero terminate config
 firmware file
Message-ID: <20180723223534.GK100814@dtor-ws>
References: <20180720215122.23558-1-nick@shmanahar.org>
 <20180720215122.23558-7-nick@shmanahar.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720215122.23558-7-nick@shmanahar.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 10:51:19PM +0100, Nick Dyer wrote:
> From: Nick Dyer <nick.dyer@itdev.co.uk>
> 
> We use sscanf to parse the configuration file, so it's necessary to zero
> terminate the configuration otherwise a truncated file can cause the
> parser to run off into uninitialised memory.
> 
> Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c | 36 +++++++++++++++++-------
>  1 file changed, 26 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index 0ce126e918f1..2d1fddafb7f9 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -279,7 +279,7 @@ enum mxt_suspend_mode {
>  
>  /* Config update context */
>  struct mxt_cfg {
> -	const u8 *raw;
> +	u8 *raw;
>  	size_t raw_size;
>  	off_t raw_pos;
>  
> @@ -1451,14 +1451,21 @@ static int mxt_update_cfg(struct mxt_data *data, const struct firmware *fw)
>  	u32 info_crc, config_crc, calculated_crc;
>  	u16 crc_start = 0;
>  
> -	cfg.raw = fw->data;
> +	/* Make zero terminated copy of the OBP_RAW file */
> +	cfg.raw = kzalloc(fw->size + 1, GFP_KERNEL);

kmemdup_nul()? I guess config it not that big to be concerned with
kmalloc() vs vmalloc() and allocation failures...

> +	if (!cfg.raw)
> +		return -ENOMEM;
> +
> +	memcpy(cfg.raw, fw->data, fw->size);
> +	cfg.raw[fw->size] = '\0';
>  	cfg.raw_size = fw->size;
>  
>  	mxt_update_crc(data, MXT_COMMAND_REPORTALL, 1);
>  
>  	if (strncmp(cfg.raw, MXT_CFG_MAGIC, strlen(MXT_CFG_MAGIC))) {
>  		dev_err(dev, "Unrecognised config file\n");
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto release_raw;
>  	}
>  
>  	cfg.raw_pos = strlen(MXT_CFG_MAGIC);
> @@ -1470,7 +1477,8 @@ static int mxt_update_cfg(struct mxt_data *data, const struct firmware *fw)
>  			     &offset);
>  		if (ret != 1) {
>  			dev_err(dev, "Bad format\n");
> -			return -EINVAL;
> +			ret = -EINVAL;
> +			goto release_raw;
>  		}
>  
>  		cfg.raw_pos += offset;
> @@ -1478,26 +1486,30 @@ static int mxt_update_cfg(struct mxt_data *data, const struct firmware *fw)
>  
>  	if (cfg.info.family_id != data->info->family_id) {
>  		dev_err(dev, "Family ID mismatch!\n");
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto release_raw;
>  	}
>  
>  	if (cfg.info.variant_id != data->info->variant_id) {
>  		dev_err(dev, "Variant ID mismatch!\n");
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto release_raw;
>  	}
>  
>  	/* Read CRCs */
>  	ret = sscanf(cfg.raw + cfg.raw_pos, "%x%n", &info_crc, &offset);
>  	if (ret != 1) {
>  		dev_err(dev, "Bad format: failed to parse Info CRC\n");
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto release_raw;
>  	}
>  	cfg.raw_pos += offset;
>  
>  	ret = sscanf(cfg.raw + cfg.raw_pos, "%x%n", &config_crc, &offset);
>  	if (ret != 1) {
>  		dev_err(dev, "Bad format: failed to parse Config CRC\n");
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto release_raw;
>  	}
>  	cfg.raw_pos += offset;
>  
> @@ -1530,8 +1542,10 @@ static int mxt_update_cfg(struct mxt_data *data, const struct firmware *fw)
>  			MXT_INFO_CHECKSUM_SIZE;
>  	cfg.mem_size = data->mem_size - cfg.start_ofs;
>  	cfg.mem = kzalloc(cfg.mem_size, GFP_KERNEL);
> -	if (!cfg.mem)
> -		return -ENOMEM;
> +	if (!cfg.mem) {
> +		ret = -ENOMEM;
> +		goto release_raw;
> +	}
>  
>  	ret = mxt_prepare_cfg_mem(data, &cfg);
>  	if (ret)
> @@ -1570,6 +1584,8 @@ static int mxt_update_cfg(struct mxt_data *data, const struct firmware *fw)
>  	/* T7 config may have changed */
>  	mxt_init_t7_power_cfg(data);
>  
> +release_raw:
> +	kfree(cfg.raw);
>  release_mem:
>  	kfree(cfg.mem);
>  	return ret;
> -- 
> 2.17.1
> 

-- 
Dmitry
