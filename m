Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753805AbeCFOb1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:31:27 -0500
Received: from bert.emutex.com ([91.103.1.109]:48169 "EHLO bert.emutex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753223AbeCFObZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:31:25 -0500
Subject: Re: [PATCH] pinctrl: intel: Implement intel_gpio_get_direction
 callback
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180306134213.16898-1-javier@emutex.com>
From: Javier Arteaga <javier@emutex.com>
Message-ID: <3585081b-70af-5c31-08c0-84e96b6055bc@emutex.com>
Date: Tue, 6 Mar 2018 14:31:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
 Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20180306134213.16898-1-javier@emutex.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
X-Spam-Report: Spam detection software, running on the system "statler.emutex.com",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  (Fix Andy's Cc: - apologies) On 06/03/2018 13:42, Javier Arteaga
    wrote: > Allows querying GPIO direction from the pad config register. > If
    the pad is not in GPIO mode, return an error. > > Signed-off-by: Javier Arteaga
    <javier@emutex.com> > --- > This is needed by the drivers for the UP Squared
    board, an APL-based > platform. (For now, these drivers are out-of-tree.)
    > > An earlier version of this patch was reviewed some time ago by Andy >
    Shevchenko outside of the mailing lists: > <https://github.com/emutex/ubilinux-kernel/commit/708a776f2ffd1b1c>
    > > drivers/pinctrl/intel/pinctrl-intel.c | 19 +++++++++++++++++++ > 1 file
    changed, 19 insertions(+) > > diff --git a/drivers/pinctrl/intel/pinctrl-intel.c
    b/drivers/pinctrl/intel/pinctrl-intel.c > index 96e73e30204e..1e24a6b8a64e
    100644 > --- a/drivers/pinctrl/intel/pinctrl-intel.c > +++ b/drivers/pinctrl/intel/pinctrl-intel.c
    > @@ -788,6 +788,24 @@ static void intel_gpio_set(struct gpio_chip *chip,
    unsigned offset, int value) > raw_spin_unlock_irqrestore(&pctrl->lock, flags);
    > } > > +static int intel_gpio_get_direction(struct gpio_chip *chip, unsigned
    int offset) > +{ > + struct intel_pinctrl *pctrl = gpiochip_get_data(chip);
    > + void __iomem *reg; > + u32 padcfg0; > + > + reg = intel_get_padcfg(pctrl,
    offset, PADCFG0); > + if (!reg) > + return -EINVAL; > + > + padcfg0 = readl(reg);
    > + > + if (padcfg0 & PADCFG0_PMODE_MASK) > + return -EINVAL; > + > + return
    !!(padcfg0 & PADCFG0_GPIOTXDIS); > +} > + > static int intel_gpio_direction_input(struct
    gpio_chip *chip, unsigned offset) > { > return pinctrl_gpio_direction_input(chip->base
    + offset); > @@ -804,6 +822,7 @@ static const struct gpio_chip intel_gpio_chip
    = { > .owner = THIS_MODULE, > .request = gpiochip_generic_request, > .free
    = gpiochip_generic_free, > + .get_direction = intel_gpio_get_direction, >
    .direction_input = intel_gpio_direction_input, > .direction_output = intel_gpio_direction_output,
    > .get = intel_gpio_get, > [...]
 Content analysis details:   (-1.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Fix Andy's Cc: - apologies)

On 06/03/2018 13:42, Javier Arteaga wrote:
> Allows querying GPIO direction from the pad config register.
> If the pad is not in GPIO mode, return an error.
> 
> Signed-off-by: Javier Arteaga <javier@emutex.com>
> ---
> This is needed by the drivers for the UP Squared board, an APL-based
> platform. (For now, these drivers are out-of-tree.)
> 
> An earlier version of this patch was reviewed some time ago by Andy
> Shevchenko outside of the mailing lists:
> <https://github.com/emutex/ubilinux-kernel/commit/708a776f2ffd1b1c>
> 
>  drivers/pinctrl/intel/pinctrl-intel.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
> index 96e73e30204e..1e24a6b8a64e 100644
> --- a/drivers/pinctrl/intel/pinctrl-intel.c
> +++ b/drivers/pinctrl/intel/pinctrl-intel.c
> @@ -788,6 +788,24 @@ static void intel_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
>  	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
>  }
>  
> +static int intel_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
> +{
> +	struct intel_pinctrl *pctrl = gpiochip_get_data(chip);
> +	void __iomem *reg;
> +	u32 padcfg0;
> +
> +	reg = intel_get_padcfg(pctrl, offset, PADCFG0);
> +	if (!reg)
> +		return -EINVAL;
> +
> +	padcfg0 = readl(reg);
> +
> +	if (padcfg0 & PADCFG0_PMODE_MASK)
> +		return -EINVAL;
> +
> +	return !!(padcfg0 & PADCFG0_GPIOTXDIS);
> +}
> +
>  static int intel_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
>  {
>  	return pinctrl_gpio_direction_input(chip->base + offset);
> @@ -804,6 +822,7 @@ static const struct gpio_chip intel_gpio_chip = {
>  	.owner = THIS_MODULE,
>  	.request = gpiochip_generic_request,
>  	.free = gpiochip_generic_free,
> +	.get_direction = intel_gpio_get_direction,
>  	.direction_input = intel_gpio_direction_input,
>  	.direction_output = intel_gpio_direction_output,
>  	.get = intel_gpio_get,
> 
