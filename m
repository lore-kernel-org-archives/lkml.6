Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752491AbeEOIXU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 04:23:20 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60156 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752431AbeEOIXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 04:23:17 -0400
Subject: Re: [PATCH v2 5/5] hisi: Consolidate the Kconfigs for the CLOCK_STUB
 and the MAILBOX
To: Leo Yan <leo.yan@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>,
        "Arnd Bergmann" <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
References: <1526352795-6991-1-git-send-email-leo.yan@linaro.org>
 <1526352795-6991-6-git-send-email-leo.yan@linaro.org>
From: Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5AFA98E7.9050609@hisilicon.com>
Date: Tue, 15 May 2018 09:23:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1526352795-6991-6-git-send-email-leo.yan@linaro.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.44]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo, Daniel,

On 2018/5/15 3:53, Leo Yan wrote:
> From: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> The current defconfig is inconsistent as it selects the mailbox and
> the clock for the hi6220 and the hi3660 without having their Kconfigs
> making sure the dependencies are correct. It ends up when selecting
> different versions for the kernel (for example when git bisecting)
> those options disappear and they don't get back, leading to unexpected
> behaviors. In our case, the cpufreq driver does no longer work because
> the clock fails to initialize due to the clock stub and the mailbox
> missing.
> 
> In order to have the dependencies correctly set when defaulting, let's
> do the same as commit 3a49afb84ca074e ("clk: enable hi655x common clk
> automatically") where we select automatically the driver when the
> parent driver is selected. With sensible defaults in place, we can leave
> other choices for EXPERT.
> 
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Acked-by: Jassi Brar <jaswinder.singh@linaro.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  arch/arm64/configs/defconfig  |  1 -
>  drivers/clk/hisilicon/Kconfig | 13 ++++++++-----
>  drivers/mailbox/Kconfig       | 12 ++++++++----
>  3 files changed, 16 insertions(+), 10 deletions(-)

Could you separate this patch into clk, mailbox and defconfig 3 parts?
Thanks!

Best Regards,
Wei

> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index ecf6137..1d9d8b9 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -549,7 +549,6 @@ CONFIG_HWSPINLOCK_QCOM=y
>  CONFIG_ARM_MHU=y
>  CONFIG_PLATFORM_MHU=y
>  CONFIG_BCM2835_MBOX=y
> -CONFIG_HI6220_MBOX=y
>  CONFIG_QCOM_APCS_IPC=y
>  CONFIG_ROCKCHIP_IOMMU=y
>  CONFIG_TEGRA_IOMMU_SMMU=y
> diff --git a/drivers/clk/hisilicon/Kconfig b/drivers/clk/hisilicon/Kconfig
> index 1bd4355..becdb1d 100644
> --- a/drivers/clk/hisilicon/Kconfig
> +++ b/drivers/clk/hisilicon/Kconfig
> @@ -44,14 +44,17 @@ config RESET_HISI
>  	  Build reset controller driver for HiSilicon device chipsets.
>  
>  config STUB_CLK_HI6220
> -	bool "Hi6220 Stub Clock Driver"
> -	depends on COMMON_CLK_HI6220 && MAILBOX
> -	default ARCH_HISI
> +	bool "Hi6220 Stub Clock Driver" if EXPERT
> +	depends on (COMMON_CLK_HI6220 || COMPILE_TEST)
> +	depends on MAILBOX
> +	default COMMON_CLK_HI6220
>  	help
>  	  Build the Hisilicon Hi6220 stub clock driver.
>  
>  config STUB_CLK_HI3660
> -	bool "Hi3660 Stub Clock Driver"
> -	depends on COMMON_CLK_HI3660 && MAILBOX
> +	bool "Hi3660 Stub Clock Driver" if EXPERT
> +	depends on (COMMON_CLK_HI3660 || COMPILE_TEST)
> +	depends on MAILBOX
> +	default COMMON_CLK_HI3660
>  	help
>  	  Build the Hisilicon Hi3660 stub clock driver.
> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> index a2bb274..567cd02 100644
> --- a/drivers/mailbox/Kconfig
> +++ b/drivers/mailbox/Kconfig
> @@ -109,16 +109,20 @@ config TI_MESSAGE_MANAGER
>  	  platform has support for the hardware block.
>  
>  config HI3660_MBOX
> -	tristate "Hi3660 Mailbox"
> -	depends on ARCH_HISI && OF
> +	tristate "Hi3660 Mailbox" if EXPERT
> +	depends on (ARCH_HISI || COMPILE_TEST)
> +	depends on OF
> +	default ARCH_HISI
>  	help
>  	  An implementation of the hi3660 mailbox. It is used to send message
>  	  between application processors and other processors/MCU/DSP. Select
>  	  Y here if you want to use Hi3660 mailbox controller.
>  
>  config HI6220_MBOX
> -	tristate "Hi6220 Mailbox"
> -	depends on ARCH_HISI
> +	tristate "Hi6220 Mailbox" if EXPERT
> +	depends on (ARCH_HISI || COMPILE_TEST)
> +	depends on OF
> +	default ARCH_HISI
>  	help
>  	  An implementation of the hi6220 mailbox. It is used to send message
>  	  between application processors and MCU. Say Y here if you want to
> 
