Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752543AbeC2H1N (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 03:27:13 -0400
Received: from lucky1.263xmail.com ([211.157.147.131]:39921 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751434AbeC2H1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 03:27:05 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: shawn.lin@rock-chips.com
X-FST-TO: mnarani@xilinx.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-UNIQUE-TAG: <73c4907bf2b8671333f5f9f6b18d0fc7>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Cc: adrian.hunter@intel.com, michal.simek@xilinx.com,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, Manish Narani <mnarani@xilinx.com>
Subject: Re: [RFC PATCH] sdhci: arasan: Add runtime PM support
To: naranimanish@gmail.com
References: <1522302530-27550-1-git-send-email-naranimanish@gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <83c564e8-6ebf-f21c-676f-05ab75016777@rock-chips.com>
Date: Thu, 29 Mar 2018 15:27:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1522302530-27550-1-git-send-email-naranimanish@gmail.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/3/29 13:48, naranimanish@gmail.com wrote:
> From: Manish Narani <mnarani@xilinx.com>
> 
> This patch adds runtime PM support in Arasan SD driver.
> 
> Signed-off-by: Manish Narani <mnarani@xilinx.com>
> ---
>   drivers/mmc/host/sdhci-of-arasan.c | 83 +++++++++++++++++++++++++++++++++++++-
>   1 file changed, 81 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index c33a5f7..47196b5 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -23,6 +23,7 @@
>   #include <linux/mfd/syscon.h>
>   #include <linux/module.h>
>   #include <linux/of_device.h>
> +#include <linux/pm_runtime.h>
>   #include <linux/phy/phy.h>
>   #include <linux/regmap.h>
>   #include <linux/of.h>
> @@ -349,6 +350,75 @@ static const struct sdhci_pltfm_data sdhci_arasan_cqe_pdata = {
>   			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
>   };
>   
> +#ifdef CONFIG_PM
> +/**
> + * sdhci_arasan_runtime_suspend - Suspend method for the driver
> + * @dev:	Address of the device structure
> + * Returns 0 on success and error value on error
> + *
> + * Put the device in a low power state.
> + */
> +static int sdhci_arasan_runtime_suspend(struct device *dev)
> +{

Would you help take care of cqhci_suspend?

> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct sdhci_host *host = platform_get_drvdata(pdev);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
> +	int ret;
> +
> +	ret = sdhci_runtime_suspend_host(host);
> +	if (ret)
> +		return ret;
> +
> +	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
> +		mmc_retune_needed(host->mmc);
> +
> +	clk_disable(pltfm_host->clk);
> +	clk_disable(sdhci_arasan->clk_ahb);
> +
> +	return 0;
> +}
> +
> +/**
> + * sdhci_arasan_runtime_resume - Resume method for the driver
> + * @dev:	Address of the device structure
> + * Returns 0 on success and error value on error
> + *
> + * Resume operation after suspend
> + */
> +static int sdhci_arasan_runtime_resume(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct sdhci_host *host = platform_get_drvdata(pdev);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
> +	int ret;
> +

Ditto, for cqhci_resume.

> +	ret = clk_enable(sdhci_arasan->clk_ahb);
> +	if (ret) {
> +		dev_err(dev, "Cannot enable AHB clock.\n");
> +		return ret;
> +	}
> +
> +	ret = clk_enable(pltfm_host->clk);
> +	if (ret) {
> +		dev_err(dev, "Cannot enable SD clock.\n");
> +		return ret;
> +	}
> +
> +	ret = sdhci_runtime_resume_host(host);
> +	if (ret)
> +		goto out;
> +
> +	return 0;
> +out:
> +	clk_disable(pltfm_host->clk);
> +	clk_disable(sdhci_arasan->clk_ahb);
> +
> +	return ret;
> +}
> +#endif /* ! CONFIG_PM */
> +
>   #ifdef CONFIG_PM_SLEEP
>   /**
>    * sdhci_arasan_suspend - Suspend method for the driver
> @@ -443,8 +513,11 @@ static int sdhci_arasan_resume(struct device *dev)
>   }
>   #endif /* ! CONFIG_PM_SLEEP */
>   
> -static SIMPLE_DEV_PM_OPS(sdhci_arasan_dev_pm_ops, sdhci_arasan_suspend,
> -			 sdhci_arasan_resume);
> +static const struct dev_pm_ops sdhci_arasan_dev_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(sdhci_arasan_suspend, sdhci_arasan_resume)
> +	SET_RUNTIME_PM_OPS(sdhci_arasan_runtime_suspend,
> +			   sdhci_arasan_runtime_resume, NULL)
> +};
>   
>   static const struct of_device_id sdhci_arasan_of_match[] = {
>   	/* SoC-specific compatible strings w/ soc_ctl_map */
> @@ -806,6 +879,12 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>   	if (ret)
>   		goto err_add_host;
>   
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +	pm_runtime_set_autosuspend_delay(&pdev->dev, 2000);
> +	pm_runtime_mark_last_busy(&pdev->dev);
> +	pm_runtime_use_autosuspend(&pdev->dev);
> +
>   	return 0;
>   
>   err_add_host:
> 
