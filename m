Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A43C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0FD32457D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FzyiFs/J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0FD32457D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754508AbeFVQE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:04:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35312 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751649AbeFVQE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=y6j0rJydYoqcY3mNyO3GCjxyfkVs9bdlOcCNSKvohmg=; b=FzyiFs/JjQCiez62w51rEpI98
        XznN4w5MqISdzMd9jJekktYdXvP9lPBm5JxCOvszjgUExXievdJxWcTwG44RHJJIpNTYLikGgKeA5
        lXqDx7YzTpo7hNwbgzjgtJnUh3L6C45ifXmTEaZEF9Htw3QnVZ/TvToJ6Xt1Hwe889KhwHMbtYZej
        9xDH1Agm/fLnGzrg6P8eqfk6PQ/EDTKxuC4Axe0Ok7eUG+bRfodYmtm+7nQ2dOO7v4yRpTsIfdiJE
        gbnG50Cf3I7rY5xl0CrxbmeswVWAjnIF/kT7O8XTkcotYOFkWM/DqzzS4b7zFc15ew6NpPm10D9FE
        hp0i2DKTQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fWOYM-0004Bo-5K; Fri, 22 Jun 2018 16:04:50 +0000
Subject: Re: [PATCH v5 09/10] gpio: Add a driver for Cadence I3C GPIO expander
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        linux-gpio@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>
References: <20180622104930.32050-1-boris.brezillon@bootlin.com>
 <20180622104930.32050-10-boris.brezillon@bootlin.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <27aae5b0-f8eb-bed7-9d14-5c739769977a@infradead.org>
Date:   Fri, 22 Jun 2018 09:04:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180622104930.32050-10-boris.brezillon@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/22/2018 03:49 AM, Boris Brezillon wrote:
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 71c0ab46f216..19ed6006aea1 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -898,6 +898,17 @@ config GPIO_TS4900
>  
>  endmenu
>  
> +menu "I3C GPIO expanders"
> +	depends on I3C
> +
> +config GPIO_CDNS_I3C
> +	tristate "Cadence I3C GPIO expander"
> +	select GPIOLIB_IRQCHIP
> +	help
> +	  Say yes here to enabled the driver for Cadence I3C GPIO expander.

	               to enable the driver

> +
> +endmenu


-- 
~Randy
