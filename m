Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932721AbeCEXVb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 18:21:31 -0500
Received: from anholt.net ([50.246.234.109]:49692 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752906AbeCEXV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 18:21:29 -0500
From: Eric Anholt <eric@anholt.net>
To: Matheus Castello <matheus@castello.eng.br>, stefan.wahren@i2se.com,
        linus.walleij@linaro.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: Re: [PATCH v2 2/3] pinctrl: bcm2835: Add support for generic pinctrl binding
In-Reply-To: <1520216960-19880-3-git-send-email-matheus@castello.eng.br>
References: <431699005.307231.1520086916739@email.1und1.de> <1520216960-19880-1-git-send-email-matheus@castello.eng.br> <1520216960-19880-3-git-send-email-matheus@castello.eng.br>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date: Mon, 05 Mar 2018 15:21:26 -0800
Message-ID: <87d10irtvt.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Matheus Castello <matheus@castello.eng.br> writes:

> To keep driver up to date we add generic pinctrl binding support, which covers
> the features used in this driver and has additional node properties that this
> SoC has compatibility, so enabling future implementations of these properties
> without the need to create new node properties in the device trees.
>
> The logic of this change maintain the old brcm legacy binding support in order
> to keep the ABI stable.
>
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>
> A brief explanation of what I did:
>
> Add pinconf-generic header for use the defines and pinctrl-generic API.
>
> Add dt-bindings pinctrl bcm2835 header to use functions selections and
> pulls definitions, which functions definitions where duplicated in the
> enum bcm2835_fsel, I removed the duplicate defines from enum.
>
> In the bcm2835_pctl_dt_node_to_map_pull I used the generic macro for
> pack the legacy param and arguments, since it will be unpacked along with
> generic properties that is packed with this same macro.
>
> In bcm2835_pctl_dt_node_to_map I thougt it was better, and simpler, to use
> pinctrl-generic parse code instead of parsing it inside the driver, so code
> first check for generic binding parse, if something is parsed then it is
> assumed that are using the new generic style, and when nothing is found then
> parse continues to search for legacy properties.
>
> In the bcm2835_pinconf_set was changed the unpack legacy by the generic, and
> was added a switch for the parameter tests, since pinctrl generic uses 3
> properties to define the states of the pull instead of one with arguments, that
> was the reason too that bcm2835_pull_config_set function was added, for reuse
> the code that set state of pull.
>
>  drivers/pinctrl/bcm/pinctrl-bcm2835.c | 83 +++++++++++++++++++++++------------
>  1 file changed, 54 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
> index 785c366..755ea90 100644
> --- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
> +++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
> @@ -36,11 +36,13 @@
>  #include <linux/pinctrl/pinconf.h>
>  #include <linux/pinctrl/pinctrl.h>
>  #include <linux/pinctrl/pinmux.h>
> +#include <linux/pinctrl/pinconf-generic.h>
>  #include <linux/platform_device.h>
>  #include <linux/seq_file.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <linux/types.h>
> +#include <dt-bindings/pinctrl/bcm2835.h>
>
>  #define MODULE_NAME "pinctrl-bcm2835"
>  #define BCM2835_NUM_GPIOS 54
> @@ -213,14 +215,6 @@ static const char * const bcm2835_gpio_groups[] = {
>  };
>
>  enum bcm2835_fsel {
> -	BCM2835_FSEL_GPIO_IN = 0,
> -	BCM2835_FSEL_GPIO_OUT = 1,
> -	BCM2835_FSEL_ALT0 = 4,
> -	BCM2835_FSEL_ALT1 = 5,
> -	BCM2835_FSEL_ALT2 = 6,
> -	BCM2835_FSEL_ALT3 = 7,
> -	BCM2835_FSEL_ALT4 = 3,
> -	BCM2835_FSEL_ALT5 = 2,
>  	BCM2835_FSEL_COUNT = 8,
>  	BCM2835_FSEL_MASK = 0x7,
>  };
> @@ -714,7 +708,7 @@ static int bcm2835_pctl_dt_node_to_map_pull(struct bcm2835_pinctrl *pc,
>  	configs = kzalloc(sizeof(*configs), GFP_KERNEL);
>  	if (!configs)
>  		return -ENOMEM;
> -	configs[0] = BCM2835_PINCONF_PACK(BCM2835_PINCONF_PARAM_PULL, pull);
> +	configs[0] = PIN_CONF_PACKED(BCM2835_PINCONF_PARAM_PULL, pull);
>
>  	map->type = PIN_MAP_TYPE_CONFIGS_PIN;
>  	map->data.configs.group_or_pin = bcm2835_gpio_pins[pin].name;
> @@ -736,6 +730,12 @@ static int bcm2835_pctl_dt_node_to_map(struct pinctrl_dev *pctldev,
>  	int i, err;
>  	u32 pin, func, pull;
>
> +	/* Check for generic binding in this node */
> +	err = pinconf_generic_dt_node_to_map_all(pctldev, np, map, num_maps);
> +	if (err || *num_maps)
> +		return err;
> +
> +	/* Generic binding did not find anything continue with legacy parse */
>  	pins = of_find_property(np, "brcm,pins", NULL);
>  	if (!pins) {
>  		dev_err(pc->dev, "%pOF: missing brcm,pins property\n", np);
> @@ -917,37 +917,62 @@ static int bcm2835_pinconf_get(struct pinctrl_dev *pctldev,
>  	return -ENOTSUPP;
>  }
>
> +static void bcm2835_pull_config_set(struct bcm2835_pinctrl *pc,
> +		unsigned pin, unsigned arg)
> +{
> +	u32 off, bit;
> +
> +	off = GPIO_REG_OFFSET(pin);
> +	bit = GPIO_REG_SHIFT(pin);
> +
> +	bcm2835_gpio_wr(pc, GPPUD, arg & 3);
> +	/*
> +	* BCM2835 datasheet say to wait 150 cycles, but not of what.
> +	* But the VideoCore firmware delay for this operation
> +	* based nearly on the same amount of VPU cycles and this clock
> +	* runs at 250 MHz.
> +	*/
> +	udelay(1);
> +	bcm2835_gpio_wr(pc, GPPUDCLK0 + (off * 4), BIT(bit));
> +	udelay(1);
> +	bcm2835_gpio_wr(pc, GPPUDCLK0 + (off * 4), 0);
> +}
> +
>  static int bcm2835_pinconf_set(struct pinctrl_dev *pctldev,
>  			unsigned pin, unsigned long *configs,
>  			unsigned num_configs)
>  {
>  	struct bcm2835_pinctrl *pc = pinctrl_dev_get_drvdata(pctldev);
> -	enum bcm2835_pinconf_param param;
> -	u16 arg;
> -	u32 off, bit;
> +	u16 param, arg;
>  	int i;
>
>  	for (i = 0; i < num_configs; i++) {
> -		param = BCM2835_PINCONF_UNPACK_PARAM(configs[i]);
> -		arg = BCM2835_PINCONF_UNPACK_ARG(configs[i]);
> +		param = configs[i] & 0xffUL;
> +		arg = configs[i] >> 8;

If you're removing the usage of BCM2835_PINCONF_PACK() and UNPACK, let's
delete those macros, too.  Also, it looks like there's
"pinconf_to_config_param()" for unpacking, instead of rolling your own.

Other than that, it looks good to me.  I'll let Linus comment on whether
this is handling the generic properties correctly.

>
> -		if (param != BCM2835_PINCONF_PARAM_PULL)
> -			return -EINVAL;
> +		switch (param) {
> +		/* Set legacy brcm,pull */
> +		case BCM2835_PINCONF_PARAM_PULL:
> +			bcm2835_pull_config_set(pc, pin, arg);
> +			break;
>
> -		off = GPIO_REG_OFFSET(pin);
> -		bit = GPIO_REG_SHIFT(pin);
> +		/* Set pull generic bindings */
> +		case PIN_CONFIG_BIAS_DISABLE:
> +			bcm2835_pull_config_set(pc, pin, BCM2835_PUD_OFF);
> +			break;
>
> -		bcm2835_gpio_wr(pc, GPPUD, arg & 3);
> -		/*
> -		 * BCM2835 datasheet say to wait 150 cycles, but not of what.
> -		 * But the VideoCore firmware delay for this operation
> -		 * based nearly on the same amount of VPU cycles and this clock
> -		 * runs at 250 MHz.
> -		 */
> -		udelay(1);
> -		bcm2835_gpio_wr(pc, GPPUDCLK0 + (off * 4), BIT(bit));
> -		udelay(1);
> -		bcm2835_gpio_wr(pc, GPPUDCLK0 + (off * 4), 0);
> +		case PIN_CONFIG_BIAS_PULL_DOWN:
> +			bcm2835_pull_config_set(pc, pin, BCM2835_PUD_DOWN);
> +			break;
> +
> +		case PIN_CONFIG_BIAS_PULL_UP:
> +			bcm2835_pull_config_set(pc, pin, BCM2835_PUD_UP);
> +			break;
> +
> +		default:
> +			return -EINVAL;
> +
> +		} /* switch param type */
>  	} /* for each config */
>
>  	return 0;
> --
> 2.7.4

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlqd0PYACgkQtdYpNtH8
nuiIXRAAh9HD/FktQJIleO+fLVN9TefY2Faxc8BXTvO3gzaLDY0t22HTdoRyDTwY
nuaBFwYzIctfi9z4NRvEieTDeLR6qcGOw7nSW3Ikwfdgsqm1Pdb76GTTu/RdrDjD
cQEFT+RyNSIQUZ2sk3ORZKRrh2L/TQ44J5aXcgts8UntcnyPelM8CI8FKjULHDS5
rpAaYWJXfaEplupLrDJdolu38j1flpwZcpOnT6tgtl45tYAfxNUMuRYvz1OaTXcB
ha2+wryLmbw0nw9NkSpx2MRm1Bz1lYsGGQ+5ZtJF96egBjBiGBuLatHzUJuu8wq5
lPnM4yrMZhBkWsbfY2ObXSvqzQSnJrxnp2nIXEqiHb/PwGqP0Zw/M4MSZpbCglD5
8MEdz4EJJ7gsZKlrem9zvRX5PGPDwcdoQ+K92tSXyq5czrKzubjbNnhC5UOWymOr
T72GegPouBPFEFN9NgM3xXyY7AVsIGqKGafCFSXld3kaqa6w//R+qJfOMNiKplNd
Hql/9pp0dro15VvVdHwmrmOudVXdE7sb1dvsJPhleh0TKzHAI/y2e4gSV36HXx3n
KUtad7XRwKnynroAj2u2n7/fF4rsMUeVK0nDCIXooH5jVCT4ZRCWU/aQJniFl4fb
98GScKzipTlyPFjtNtf0z4buAh6V15O5xfCan2R6a0YxKSKCISM=
=vvY+
-----END PGP SIGNATURE-----
--=-=-=--
