Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5847CC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C6F527FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:41:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C6F527FCB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935575AbeF2Olx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 10:41:53 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:3037 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753285AbeF2Olv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 10:41:51 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b36452d0002>; Fri, 29 Jun 2018 07:41:49 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 29 Jun 2018 07:41:50 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 29 Jun 2018 07:41:50 -0700
Received: from [10.21.132.122] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 29 Jun
 2018 14:41:47 +0000
Subject: Re: [PATCH] clk: tegra: bpmp: Don't crash when a clock fails to
 register
To:     Mikko Perttunen <mperttunen@nvidia.com>, <pdeschrijver@nvidia.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <thierry.reding@gmail.com>
CC:     <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swarren@nvidia.com>,
        <vbhadram@nvidia.com>
References: <20180629143814.17950-1-mperttunen@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <f378f345-02db-f3fd-4c95-b1a2e8ecf3f5@nvidia.com>
Date:   Fri, 29 Jun 2018 15:41:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180629143814.17950-1-mperttunen@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 29/06/18 15:38, Mikko Perttunen wrote:
> When registering clocks, we just skip any that fail to register
> (leaving a NULL hole in the clock table). However, our of_xlate
> function still tries to dereference each entry while looking for
> the clock with the requested id, causing a crash if any clocks
> failed to register. Add a check to of_xlate to skip any NULL
> clocks.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  drivers/clk/tegra/clk-bpmp.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/tegra/clk-bpmp.c b/drivers/clk/tegra/clk-bpmp.c
> index a896692b74ec..01dada561c10 100644
> --- a/drivers/clk/tegra/clk-bpmp.c
> +++ b/drivers/clk/tegra/clk-bpmp.c
> @@ -586,9 +586,15 @@ static struct clk_hw *tegra_bpmp_clk_of_xlate(struct of_phandle_args *clkspec,
>  	unsigned int id = clkspec->args[0], i;
>  	struct tegra_bpmp *bpmp = data;
>  
> -	for (i = 0; i < bpmp->num_clocks; i++)
> -		if (bpmp->clocks[i]->id == id)
> -			return &bpmp->clocks[i]->hw;
> +	for (i = 0; i < bpmp->num_clocks; i++) {
> +		struct tegra_bpmp_clk *clk = bpmp->clocks[i];
> +
> +		if (!clk)
> +			continue;
> +
> +		if (clk->id == id)
> +			return &clk->hw;
> +	}
>  
>  	return NULL;
>  }

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers!
Jon

-- 
nvpublic
