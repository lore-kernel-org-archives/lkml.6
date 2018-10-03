Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950CAC65BA7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 633A620684
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:39:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 633A620684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbeJCM0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 08:26:34 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37343 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbeJCM0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 08:26:33 -0400
Received: by mail-lf1-f66.google.com with SMTP id a82-v6so3192467lfa.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 22:39:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0if6v2eWOR553v1acn4YcQGaB4y4FMj4cXevHW3+78E=;
        b=VG3voo1qUau4KZ0qsprh4AJEC9CWCPnt6DDfw/m50HmFWQHvJ8Qc211zB9nPRFVEr7
         LqT3S1ho8b1NqlwHfilFR5LCG3lLoVnUrVPpkNa5Xys7kiA+gIKXv12AWyrZtYxGnWUv
         2A9bOdNVFNQh9vjKjZJIcq00R1D6WXOJxS4l7zCYYiI2vLAT1XZ+4BVmj1n9oYfeKRdq
         maSkdwnSc4IIEBLowtOx2uIdhcsgMzKiM46MvNIpgJVSzIQH9Szj1SuUea2Q8yIT33cs
         xr1QW66GTFj2c6iHYrZXemIGIPlZ4Pw+QH8mT0OBn6N0valq+dPq4+KqpLnsqjm+qMVS
         xuxA==
X-Gm-Message-State: ABuFfohKONR80WAITQy5VZtkLo0GbW86NHVWm/GocLMgBsaQJ/cVSbQS
        99SnFbKmiiUETY+Ep8L5yUQ=
X-Google-Smtp-Source: ACcGV60KsdoQRLUQOTiXqkAYrMNc6969qZ1FLk8MSQQvO5khIisMk7BlunkPHQSsIY2hpWfVCXofVw==
X-Received: by 2002:a19:ea57:: with SMTP id i84-v6mr9744422lfh.91.1538545182396;
        Tue, 02 Oct 2018 22:39:42 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id g14-v6sm65540lja.96.2018.10.02.22.39.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 22:39:41 -0700 (PDT)
Date:   Wed, 3 Oct 2018 08:39:39 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator/mfd: fix pointer-to-int cast
Message-ID: <20181003053939.GE9389@localhost.localdomain>
References: <20181002210826.2588925-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002210826.2588925-1-arnd@arndb.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Arnd,

On Tue, Oct 02, 2018 at 11:07:32PM +0200, Arnd Bergmann wrote:
> gcc points out that a pointer is longer than an int on 64-bit
> architectures, and that casting between the two may be dangerous:
> 
> drivers/mfd/rohm-bd718x7.c: In function 'bd718xx_i2c_probe':
> drivers/mfd/rohm-bd718x7.c:101:23: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
> 
> In this driver it is correct, we just need the right kind of cast
> to avoid the warning.
> 
> Fixes: 494edd266b94 ("regulator/mfd: Support ROHM BD71847 power management IC")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/mfd/rohm-bd718x7.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/rohm-bd718x7.c b/drivers/mfd/rohm-bd718x7.c
> index 161c8aac6d86..e66d59190a82 100644
> --- a/drivers/mfd/rohm-bd718x7.c
> +++ b/drivers/mfd/rohm-bd718x7.c
> @@ -98,7 +98,7 @@ static int bd718xx_i2c_probe(struct i2c_client *i2c,
>  		return -ENOMEM;
>  
>  	bd718xx->chip_irq = i2c->irq;
> -	bd718xx->chip_type = (unsigned int)
> +	bd718xx->chip_type = (uintptr_t)
>  				of_device_get_match_data(&i2c->dev);
>  	bd718xx->dev = &i2c->dev;
>  	dev_set_drvdata(&i2c->dev, bd718xx);

Big thanks for this activity =) I also got heads up mail from linux-next
so I also did a patch fixing this. I think Mark alrady applied that
patch to his tree.

(https://lore.kernel.org/lkml/20181002145901.899D41121A41@debutante.sirena.org.uk/)

Br,
	Matti Vaittinen
