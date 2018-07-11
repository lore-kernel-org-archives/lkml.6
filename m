Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0B3C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D771E20877
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:27:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D771E20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732423AbeGKIab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 04:30:31 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:6527 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbeGKIa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 04:30:29 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b45bf670000>; Wed, 11 Jul 2018 01:27:19 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 11 Jul 2018 01:27:21 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 11 Jul 2018 01:27:21 -0700
Received: from [10.21.132.122] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 11 Jul
 2018 08:27:19 +0000
Subject: Re: [PATCH 3/6] soc/tegra: pmc: Implement tegra_io_pad_is_powered()
To:     Aapo Vienamo <avienamo@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1531226879-11802-1-git-send-email-avienamo@nvidia.com>
 <1531226879-11802-4-git-send-email-avienamo@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <01e8e69f-ef6f-e5e8-bb72-5ad408d81806@nvidia.com>
Date:   Wed, 11 Jul 2018 09:27:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1531226879-11802-4-git-send-email-avienamo@nvidia.com>
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


On 10/07/18 13:47, Aapo Vienamo wrote:
> Implement a function to query whether a pad is in deep power down mode.
> 
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>  drivers/soc/tegra/pmc.c | 17 +++++++++++++++++
>  include/soc/tegra/pmc.h |  1 +
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index 83b39cd..3f5b69fd 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -1075,6 +1075,23 @@ int tegra_io_pad_power_disable(enum tegra_io_pad id)
>  }
>  EXPORT_SYMBOL(tegra_io_pad_power_disable);
>  
> +int tegra_io_pad_is_powered(enum tegra_io_pad id)
> +{
> +	unsigned long request, status;
> +	u32 mask;
> +	u32 value;

Nit-pick ... could have been on a single line.

> +	int err;
> +
> +	err = tegra_io_pad_get_dpd_register_bit(id, &request, &status, &mask);
> +	if (err)
> +		return err;
> +
> +	value = tegra_pmc_readl(status);
> +
> +	return !(value & mask);
> +}
> +EXPORT_SYMBOL(tegra_io_pad_is_powered);
> +
>  int tegra_io_pad_set_voltage(enum tegra_io_pad id,
>  			     enum tegra_io_pad_voltage voltage)
>  {
> diff --git a/include/soc/tegra/pmc.h b/include/soc/tegra/pmc.h
> index c32bf91..f88c6e2 100644
> --- a/include/soc/tegra/pmc.h
> +++ b/include/soc/tegra/pmc.h
> @@ -162,6 +162,7 @@ int tegra_powergate_sequence_power_up(unsigned int id, struct clk *clk,
>  
>  int tegra_io_pad_power_enable(enum tegra_io_pad id);
>  int tegra_io_pad_power_disable(enum tegra_io_pad id);
> +int tegra_io_pad_is_powered(enum tegra_io_pad id);
>  int tegra_io_pad_set_voltage(enum tegra_io_pad id,
>  			     enum tegra_io_pad_voltage voltage);
>  int tegra_io_pad_get_voltage(enum tegra_io_pad id);
> 

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
