Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752123AbeCPElh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 00:41:37 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34841 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750793AbeCPElf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 00:41:35 -0400
X-Google-Smtp-Source: AG47ELv6AAnfJnq2DVqUlRIQnP97ij10jDei5DPFmlf30+xKkIkCA4LXJ0Zj4R3c1pCiK4i9mEGFuA==
Date: Fri, 16 Mar 2018 10:11:32 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: sboyd@kernel.org, andy.gross@linaro.org, ulf.hansson@linaro.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 6/7] mmc: sdhci-msm: Adapt the driver to use OPPs to set
 clocks/performance state
Message-ID: <20180316044132.GS15832@vireshk-i7>
References: <20180316040824.21472-1-rnayak@codeaurora.org>
 <20180316040824.21472-7-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316040824.21472-7-rnayak@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-03-18, 09:38, Rajendra Nayak wrote:
> @@ -1540,6 +1571,9 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  	pm_runtime_disable(&pdev->dev);
>  	pm_runtime_set_suspended(&pdev->dev);
>  	pm_runtime_put_noidle(&pdev->dev);
> +	dev_pm_opp_of_remove_table(&pdev->dev);

You can't do this if there is no OPP table. Probably you should just
make it part of the below if block.

> +	if (msm_host->opp_table)
> +		dev_pm_opp_put_clkname(msm_host->opp_table);
>  clk_disable:
>  	clk_bulk_disable_unprepare(ARRAY_SIZE(msm_host->bulk_clks),
>  				   msm_host->bulk_clks);
> @@ -1564,6 +1598,9 @@ static int sdhci_msm_remove(struct platform_device *pdev)
>  	pm_runtime_get_sync(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
>  	pm_runtime_put_noidle(&pdev->dev);
> +	dev_pm_opp_of_remove_table(&pdev->dev);

And this too.

> +	if (msm_host->opp_table)
> +		dev_pm_opp_put_clkname(msm_host->opp_table);
>  
>  	clk_bulk_disable_unprepare(ARRAY_SIZE(msm_host->bulk_clks),
>  				   msm_host->bulk_clks);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
