Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754252AbeE1JHr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:07:47 -0400
Received: from mga17.intel.com ([192.55.52.151]:63993 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754082AbeE1JHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:07:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,451,1520924400";
   d="scan'208";a="44483833"
Subject: Re: [PATCH v2] mmc: Allow non-sleeping GPIO cd
To: Evan Green <evgreen@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Douglas Anderson <dianders@chromium.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180525192523.204873-1-evgreen@chromium.org>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <3cbcda6a-4b57-0e7c-548c-ff8b38aaa635@intel.com>
Date: Mon, 28 May 2018 12:06:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180525192523.204873-1-evgreen@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/18 22:25, Evan Green wrote:
> This change uses the appropriate _cansleep or non-sleeping API for
> reading GPIO card detect state. This allows users with GPIOs that
> never sleep to avoid a warning when certain quirks are present.
> 
> The sdhci controller has an SDHCI_QUIRK_NO_CARD_NO_RESET, which
> indicates that a controller will not reset properly if no card is
> inserted. With this quirk enabled, mmc_get_cd_gpio is called in
> several places with a spinlock held and interrupts disabled.
> gpiod_get_raw_value_cansleep is not happy with this situation,
> and throws out a warning.
> 
> For boards that a) use controllers that have this quirk, and b) wire
> card detect up to a GPIO that doesn't sleep, this is a spurious warning.
> This change silences that warning, at the cost of pushing this problem
> down to users that have sleeping GPIOs and controllers with this quirk.
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
> Changes since v1:
> 	- Style fixups as suggested by Andy
> 
> This is my initial solution to the warning I was trying to face down
> in my previous RFC [1]. Upsides of this solution is it manages to
> avoid the warning in places where the warning doesn't apply, and is
> low-risk. Other approaches I considered:
> 
> 1. Changing sdhci_get_cd to reach through mmc and get the GPIO value
> directly (without sleeping) rather than calling mmc_gpio_get_cd,
> which uses the cansleep functions. I didn't love this because a) it
> seemed ugly to be reaching into mmc_host like that and b) I'd have to
> duplicate the logic in mmc_gpio_get_cd, which seemed brittle.
> 
> 2. Using mmc_gpio_set_cd_isr to record when the card detect pin
> changes, and then in sdhci_do_reset we wouldn't actually need to
> get CD state, just look at the cached value. This seemed risky to me
> since it would affect all sdhci controllers, and I don't know that
> everybody using gpio-cd can do interrupts on their pins.
> 
> 3. Adding mmc_gpio_get_cd_nosleep(). That one's still doable if
> preferred, but I'd have to give some thought to when sdhci wires
> up to which one.

Surely just when SDHCI_QUIRK_NO_CARD_NO_RESET is used

> 
> I'm up for other suggestions. This one most just seemed like the
> best first stab of minimally addressing the warning without rocking
> the boat otherwise.
> 
> [1] https://patchwork.kernel.org/patch/10374633/
> ---
>  drivers/mmc/core/slot-gpio.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
> index 31f7dbb15668..1ca8220690f2 100644
> --- a/drivers/mmc/core/slot-gpio.c
> +++ b/drivers/mmc/core/slot-gpio.c
> @@ -76,15 +76,22 @@ EXPORT_SYMBOL(mmc_gpio_get_ro);
>  int mmc_gpio_get_cd(struct mmc_host *host)
>  {
>  	struct mmc_gpio *ctx = host->slot.handler_priv;
> +	int cansleep;
>  
>  	if (!ctx || !ctx->cd_gpio)
>  		return -ENOSYS;
>  
> -	if (ctx->override_cd_active_level)
> -		return !gpiod_get_raw_value_cansleep(ctx->cd_gpio) ^
> -			!!(host->caps2 & MMC_CAP2_CD_ACTIVE_HIGH);
> +	cansleep = gpiod_cansleep(ctx->cd_gpio);
> +	if (ctx->override_cd_active_level) {
> +		int value = cansleep ?
> +				gpiod_get_raw_value_cansleep(ctx->cd_gpio) :
> +				gpiod_get_raw_value(ctx->cd_gpio);
> +		return !value ^ !!(host->caps2 & MMC_CAP2_CD_ACTIVE_HIGH);
> +	}
>  
> -	return gpiod_get_value_cansleep(ctx->cd_gpio);
> +	return cansleep ?
> +		gpiod_get_value_cansleep(ctx->cd_gpio) :
> +		gpiod_get_value(ctx->cd_gpio);
>  }
>  EXPORT_SYMBOL(mmc_gpio_get_cd);
>  
> 
