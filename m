Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62DBC04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 18:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7B620867
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 18:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RslR/+1s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D7B620867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725775AbeLBFrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 00:47:19 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34675 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbeLBFrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 00:47:19 -0500
Received: by mail-pl1-f195.google.com with SMTP id w4so4414592plz.1;
        Sat, 01 Dec 2018 10:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MXWcTJO3aN/u+KjjnsMi/p95i4Jlu2fonCLstkXiyNs=;
        b=RslR/+1s17ThTSrJhMk2UxtaY23DKqNDxH1Wv1gSARlI2tP9mG339xRiZsEKaW2n2D
         BS0/30v7T6Ixml84A8Kg3xGkRhYGw5U41KKRUmY1t03CjUjcCX/A8GxbXoONPWckVnYy
         HKIoIlSyaG3lnl/SjD0+RHJxTDhVka/w5zL8T3PlZ+f/46QWBUIaH0HvHCmOJUAQaVfQ
         hpmFoq33b2WyMA1vk704ngg+74PoM+giVn9vPk3gR4CWMa71e6fAxhQ7yfD4yjg3r7xY
         XFwfcdtINzP3ohGFbAazAMbOZaC2+xdQSNEMYxUas7skgrsTAIAOe7kPQWoxtfn8mgl8
         CaQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=MXWcTJO3aN/u+KjjnsMi/p95i4Jlu2fonCLstkXiyNs=;
        b=MVvikM+3b7Us+tMQYJ72N3G7tSDlZAnJinW6cUcOukZ9H4xJ6KnL0QALxnVi44+ejG
         fbJ8pIoXxb1daZBEI7NQtI0dFNw4JX0kyteiw09KifX6eKAC7qZpYAuTM86y81TVTPK7
         qahrpTYQ3OMaC+DfJsBf1KBn4BUvsgvPT+NebelM4NcMeCKJJkU+MMzPJXVKU9ocKK95
         rigu1amJcB7fwctXvfBeu8Wa0z7Mc7iT3cRJZKbF4Ce1IAsuUjXSil/Sck8aKUFox1j0
         Mcv0gmJeK+G3C/2Q+msMpXDrh6qcU6TtkWM55EAhuLqQGlPVyzOi77HChzy+MOof9Dbv
         RGUg==
X-Gm-Message-State: AA+aEWaMXDQfOxKgkOxyUtGIijQFZVHmAY0lFiPJFyo0OHjbLBhSRfhV
        QUDHcIfG/l4C5jrbUdzYRWVFx/aa
X-Google-Smtp-Source: AFSGD/VDm77+sq+eWFlWRWLiIr3cChAxl90hovMU8Tfmrxli4AbovxUSP8hG5UfzRQNiKASu6EHLXg==
X-Received: by 2002:a17:902:4827:: with SMTP id s36mr9821825pld.168.1543689251330;
        Sat, 01 Dec 2018 10:34:11 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z191sm10083305pgd.74.2018.12.01.10.34.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Dec 2018 10:34:10 -0800 (PST)
Date:   Sat, 1 Dec 2018 10:34:09 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: Remove multiple space after dot
Message-ID: <20181201183409.GA32389@roeck-us.net>
References: <1543522155-17406-1-git-send-email-clabbe@baylibre.com>
 <1543522155-17406-2-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543522155-17406-2-git-send-email-clabbe@baylibre.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 08:09:15PM +0000, Corentin Labbe wrote:
> This patch remove extra space after a dot.
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Marginal ... I think that used to be common style a long time ago.
Nevertheless, applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/Kconfig | 236 +++++++++++++++++++++---------------------
>  1 file changed, 118 insertions(+), 118 deletions(-)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 100b7fce1412..3ed91b21f368 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -11,7 +11,7 @@ menuconfig HWMON
>  	  of a system. Most modern motherboards include such a device. It
>  	  can include temperature sensors, voltage sensors, fan speed
>  	  sensors and various additional features such as the ability to
> -	  control the speed of the fans.  If you want this support you
> +	  control the speed of the fans. If you want this support you
>  	  should say Y here and also to the specific driver(s) for your
>  	  sensors chip(s) below.
>  
> @@ -19,7 +19,7 @@ menuconfig HWMON
>  	  sensors-detect script from the lm_sensors package.  Read
>  	  <file:Documentation/hwmon/userspace-tools> for details.
>  
> -	  This support can also be built as a module.  If so, the module
> +	  This support can also be built as a module. If so, the module
>  	  will be called hwmon.
>  
>  if HWMON
> @@ -46,7 +46,7 @@ config SENSORS_AB8500
>  	  AB8500 die and two GPADC channels. The GPADC channel are preferably
>  	  used to access sensors outside the AB8500 chip.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called abx500-temp.
>  
>  config SENSORS_ABITUGURU
> @@ -61,7 +61,7 @@ config SENSORS_ABITUGURU
>  	  of which motherboards have which revision see
>  	  Documentation/hwmon/abituguru
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called abituguru.
>  
>  config SENSORS_ABITUGURU3
> @@ -75,7 +75,7 @@ config SENSORS_ABITUGURU3
>  	  2005). For more info and a list of which motherboards have which
>  	  revision see Documentation/hwmon/abituguru3
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called abituguru3.
>  
>  config SENSORS_AD7314
> @@ -116,7 +116,7 @@ config SENSORS_ADM1021
>  	  and ADM1023 sensor chips and clones: Maxim MAX1617 and MAX1617A,
>  	  Genesys Logic GL523SM, National Semiconductor LM84 and TI THMC10.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called adm1021.
>  
>  config SENSORS_ADM1025
> @@ -127,7 +127,7 @@ config SENSORS_ADM1025
>  	  If you say yes here you get support for Analog Devices ADM1025
>  	  and Philips NE1619 sensor chips.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called adm1025.
>  
>  config SENSORS_ADM1026
> @@ -138,7 +138,7 @@ config SENSORS_ADM1026
>  	  If you say yes here you get support for Analog Devices ADM1026
>  	  sensor chip.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called adm1026.
>  
>  config SENSORS_ADM1029
> @@ -149,7 +149,7 @@ config SENSORS_ADM1029
>  	  sensor chip.
>  	  Very rare chip, please let us know you use it.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called adm1029.
>  
>  config SENSORS_ADM1031
> @@ -159,7 +159,7 @@ config SENSORS_ADM1031
>  	  If you say yes here you get support for Analog Devices ADM1031
>  	  and ADM1030 sensor chips.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called adm1031.
>  
>  config SENSORS_ADM9240
> @@ -170,7 +170,7 @@ config SENSORS_ADM9240
>  	  If you say yes here you get support for Analog Devices ADM9240,
>  	  Dallas DS1780, National Semiconductor LM81 sensor chips.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called adm9240.
>  
>  config SENSORS_ADT7X10
> @@ -242,7 +242,7 @@ config SENSORS_ADT7475
>  	  ADT7473, ADT7475, ADT7476 and ADT7490 hardware monitoring
>  	  chips.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called adt7475.
>  
>  config SENSORS_ASC7621
> @@ -255,7 +255,7 @@ config SENSORS_ASC7621
>  	  aSC7621
>  	  aSC7621a
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called asc7621.
>  
>  config SENSORS_K8TEMP
> @@ -267,7 +267,7 @@ config SENSORS_K8TEMP
>  	  microarchitecture. Please note that you will need at least
>  	  lm-sensors 2.10.1 for proper userspace support.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called k8temp.
>  
>  config SENSORS_K10TEMP
> @@ -280,7 +280,7 @@ config SENSORS_K10TEMP
>  	  12h (Llano), 14h (Brazos), 15h (Bulldozer/Trinity/Kaveri/Carrizo)
>  	  and 16h (Kabini/Mullins) microarchitectures.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called k10temp.
>  
>  config SENSORS_FAM15H_POWER
> @@ -290,7 +290,7 @@ config SENSORS_FAM15H_POWER
>  	  If you say yes here you get support for processor power
>  	  information of your AMD family 15h CPU.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called fam15h_power.
>  
>  config SENSORS_APPLESMC
> @@ -326,7 +326,7 @@ config SENSORS_ARM_SCMI
>  	  and power sensors available on SCMI based platforms. The actual
>  	  number and type of sensors exported depend on the platform.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called scmi-hwmon.
>  
>  config SENSORS_ARM_SCPI
> @@ -346,7 +346,7 @@ config SENSORS_ASB100
>  	  If you say yes here you get support for the ASB100 Bach sensor
>  	  chip found on some Asus mainboards.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called asb100.
>  
>  config SENSORS_ASPEED
> @@ -371,7 +371,7 @@ config SENSORS_ATXP1
>  	  If your board have such a chip, you are able to control your CPU
>  	  core and other voltages.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called atxp1.
>  
>  config SENSORS_DS620
> @@ -381,7 +381,7 @@ config SENSORS_DS620
>  	  If you say yes here you get support for Dallas Semiconductor
>  	  DS620 sensor chip.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called ds620.
>  
>  config SENSORS_DS1621
> @@ -396,7 +396,7 @@ config SENSORS_DS1621
>  	  - Maxim Integrated DS1721
>  	  - Maxim Integrated DS1731
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called ds1621.
>  
>  config SENSORS_DELL_SMM
> @@ -427,7 +427,7 @@ config SENSORS_DA9055
>  	  If you say yes here you get support for ADC on the Dialog
>  	  Semiconductor DA9055 PMIC.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called da9055-hwmon.
>  
>  config SENSORS_I5K_AMB
> @@ -448,7 +448,7 @@ config SENSORS_F71805F
>  	  features of the Fintek F71805F/FG, F71806F/FG and F71872F/FG
>  	  Super-I/O chips.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called f71805f.
>  
>  config SENSORS_F71882FG
> @@ -470,7 +470,7 @@ config SENSORS_F71882FG
>  	    F81801U
>  	    F81865F
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called f71882fg.
>  
>  config SENSORS_F75375S
> @@ -480,7 +480,7 @@ config SENSORS_F75375S
>  	  If you say yes here you get support for hardware monitoring
>  	  features of the Fintek F75375S/SP, F75373 and F75387
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called f75375s.
>  
>  config SENSORS_MC13783_ADC
> @@ -502,7 +502,7 @@ config SENSORS_FSCHMD
>  	  fscscy and fscher drivers and adding support for several other FSC
>  	  sensor chips.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called fschmd.
>  
>  config SENSORS_FTSTEUTATES
> @@ -524,7 +524,7 @@ config SENSORS_GL518SM
>  	  If you say yes here you get support for Genesys Logic GL518SM
>  	  sensor chips.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called gl518sm.
>  
>  config SENSORS_GL520SM
> @@ -535,7 +535,7 @@ config SENSORS_GL520SM
>  	  If you say yes here you get support for Genesys Logic GL520SM
>  	  sensor chips.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called gl520sm.
>  
>  config SENSORS_G760A
> @@ -545,7 +545,7 @@ config SENSORS_G760A
>  	  If you say yes here you get support for Global Mixed-mode
>  	  Technology Inc G760A fan speed PWM controller chips.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called g760a.
>  
>  config SENSORS_G762
> @@ -555,7 +555,7 @@ config SENSORS_G762
>  	  If you say yes here you get support for Global Mixed-mode
>  	  Technology Inc G762 and G763 fan speed PWM controller chips.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called g762.
>  
>  config SENSORS_GPIO_FAN
> @@ -566,7 +566,7 @@ config SENSORS_GPIO_FAN
>  	help
>  	  If you say yes here you get support for fans connected to GPIO lines.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called gpio-fan.
>  
>  config SENSORS_HIH6130
> @@ -576,7 +576,7 @@ config SENSORS_HIH6130
>  	  If you say yes here you get support for Honeywell Humidicon
>  	  HIH-6130 and HIH-6131 Humidicon humidity sensors.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called hih6130.
>  
>  config SENSORS_IBMAEM
> @@ -590,7 +590,7 @@ config SENSORS_IBMAEM
>  	  the x3350, x3550, x3650, x3655, x3755, x3850 M2, x3950 M2,
>  	  and certain HC10/HS2x/LS2x/QS2x blades.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called ibmaem.
>  
>  config SENSORS_IBMPEX
> @@ -604,7 +604,7 @@ config SENSORS_IBMPEX
>  	  x3655, and x3755; the x3800, x3850, and x3950 models that have
>  	  PCI Express; and some of the HS2x, LS2x, and QS2x blades.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called ibmpex.
>  
>  config SENSORS_IBMPOWERNV
> @@ -656,7 +656,7 @@ config SENSORS_IT87
>  	  IT8603E, IT8620E, IT8623E, and IT8628E sensor chips, and the SiS950
>  	  clone.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called it87.
>  
>  config SENSORS_JZ4740
> @@ -680,7 +680,7 @@ config SENSORS_JC42
>  	  MCP9808, MCP98242, MCP98243, MCP98244, MCP9843, SE97, SE98,
>  	  STTS424(E), STTS2002, STTS3000, TSE2002, TSE2004, TS3000, and TS3001.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called jc42.
>  
>  config SENSORS_POWR1220
> @@ -691,7 +691,7 @@ config SENSORS_POWR1220
>  	  functions of the Lattice POWR1220 isp Power Supply Monitoring,
>  	  Sequencing and Margining Controller.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called powr1220.
>  
>  config SENSORS_LINEAGE
> @@ -702,7 +702,7 @@ config SENSORS_LINEAGE
>  	  series of DC/DC and AC/DC converters such as CP1800, CP2000AC,
>  	  CP2000DC, CP2725, and others.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called lineage-pem.
>  
>  config SENSORS_LTC2945
> @@ -803,7 +803,7 @@ config SENSORS_MAX1111
>  	  Say y here to support Maxim's MAX1110, MAX1111, MAX1112, and MAX1113
>  	  ADC chips.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called max1111.
>  
>  config SENSORS_MAX16065
> @@ -819,7 +819,7 @@ config SENSORS_MAX16065
>  	    MAX16070
>  	    MAX16071
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called max16065.
>  
>  config SENSORS_MAX1619
> @@ -828,7 +828,7 @@ config SENSORS_MAX1619
>  	help
>  	  If you say yes here you get support for MAX1619 sensor chip.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called max1619.
>  
>  config SENSORS_MAX1668
> @@ -838,7 +838,7 @@ config SENSORS_MAX1668
>  	  If you say yes here you get support for MAX1668, MAX1989 and
>  	  MAX1805 chips.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called max1668.
>  
>  config SENSORS_MAX197
> @@ -881,7 +881,7 @@ config SENSORS_MAX6639
>  	  If you say yes here you get support for the MAX6639
>  	  sensor chips.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called max6639.
>  
>  config SENSORS_MAX6642
> @@ -892,7 +892,7 @@ config SENSORS_MAX6642
>  	  MAX6642 is a SMBus-Compatible Remote/Local Temperature Sensor
>  	  with Overtemperature Alarm from Maxim.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called max6642.
>  
>  config SENSORS_MAX6650
> @@ -902,7 +902,7 @@ config SENSORS_MAX6650
>  	  If you say yes here you get support for the MAX6650 / MAX6651
>  	  sensor chips.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called max6650.
>  
>  config SENSORS_MAX6697
> @@ -913,7 +913,7 @@ config SENSORS_MAX6697
>  	  MAX6636, MAX6689, MAX6693, MAX6694, MAX6697, MAX6698, and MAX6699
>  	  temperature sensor chips.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called max6697.
>  
>  config SENSORS_MAX31790
> @@ -923,7 +923,7 @@ config SENSORS_MAX31790
>  	  If you say yes here you get support for 6-Channel PWM-Output
>  	  Fan RPM Controller.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called max31790.
>  
>  config SENSORS_MCP3021
> @@ -934,7 +934,7 @@ config SENSORS_MCP3021
>  	  The MCP3021 is a A/D converter (ADC) with 10-bit and the MCP3221
>  	  with 12-bit resolution.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called mcp3021.
>  
>  config SENSORS_MLXREG_FAN
> @@ -957,7 +957,7 @@ config SENSORS_TC654
>  	  The TC654 and TC655 are PWM mode fan speed controllers with
>  	  FanSense technology for use with brushless DC fans.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called tc654.
>  
>  config SENSORS_MENF21BMC_HWMON
> @@ -983,7 +983,7 @@ config SENSORS_ADCXX
>  
>  	  Examples : ADC081S101, ADC124S501, ...
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called adcxx.
>  
>  config SENSORS_LM63
> @@ -996,7 +996,7 @@ config SENSORS_LM63
>  	  on the Tyan S4882 (Thunder K8QS Pro) motherboard, among
>  	  others.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called lm63.
>  
>  config SENSORS_LM70
> @@ -1007,7 +1007,7 @@ config SENSORS_LM70
>  	  LM70, LM71, LM74 and Texas Instruments TMP121/TMP123 digital tempera-
>  	  ture sensor chips.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called lm70.
>  
>  config SENSORS_LM73
> @@ -1016,7 +1016,7 @@ config SENSORS_LM73
>  	help
>  	  If you say yes here you get support for National Semiconductor LM73
>  	  sensor chips.
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called lm73.
>  
>  config SENSORS_LM75
> @@ -1046,7 +1046,7 @@ config SENSORS_LM75
>  	  that with some chips which don't replicate LM75 quirks exactly,
>  	  you may need the "force" module parameter.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called lm75.
>  
>  config SENSORS_LM77
> @@ -1056,7 +1056,7 @@ config SENSORS_LM77
>  	  If you say yes here you get support for National Semiconductor LM77
>  	  sensor chips.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called lm77.
>  
>  config SENSORS_LM78
> @@ -1067,7 +1067,7 @@ config SENSORS_LM78
>  	  If you say yes here you get support for National Semiconductor LM78,
>  	  LM78-J and LM79.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called lm78.
>  
>  config SENSORS_LM80
> @@ -1077,7 +1077,7 @@ config SENSORS_LM80
>  	  If you say yes here you get support for National Semiconductor
>  	  LM80 and LM96080 sensor chips.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called lm80.
>  
>  config SENSORS_LM83
> @@ -1087,7 +1087,7 @@ config SENSORS_LM83
>  	  If you say yes here you get support for National Semiconductor
>  	  LM82 and LM83 sensor chips.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called lm83.
>  
>  config SENSORS_LM85
> @@ -1099,7 +1099,7 @@ config SENSORS_LM85
>  	  sensor chips and clones: ADM1027, ADT7463, ADT7468, EMC6D100,
>  	  EMC6D101, EMC6D102, and EMC6D103.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called lm85.
>  
>  config SENSORS_LM87
> @@ -1110,7 +1110,7 @@ config SENSORS_LM87
>  	  If you say yes here you get support for National Semiconductor LM87
>  	  and Analog Devices ADM1024 sensor chips.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called lm87.
>  
>  config SENSORS_LM90
> @@ -1124,7 +1124,7 @@ config SENSORS_LM90
>  	  Winbond/Nuvoton W83L771W/G/AWG/ASG, Philips SA56004, GMT G781, and
>  	  Texas Instruments TMP451 sensor chips.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called lm90.
>  
>  config SENSORS_LM92
> @@ -1134,7 +1134,7 @@ config SENSORS_LM92
>  	  If you say yes here you get support for National Semiconductor LM92
>  	  and Maxim MAX6635 sensor chips.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called lm92.
>  
>  config SENSORS_LM93
> @@ -1145,7 +1145,7 @@ config SENSORS_LM93
>  	  If you say yes here you get support for National Semiconductor LM93,
>  	  LM94, and compatible sensor chips.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called lm93.
>  
>  config SENSORS_LM95234
> @@ -1155,7 +1155,7 @@ config SENSORS_LM95234
>  	  If you say yes here you get support for the LM95233 and LM95234
>  	  temperature sensor chips.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called lm95234.
>  
>  config SENSORS_LM95241
> @@ -1165,7 +1165,7 @@ config SENSORS_LM95241
>  	  If you say yes here you get support for LM95231 and LM95241 sensor
>  	  chips.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called lm95241.
>  
>  config SENSORS_LM95245
> @@ -1176,7 +1176,7 @@ config SENSORS_LM95245
>  	  If you say yes here you get support for LM95235 and LM95245
>  	  temperature sensor chips.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called lm95245.
>  
>  config SENSORS_PC87360
> @@ -1190,7 +1190,7 @@ config SENSORS_PC87360
>  	  control.  The PC87365 and PC87366 additionally have voltage and
>  	  temperature monitoring.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called pc87360.
>  
>  config SENSORS_PC87427
> @@ -1204,7 +1204,7 @@ config SENSORS_PC87427
>  	  monitoring. Fan speed monitoring and control are supported, as
>  	  well as temperature monitoring. Voltages aren't supported yet.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called pc87427.
>  
>  config SENSORS_NTC_THERMISTOR
> @@ -1220,7 +1220,7 @@ config SENSORS_NTC_THERMISTOR
>  	  NCP15WB473, NCP18WB473, NCP21WB473, NCP03WB473, NCP15WL333,
>  	  NCP03WF104 and NCP15XH103 from Murata and B57330V2103 from EPCOS.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called ntc-thermistor.
>  
>  config SENSORS_NCT6683
> @@ -1230,7 +1230,7 @@ config SENSORS_NCT6683
>  	  If you say yes here you get support for the hardware monitoring
>  	  functionality of the Nuvoton NCT6683D eSIO chip.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called nct6683.
>  
>  config SENSORS_NCT6775
> @@ -1244,7 +1244,7 @@ config SENSORS_NCT6775
>  	  Super-I/O chips. This driver replaces the w83627ehf driver for
>  	  NCT6775F and NCT6776F.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called nct6775.
>  
>  config SENSORS_NCT7802
> @@ -1255,7 +1255,7 @@ config SENSORS_NCT7802
>  	  If you say yes here you get support for the Nuvoton NCT7802Y
>  	  hardware monitoring chip.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called nct7802.
>  
>  config SENSORS_NCT7904
> @@ -1265,7 +1265,7 @@ config SENSORS_NCT7904
>  	  If you say yes here you get support for the Nuvoton NCT7904
>  	  hardware monitoring chip, including manual fan speed control.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called nct7904.
>  
>  config SENSORS_NPCM7XX
> @@ -1302,11 +1302,11 @@ config SENSORS_PCF8591
>  	  If you say yes here you get support for Philips PCF8591 4-channel
>  	  ADC, 1-channel DAC chips.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called pcf8591.
>  
>  	  These devices are hard to detect and rarely found on mainstream
> -	  hardware.  If unsure, say N.
> +	  hardware. If unsure, say N.
>  
>  source drivers/hwmon/pmbus/Kconfig
>  
> @@ -1319,7 +1319,7 @@ config SENSORS_PWM_FAN
>  	  The driver uses the generic PWM interface, thus it will work on a
>  	  variety of SoCs.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called pwm-fan.
>  
>  config SENSORS_RASPBERRYPI_HWMON
> @@ -1340,7 +1340,7 @@ config SENSORS_SHT15
>  	  If you say yes here you get support for the Sensiron SHT10, SHT11,
>  	  SHT15, SHT71, SHT75 humidity and temperature sensors.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called sht15.
>  
>  config SENSORS_SHT21
> @@ -1350,7 +1350,7 @@ config SENSORS_SHT21
>  	  If you say yes here you get support for the Sensiron SHT21, SHT25
>  	  humidity and temperature sensors.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called sht21.
>  
>  config SENSORS_SHT3x
> @@ -1361,7 +1361,7 @@ config SENSORS_SHT3x
>  	  If you say yes here you get support for the Sensiron SHT30 and SHT31
>  	  humidity and temperature sensors.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called sht3x.
>  
>  config SENSORS_SHTC1
> @@ -1371,7 +1371,7 @@ config SENSORS_SHTC1
>  	  If you say yes here you get support for the Sensiron SHTC1 and SHTW1
>  	  humidity and temperature sensors.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called shtc1.
>  
>  config SENSORS_S3C
> @@ -1398,7 +1398,7 @@ config SENSORS_SIS5595
>  	  If you say yes here you get support for the integrated sensors in
>  	  SiS5595 South Bridges.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called sis5595.
>  
>  config SENSORS_DME1737
> @@ -1410,7 +1410,7 @@ config SENSORS_DME1737
>  	  and fan control features of the SMSC DME1737, SCH311x, SCH5027, and
>  	  Asus A8000 Super-I/O chips.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called dme1737.
>  
>  config SENSORS_EMC1403
> @@ -1431,7 +1431,7 @@ config SENSORS_EMC2103
>  	  If you say yes here you get support for the temperature
>  	  and fan sensors of the SMSC EMC2103 chips.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called emc2103.
>  
>  config SENSORS_EMC6W201
> @@ -1441,7 +1441,7 @@ config SENSORS_EMC6W201
>  	  If you say yes here you get support for the SMSC EMC6W201
>  	  hardware monitoring chip.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called emc6w201.
>  
>  config SENSORS_SMSC47M1
> @@ -1458,7 +1458,7 @@ config SENSORS_SMSC47M1
>  	  driver, select also "SMSC LPC47M192 and compatibles" below for
>  	  those.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called smsc47m1.
>  
>  config SENSORS_SMSC47M192
> @@ -1475,7 +1475,7 @@ config SENSORS_SMSC47M192
>  	  "SMSC LPC47M10x and compatibles" above. You need both drivers
>  	  if you want fan control and voltage/temperature sensor support.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called smsc47m192.
>  
>  config SENSORS_SMSC47B397
> @@ -1485,7 +1485,7 @@ config SENSORS_SMSC47B397
>  	  If you say yes here you get support for the SMSC LPC47B397-NC
>  	  sensor chip.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called smsc47b397.
>  
>  config SENSORS_SCH56XX_COMMON
> @@ -1501,7 +1501,7 @@ config SENSORS_SCH5627
>  	  features of the SMSC SCH5627 Super-I/O chip including support for
>  	  the integrated watchdog.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called sch5627.
>  
>  config SENSORS_SCH5636
> @@ -1519,7 +1519,7 @@ config SENSORS_SCH5636
>  	  Theseus' hardware monitoring features including support for the
>  	  integrated watchdog.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called sch5636.
>  
>  config SENSORS_STTS751
> @@ -1529,7 +1529,7 @@ config SENSORS_STTS751
>  	  If you say yes here you get support for STTS751
>  	  temperature sensor chips.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called stts751.
>  
>  config SENSORS_SMM665
> @@ -1563,7 +1563,7 @@ config SENSORS_ADS1015
>  	  If you say yes here you get support for Texas Instruments
>  	  ADS1015/ADS1115 12/16-bit 4-input ADC device.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called ads1015.
>  
>  config SENSORS_ADS7828
> @@ -1575,7 +1575,7 @@ config SENSORS_ADS7828
>  	  ADS7830 8-channel A/D converters. ADS7828 resolution is 12-bit, while
>  	  it is 8-bit on ADS7830.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called ads7828.
>  
>  config SENSORS_ADS7871
> @@ -1584,7 +1584,7 @@ config SENSORS_ADS7871
>  	help
>  	  If you say yes here you get support for TI ADS7871 & ADS7870
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called ads7871.
>  
>  config SENSORS_AMC6821
> @@ -1594,7 +1594,7 @@ config SENSORS_AMC6821
>  	  If you say yes here you get support for the Texas Instruments
>  	  AMC6821 hardware monitoring chips.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called amc6821.
>  
>  config SENSORS_INA209
> @@ -1618,7 +1618,7 @@ config SENSORS_INA2XX
>  	  The INA2xx driver is configured for the default configuration of
>  	  the part as described in the datasheet.
>  	  Default value for Rshunt is 10 mOhms.
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called ina2xx.
>  
>  config SENSORS_INA3221
> @@ -1629,7 +1629,7 @@ config SENSORS_INA3221
>  	  If you say yes here you get support for  the TI INA3221 Triple Power
>  	  Monitor.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called ina3221.
>  
>  config SENSORS_TC74
> @@ -1639,7 +1639,7 @@ config SENSORS_TC74
>  	  If you say yes here you get support for Microchip TC74 single
>  	  input temperature sensor chips.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called tc74.
>  
>  config SENSORS_THMC50
> @@ -1649,7 +1649,7 @@ config SENSORS_THMC50
>  	  If you say yes here you get support for Texas Instruments THMC50
>  	  sensor chips and clones: the Analog Devices ADM1022.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called thmc50.
>  
>  config SENSORS_TMP102
> @@ -1660,7 +1660,7 @@ config SENSORS_TMP102
>  	  If you say yes here you get support for Texas Instruments TMP102
>  	  sensor chips.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called tmp102.
>  
>  config SENSORS_TMP103
> @@ -1671,7 +1671,7 @@ config SENSORS_TMP103
>  	  If you say yes here you get support for Texas Instruments TMP103
>  	  sensor chips.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called tmp103.
>  
>  config SENSORS_TMP108
> @@ -1682,7 +1682,7 @@ config SENSORS_TMP108
>  	  If you say yes here you get support for Texas Instruments TMP108
>  	  sensor chips.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called tmp108.
>  
>  config SENSORS_TMP401
> @@ -1692,7 +1692,7 @@ config SENSORS_TMP401
>  	  If you say yes here you get support for Texas Instruments TMP401,
>  	  TMP411, TMP431, TMP432, TMP435, and TMP461 temperature sensor chips.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called tmp401.
>  
>  config SENSORS_TMP421
> @@ -1702,7 +1702,7 @@ config SENSORS_TMP421
>  	  If you say yes here you get support for Texas Instruments TMP421,
>  	  TMP422, TMP423, TMP441, and TMP442 temperature sensor chips.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called tmp421.
>  
>  config SENSORS_VEXPRESS
> @@ -1729,7 +1729,7 @@ config SENSORS_VIA686A
>  	  If you say yes here you get support for the integrated sensors in
>  	  Via 686A/B South Bridges.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called via686a.
>  
>  config SENSORS_VT1211
> @@ -1740,7 +1740,7 @@ config SENSORS_VT1211
>  	  If you say yes here then you get support for hardware monitoring
>  	  features of the VIA VT1211 Super-I/O chip.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called vt1211.
>  
>  config SENSORS_VT8231
> @@ -1751,7 +1751,7 @@ config SENSORS_VT8231
>  	  If you say yes here then you get support for the integrated sensors
>  	  in the VIA VT8231 device.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called vt8231.
>  
>  config SENSORS_W83773G
> @@ -1761,7 +1761,7 @@ config SENSORS_W83773G
>  	  If you say yes here you get support for the Nuvoton W83773G hardware
>  	  monitoring chip.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called w83773g.
>  
>  config SENSORS_W83781D
> @@ -1773,7 +1773,7 @@ config SENSORS_W83781D
>  	  of sensor chips: the W83781D, W83782D and W83783S, and the similar
>  	  Asus AS99127F.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called w83781d.
>  
>  config SENSORS_W83791D
> @@ -1783,7 +1783,7 @@ config SENSORS_W83791D
>  	help
>  	  If you say yes here you get support for the Winbond W83791D chip.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called w83791d.
>  
>  config SENSORS_W83792D
> @@ -1792,7 +1792,7 @@ config SENSORS_W83792D
>  	help
>  	  If you say yes here you get support for the Winbond W83792D chip.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called w83792d.
>  
>  config SENSORS_W83793
> @@ -1804,7 +1804,7 @@ config SENSORS_W83793
>  	  hardware monitoring chip, including support for the integrated
>  	  watchdog.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called w83793.
>  
>  config SENSORS_W83795
> @@ -1815,7 +1815,7 @@ config SENSORS_W83795
>  	  W83795ADG hardware monitoring chip, including manual fan speed
>  	  control.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called w83795.
>  
>  config SENSORS_W83795_FANCTRL
> @@ -1842,7 +1842,7 @@ config SENSORS_W83L785TS
>  	  sensor chip, which is used on the Asus A7N8X, among other
>  	  motherboards.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called w83l785ts.
>  
>  config SENSORS_W83L786NG
> @@ -1852,7 +1852,7 @@ config SENSORS_W83L786NG
>  	  If you say yes here you get support for the Winbond W83L786NG
>  	  and W83L786NR sensor chips.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called w83l786ng.
>  
>  config SENSORS_W83627HF
> @@ -1864,7 +1864,7 @@ config SENSORS_W83627HF
>  	  of sensor chips: the W83627HF, W83627THF, W83637HF, W83687THF and
>  	  W83697HF.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called w83627hf.
>  
>  config SENSORS_W83627EHF
> @@ -1884,7 +1884,7 @@ config SENSORS_W83627EHF
>  	  This driver also supports Nuvoton W83667HG, W83667HG-B, NCT6775F
>  	  (also known as W83667HG-I), and NCT6776F.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called w83627ehf.
>  
>  config SENSORS_WM831X
> @@ -1895,7 +1895,7 @@ config SENSORS_WM831X
>  	  monitoring functionality of the Wolfson Microelectronics
>  	  WM831x series of PMICs.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called wm831x-hwmon.
>  
>  config SENSORS_WM8350
> @@ -1905,7 +1905,7 @@ config SENSORS_WM8350
>  	  If you say yes here you get support for the hardware
>  	  monitoring features of the WM835x series of PMICs.
>  
> -	  This driver can also be built as a module.  If so, the module
> +	  This driver can also be built as a module. If so, the module
>  	  will be called wm8350-hwmon.
>  
>  config SENSORS_ULTRA45
