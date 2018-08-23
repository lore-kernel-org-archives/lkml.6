Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD89C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC0320671
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZnHM3Sdz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC0320671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbeHWS6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 14:58:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60346 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeHWS6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 14:58:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yFdVCt0atTVn2OGnjjUPg7rUZJoLFRaXuwE0O/N2luc=; b=ZnHM3Sdzdcb6dPtCBzZKtbmme
        vhXKbst8kZyTAWHPC6c3RBMzkkLu+y48VRduuYTwAo/J+Xk6eMCQZfMQwvtIwgOufvfLsXsdY3uc2
        71l+vWxzRuliojWvXZUERXVdTcyicTAfA8Hz0cfHIRC2UekhIZmY2FbSfULPcqVK7hf600S5UwAJH
        iUTDb0gpXxhafe+TO9art4j48Eoz2ZdzIcx9SFnBjbdr5hSvS/NZvMvDhR9ta2gyy32zcuEe3DYCB
        sQUArTihe//tz2nhwRiqKtZn9J3jjpmxnjBK9PwrtW5tt/b+Rbv9/ofMcuwJ63a4rRTSa9jtUSMAG
        Ydmn2dogQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fsrX6-0004dh-UU; Thu, 23 Aug 2018 15:28:24 +0000
Subject: Re: [PATCH V4 3/3] Input: new da7280 haptic driver
To:     Roy Im <roy.im.opensource@diasemi.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Support Opensource <support.opensource@diasemi.com>,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1534830272.git.Roy.Im@diasemi.com>
 <2c28a93093c075e0145b70e7bc999f2654d0431d.1534830272.git.Roy.Im@diasemi.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6115d6ca-8df6-1830-3c61-681610d8f2b0@infradead.org>
Date:   Thu, 23 Aug 2018 08:28:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2c28a93093c075e0145b70e7bc999f2654d0431d.1534830272.git.Roy.Im@diasemi.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/20/2018 10:44 PM, Roy Im wrote:
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index ca59a2b..6e0de69 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -851,4 +851,16 @@ config INPUT_SC27XX_VIBRA
>  	  To compile this driver as a module, choose M here. The module will
>  	  be called sc27xx_vibra.
>  

Hi,
Can you explain the "depends on" below, please.

> +config INPUT_DA7280_HAPTICS
> +	tristate "Dialog Semiconductor DA7280 haptics support"
> +	depends on (INPUT && I2C && SYSFS) || PWM
> +	select INPUT_FF_MEMLESS
> +	select REGMAP_I2C

If INPUT is disabled, and I2C is disabled, and SYSFS is disabled, but PWM=y,
then the "select"s will have problems with unmet dependencies.

> +	help
> +	  Say Y to enable support for the haptics controller on
> +	  Dialog DA7280 chip.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called da7280-haptic.

That module name doesn't match what's in the Makefile (below).

> +
>  endif
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> index 9d0f9d1..d941348 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -25,6 +25,7 @@ obj-$(CONFIG_INPUT_CMA3000)		+= cma3000_d0x.o
>  obj-$(CONFIG_INPUT_CMA3000_I2C)		+= cma3000_d0x_i2c.o
>  obj-$(CONFIG_INPUT_COBALT_BTNS)		+= cobalt_btns.o
>  obj-$(CONFIG_INPUT_CPCAP_PWRBUTTON)	+= cpcap-pwrbutton.o
> +obj-$(CONFIG_INPUT_DA7280_HAPTICS)	+= da7280.o
>  obj-$(CONFIG_INPUT_DA9052_ONKEY)	+= da9052_onkey.o
>  obj-$(CONFIG_INPUT_DA9055_ONKEY)	+= da9055_onkey.o
>  obj-$(CONFIG_INPUT_DA9063_ONKEY)	+= da9063_onkey.o


-- 
~Randy
