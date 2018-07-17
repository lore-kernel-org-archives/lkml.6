Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44182ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36F220C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D36F220C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbeGQH1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 03:27:11 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:59164 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbeGQH1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 03:27:10 -0400
Received: from [192.168.90.200] (10.18.20.235) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Tue, 17 Jul
 2018 14:55:20 +0800
Subject: Re: [PATCH 3/3] pinctrl: meson-g12a: add pinctrl driver support
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20180704224511.29350-1-yixun.lan@amlogic.com>
 <20180704224511.29350-4-yixun.lan@amlogic.com>
 <CAFBinCCvk_0-sZJLoa5DftYgRhpVfp8zOHZ+iOG2_DDuaeO=xA@mail.gmail.com>
CC:     <yixun.lan@amlogic.com>, <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>, <robh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        <khilman@baylibre.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <carlo@caione.org>,
        <linux-amlogic@lists.infradead.org>, <xingyu.chen@amlogic.com>,
        <jbrunet@baylibre.com>
From:   Yixun Lan <yixun.lan@amlogic.com>
Message-ID: <19a2b2b1-42a0-9262-4271-f6d6ddef00b2@amlogic.com>
Date:   Tue, 17 Jul 2018 14:55:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCCvk_0-sZJLoa5DftYgRhpVfp8zOHZ+iOG2_DDuaeO=xA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.20.235]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


HI Martin

On 07/14/18 23:30, Martin Blumenstingl wrote:
> Hi Yixun,
> 
> On Wed, Jul 4, 2018 at 4:50 PM Yixun Lan <yixun.lan@amlogic.com> wrote:
>>
>> Add the pinctrl driver for Meson-G12A SoC which share the similar IP as
>> the previous Meson-AXG SoC.
> my understanding is that:
> - AXG and G12A use the same mechanism (register layout) to configure
> the pin controller
> - however, the pin mapping differs between AXG and G12A (because G12A
> has more pins in the GPIOZ bank, G12A has a GPIOH bank which AXG
> doesn't have at all, G12A has less pins in the GPIOA and GPIOX
>  banks than AXG and finally AXG has a GPIOY bank which G12A doesn't have)
> 
> maybe you can update the commit description to make it clear that
> - "similar IP" means that the pinmux ops (register layout) are the same
> - a new driver is needed due to the differences in the pins
> 
exactly! thanks for this input

> I am assuming that the pin function names are taken from the
> datasheets (as I don't have access to the datasheets of this SoC)
> these names are slightly inconsistent, but if it's what's written in
> the datasheet then I'm fine with it.
> an example (there are too many places to name them all):
> "uart_rx_ao_a" (this is for the RX line of the uart_ao_a controller)
yes, the name is taken from the datasheet, so this chaos is actually
coming from the datasheet..

as I'm writing in another thread, we are using follow syntax to do the
naming.
${FUNCTION}_${DOMAIN}_${PORT}_${PINFUNC}_${BANK}${PINNUM}

take " uart_ao_a_tx_c" as an example
FUNCTION = uart
DOMAIN= ao (may omit if it's belong to EE domain)
PORT=a (may omit if only one port)
PINFUNC = tx
BANK = C (may omit if only one BANK)
PINNUM = ? (only if two more same function in one BANK)


I'm trying to fix this in code level to make it slightly more
consistent. and yes, we raised this issue to internal ASIC team, hope
they can improve this in next generation SoC..


> vs "pwm_ao_a_hiz" (this is for the "HIZ" line of the the pwm_ao_a
> controller) -> to have a consistent naming it would either have to be
> "uart_ao_a_rx" or "pwm_hiz_ao_a"
indeed, we pick 'pwm_ao_a_hiz'

> 
>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> with the few notes fixed (see below):
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
thanks

>> ---
>>  drivers/pinctrl/meson/Kconfig              |    6 +
>>  drivers/pinctrl/meson/Makefile             |    1 +
>>  drivers/pinctrl/meson/pinctrl-meson-g12a.c | 1432 ++++++++++++++++++++
>>  3 files changed, 1439 insertions(+)
>>  create mode 100644 drivers/pinctrl/meson/pinctrl-meson-g12a.c
>>
>> diff --git a/drivers/pinctrl/meson/Kconfig b/drivers/pinctrl/meson/Kconfig
>> index c80951d6caff..9ab537eb78a3 100644
>> --- a/drivers/pinctrl/meson/Kconfig
>> +++ b/drivers/pinctrl/meson/Kconfig
>> @@ -47,4 +47,10 @@ config PINCTRL_MESON_AXG
>>  config PINCTRL_MESON_AXG_PMX
>>         bool
>>
>> +config PINCTRL_MESON_G12A
>> +       bool "Meson g12a Soc pinctrl driver"
>> +       depends on ARM64
>> +       select PINCTRL_MESON_AXG_PMX
>> +       default y
>> +
>>  endif
>> diff --git a/drivers/pinctrl/meson/Makefile b/drivers/pinctrl/meson/Makefile
>> index 3c6580c2d9d7..cf283f48f9d8 100644
>> --- a/drivers/pinctrl/meson/Makefile
>> +++ b/drivers/pinctrl/meson/Makefile
>> @@ -6,3 +6,4 @@ obj-$(CONFIG_PINCTRL_MESON_GXBB) += pinctrl-meson-gxbb.o
>>  obj-$(CONFIG_PINCTRL_MESON_GXL) += pinctrl-meson-gxl.o
>>  obj-$(CONFIG_PINCTRL_MESON_AXG_PMX) += pinctrl-meson-axg-pmx.o
>>  obj-$(CONFIG_PINCTRL_MESON_AXG) += pinctrl-meson-axg.o
>> +obj-$(CONFIG_PINCTRL_MESON_G12A) += pinctrl-meson-g12a.o
>> diff --git a/drivers/pinctrl/meson/pinctrl-meson-g12a.c b/drivers/pinctrl/meson/pinctrl-meson-g12a.c
>> new file mode 100644
>> index 000000000000..2711bad5d252
>> --- /dev/null
>> +++ b/drivers/pinctrl/meson/pinctrl-meson-g12a.c
>> @@ -0,0 +1,1432 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
>> +/*
>> + * Pin controller and GPIO driver for Amlogic Meson G12A SoC.
>> + *
>> + * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
>> + * Author: Xingyu Chen <xingyu.chen@amlogic.com>
>> + * Author: Yixun Lan <yixun.lan@amlogic.com>
> same as with the dt-bindings patch: do we also need a "Signed-off-by"
> from Xingyu Chen?
> 
sure, will do this

>> + */
>> +
>> +#include <dt-bindings/gpio/meson-g12a-gpio.h>
>> +#include "pinctrl-meson.h"
>> +#include "pinctrl-meson-axg-pmx.h"

[,,.]
>> +
>> +/* pwm_a */
>> +static const unsigned int pwm_a_pins[]                 = { GPIOX_6 };
>> +
>> +/* pwm_b */
>> +static const unsigned int pwm_b_x7_pins[]              = { GPIOX_7 };
>> +static const unsigned int pwm_b_x19_pins[]             = { GPIOX_19 };
>> +
>> +/* pwm_c */
>> +static const unsigned int pwm_c_c4_pins[]              = { GPIOC_4 };
> this could just be called "pwm_c_c_pins" because it appears only once
> in the C bank (similar to iso7816_clk_c_pins above)
> I suggest you only change this if another reviewer thinks that it's
> worth changing it

good catch!

it's worth to do the change, we actually follow the rule to keep the
name short (enough to differentiate each other)

> 
>> +static const unsigned int pwm_c_x5_pins[]              = { GPIOX_5 };
>> +static const unsigned int pwm_c_x8_pins[]              = { GPIOX_8 };
>> +
>> +/* pwm_d */
>> +static const unsigned int pwm_d_x3_pins[]              = { GPIOX_3 };
>> +static const unsigned int pwm_d_x6_pins[]              = { GPIOX_6 };
>> +
>> +/* pwm_e */
>> +static const unsigned int pwm_e_pins[]                 = { GPIOX_16 };
>> +
>> +/* pwm_f */
>> +static const unsigned int pwm_f_x_pins[]               = { GPIOX_7 };
>> +static const unsigned int pwm_f_h_pins[]               = { GPIOH_5 };
>> +
>> +/* cec_ao_ee */
>> +static const unsigned int cec_ao_a_ee_pins[]           = { GPIOH_3 };
>> +static const unsigned int cec_ao_b_ee_pins[]           = { GPIOH_3 };
> uart_ao_a_ee above uses "uart_ao_rx_a_c2_pins" instead of "uart_ao_rx_a_ee_pins"
> I'm not sure which one is better, but it would be good if this was consistent
> 
as mentioned above, we try to rename to uart_ao_a_rx_c_pins and
cec_ao_a_h_pins/cec_ao_b_h_pins here.

>> +
>> +/* jtag_b */
>> +static const unsigned int jtag_b_tdo_pins[]            = { GPIOC_0 };
>> +static const unsigned int jtag_b_tdi_pins[]            = { GPIOC_1 };
>> +static const unsigned int jtag_b_clk_pins[]            = { GPIOC_4 };
>> +static const unsigned int jtag_b_tms_pins[]            = { GPIOC_5 };
>> +
>> +/* bt565 */
>> +static const unsigned int bt565_a_vs_pins[]            = { GPIOZ_0 };
>> +static const unsigned int bt565_a_hs_pins[]            = { GPIOZ_1 };
>> +static const unsigned int bt565_a_clk_pins[]           = { GPIOZ_3 };
>> +static const unsigned int bt565_a_din0_pins[]          = { GPIOZ_4 };
>> +static const unsigned int bt565_a_din1_pins[]          = { GPIOZ_5 };
>> +static const unsigned int bt565_a_din2_pins[]          = { GPIOZ_6 };
>> +static const unsigned int bt565_a_din3_pins[]          = { GPIOZ_7 };
>> +static const unsigned int bt565_a_din4_pins[]          = { GPIOZ_8 };
>> +static const unsigned int bt565_a_din5_pins[]          = { GPIOZ_9 };
>> +static const unsigned int bt565_a_din6_pins[]          = { GPIOZ_10 };
>> +static const unsigned int bt565_a_din7_pins[]          = { GPIOZ_11 };

[...]

>> +/* uart_ao_a */
>> +static const unsigned int uart_ao_tx_a_pins[]          = { GPIOAO_0 };
>> +static const unsigned int uart_ao_rx_a_pins[]          = { GPIOAO_1 };
>> +static const unsigned int uart_ao_cts_a_pins[]         = { GPIOE_0 };
>> +static const unsigned int uart_ao_rts_a_pins[]         = { GPIOE_1 };
>> +
>> +/* uart_ao_b */
>> +static const unsigned int uart_ao_tx_b_2_pins[]                = { GPIOAO_2 };
>> +static const unsigned int uart_ao_rx_b_3_pins[]                = { GPIOAO_3 };
>> +
>> +static const unsigned int uart_ao_tx_b_8_pins[]                = { GPIOAO_8 };
>> +static const unsigned int uart_ao_rx_b_9_pins[]                = { GPIOAO_9 };
>> +
>> +static const unsigned int uart_ao_cts_b_pins[]         = { GPIOE_0 };
>> +static const unsigned int uart_ao_rts_b_pins[]         = { GPIOE_1 };
>> +
>> +/* i2c_ao */
>> +static const unsigned int i2c_ao_sck_pins[]            = { GPIOAO_2 };
>> +static const unsigned int i2c_ao_sda_pins[]            = { GPIOAO_3 };
>> +
>> +static const unsigned int i2c_ao_sck_e_pins[]          = { GPIOE_0 };
>> +static const unsigned int i2c_ao_sda_e_pins[]          = { GPIOE_1 };
> shouldn't these two be called "...ao2..." and "...ao3..." (and so on)
> so they match the naming of the pins in the EE controller?
> 
I'd just leave it un-changed.

it's kind redundant to add another 'ao' here. give it a number is
already enough to distinguish the pins, and if user really want to know
the meaning they can always look into the code. we don't try to encode
all the pin information here.


>> +/* i2c_ao_slave */
>> +static const unsigned int i2c_ao_slave_sck_pins[]      = { GPIOAO_2 };
>> +static const unsigned int i2c_ao_slave_sda_pins[]      = { GPIOAO_3 };
>> +
>> +/* ir_in */
>> +static const unsigned int remote_input_ao_pins[]       = { GPIOAO_5 };
>> +
>> +/* ir_out */
>> +static const unsigned int remote_out_ao_pins[]         = { GPIOAO_4 };
>> +
>> +/* pwm_ao_a */
>> +static const unsigned int pwm_ao_a_pins[]              = { GPIOAO_11 };
>> +static const unsigned int pwm_ao_a_hiz_pins[]          = { GPIOAO_11 };
>> +
>> +/* pwm_ao_b */
>> +static const unsigned int pwm_ao_b_pins[]              = { GPIOE_0 };
>> +
>> +/* pwm_ao_c */
>> +static const unsigned int pwm_ao_c_4_pins[]            = { GPIOAO_4 };
> should this be pwm_ao_c_ao4_pins as explained above?
> 
>> +static const unsigned int pwm_ao_c_hiz_4_pins[]                = { GPIOAO_4 };
> do we need the "_4_" in here or is pwm_ao_c_hiz_pins sufficient?
> I'd like someone else to give feedback on this
> 
I will drop _4, thanks for catching this.

>> +static const unsigned int pwm_ao_c_6_pins[]            = { GPIOAO_6 };
> should this be pwm_ao_c_ao6_pins as explained above?
> 
>> +
>> +/* pwm_ao_d */
>> +static const unsigned int pwm_ao_d_5_pins[]            = { GPIOAO_5 };
>> +static const unsigned int pwm_ao_d_10_pins[]           = { GPIOAO_10 };
> ..ao5... and ..ao10.. here too?
I will just leave as it is, ditto
> 
>> +static const unsigned int pwm_ao_d_e_pins[]            = { GPIOE_1 };
>> +
>> +/* jtag_a */
.


