Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CBCC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E521F20851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2rfJdjX+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E521F20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbeLLSsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:48:33 -0500
Received: from merlin.infradead.org ([205.233.59.134]:34920 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727897AbeLLSsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:48:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Ttyo4Kl+9DOlfE2GjxEeKBk86/4qJBO2/V0uJDlF2sU=; b=2rfJdjX+/x4oyv+R3iO8IizOlY
        QGhym1X/sbb+TARgj5+ylJgfuIvy6CfCmSBkq+f7Vq/4gOsyhUuwRPsJINOmNFrKkF5I18Jx4xfUZ
        rLa+uprvQOCqPmMOUDvIt0C6xVV3xSCfB++nbjHJrdCNkpt31BW//TKlo5Qph04INfCp3ItRen/8l
        2XiHFnETTrPStLK1SuhkmCJ6V/7NvvJcTxzFCpqLhh74JWnjuj8rwYONRmHBbi3qfuzM9f2hZQpOO
        OoYMWE8YiP6/9pqyJMz+0h1IBqBWb7Y2MlFNejZpev0Qt3oXNXU8elIjNjQDNAX1Aq877rtsiFTjy
        lmGRcPYg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gX9Yb-0004EM-VQ; Wed, 12 Dec 2018 18:48:30 +0000
Subject: Re: [PATCH v2 2/2] driver: clocksource: Add nxp system counter timer
 driver support
To:     Jacky Bai <ping.bai@nxp.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
References: <1544592770-19996-1-git-send-email-ping.bai@nxp.com>
 <1544592770-19996-2-git-send-email-ping.bai@nxp.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <dbe836ff-cd29-a693-4d83-a2fee419b424@infradead.org>
Date:   Wed, 12 Dec 2018 10:48:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1544592770-19996-2-git-send-email-ping.bai@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/11/18 9:28 PM, Jacky Bai wrote:
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index c57b156..7e5f2de 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -579,6 +579,14 @@ config CLKSRC_IMX_TPM
>  	  Enable this option to use IMX Timer/PWM Module (TPM) timer as
>  	  clocksource.
>  
> +config CLKSRC_IMX_SYS_CTR
> +	bool "Clocksource using i.MX system counter" if COMPILE_TEST

Looks like a "make *config" user only gets this prompt if COMPILE_TEST is set.

If COMPILE_TEST is not set, how does this driver become enabled/set?


> +	depends on (ARM || ARM64) && CLKDEV_LOOKUP
> +	select CLKSRC_MMIO
> +	help
> +	  Enable this option to use IMX system counter timer as
> +	  clocksource.
> +
>  config CLKSRC_ST_LPC
>  	bool "Low power clocksource found in the LPC" if COMPILE_TEST
>  	select TIMER_OF if OF

thanks,
-- 
~Randy
