Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA06C28CF8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 03:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8092085B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 03:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCJfiW1c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B8092085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbeJLKiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 06:38:54 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45251 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbeJLKiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 06:38:54 -0400
Received: by mail-pf1-f196.google.com with SMTP id u12-v6so5404925pfn.12;
        Thu, 11 Oct 2018 20:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kKX4qI+YccaYEgWA94m/omIQM4b5BY5oMeXyVb3b3jA=;
        b=bCJfiW1cxWhEzm6q2wi8DCL7fPyOF/eLE+1WDjkr+IvhbhUtr5HHiszOR1RnOC5o44
         je+ZWabpj+kTUgoQ91dIRreIZ0DNCtzQ1owaSfSVE3ytUSz9HaYCWPDGTd3CSN/EnVYw
         IANbDpZ8rRyh/GpGW5AOgQu01H1So9+j2LIu0R5DwAIe0Go1b0nNYpYDlp/X1piNSQXy
         ADM+bKyZ+SK5wtgZgzTR/kMx6NT9dxS00vBeXVbOLQIJ/uskz49ULbTOxcM0zMyZpNaU
         OJ11T5saMNfL+uCXlwKgHPsbAr5mJcfFWRk3fG50zXQovPwNW4ALu8TImA/NXKNNtaw0
         VNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kKX4qI+YccaYEgWA94m/omIQM4b5BY5oMeXyVb3b3jA=;
        b=BphE1IUHkVIA7wxuFEtgEdozOaws4OmyO7BXI4C5ZK5rcuSPg0xxAKJghMBs42bri2
         M6M0V2vHomDU1ioPuLQh/Na5KXLdFVRKlAthgBl4hi8oa6B3BvRMHBMcM6wU3hu8ZaAd
         eoFbmd2N4m4mlyFEC1SKb5Fqh+djoeLuCa4MVLbSHyy5opX6s66wtf8q4WtNEfc+gqpU
         CMqdaIsg9gbQ+feLGxnFF7NdSswYlEoORdsI5vUL/W/usCQfP7LNuV7Z333J8exC8Hg9
         Klb9wZX0uiVpo01mTRfxong0evvolvEHMxvKfLS3phTkqCnr5z5wsZ79VPfet/8nJqxe
         IStQ==
X-Gm-Message-State: ABuFfohZUS3f5xgpTo2q+9xOOb8JGVLwLVXD5DV27wd92TcIUtIQxSLn
        YcBeNYGEh06w/0m6EyN1fCrZBGxl
X-Google-Smtp-Source: ACcGV601FNth4D745L0g1qjzwuZ5kyt7ZT057cMo/cW84SAqeziqRK98FU/9cpG9wsqUQC+ULl8snA==
X-Received: by 2002:a63:ff23:: with SMTP id k35-v6mr3843586pgi.62.1539313719899;
        Thu, 11 Oct 2018 20:08:39 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id h5-v6sm36163902pfo.135.2018.10.11.20.08.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 20:08:39 -0700 (PDT)
Date:   Thu, 11 Oct 2018 20:08:38 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (pmbus) remove redundant 'default n' from Kconfig
Message-ID: <20181012030838.GA12708@roeck-us.net>
References: <CGME20181010143559eucas1p109d607c22ad0d3b2934ac92e14b02256@eucas1p1.samsung.com>
 <20181010143559eucas1p109d607c22ad0d3b2934ac92e14b02256~cRgTZHiWX1762717627eucas1p1I@eucas1p1.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010143559eucas1p109d607c22ad0d3b2934ac92e14b02256~cRgTZHiWX1762717627eucas1p1I@eucas1p1.samsung.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 04:35:57PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 'default n' is the default value for any bool or tristate Kconfig
> setting so there is no need to write it explicitly.
> 
> Also since commit f467c5640c29 ("kconfig: only write '# CONFIG_FOO
> is not set' for visible symbols") the Kconfig behavior is the same
> regardless of 'default n' being present or not:
> 
>     ...
>     One side effect of (and the main motivation for) this change is making
>     the following two definitions behave exactly the same:
>     
>         config FOO
>                 bool
>     
>         config FOO
>                 bool
>                 default n
>     
>     With this change, neither of these will generate a
>     '# CONFIG_FOO is not set' line (assuming FOO isn't selected/implied).
>     That might make it clearer to people that a bare 'default n' is
>     redundant.
>     ...
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/Kconfig |   15 ---------------
>  1 file changed, 15 deletions(-)
> 
> Index: b/drivers/hwmon/pmbus/Kconfig
> ===================================================================
> --- a/drivers/hwmon/pmbus/Kconfig	2018-10-09 15:58:39.067122941 +0200
> +++ b/drivers/hwmon/pmbus/Kconfig	2018-10-10 16:31:57.671888538 +0200
> @@ -5,7 +5,6 @@
>  menuconfig PMBUS
>  	tristate "PMBus support"
>  	depends on I2C
> -	default n
>  	help
>  	  Say yes here if you want to enable PMBus support.
>  
> @@ -28,7 +27,6 @@ config SENSORS_PMBUS
>  
>  config SENSORS_ADM1275
>  	tristate "Analog Devices ADM1275 and compatibles"
> -	default n
>  	help
>  	  If you say yes here you get hardware monitoring support for Analog
>  	  Devices ADM1075, ADM1272, ADM1275, ADM1276, ADM1278, ADM1293,
> @@ -49,7 +47,6 @@ config SENSORS_IBM_CFFPS
>  
>  config SENSORS_IR35221
>  	tristate "Infineon IR35221"
> -	default n
>  	help
>  	  If you say yes here you get hardware monitoring support for the
>  	  Infineon IR35221 controller.
> @@ -59,7 +56,6 @@ config SENSORS_IR35221
>  
>  config SENSORS_LM25066
>  	tristate "National Semiconductor LM25066 and compatibles"
> -	default n
>  	help
>  	  If you say yes here you get hardware monitoring support for National
>  	  Semiconductor LM25056, LM25066, LM5064, and LM5066.
> @@ -69,7 +65,6 @@ config SENSORS_LM25066
>  
>  config SENSORS_LTC2978
>  	tristate "Linear Technologies LTC2978 and compatibles"
> -	default n
>  	help
>  	  If you say yes here you get hardware monitoring support for Linear
>  	  Technology LTC2974, LTC2975, LTC2977, LTC2978, LTC2980, LTC3880,
> @@ -88,7 +83,6 @@ config SENSORS_LTC2978_REGULATOR
>  
>  config SENSORS_LTC3815
>  	tristate "Linear Technologies LTC3815"
> -	default n
>  	help
>  	  If you say yes here you get hardware monitoring support for Linear
>  	  Technology LTC3815.
> @@ -98,7 +92,6 @@ config SENSORS_LTC3815
>  
>  config SENSORS_MAX16064
>  	tristate "Maxim MAX16064"
> -	default n
>  	help
>  	  If you say yes here you get hardware monitoring support for Maxim
>  	  MAX16064.
> @@ -108,7 +101,6 @@ config SENSORS_MAX16064
>  
>  config SENSORS_MAX20751
>  	tristate "Maxim MAX20751"
> -	default n
>  	help
>  	  If you say yes here you get hardware monitoring support for Maxim
>  	  MAX20751.
> @@ -118,7 +110,6 @@ config SENSORS_MAX20751
>  
>  config SENSORS_MAX31785
>  	tristate "Maxim MAX31785 and compatibles"
> -	default n
>  	help
>  	  If you say yes here you get hardware monitoring support for Maxim
>  	  MAX31785.
> @@ -128,7 +119,6 @@ config SENSORS_MAX31785
>  
>  config SENSORS_MAX34440
>  	tristate "Maxim MAX34440 and compatibles"
> -	default n
>  	help
>  	  If you say yes here you get hardware monitoring support for Maxim
>  	  MAX34440, MAX34441, MAX34446, MAX34451, MAX34460, and MAX34461.
> @@ -138,7 +128,6 @@ config SENSORS_MAX34440
>  
>  config SENSORS_MAX8688
>  	tristate "Maxim MAX8688"
> -	default n
>  	help
>  	  If you say yes here you get hardware monitoring support for Maxim
>  	  MAX8688.
> @@ -148,7 +137,6 @@ config SENSORS_MAX8688
>  
>  config SENSORS_TPS40422
>  	tristate "TI TPS40422"
> -	default n
>  	help
>  	  If you say yes here you get hardware monitoring support for TI
>  	  TPS40422.
> @@ -167,7 +155,6 @@ config SENSORS_TPS53679
>  
>  config SENSORS_UCD9000
>  	tristate "TI UCD90120, UCD90124, UCD90160, UCD9090, UCD90910"
> -	default n
>  	help
>  	  If you say yes here you get hardware monitoring support for TI
>  	  UCD90120, UCD90124, UCD90160, UCD9090, UCD90910, Sequencer and System
> @@ -178,7 +165,6 @@ config SENSORS_UCD9000
>  
>  config SENSORS_UCD9200
>  	tristate "TI UCD9220, UCD9222, UCD9224, UCD9240, UCD9244, UCD9246, UCD9248"
> -	default n
>  	help
>  	  If you say yes here you get hardware monitoring support for TI
>  	  UCD9220, UCD9222, UCD9224, UCD9240, UCD9244, UCD9246, and UCD9248
> @@ -189,7 +175,6 @@ config SENSORS_UCD9200
>  
>  config SENSORS_ZL6100
>  	tristate "Intersil ZL6100 and compatibles"
> -	default n
>  	help
>  	  If you say yes here you get hardware monitoring support for Intersil
>  	  ZL2004, ZL2005, ZL2006, ZL2008, ZL2105, ZL2106, ZL6100, ZL6105,
