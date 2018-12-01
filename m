Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541DCC04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 18:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208372082F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 18:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLPczgDc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 208372082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725785AbeLBFs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 00:48:28 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43395 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbeLBFs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 00:48:28 -0500
Received: by mail-pg1-f195.google.com with SMTP id v28so3906678pgk.10;
        Sat, 01 Dec 2018 10:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1HCnnsufm9IWVC9Bq0TX2KEa5Pi6y2qITsCFACxUnKY=;
        b=BLPczgDcyI54jiHVDOcvJFlmPb+fR3+3OoVfBRJmBrBchjrftF3chmrHbnCnLFxMCt
         +puz5Sx+E/S/bQyekhg591zeA97I7udnXRhTK3qGHqK9ki1DZro3VDZBiGiovWV35GuF
         rAi0pgj2E8KZeImUe2YXQ6DrWi2I5R72Jpb+J4QDddfjz4w+yuD45UuziMRH/4+lkQeX
         D3yrtMSEaUUrc0HWpQ489/hxm8j2/1uYKpa9lZbgmANbBgvOLH9IHkughlGrPj3rMVgB
         zdDzp91wJgTsr0aVU2wqvydvJwjrSuo2Uf9XkP1aYtBJogd0ok/r0mz/SOlD6NxQFbPo
         Kfpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1HCnnsufm9IWVC9Bq0TX2KEa5Pi6y2qITsCFACxUnKY=;
        b=Z00QGWwRMShsEPwRNAGWFEqur/zOL2anKwVwD2uY0kqrkJ1MS4U9BRNEBET/fGZcf0
         U5/Sm1pD98o0bLPKX7o7WjQ5kMsgAtZV9CTkAfq4yhicnBghETSR9hAybKHv+fH2mq6w
         WrwCe1HCq4yCDswQPd8SVczAPsLX5pbD9wks8cPy/L0wOiQ81pQ9ifhQ11PjMxRymyZe
         VQrkEeV4N69rbLe+L1TfXqmYymX1J2MEP+Rv9A7PzStoxB4a86cAbO21Cwl1hoa36nsY
         RKM0E9/4nOy0R/3cBhAuls/RkYcWsWgDAtVaJnZrPS5geVYpLfVnRNJ7E6bUHUEnUceX
         H04A==
X-Gm-Message-State: AA+aEWa4NRRQIxUBD1KVb99GgixvIt/7RiGD/z9zjuyTN2W+Mkimae6I
        vWkzhc2gupX/FEyggsQKmvEchA4k
X-Google-Smtp-Source: AFSGD/WivwMXFkQbGdRVlGKbKAqIO/a7m1aM2VP2kL8MW2gyTir60WbTOx2aWZ1lGKO+0/WGn1coJg==
X-Received: by 2002:a62:e704:: with SMTP id s4mr10266107pfh.124.1543689320792;
        Sat, 01 Dec 2018 10:35:20 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t62sm11611682pgb.39.2018.12.01.10.35.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Dec 2018 10:35:20 -0800 (PST)
Date:   Sat, 1 Dec 2018 10:35:19 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Colin King <colin.king@canonical.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (ltc2978): Fix spelling mistake "comppatible" ->
 "compatible"
Message-ID: <20181201183519.GA24535@roeck-us.net>
References: <20181126162832.28060-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126162832.28060-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 04:28:32PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in the module description text, fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/ltc2978.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pmbus/ltc2978.c b/drivers/hwmon/pmbus/ltc2978.c
> index 07afb92bb36b..29c0b7219aaa 100644
> --- a/drivers/hwmon/pmbus/ltc2978.c
> +++ b/drivers/hwmon/pmbus/ltc2978.c
> @@ -795,5 +795,5 @@ static struct i2c_driver ltc2978_driver = {
>  module_i2c_driver(ltc2978_driver);
>  
>  MODULE_AUTHOR("Guenter Roeck");
> -MODULE_DESCRIPTION("PMBus driver for LTC2978 and comppatible chips");
> +MODULE_DESCRIPTION("PMBus driver for LTC2978 and compatible chips");
>  MODULE_LICENSE("GPL");
