Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752219AbeERCHf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 22:07:35 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39979 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751644AbeERCHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 22:07:33 -0400
X-Google-Smtp-Source: AB8JxZqBNB2yXN4ofWukoAmcXTJQqDPzfAuDaY1HNnpmJMfFvjRMjWMzfxXra5Lwm3zGJ7/65HT5Dg==
Date: Fri, 18 May 2018 07:37:30 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH v1 10/11] cpufreq: tegra20: Wrap cpufreq into platform
 driver
Message-ID: <20180518020730.byftoaodycccze3m@vireshk-i7>
References: <20180517180056.13336-1-digetx@gmail.com>
 <20180517180056.13336-11-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517180056.13336-11-digetx@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-05-18, 21:00, Dmitry Osipenko wrote:
> -static int __init tegra_cpufreq_init(void)
> +static int tegra20_cpufreq_probe(struct platform_device *pdev)
>  {
> +	struct tegra20_cpufreq_data *data;
>  	int err;
>  
> -	if (!of_machine_is_compatible("nvidia,tegra20"))
> -		return -ENODEV;

So this stuff wasn't really required as you are getting rid of that in
the same series. Should we really add it then ? Maybe ..

> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
>  
> -	cpu_clk = clk_get_sys(NULL, "cclk");
> -	if (IS_ERR(cpu_clk))
> -		return PTR_ERR(cpu_clk);
> +	data->cpu_clk = clk_get_sys(NULL, "cclk");
> +	if (IS_ERR(data->cpu_clk))
> +		return PTR_ERR(data->cpu_clk);
>  
> -	pll_x_clk = clk_get_sys(NULL, "pll_x");
> -	if (IS_ERR(pll_x_clk)) {
> -		err = PTR_ERR(pll_x_clk);
> +	data->pll_x_clk = clk_get_sys(NULL, "pll_x");
> +	if (IS_ERR(data->pll_x_clk)) {
> +		err = PTR_ERR(data->pll_x_clk);
>  		goto put_cpu;
>  	}
>  
> -	pll_p_clk = clk_get_sys(NULL, "pll_p");
> -	if (IS_ERR(pll_p_clk)) {
> -		err = PTR_ERR(pll_p_clk);
> +	data->pll_p_clk = clk_get_sys(NULL, "pll_p");
> +	if (IS_ERR(data->pll_p_clk)) {
> +		err = PTR_ERR(data->pll_p_clk);
>  		goto put_pll_x;
>  	}
>  
> +	data->dev = &pdev->dev;
> +
> +	tegra_cpufreq_driver.driver_data = data;
> +
>  	err = cpufreq_register_driver(&tegra_cpufreq_driver);
>  	if (err)
>  		goto put_pll_p;
>  
> +	platform_set_drvdata(pdev, data);
> +
>  	return 0;
>  
>  put_pll_p:
> -	clk_put(pll_p_clk);
> +	clk_put(data->pll_p_clk);
>  put_pll_x:
> -	clk_put(pll_x_clk);
> +	clk_put(data->pll_x_clk);
>  put_cpu:
> -	clk_put(cpu_clk);
> +	clk_put(data->cpu_clk);
>  
>  	return err;
>  }
>  
> -static void __exit tegra_cpufreq_exit(void)
> +static int tegra20_cpufreq_remove(struct platform_device *pdev)
>  {
> +	struct tegra20_cpufreq_data *data = platform_get_drvdata(pdev);
> +
>  	cpufreq_unregister_driver(&tegra_cpufreq_driver);
> -	clk_put(pll_p_clk);
> -	clk_put(pll_x_clk);
> -	clk_put(cpu_clk);
> +
> +	clk_put(data->pll_p_clk);
> +	clk_put(data->pll_x_clk);
> +	clk_put(data->cpu_clk);
> +
> +	return 0;
>  }
>  
> +static struct platform_driver tegra20_cpufreq_driver = {
> +	.probe		= tegra20_cpufreq_probe,
> +	.remove		= tegra20_cpufreq_remove,
> +	.driver		= {
> +		.name	= "tegra20-cpufreq",
> +	},
> +};
> +module_platform_driver(tegra20_cpufreq_driver);
> +
>  MODULE_AUTHOR("Colin Cross <ccross@android.com>");
> +MODULE_ALIAS("platform:tegra20-cpufreq");
>  MODULE_DESCRIPTION("NVIDIA Tegra20 cpufreq driver");
>  MODULE_LICENSE("GPL");
> -module_init(tegra_cpufreq_init);
> -module_exit(tegra_cpufreq_exit);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
