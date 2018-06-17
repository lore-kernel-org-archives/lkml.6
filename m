Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B1AC5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 16:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA3220891
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 16:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ol2vbKxj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA3220891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934523AbeFQQwZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 12:52:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47926 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934108AbeFQQwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 12:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3grIIalnNEa4wifl/c2uHQTse8l0gDLiMfKpCvxDyA0=; b=ol2vbKxjH/aKPr17a48UzT7HH
        iz9fGSKZtjdlA7Iz5ZP5sxPwncXSUkZ14ZnDbIFxlen4KWvZk8gR8sw6P2zQXBedxv7al2cbeuNpa
        lASmNZwBtcmjhHsH8SnizPSkqHBXuPd6L2JpBtr/arK0Ebwbhz8jqtX0rSX5Ye1yor54hk6K11Dil
        kuABEDzKEibSQy+G7Gv+8YsDaZwqEFjpNGfWyKa/LKasVMGcJfPbZdWXWhc/3vhuueZU600RJH2Pr
        d3L9cByAwtYJzfaGNDPofhbByZGU9AxtgW85Vq53D9f4kVe3FvG98iuYTmRZQFoRPSpOqcu06TaLK
        MiBEsbDKA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fUauZ-0003Yn-3z; Sun, 17 Jun 2018 16:52:19 +0000
Subject: Re: [PATCH v6 6/8] platform/mellanox: Introduce support for Mellanox
 register access driver
To:     Vadim Pasternak <vadimp@mellanox.com>, dvhart@infradead.org,
        andy.shevchenko@gmail.com, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        jiri@resnulli.us, michaelsh@mellanox.com, ivecera@redhat.com
References: <1529254615-88124-1-git-send-email-vadimp@mellanox.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b804ccc4-77c3-e7a9-9486-8d12d50ec5f7@infradead.org>
Date:   Sun, 17 Jun 2018 09:52:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1529254615-88124-1-git-send-email-vadimp@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/17/2018 09:56 AM, Vadim Pasternak wrote:
> ---
>  drivers/platform/mellanox/Kconfig     |  11 ++
>  drivers/platform/mellanox/Makefile    |   1 +
>  drivers/platform/mellanox/mlxreg-io.c | 245 ++++++++++++++++++++++++++++++++++
>  3 files changed, 257 insertions(+)
>  create mode 100644 drivers/platform/mellanox/mlxreg-io.c

Hi,

> diff --git a/drivers/platform/mellanox/Kconfig b/drivers/platform/mellanox/Kconfig
> index 591bccd..ddfae9fc 100644
> --- a/drivers/platform/mellanox/Kconfig
> +++ b/drivers/platform/mellanox/Kconfig
> @@ -23,4 +23,15 @@ config MLXREG_HOTPLUG
>  	  This driver handles hot-plug events for the power suppliers, power
>  	  cables and fans on the wide range Mellanox IB and Ethernet systems.
>  
> +config MLXREG_IO
> +	tristate "Mellanox platform register access driver support"
> +	depends on REGMAP
> +	depends on HWMON
> +	help
> +	  This driver allows access to Mellanox programmable device register
> +	  space trough sysfs interface. The sets of registers for sysfs access

	        through

> +	  are defined per system type bases and includes the registers related

	                                    and include the

> +	  to system resets operation, system reset causes monitoring and some
> +	  kinds of mux selection.
> +
>  endif # MELLANOX_PLATFORM


-- 
~Randy
