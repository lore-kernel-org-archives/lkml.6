Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753995AbeEWF6Y (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 01:58:24 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43728 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751085AbeEWF6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 01:58:20 -0400
X-Google-Smtp-Source: AB8JxZpsoCfaCEhqJLCBvOQpmDDKobM0WNP0cYiLlrniKsgMp+ua/fy652ZfxKywPllGbtQb7IGzeQ==
Date: Wed, 23 May 2018 11:28:17 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] cpufreq: tegra20: Fix imbalanced clock enable count
Message-ID: <20180523055817.subrv6oeckfecpcp@vireshk-i7>
References: <20180522211420.2006-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522211420.2006-1-digetx@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-05-18, 00:14, Dmitry Osipenko wrote:
> Tegra20-cpufreq driver missed enabling the CPU clocks. This results in a
> clock-enable refcount disbalance on PLL_P <-> PLL_X reparent, causing
> PLL_X to get disabled while it shouldn't. Fix this by enabling the clocks
> on the driver probe.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
> 
> CPUFreq maintainers,
> 
> Please take into account that this patch is made on top of my recent
> series of patches [0] "Clean up Tegra20 cpufreq driver" that was fully
> reviewed, but seems not applied yet. Let me know if you prefer to re-spin
> the [0], including this patch into the series.
> 
> [0] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=45321

This is already picked by Rafael and is sitting in pm/bleeding-edge
branch. Should get merged into linux-next in a day or two.

>  drivers/cpufreq/tegra20-cpufreq.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
> index 05f57dcd5215..ca5229265b60 100644
> --- a/drivers/cpufreq/tegra20-cpufreq.c
> +++ b/drivers/cpufreq/tegra20-cpufreq.c
> @@ -176,6 +176,14 @@ static int tegra20_cpufreq_probe(struct platform_device *pdev)
>  		goto put_pll_x;
>  	}
>  
> +	err = clk_prepare_enable(cpufreq->pll_x_clk);
> +	if (err)
> +		goto put_pll_p;
> +
> +	err = clk_prepare_enable(cpufreq->pll_p_clk);
> +	if (err)
> +		goto disable_pll_x;
> +
>  	cpufreq->dev = &pdev->dev;
>  	cpufreq->driver.get = cpufreq_generic_get;
>  	cpufreq->driver.attr = cpufreq_generic_attr;
> @@ -192,12 +200,16 @@ static int tegra20_cpufreq_probe(struct platform_device *pdev)
>  
>  	err = cpufreq_register_driver(&cpufreq->driver);
>  	if (err)
> -		goto put_pll_p;
> +		goto disable_pll_p;
>  
>  	platform_set_drvdata(pdev, cpufreq);
>  
>  	return 0;
>  
> +disable_pll_p:
> +	clk_disable_unprepare(cpufreq->pll_p_clk);
> +disable_pll_x:
> +	clk_disable_unprepare(cpufreq->pll_x_clk);
>  put_pll_p:
>  	clk_put(cpufreq->pll_p_clk);
>  put_pll_x:
> @@ -214,6 +226,8 @@ static int tegra20_cpufreq_remove(struct platform_device *pdev)
>  
>  	cpufreq_unregister_driver(&cpufreq->driver);
>  
> +	clk_disable_unprepare(cpufreq->pll_p_clk);
> +	clk_disable_unprepare(cpufreq->pll_x_clk);
>  	clk_put(cpufreq->pll_p_clk);
>  	clk_put(cpufreq->pll_x_clk);
>  	clk_put(cpufreq->cpu_clk);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
