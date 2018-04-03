Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932139AbeDCLbs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 07:31:48 -0400
Received: from lucky1.263xmail.com ([211.157.147.130]:45070 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932066AbeDCLbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 07:31:44 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: shawn.lin@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-UNIQUE-TAG: <8cb01b0dda2855c68856409c8b947b39>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Cc: shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: dw_mmc-k3: Fix DDR52 mode by setting required clock
 divisor
To: oscardagrach <ryan@edited.us>
References: <20180329182423.21201-1-ryan@edited.us>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <e3ec3a77-f2f3-2164-4dbb-80e1ba3ebc63@rock-chips.com>
Date: Tue, 3 Apr 2018 19:31:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180329182423.21201-1-ryan@edited.us>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/3/30 2:24, oscardagrach wrote:

Need at least one line commit body.

> Signed-off-by: oscardagrach <ryan@edited.us>
> ---
>   drivers/mmc/host/dw_mmc-k3.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
> index 89cdb3d533bb..efc546cb4db8 100644
> --- a/drivers/mmc/host/dw_mmc-k3.c
> +++ b/drivers/mmc/host/dw_mmc-k3.c
> @@ -194,8 +194,14 @@ static void dw_mci_hi6220_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>   	int ret;
>   	unsigned int clock;
>   
> -	clock = (ios->clock <= 25000000) ? 25000000 : ios->clock;
> -
> +	/* CLKDIV must be 1 for DDR52/8-bit mode */
> +	if (ios->bus_width == MMC_BUS_WIDTH_8 &&
> +		ios->timing == MMC_TIMING_MMC_DDR52) {
> +		mci_writel(host, CLKDIV, 0x1);
> +		clock = ios->clock;
> +	} else {
> +		clock = (ios->clock <= 25000000) ? 25000000 : ios->clock;
> +	}

I undertand DDR52/8-bit need CLKDIV fixed 1, but shouldn't the following
change is more sensible?

if (ios->bus_width == MMC_BUS_WIDTH_8 && ios->timing ==
MMC_TIMING_MMC_DDR52)
	clock = ios->clock * 2;
else
	clock = (ios->clock <= 25000000) ? 25000000 : ios->clock;


The reason is ios->clock is 52MHz and you could claim 104MHz from the
clock provider and let dw_mmc core take care of the divder to be 1.
Otherwise, you just force it to be DDR52/8-bit with a clk rate of 26MHz.

>   	ret = clk_set_rate(host->biu_clk, clock);
>   	if (ret)
>   		dev_warn(host->dev, "failed to set rate %uHz\n", clock);
> 
