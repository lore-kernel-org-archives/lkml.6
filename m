Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C8AC67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 15:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A9A92082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 15:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZreF+p6o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A9A92082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbeJYA1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 20:27:18 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38902 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbeJYA1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 20:27:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:Subject:From:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=J6/g6MGPv3fU3M/9mbisF4oC7x0qcPKZb2AHEa5Ep5A=; b=ZreF+p6opoQXQ8V2QBMwFaCHl/
        fVr7c7rjqKL+UVfOI/kbUCnM4VPtpwp+bMhq57/y7bswbN32yWatiEP5FkBLYsa77YYe0PCYpgVvC
        5Oi2+/gQqvVbARlIdl8+dkR2HTv2HbbN99ZcHeXGaoUPPL/LFoB10YTwEA1tbXBbSFluNmLIcDuXG
        grUb37IXve6AF3fDwloDqhEDB1YPALABr1E3kfWPbMG4BaElc1/ayKd34H7JWENs9rRNyxy5ibzB0
        f2AUhqPUbE6B1hDYStkKeobUeZfWfUHrF7vbrkpS8n4jMNdZ9fA9gaJsqKvqnJEhz52B4dzLli+lr
        DM9ybvKw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gFLYM-0000nl-VV; Wed, 24 Oct 2018 15:58:39 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH anybus v1 3/4] bus: support HMS Anybus-S bus.
To:     Sven Van Asbroeck <svendev@arcx.com>, lee.jones@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, afaerber@suse.de,
        treding@nvidia.com, david@lechnology.com, noralf@tronnes.org,
        johan@kernel.org, monstr@monstr.eu, michal.vokac@ysoft.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, john.garry@huawei.com,
        andriy.shevchenko@linux.intel.com, geert+renesas@glider.be,
        robin.murphy@arm.com, paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        yuanzhichang@hisilicon.com, stuyoder@gmail.com,
        linus.walleij@linaro.org, maxime.ripard@bootlin.com,
        bogdan.purcareata@nxp.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20181024142456.10084-1-svendev@arcx.com>
 <20181024142456.10084-4-svendev@arcx.com>
Message-ID: <d58debbd-4c14-6995-cc63-bbc2b35fa7cf@infradead.org>
Date:   Wed, 24 Oct 2018 08:58:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181024142456.10084-4-svendev@arcx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/18 7:24 AM, Sven Van Asbroeck wrote:
> diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
> index 1851112ccc29..68869648b9ab 100644
> --- a/drivers/bus/Kconfig
> +++ b/drivers/bus/Kconfig
> @@ -45,6 +45,17 @@ config IMX_WEIM
>  	  The WEIM(Wireless External Interface Module) works like a bus.
>  	  You can attach many different devices on it, such as NOR, onenand.
>  
> +config HMS_ANYBUSS_HOST
> +	tristate "HMS Anybus-S Host/Bus Driver"
> +	select REGMAP
> +	depends on OF
> +	default n

Please drop the "default n".  That is already the default in Kconfig files.

> +	help
> +	  Driver for the HMS Industrial Networks Anybus-S bus.
> +	  You can attach Anybus-S compatible cards to it, which
> +	  typically provide fieldbus and industrial ethernet
> +	  functionality.
> +
>  config MIPS_CDMM
>  	bool "MIPS Common Device Memory Map (CDMM) Driver"
>  	depends on CPU_MIPSR2


Also please check the multi-line comments for kernel comment style.

thanks,
-- 
~Randy
