Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED12C282CB
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB2620881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="C1eZRpAC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfA1Hyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 02:54:50 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15316 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfA1Hyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 02:54:50 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c4eb52d0000>; Sun, 27 Jan 2019 23:54:21 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 27 Jan 2019 23:54:48 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 27 Jan 2019 23:54:48 -0800
Received: from [10.19.108.140] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 28 Jan
 2019 07:54:46 +0000
Subject: Re: [PATCH 2/6] usb: host: xhci-tegra: Selectively program IPFS
To:     Thierry Reding <thierry.reding@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>, <linux-usb@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190125113013.11447-1-thierry.reding@gmail.com>
 <20190125113013.11447-2-thierry.reding@gmail.com>
From:   jckuo <jckuo@nvidia.com>
Message-ID: <b65fa749-1ac1-0889-e889-579d42fc3074@nvidia.com>
Date:   Mon, 28 Jan 2019 15:54:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190125113013.11447-2-thierry.reding@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548662061; bh=g4DEb9POZJcJ7LvyFccGVYKJtK27t2K/OKqijCpCOcU=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=C1eZRpACjDWWswmepQ8DWHc+3zy9ORuaqhf+6/yCTxkqr/PkDE984fhbXvLIWGlaa
         eyBO/oQdOTH+zMmmuyR5TSUoocpKzVUNljfrHbu3BtW5KVGzsQjWVJPXarmIiZUItp
         2Pud64btVPXQ7XT+P08Jy54rkUZMex2vlgI1wMrXpaHRVge2kNYZBAyluAz/N4UDIn
         /kh4S737kxT3P0dvzzirEFn19d3mNNWOLV8OOP4by0kyl7Y1ifBcEqUoqf6W6kLAbo
         uUI8FjYaGi0SgtTlm06duOge7UprhvPV/zGj4KPFesXiMQDaCv5oZMlH4Pfr4u8R+1
         qkd+MgHd9krsA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: JC Kuo <jckuo@nvidia.com>

On 1/25/19 7:30 PM, Thierry Reding wrote:
> From: JC Kuo <jckuo@nvidia.com>
>
> Starting with Tegra186, the XUSB controller no longer has the IPFS
> wrapper. This commit adds a "has_ipfs" field to struct tegra_xusb_soc
> that can be used to declare the existence of the IPFS wrapper.
>
> For the existing chips (i.e. Tegra124 and Tegra210), the new field is
> set to true. A future patch adding support for Tegra186 will set it to
> false.
>
> Signed-off-by: JC Kuo <jckuo@nvidia.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>   drivers/usb/host/xhci-tegra.c | 43 +++++++++++++++++++++--------------
>   1 file changed, 26 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
> index 938ff06c0349..49e033f953a2 100644
> --- a/drivers/usb/host/xhci-tegra.c
> +++ b/drivers/usb/host/xhci-tegra.c
> @@ -161,6 +161,7 @@ struct tegra_xusb_soc {
>   	} ports;
>   
>   	bool scale_ss_clock;
> +	bool has_ipfs;
>   };
>   
>   struct tegra_xusb {
> @@ -637,16 +638,18 @@ static irqreturn_t tegra_xusb_mbox_thread(int irq, void *data)
>   	return IRQ_HANDLED;
>   }
>   
> -static void tegra_xusb_ipfs_config(struct tegra_xusb *tegra,
> -				   struct resource *regs)
> +static void tegra_xusb_config(struct tegra_xusb *tegra,
> +			      struct resource *regs)
>   {
>   	u32 value;
>   
> -	value = ipfs_readl(tegra, IPFS_XUSB_HOST_CONFIGURATION_0);
> -	value |= IPFS_EN_FPCI;
> -	ipfs_writel(tegra, value, IPFS_XUSB_HOST_CONFIGURATION_0);
> +	if (tegra->soc->has_ipfs) {
> +		value = ipfs_readl(tegra, IPFS_XUSB_HOST_CONFIGURATION_0);
> +		value |= IPFS_EN_FPCI;
> +		ipfs_writel(tegra, value, IPFS_XUSB_HOST_CONFIGURATION_0);
>   
> -	usleep_range(10, 20);
> +		usleep_range(10, 20);
> +	}
>   
>   	/* Program BAR0 space */
>   	value = fpci_readl(tegra, XUSB_CFG_4);
> @@ -661,13 +664,15 @@ static void tegra_xusb_ipfs_config(struct tegra_xusb *tegra,
>   	value |= XUSB_IO_SPACE_EN | XUSB_MEM_SPACE_EN | XUSB_BUS_MASTER_EN;
>   	fpci_writel(tegra, value, XUSB_CFG_1);
>   
> -	/* Enable interrupt assertion */
> -	value = ipfs_readl(tegra, IPFS_XUSB_HOST_INTR_MASK_0);
> -	value |= IPFS_IP_INT_MASK;
> -	ipfs_writel(tegra, value, IPFS_XUSB_HOST_INTR_MASK_0);
> +	if (tegra->soc->has_ipfs) {
> +		/* Enable interrupt assertion */
> +		value = ipfs_readl(tegra, IPFS_XUSB_HOST_INTR_MASK_0);
> +		value |= IPFS_IP_INT_MASK;
> +		ipfs_writel(tegra, value, IPFS_XUSB_HOST_INTR_MASK_0);
>   
> -	/* Set hysteresis */
> -	ipfs_writel(tegra, 0x80, IPFS_XUSB_HOST_CLKGATE_HYSTERESIS_0);
> +		/* Set hysteresis */
> +		ipfs_writel(tegra, 0x80, IPFS_XUSB_HOST_CLKGATE_HYSTERESIS_0);
> +	}
>   }
>   
>   static int tegra_xusb_clk_enable(struct tegra_xusb *tegra)
> @@ -1015,10 +1020,12 @@ static int tegra_xusb_probe(struct platform_device *pdev)
>   	if (IS_ERR(tegra->fpci_base))
>   		return PTR_ERR(tegra->fpci_base);
>   
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> -	tegra->ipfs_base = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(tegra->ipfs_base))
> -		return PTR_ERR(tegra->ipfs_base);
> +	if (tegra->soc->has_ipfs) {
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> +		tegra->ipfs_base = devm_ioremap_resource(&pdev->dev, res);
> +		if (IS_ERR(tegra->ipfs_base))
> +			return PTR_ERR(tegra->ipfs_base);
> +	}
>   
>   	tegra->xhci_irq = platform_get_irq(pdev, 0);
>   	if (tegra->xhci_irq < 0)
> @@ -1208,7 +1215,7 @@ static int tegra_xusb_probe(struct platform_device *pdev)
>   		goto disable_rpm;
>   	}
>   
> -	tegra_xusb_ipfs_config(tegra, regs);
> +	tegra_xusb_config(tegra, regs);
>   
>   	err = tegra_xusb_load_firmware(tegra);
>   	if (err < 0) {
> @@ -1380,6 +1387,7 @@ static const struct tegra_xusb_soc tegra124_soc = {
>   		.usb3 = { .offset = 0, .count = 2, },
>   	},
>   	.scale_ss_clock = true,
> +	.has_ipfs = true,
>   };
>   MODULE_FIRMWARE("nvidia/tegra124/xusb.bin");
>   
> @@ -1411,6 +1419,7 @@ static const struct tegra_xusb_soc tegra210_soc = {
>   		.usb3 = { .offset = 0, .count = 4, },
>   	},
>   	.scale_ss_clock = false,
> +	.has_ipfs = true,
>   };
>   MODULE_FIRMWARE("nvidia/tegra210/xusb.bin");
>   
