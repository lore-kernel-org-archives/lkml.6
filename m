Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80198C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33CBF20874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33CBF20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965681AbeFSKH0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 06:07:26 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:1812 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755946AbeFSKHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 06:07:25 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b28d5de0000>; Tue, 19 Jun 2018 03:07:27 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 19 Jun 2018 03:07:24 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 19 Jun 2018 03:07:24 -0700
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 19 Jun
 2018 10:07:21 +0000
Subject: Re: [PATCH] usb: xhci: tegra: fix runtime PM error handling
To:     Stefan Agner <stefan@agner.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20180617111258.13447-1-stefan@agner.ch>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <738c34e8-e6cc-9947-8d4f-3867b57a0e12@nvidia.com>
Date:   Tue, 19 Jun 2018 11:07:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180617111258.13447-1-stefan@agner.ch>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17/06/18 12:12, Stefan Agner wrote:
> The address-of operator will always evaluate to true. However,
> power should be explicitly disabled if no power domain is used.
> 
> Remove the address-of operator.
> 
> Fixes: 58c38116c6cc ("usb: xhci: tegra: Add support for managing powergates")
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/usb/host/xhci-tegra.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
> index a8c1d073cba0..33daac4136e8 100644
> --- a/drivers/usb/host/xhci-tegra.c
> +++ b/drivers/usb/host/xhci-tegra.c
> @@ -1223,10 +1223,10 @@ static int tegra_xusb_probe(struct platform_device *pdev)
>  	pm_runtime_disable(&pdev->dev);
>  	usb_put_hcd(tegra->hcd);
>  disable_xusbc:
> -	if (!&pdev->dev.pm_domain)
> +	if (!pdev->dev.pm_domain)
>  		tegra_powergate_power_off(TEGRA_POWERGATE_XUSBC);
>  disable_xusba:
> -	if (!&pdev->dev.pm_domain)
> +	if (!pdev->dev.pm_domain)
>  		tegra_powergate_power_off(TEGRA_POWERGATE_XUSBA);
>  put_padctl:
>  	tegra_xusb_padctl_put(tegra->padctl);
> 

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Thanks for fixing!
Jon

-- 
nvpublic
