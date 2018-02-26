Return-Path: <linus.walleij@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1519639951; cv=none;
        d=google.com; s=arc-20160816;
        b=fLKjwhoyNp2UBLM5/FXmMn2LqxR4ya1/N2Icy8vXQ8zYv3tEm6Kqj9dr3K/KIWHqqc
         1zKhFQHxdA2g8KXyaLysqKrW97vlRIs+u8YmTEriVLcD6pTTKwILXFvUTjRG8Opoc1Az
         RZUFPhb2CEKFsH9GoHwXGTClIZOQgvs/i+AuvciXTA8FXMwW8ukyYvSF393u320EyVHB
         E9S4lVPtlOUwfnYFia9ZzP8Ot9hTI2imVPeUfmmuJyh7FwMVuCbSZZGnjACH93akqtn5
         zNkP3f9LQLYKSw2CiRhLLhgDeQLF5mq6iUvphDGOH/2Nfg/ygFta5SSZw7NvKtG+bNVm
         AGPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=0EHJLnxK78W0m5aMxDFZGyffJtyp2r4A8mpGt6CxE14=;
        b=NmKYJc4d/eItvC0NIK9QbQqxRW6C+49Qb4xrIj9oaU5UNm48v8FupbfaACoEO8XYse
         E7priCFgAuNKr226jiwi0oUjala9X02dLocXmvo6OSm09bW9/zwTrduG/0HPzW08cgkY
         jgCmFie9VAwViz301L1YXXd1rcL2ew9dRDqIE2yeG/ARWQRe/QdieaQr/g9YfuwpUVWQ
         VCDjQabxlqM////uW6aq3tiG7HRlesSqt5qdDwWgNFg10ruSUneZGWUpvYGmTjrYLSYP
         y+FIaBwV2ZDgw0EHi7uRydoOTjvU4omK29hwiglkP2svcB8WoRUFWnItWzLgpSV1FO4/
         E35Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=YW8k7wpy;
       spf=pass (google.com: domain of linus.walleij@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus.walleij@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=YW8k7wpy;
       spf=pass (google.com: domain of linus.walleij@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus.walleij@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELuuMrU4x3PoxjkqArp74V8xnNmlT038V6iq9s9P7DrqWJ8CmsT04I/iRvsHuF4jYW9nXdFgjYupVwFW5Q16ujc=
MIME-Version: 1.0
In-Reply-To: <1519632964-64257-2-git-send-email-leo.wen@rock-chips.com>
References: <1519632964-64257-1-git-send-email-leo.wen@rock-chips.com> <1519632964-64257-2-git-send-email-leo.wen@rock-chips.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 26 Feb 2018 11:12:30 +0100
Message-ID: <CACRpkdZDWvqrpop9FaJUidJjR8jB=Db-WztePrqKSg5Yp5gvCA@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] [media] Add Rockchip RK1608 driver
To: Wen Nuan <leo.wen@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
	David Wu <david.wu@rock-chips.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	jacob2.chen@rock-chips.com,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org,
	Eddie Cai <eddie.cai@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593450825351606714?=
X-GMAIL-MSGID: =?utf-8?q?1593457981646871615?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 26, 2018 at 9:16 AM, Wen Nuan <leo.wen@rock-chips.com> wrote:

> +#include <linux/of_gpio.h>

Please do not use this old API in new drivers.

Just use GPIO descriptors and only
#include <linux/gpio/consumer.h>

There is documentation in
Documentation/gpio/consumer.txt

> +static int rk1608_pin_power(struct rk1608_state *pdata, int on)
> +{
> +       unsigned int grf_val = 0;
> +
> +       if (on) {
> +               clk_prepare_enable(pdata->pd_cif);
> +               clk_prepare_enable(pdata->aclk_cif);
> +               clk_prepare_enable(pdata->hclk_cif);
> +               clk_prepare_enable(pdata->cif_clk_in);
> +               clk_prepare_enable(pdata->cif_clk_out);
> +               clk_prepare_enable(pdata->clk_mipi_24m);
> +               clk_prepare_enable(pdata->hclk_mipiphy);
> +               clk_set_rate(pdata->cif_clk_out, RK1608_MCLK_RATE);
> +
> +               clk_prepare_enable(pdata->mipi_clk);
> +               clk_set_rate(pdata->mipi_clk, RK1608_MCLK_RATE);
> +
> +               gpio_direction_output(pdata->rst1, 0);

Instead of this old GPIO API, put GPIO descriptors
struct gpio_desc *rst1; etc in your state container and
use gpiod_direction_output() etc.

> +               pdata->grf_gpio2b_iomux = ioremap((resource_size_t)
> +                                                 (GRF_BASE_ADDR +
> +                                                  GRF_GPIO2B_IOMUX), 4);
> +               grf_val = __raw_readl(pdata->grf_gpio2b_iomux);
> +               __raw_writel(((grf_val) | (1 << 6) | (1 << (6 + 16))),
> +                            pdata->grf_gpio2b_iomux);
> +
> +               pdata->grf_io_vsel = ioremap((resource_size_t)
> +                                             (GRF_BASE_ADDR + GRF_IO_VSEL), 4);
> +               grf_val = __raw_readl(pdata->grf_io_vsel);
> +               __raw_writel(((grf_val) | (1 << 1) | (1 << (1 + 16))),
> +                            pdata->grf_io_vsel);

You are doing pin control on the side of the pin control subsystem
it looks like?

I think David Wu and Heiko Stubner needs to have a look at what you
are doing here to suggest other solutions.

Apart from that, why use __raw_writel instead of just writel()?

> +static int rk1608_parse_dt_property(struct rk1608_state *pdata)
> +{
(...)
> +       enum of_gpio_flags flags;

Don't use this.

> +       ret = of_get_named_gpio_flags(node, "rockchip,reset1", 0, &flags);

You should not use custom properties for GPIO names,
they need names like this:

gpios-reset1 = <&gpioN 1 GPIO_ACTIVE_HIGH>

See
Documentation/devicetree/bindings/gpio/gpio.txt

> +       if (ret <= 0)
> +               dev_err(dev, "can not find reset1 error %d\n", ret);
> +       pdata->rst1 = ret;
> +
> +       ret = devm_gpio_request(dev, pdata->rst1, "rockchip-reset1");
> +       if (ret) {
> +               dev_err(dev, "gpio pdata->rst1 %d request error %d\n",
> +                       pdata->rst1, ret);
> +               return ret;
> +       }
> +       gpio_set_value(pdata->rst1, 0);
> +       ret = gpio_direction_output(pdata->rst1, 0);
> +       if (ret) {
> +               dev_err(dev, "gpio %d direction output error %d\n",
> +                       pdata->rst1, ret);
> +               return ret;
> +       }

As you see this become tedious and repetitive.

Instead use:

pdata->rst1 = gpiod_get(dev, "reset1", GPIOD_OUT_LOW);
if (IS_ERR(pdata->rst1))
    return PTR_ERR(pdata->rst1);

After this point you know that you have a valid handle on the
GPIO line and it is initialized low.

> +struct rk1608_state {
(...)
> +       void __iomem            *grf_gpio2b_iomux;

I suspect this should be done with pin control.

> +       void __iomem            *grf_io_vsel;

And this should maybe use a regulator.

> +       int powerdown1;
> +       int rst1;
> +       int powerdown0;
> +       int rst0;
> +       int power_count;
> +       int reset_gpio;
> +       int reset_active;
> +       int irq_gpio;
> +       int irq;
> +       int sleepst_gpio;
> +       int sleepst_irq;
> +       int wakeup_gpio;
> +       int wakeup_active;
> +       int powerdown_gpio;
> +       int powerdown_active;

Anything that us a GPIO should be a struct gpio_desc *.

You do not need to keep track of if they are active I guess,
but I haven't looked close. They should probably be bool
rather than int if necessary.

But notice that we have
gpiod_get_optional() and if you use that you can
just check if the gpio_desc * is NULL like

if (!pdata->wakeup_gpio)
     gpiod_set_value() ...

Yours,
Linus Walleij
