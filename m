Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935294AbeE2O1j (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:27:39 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:14140 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934861AbeE2O1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:27:31 -0400
X-IronPort-AV: E=Sophos;i="5.49,456,1520924400";
   d="scan'208";a="15402368"
Subject: Re: [PATCH v4 5/6] spi: at91-usart: add driver for at91-usart as spi
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, Lee Jones <lee.jones@linaro.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
References: <20180525171941.26766-1-radu.pirea@microchip.com>
 <20180525171941.26766-6-radu.pirea@microchip.com>
 <CAHp75Vc0e=+2YptoFAUuPSpAyxaCUJJqjQPPY5VZHV=MEMOqHQ@mail.gmail.com>
From: Radu Pirea <radu.pirea@microchip.com>
Message-ID: <110bb353-b131-348c-8e26-9863b074142d@microchip.com>
Date: Tue, 29 May 2018 17:28:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vc0e=+2YptoFAUuPSpAyxaCUJJqjQPPY5VZHV=MEMOqHQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/28/2018 11:21 AM, Andy Shevchenko wrote:
> On Fri, May 25, 2018 at 8:19 PM, Radu Pirea <radu.pirea@microchip.com> wrote:
>> This is the driver for at91-usart in spi mode. The USART IP can be configured
>> to work in many modes and one of them is SPI.
>>
>> The driver was tested on sama5d3-xplained and sama5d4-xplained boards with
>> enc28j60 ethernet controller as slave.
> 
>> +#include <linux/of_gpio.h>
> 
> What is the use of it?

I need of_gpio.h for of_gpio_named_count, of_get_named_gpio and 
devm_gpio_request_one(found in gpio.h)

> 
>> +#define US_INIT                        (US_MR_SPI_MASTER | US_MR_CHRL | US_MR_CLKO | \
>> +                               US_MR_WRDBT)
> 
> Don't split lines like this, it's hard to read.
> 
> #define FOO \
>   (BAR1 | BAR2)

I'll fix it.

> 
> I think I already told this to someone recently, maybe to you.
> 
>> +/* Register access macros */
>> +#define spi_readl(port, reg) \
>> +       readl_relaxed((port)->regs + US_##reg)
>> +#define spi_writel(port, reg, value) \
>> +       writel_relaxed((value), (port)->regs + US_##reg)
>> +
>> +#define spi_readb(port, reg) \
>> +       readb_relaxed((port)->regs + US_##reg)
>> +#define spi_writeb(port, reg, value) \
>> +       writeb_relaxed((value), (port)->regs + US_##reg)
> 
> Names are too generic. You better to use the same prefix as for the
> rest, i.e. at91_spi_

Good ideea. I will change the names.

> 
>> +       /*used in interrupt to protect data reading*/
> 
> Comment style.
> 
> You need to read some existing code, perhaps, to see how it's done.

Ok. I will add the comment.

> 
>> +static inline void at91_usart_spi_tx(struct at91_usart_spi *aus)
>> +{
>> +       unsigned int len = aus->current_transfer->len;
>> +       unsigned int remaining = aus->current_tx_remaining_bytes;
>> +       const u8  *tx_buf = aus->current_transfer->tx_buf;
>> +
> 
>> +       if (remaining)
>> +               if (at91_usart_spi_tx_ready(aus)) {
> 
> if (x) {
>   if (y) {
> ...
>   }
> }
> 
> is equivalent to if (x && y) {}.
> 
> Though, considering your intention here, I would rather go with better
> pattern, i.e.
> 
> if (!remaining)
>   return;

Thank for suggestion. I will change.

> 
>> +                       spi_writeb(aus, THR, tx_buf[len - remaining]);
>> +                       aus->current_tx_remaining_bytes--;
>> +               }
>> +}
>> +
>> +static inline void at91_usart_spi_rx(struct at91_usart_spi *aus)
>> +{
> 
>> +       if (remaining) {
>> +               rx_buf[len - remaining] = spi_readb(aus, RHR);
>> +               aus->current_rx_remaining_bytes--;
>> +       }
> 
> Ditto.
> 
>> +}
> 
> 
>> +static int at91_usart_gpio_setup(struct platform_device *pdev)
>> +{
> 
>> +       struct device_node      *np = pdev->dev.parent->of_node;
> 
> Your driver is not OF specific as far as I can see. Drop all these
> device_node stuff and change API calls respectively.

Ok. What do you suggest to use instead of OF API to get the count of 
cs-gpios and to read their values one by one?

> 
>> +       int                     i;
> 
>> +       int                     ret = 0;
>> +       int                     nb = 0;
> 
> What happened to indentation?
> 
> Redundnant assignment for both.
> 
>> +       if (!np)
>> +               return -EINVAL;
>> +
>> +       nb = of_gpio_named_count(np, "cs-gpios");
>> +       for (i = 0; i < nb; i++) {
>> +               int cs_gpio = of_get_named_gpio(np, "cs-gpios", i);
>> +
>> +               if (cs_gpio < 0)
>> +                       return cs_gpio;
>> +
>> +               if (gpio_is_valid(cs_gpio)) {
>> +                       ret = devm_gpio_request_one(&pdev->dev, cs_gpio,
>> +                                                   GPIOF_DIR_OUT,
>> +                                                   dev_name(&pdev->dev));
>> +                       if (ret)
>> +                               return ret;
>> +               }
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int at91_usart_spi_probe(struct platform_device *pdev)
>> +{
> 
>> +       regs = platform_get_resource(to_platform_device(pdev->dev.parent),
>> +                                    IORESOURCE_MEM, 0);
>> +       if (!regs)
>> +               return -EINVAL;
> 
> This looks weird. Supply resource to _this_ device in your MFD code.

I know weird, but is the safest way to pass the resource and the of_node.

> 
>> +       dev_info(&pdev->dev,
>> +                "Atmel USART SPI Controller version 0x%x at 0x%08lx (irq %d)\n",
>> +                spi_readl(aus, VERSION),
>> +                (unsigned long)regs->start, irq);
> 
> I think I already told you, don't use explicit casting when print.
> If it wasn't you, do you homework then. But above is no go. >
>> +       return 0;
> 
>> +static struct platform_driver at91_usart_spi_driver = {
>> +       .driver = {
>> +               .name = "at91_usart_spi",
> 
>> +               .of_match_table = of_match_ptr(at91_usart_spi_dt_ids),
> 
> Drop of_match_ptr(). It's not needed.
> 
>> +       },
>> +       .probe = at91_usart_spi_probe,
> 
>> +       .remove = at91_usart_spi_remove, };
> 
> Already told ya, split lines correctly.
> 
