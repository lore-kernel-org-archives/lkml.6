Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC38EC04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 18:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9784220867
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 18:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/5UPyIg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9784220867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725764AbeLBFpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 00:45:40 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43854 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbeLBFpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 00:45:39 -0500
Received: by mail-pl1-f193.google.com with SMTP id gn14so4397522plb.10;
        Sat, 01 Dec 2018 10:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G9dg8U5mgE46K9o752uJQkqVDfIPY2EnwQPBZscCcuk=;
        b=s/5UPyIgeeKWPD/0ybgpm0Gt8M8DvJ/HUKOV0emEfeQWF5UfMqLhI78O1qOyk6bPP+
         za3TSeZBNagibzIgDtZcbOTK2ZXbUOyJSGnyqCvsFaA4xdjazPZ2fneIBnn0L3mgTLoI
         ng2epk0f388/Y2R1t8bhsLpdcQ9J7md8zHClBOpbRxzCOn0UDOv21vKFwrDqz1y3o63+
         L4MZAJ+V9shSc58yGeQv47h0XT2k7XIArYCYo41jf7tp+03ThVcSnpaM/+tbzysNaX1j
         BK01QR4YFMGWO5pkGxQsnMeub2qMY+LixIiNUnw/JBjGpcJJG45YfDts0dgoC38p5Fjo
         c2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=G9dg8U5mgE46K9o752uJQkqVDfIPY2EnwQPBZscCcuk=;
        b=kRJH9/F6Dx8ZLJcKkq2h0AuSDoLSGSUaQQIbUmctfHE4S8lqx4oGYtV0kgjOPR5LAU
         l1JakjED/iSxm0zy9DTGYVzk3Du90CvqFt+jXyUNXKVqcSdV5KnH9plA5ChopQ9jRPFB
         Qc7hpg15jOK5AaGaGpaoUkec5r0RQEvozZ989c35+7u3TXMyCr8kP7eD3+g6wiI9FbfS
         L7aWeL1aEVYZMO80eoxsiQ1BnaHw3ZgX4Exmo9iHwaifXagIY4C7wTu4MJaNsZytN9Eq
         W0j8V9tP9v+rzf/J+sYmo5eG7NM7Uv3PIamxxm0j4J8FWROeraOwUnvBiiQCJiiw4DRz
         oOgQ==
X-Gm-Message-State: AA+aEWYFXmtaf032cLWB/LlaWE9KQmj0C1Zmf60Wzl9CN3cycHL/lppd
        ixhrJGiREyks5TL5JF0T9+4=
X-Google-Smtp-Source: AFSGD/WuNNlLkWaFtJ8xbBaRtsZKRvDyBj6MgEVSGdjn032C9mnWqAsLVOB/GfwMHN5V2chKPGDfjA==
X-Received: by 2002:a17:902:30a3:: with SMTP id v32mr4326563plb.26.1543689152844;
        Sat, 01 Dec 2018 10:32:32 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q75sm14385044pfa.38.2018.12.01.10.32.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Dec 2018 10:32:32 -0800 (PST)
Date:   Sat, 1 Dec 2018 10:32:31 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon: fix typo build -> built
Message-ID: <20181201183231.GA14451@roeck-us.net>
References: <1543522155-17406-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543522155-17406-1-git-send-email-clabbe@baylibre.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 08:09:14PM +0000, Corentin Labbe wrote:
> This patch fix a typo where build is used instead of built.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/Kconfig | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 532a0532d01b..100b7fce1412 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -179,7 +179,7 @@ config SENSORS_ADT7X10
>  	  This module contains common code shared by the ADT7310/ADT7320 and
>  	  ADT7410/ADT7420 temperature monitoring chip drivers.
>  
> -	  If build as a module, the module will be called adt7x10.
> +	  If built as a module, the module will be called adt7x10.
>  
>  config SENSORS_ADT7310
>  	tristate "Analog Devices ADT7310/ADT7320"
> @@ -242,7 +242,7 @@ config SENSORS_ADT7475
>  	  ADT7473, ADT7475, ADT7476 and ADT7490 hardware monitoring
>  	  chips.
>  
> -	  This driver can also be build as a module.  If so, the module
> +	  This driver can also be built as a module.  If so, the module
>  	  will be called adt7475.
>  
>  config SENSORS_ASC7621
> @@ -666,7 +666,7 @@ config SENSORS_JZ4740
>  	  If you say yes here you get support for reading adc values from the ADCIN
>  	  pin on Ingenic JZ4740 SoC based boards.
>  
> -	  This driver can also be build as a module. If so, the module will be
> +	  This driver can also be built as a module. If so, the module will be
>  	  called jz4740-hwmon.
>  
>  config SENSORS_JC42
> @@ -1594,7 +1594,7 @@ config SENSORS_AMC6821
>  	  If you say yes here you get support for the Texas Instruments
>  	  AMC6821 hardware monitoring chips.
>  
> -	  This driver can also be build as a module.  If so, the module
> +	  This driver can also be built as a module.  If so, the module
>  	  will be called amc6821.
>  
>  config SENSORS_INA209
