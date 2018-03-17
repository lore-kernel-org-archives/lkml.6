Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753678AbeCQSWz (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 14:22:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:38302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752819AbeCQSWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 14:22:53 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BDE420855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 17 Mar 2018 18:22:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: linus.walleij@linaro.org, andy.shevchenko@gmail.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v3 1/8] iio: stx104: Implement get_multiple callback
Message-ID: <20180317182248.28fc9cbb@archlinux>
In-Reply-To: <14a09900bf4642495ebe4072b9eb02769dbc4c5e.1521301345.git.vilhelm.gray@gmail.com>
References: <cover.1521301345.git.vilhelm.gray@gmail.com>
        <14a09900bf4642495ebe4072b9eb02769dbc4c5e.1521301345.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Mar 2018 11:49:56 -0400
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> The Apex Embedded Systems STX104 series of devices provides 4 TTL
> compatible lines of inputs accessed via a single 4-bit port. Since four
> input lines are acquired on a single port input read, the STX104 GPIO
> driver may improve multiple input reads by utilizing a get_multiple
> callback. This patch implements the stx104_gpio_get_multiple function
> which serves as the respective get_multiple callback.
> 
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
This one is simple so applied to the togreg branch of iio.git and pushed
out as testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/stx104.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/iio/adc/stx104.c b/drivers/iio/adc/stx104.c
> index 17b021f33180..0662ca199eb0 100644
> --- a/drivers/iio/adc/stx104.c
> +++ b/drivers/iio/adc/stx104.c
> @@ -233,6 +233,16 @@ static int stx104_gpio_get(struct gpio_chip *chip, unsigned int offset)
>  	return !!(inb(stx104gpio->base) & BIT(offset));
>  }
>  
> +static int stx104_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
> +	unsigned long *bits)
> +{
> +	struct stx104_gpio *const stx104gpio = gpiochip_get_data(chip);
> +
> +	*bits = inb(stx104gpio->base);
> +
> +	return 0;
> +}
> +
>  static void stx104_gpio_set(struct gpio_chip *chip, unsigned int offset,
>  	int value)
>  {
> @@ -342,6 +352,7 @@ static int stx104_probe(struct device *dev, unsigned int id)
>  	stx104gpio->chip.direction_input = stx104_gpio_direction_input;
>  	stx104gpio->chip.direction_output = stx104_gpio_direction_output;
>  	stx104gpio->chip.get = stx104_gpio_get;
> +	stx104gpio->chip.get_multiple = stx104_gpio_get_multiple;
>  	stx104gpio->chip.set = stx104_gpio_set;
>  	stx104gpio->chip.set_multiple = stx104_gpio_set_multiple;
>  	stx104gpio->base = base[id] + 3;
