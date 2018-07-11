Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8568C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA6820877
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AA6820877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732356AbeGKI2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 04:28:09 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:1448 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbeGKI2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 04:28:09 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b45beb20000>; Wed, 11 Jul 2018 01:24:18 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 11 Jul 2018 01:25:02 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 11 Jul 2018 01:25:02 -0700
Received: from [10.21.132.122] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 11 Jul
 2018 08:24:59 +0000
Subject: Re: [PATCH 2/6] soc/tegra: pmc: Factor out DPD register bit
 calculation
To:     Aapo Vienamo <avienamo@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1531226879-11802-1-git-send-email-avienamo@nvidia.com>
 <1531226879-11802-3-git-send-email-avienamo@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <040dce71-36c8-f2e6-cdf0-a848294862c4@nvidia.com>
Date:   Wed, 11 Jul 2018 09:24:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1531226879-11802-3-git-send-email-avienamo@nvidia.com>
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
> Factor out the the code to calculate the correct DPD register and bit
> number for a given pad. This logic will be needed to query the status
> register.
> 
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>  drivers/soc/tegra/pmc.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index 5bea3b9..83b39cd 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -922,11 +922,12 @@ tegra_io_pad_find(struct tegra_pmc *pmc, enum tegra_io_pad id)
>  	return NULL;
>  }
>  
> -static int tegra_io_pad_prepare(enum tegra_io_pad id, unsigned long *request,
> -				unsigned long *status, u32 *mask)
> +static int tegra_io_pad_get_dpd_register_bit(enum tegra_io_pad id,
> +					     unsigned long *request,
> +					     unsigned long *status,
> +					     u32 *mask)
>  {
>  	const struct tegra_io_pad_soc *pad;
> -	unsigned long rate, value;
>  
>  	pad = tegra_io_pad_find(pmc, id);
>  	if (!pad) {
> @@ -947,6 +948,19 @@ static int tegra_io_pad_prepare(enum tegra_io_pad id, unsigned long *request,
>  		*request = pmc->soc->regs->dpd2_req;
>  	}
>  
> +	return 0;
> +}
> +
> +static int tegra_io_pad_prepare(enum tegra_io_pad id, unsigned long *request,
> +				unsigned long *status, u32 *mask)
> +{
> +	unsigned long rate, value;
> +	int err;
> +
> +	err = tegra_io_pad_get_dpd_register_bit(id, request, status, mask);
> +	if (err)
> +		return err;
> +
>  	if (pmc->clk) {
>  		rate = clk_get_rate(pmc->clk);
>  		if (!rate) {
> 

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
