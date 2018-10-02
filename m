Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5499DC64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B6032083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n88cAfct"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B6032083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbeJCEj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:39:59 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32843 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbeJCEj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:39:59 -0400
Received: by mail-pg1-f196.google.com with SMTP id y18-v6so585472pge.0;
        Tue, 02 Oct 2018 14:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Wwjie/8p5V4k2SacZgEWEyoAR4bKGTfL2HgfmlMnrok=;
        b=n88cAfctbhtvamDuuiwu72qoRnissEw6xkW1LeCERgZNiiFXuGcmVOP8cUFkQLlJHt
         VvqwrV30jRjpNbPvf2WDZJg7y40ZyMK97XOugLArW3Fhevv3anVVXyzz8DZHSTrKAgxg
         Fb0/9s1mY6KoIJ2uQraRFOS06k3UI+XgugQYdq+mH0pqjpzjYoL6n+86fHHEY9QpbE1H
         8FUqRN39HvFxpZ7QcWHsL+aZqM4FazIu189JQNbMI/LzfHfpuDy9UuqfiTbDMyOacdBo
         nvHMKv9u33UpoA2cmXlpM35s3FbknuCXuKPZffKD1ozV/64Fhu2ukQEiRpRZxPNfk748
         ZnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=Wwjie/8p5V4k2SacZgEWEyoAR4bKGTfL2HgfmlMnrok=;
        b=oN6d5we/e0/8UNhRyzhvqvvq0YZHtZqWTeQ/GZxBgEG8msTX6ZyC60nsH1HYdsExsF
         CvIP15URFchrn8/rC+z9AihukWmJGcCXH/AkvlgHjhpLVtPzOypGjOJ+MUEbANhp9yIK
         Bu8OGYTeJ8BhgF0dTevKYv+QVOFvU0c6ODBkne5rcHgH+hIa3Qr/n+ig3EhQlwShUYSa
         GNQ7Z55wz74The4Ty2NHZzNiTPRw2IOnsHyFvnjX4abWDb5dRiGRVdwK/Y5vLVQYYQl1
         5nEGN8WeYEoZxoSx4DZvnOr05AuLjJUSmK61c6p05Nkyt5f0PSr/Lh+DtswSa7s00/zb
         dp3Q==
X-Gm-Message-State: ABuFfoj2wC5wMMgqEiJuy9O7DQbOdVMS2GlTX1KZ9+clOR084TObNsKZ
        CDF2Za7CcWDABol2uFIwzKc=
X-Google-Smtp-Source: ACcGV602b/bON8Ocu94qrZNJK0E/a8m/HZraZ5fnvvfP99Z0P4AjD6Lu2n0wNkcBhS42wFRgbUa/qw==
X-Received: by 2002:a63:d048:: with SMTP id s8-v6mr15942749pgi.311.1538517270984;
        Tue, 02 Oct 2018 14:54:30 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id p3-v6sm22699062pfo.130.2018.10.02.14.54.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 14:54:30 -0700 (PDT)
Date:   Tue, 2 Oct 2018 14:54:29 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: ina3221: mark PM functions as __maybe_unused
Message-ID: <20181002215429.GA10027@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 11:10:47PM +0200, Arnd Bergmann wrote:
> When CONFIG_PM_SLEEP is disabled, we get a warning about unused
> suspend/resume functions:
> 
> drivers/hwmon/ina3221.c:451:12: error: 'ina3221_resume' defined but not used [-Werror=unused-function]
>  static int ina3221_resume(struct device *dev)
> drivers/hwmon/ina3221.c:428:12: error: 'ina3221_suspend' defined but not used [-Werror=unused-function]
>  static int ina3221_suspend(struct device *dev)
> 
> Picking the correct #ifdef check is hard, so let's remove
> that check and instead mark the functions as __maybe_unused
> to let the compiler silently drop them instead.
> 
> Fixes: 7de1ab9dac8e ("hwmon: (ina3221) Add suspend and resume functions")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/ina3221.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
> index 1e38b4c43fbf..8c3352910cc4 100644
> --- a/drivers/hwmon/ina3221.c
> +++ b/drivers/hwmon/ina3221.c
> @@ -424,8 +424,7 @@ static int ina3221_probe(struct i2c_client *client,
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM
> -static int ina3221_suspend(struct device *dev)
> +static int __maybe_unused ina3221_suspend(struct device *dev)
>  {
>  	struct ina3221_data *ina = dev_get_drvdata(dev);
>  	int ret;
> @@ -448,7 +447,7 @@ static int ina3221_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int ina3221_resume(struct device *dev)
> +static int __maybe_unused ina3221_resume(struct device *dev)
>  {
>  	struct ina3221_data *ina = dev_get_drvdata(dev);
>  	int ret;
> @@ -474,7 +473,6 @@ static int ina3221_resume(struct device *dev)
>  
>  	return 0;
>  }
> -#endif
>  
>  static const struct dev_pm_ops ina3221_pm = {
>  	SET_SYSTEM_SLEEP_PM_OPS(ina3221_suspend, ina3221_resume)
> -- 
> 2.18.0
> 
