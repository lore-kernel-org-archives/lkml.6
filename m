Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFE7C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32AD221855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfAXKwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 05:52:45 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:55002 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfAXKwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 05:52:45 -0500
Received: from 79.184.255.239.ipv4.supernova.orange.pl (79.184.255.239) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id ccbda617de99b9ce; Thu, 24 Jan 2019 11:52:42 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     linux-next@vger.kernel.org, linux-acpi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [for next][PATCH 1/2] mfd: Fix unmet dependency warning for MFD_TPS68470
Date:   Thu, 24 Jan 2019 11:51:43 +0100
Message-ID: <2222147.2pZxjFhHIY@aspire.rjw.lan>
In-Reply-To: <20190121231958.28255-1-okaya@kernel.org>
References: <20190121231958.28255-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, January 22, 2019 12:19:57 AM CET Sinan Kaya wrote:
> After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
> CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
> satisfied implicitly through dependencies on CONFIG_ACPI have to be
> specified directly.
> 
> WARNING: unmet direct dependencies detected for I2C_DESIGNWARE_PLATFORM
>   Depends on [n]: I2C [=y] && HAS_IOMEM [=y] && (ACPI [=y] && COMMON_CLK [=n] || !ACPI [=y])
>   Selected by [y]:
>   - MFD_TPS68470 [=y] && HAS_IOMEM [=y] && ACPI [=y] && I2C [=y]=y
> 
> MFD_TPS68470 is an ACPI only device and selects I2C_DESIGNWARE_PLATFORM.
> I2C_DESIGNWARE_PLATFORM does not have any configuration today for ACPI
> support without CONFIG_PCI set.
> 
> For sake of a quick fix this introduces a new mandatory dependency to the
> driver which may survive without it. Otherwise we need to revisit the
> driver architecture to address this properly.
> 
> Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  drivers/mfd/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index f461460a2aeb..76f9909cf396 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1419,7 +1419,7 @@ config MFD_TPS65217
>  
>  config MFD_TPS68470
>  	bool "TI TPS68470 Power Management / LED chips"
> -	depends on ACPI && I2C=y
> +	depends on ACPI && PCI && I2C=y
>  	select MFD_CORE
>  	select REGMAP_I2C
>  	select I2C_DESIGNWARE_PLATFORM
> 

Is anyone taking this or should I?



