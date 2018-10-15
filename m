Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C75C7113E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A29F8208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLAarC5k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A29F8208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbeJPDcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 23:32:02 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34063 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbeJPDcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 23:32:02 -0400
Received: by mail-pl1-f194.google.com with SMTP id f18-v6so9805003plr.1;
        Mon, 15 Oct 2018 12:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m00JvX+YttERde0a06pOFir8Ow1RCNvUFAr2CQNCH7Y=;
        b=MLAarC5kTk+1wFLtaodG7pYC8a/JGZm60iUuPEgVVb2FVG+f/ISltg8/pW8AxuIh1j
         xWYbtaikciIz4LQoVrmRnHu0B3F5ZyBb6ulKK/hJwHih9lEqq/WE/MRPbJatLyOkuMDI
         hXFsyyTFOjcdIhNiynPedGBWHS6k5pVbPGLxXrxVnw+lcFWJjaiuSJB/HxdvhBTPZH59
         BFtfMd9ZzlVJw+YNMm3wXtLxEHeyvLgNurgFNCQ8CK4gSRmbbqKzXCP4kyd6//xjif5q
         f+w/dqpzrRz5RZww6zPNUyI2yOp9p7fJws3rURFYa8uQT3VmFJhRCbTrZTEsUv7uUvwR
         7X8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=m00JvX+YttERde0a06pOFir8Ow1RCNvUFAr2CQNCH7Y=;
        b=YLjtC+iBSnVxvjf6fg7BfWr+vf31qw+DQKID6e+rb+EjWFKy6jjrX8ufKJimX3r0oU
         KxqiM624SR5S2o8Va8gHc1mZdPDunNRMN+rH0KYRad5APvy2hFqHeX0facYP4BM0279X
         FmHCjDp/3qtynxhcTZBTDVSJaMkDWSm2hSVxYEnTTcBtkRAlSEgLOPDSnSOwZRHztYkK
         cPd7gQ4gkVACB212L1QSblQwHipeHEokk6VpQrxqaPAeXk26C/cM1v2KrxBPk/7HeJQu
         eU7kot+b6zV7z/cePKst3jJ166lonK6XCPJzGpeMn0/ceZKeaJlq/LLCymCZ/xW1M45P
         ffww==
X-Gm-Message-State: ABuFfoiWyUluA+uotD7BaXL8l6ullY98DnNvPsnNC+t+va97jqdNgvOB
        uofltlrXbV2sst0whjA5X14=
X-Google-Smtp-Source: ACcGV60b7slSQHzDXTC1p1Tg0FMkoaZL3ImexJ7vx+7a2t3/cWepZPrF7hg7asAYG2bWorz+J1fQjA==
X-Received: by 2002:a17:902:d01:: with SMTP id 1-v6mr18632068plu.88.1539632721166;
        Mon, 15 Oct 2018 12:45:21 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id z70-v6sm14941449pgd.64.2018.10.15.12.45.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 12:45:20 -0700 (PDT)
Date:   Mon, 15 Oct 2018 12:45:19 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Dmitry Bazhenov <bazhenov.dn@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (pmbus) Fix page count auto-detection.
Message-ID: <20181015194519.GA21672@roeck-us.net>
References: <20181015092122.10533-1-bazhenov.dn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015092122.10533-1-bazhenov.dn@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 02:21:22PM +0500, Dmitry Bazhenov wrote:
> Devices with compatible="pmbus" field have zero initial page count,
> and pmbus_clear_faults() being called before the page count auto-
> detection does not actually clear faults because it depends on the
> page count. Non-cleared faults in its turn may fail the subsequent
> page count auto-detection.
> 
> This patch fixes this problem by calling pmbus_clear_fault_page()
> for currently set page and calling pmbus_clear_faults() after the
> page count was detected.
> 
> Signed-off-by: Dmitry Bazhenov <bazhenov.dn@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/pmbus.c      | 2 ++
>  drivers/hwmon/pmbus/pmbus_core.c | 5 ++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus.c b/drivers/hwmon/pmbus/pmbus.c
> index 7718e58dbda5..7688dab32f6e 100644
> --- a/drivers/hwmon/pmbus/pmbus.c
> +++ b/drivers/hwmon/pmbus/pmbus.c
> @@ -118,6 +118,8 @@ static int pmbus_identify(struct i2c_client *client,
>  		} else {
>  			info->pages = 1;
>  		}
> +
> +		pmbus_clear_faults(client);
>  	}
>  
>  	if (pmbus_check_byte_register(client, 0, PMBUS_VOUT_MODE)) {
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 82c3754e21e3..2e2b5851139c 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -2015,7 +2015,10 @@ static int pmbus_init_common(struct i2c_client *client, struct pmbus_data *data,
>  	if (ret >= 0 && (ret & PB_CAPABILITY_ERROR_CHECK))
>  		client->flags |= I2C_CLIENT_PEC;
>  
> -	pmbus_clear_faults(client);
> +	if (data->info->pages)
> +		pmbus_clear_faults(client);
> +	else
> +		pmbus_clear_fault_page(client, -1);
>  
>  	if (info->identify) {
>  		ret = (*info->identify)(client, info);
