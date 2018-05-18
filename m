Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752273AbeERBzW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 21:55:22 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:43328 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752237AbeERBzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 21:55:20 -0400
X-Google-Smtp-Source: AB8JxZrFziry865Jd8xM+okJQJ/RF9lckKoH91sK+WzW3eeBFTCV1kARHgRwWos/eIgCoxG+PFFX3g==
Date: Fri, 18 May 2018 07:25:15 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH v1 04/11] cpufreq: tegra20: Release clocks properly
Message-ID: <20180518015515.2vrnrvfcdiwqltwq@vireshk-i7>
References: <20180517180056.13336-1-digetx@gmail.com>
 <20180517180056.13336-5-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517180056.13336-5-digetx@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-05-18, 21:00, Dmitry Osipenko wrote:
> Properly put requested clocks in the module init/exit code.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/cpufreq/tegra20-cpufreq.c | 31 ++++++++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
> index 693f9067ba8a..69f033d297e1 100644
> --- a/drivers/cpufreq/tegra20-cpufreq.c
> +++ b/drivers/cpufreq/tegra20-cpufreq.c
> @@ -165,24 +165,45 @@ static struct cpufreq_driver tegra_cpufreq_driver = {
>  
>  static int __init tegra_cpufreq_init(void)
>  {
> +	int err;
> +
>  	cpu_clk = clk_get_sys(NULL, "cclk");
>  	if (IS_ERR(cpu_clk))
>  		return PTR_ERR(cpu_clk);
>  
>  	pll_x_clk = clk_get_sys(NULL, "pll_x");
> -	if (IS_ERR(pll_x_clk))
> -		return PTR_ERR(pll_x_clk);
> +	if (IS_ERR(pll_x_clk)) {
> +		err = PTR_ERR(pll_x_clk);
> +		goto put_cpu;
> +	}
>  
>  	pll_p_clk = clk_get_sys(NULL, "pll_p");
> -	if (IS_ERR(pll_p_clk))
> -		return PTR_ERR(pll_p_clk);
> +	if (IS_ERR(pll_p_clk)) {
> +		err = PTR_ERR(pll_p_clk);
> +		goto put_pll_x;
> +	}
> +
> +	err = cpufreq_register_driver(&tegra_cpufreq_driver);
> +	if (err)
> +		goto put_pll_p;
> +
> +	return 0;
> +
> +put_pll_p:
> +	clk_put(pll_p_clk);
> +put_pll_x:
> +	clk_put(pll_x_clk);
> +put_cpu:
> +	clk_put(cpu_clk);
>  
> -	return cpufreq_register_driver(&tegra_cpufreq_driver);
> +	return err;
>  }
>  
>  static void __exit tegra_cpufreq_exit(void)
>  {
>  	cpufreq_unregister_driver(&tegra_cpufreq_driver);
> +	clk_put(pll_p_clk);
> +	clk_put(pll_x_clk);
>  	clk_put(cpu_clk);
>  }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
