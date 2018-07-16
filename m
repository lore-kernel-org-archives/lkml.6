Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806DAECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E029C20779
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:07:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E029C20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbeGPJeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 05:34:14 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:53959 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbeGPJeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 05:34:14 -0400
Received: from [192.168.90.200] (10.18.20.235) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Mon, 16 Jul
 2018 17:06:57 +0800
Subject: Re: [PATCH v2 2/2] pinctrl: meson-g12a: add pinctrl driver support
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>
References: <20180714232754.5402-1-yixun.lan@amlogic.com>
 <20180714232754.5402-3-yixun.lan@amlogic.com>
 <1531671413.2708.223.camel@baylibre.com>
CC:     <yixun.lan@amlogic.com>, Xingyu Chen <xingyu.chen@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
From:   Yixun Lan <yixun.lan@amlogic.com>
Message-ID: <4182fb4b-5ddb-cde6-7508-f1f1c52a4776@amlogic.com>
Date:   Mon, 16 Jul 2018 17:07:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <1531671413.2708.223.camel@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.20.235]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome

thanks for the review, see my comments below

On 07/16/18 00:16, Jerome Brunet wrote:
> On Sat, 2018-07-14 at 23:27 +0000, Yixun Lan wrote:
>> Add the pinctrl driver for Meson-G12A SoC which share the similar IP as
>> the previous Meson-AXG SoC.
>>
>> Starting from Meson-AXG SoC, the pinctrl controller block use 4
>> continues register bits to specific the pin mux function, while comparing
>> to old generation SoC which using variable length register bits for
>> the pin mux definition. The new design greatly simplify the software model.
>>
>> For the detail example, one 32bit register can be divided into 8 parts,
>> each has 4 bits whose value start from 0 - 7, each can describe one pin,
>> the value 0 is always devoted to GPIO function, while 1 - 7 devoted to
>> the mux pin function.
>>
>> Please note, the GPIOE is actually located at AO (always on) bank.
>>
>> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>> ---
>>  drivers/pinctrl/meson/Kconfig              |    6 +
>>  drivers/pinctrl/meson/Makefile             |    1 +
>>  drivers/pinctrl/meson/pinctrl-meson-g12a.c | 1433 ++++++++++++++++++++
>>  3 files changed, 1440 insertions(+)
>>  create mode 100644 drivers/pinctrl/meson/pinctrl-meson-g12a.c
>>
>> diff --git a/drivers/pinctrl/meson/Kconfig b/drivers/pinctrl/meson/Kconfig
>> index c80951d6caff..9ab537eb78a3 100644
>> --- a/drivers/pinctrl/meson/Kconfig
>> +++ b/drivers/pinctrl/meson/Kconfig
>> @@ -47,4 +47,10 @@ config PINCTRL_MESON_AXG
>>  config PINCTRL_MESON_AXG_PMX
>>  	bool
>>  
>> +config PINCTRL_MESON_G12A
>> +	bool "Meson g12a Soc pinctrl driver"
>> +	depends on ARM64
>> +	select PINCTRL_MESON_AXG_PMX
>> +	default y
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
>> index 000000000000..ca5cec40ac34
>> --- /dev/null
>> +++ b/drivers/pinctrl/meson/pinctrl-meson-g12a.c
>> @@ -0,0 +1,1433 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
>> +/*
>> + * Pin controller and GPIO driver for Amlogic Meson G12A SoC.
>> + *
>> + * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
>> + * Author: Xingyu Chen <xingyu.chen@amlogic.com>
>> + * Author: Yixun Lan <yixun.lan@amlogic.com>
>> + */
>> +
>> +#include <dt-bindings/gpio/meson-g12a-gpio.h>
>> +#include "pinctrl-meson.h"
>> +#include "pinctrl-meson-axg-pmx.h"
>> +
>>
> 
> [...]
> 
>> +/* uart_ao_a_ee */
>> +static const unsigned int uart_ao_rx_a_c2_pins[]	= { GPIOC_2 };
>> +static const unsigned int uart_ao_tx_a_c3_pins[]	= { GPIOC_3 };
> 
> Same comment as Martin about naming consistency ... drop c2 and c3 here.
> 

there is already uart_ao_rx_a_pins[]  uart_ao_tx_a_pins[] , see

 794 static const unsigned int uart_ao_tx_a_pins[]           = {
GPIOAO_0 };
 795 static const unsigned int uart_ao_rx_a_pins[]           = {
GPIOAO_1 };

in the G12A ASIC design, some AO device (from function perspective)
route the pin to EE domain, for maximize pin mux utilization.

if you don't like this naming scheme, I could rename it into
  uart_ao_rx_a_ee_pins[]
  uart_ao_tx_a_ee_pins[]

which mean uart_ao rx pin at port A route to EE domain's physical pin.


>> +
>> +/* iso7816 */
>> +static const unsigned int iso7816_clk_c_pins[]		= { GPIOC_5 };
>> +static const unsigned int iso7816_data_c_pins[]		= { GPIOC_6 };
>> +
>> +static const unsigned int iso7816_clk_x_pins[]		= { GPIOX_8 };
>> +static const unsigned int iso7816_data_x_pins[]		= { GPIOX_9 };
>> +
>> +static const unsigned int iso7816_clk_h_pins[]		= { GPIOH_6 };
>> +static const unsigned int iso7816_data_h_pins[]		= { GPIOH_7 };
>> +
>> +static const unsigned int iso7816_clk_z_pins[]		= { GPIOZ_0 };
>> +static const unsigned int iso7816_data_z_pins[]		= { GPIOZ_1 };
>> +
>> +/* eth */
>> +static const unsigned int eth_mdio_pins[]		= { GPIOZ_0 };
>> +static const unsigned int eth_mdc_pins[]		= { GPIOZ_1 };
>> +static const unsigned int eth_rgmii_rx_clk_pins[]	= { GPIOZ_2 };
>> +static const unsigned int eth_rx_dv_pins[]		= { GPIOZ_3 };
>> +static const unsigned int eth_rxd0_pins[]		= { GPIOZ_4 };
>> +static const unsigned int eth_rxd1_pins[]		= { GPIOZ_5 };
>> +static const unsigned int eth_rxd2_rgmii_pins[]		= { GPIOZ_6 };
>> +static const unsigned int eth_rxd3_rgmii_pins[]		= { GPIOZ_7 };
>> +static const unsigned int eth_rgmii_tx_clk_pins[]	= { GPIOZ_8 };
>> +static const unsigned int eth_txen_pins[]		= { GPIOZ_9 };
>> +static const unsigned int eth_txd0_pins[]		= { GPIOZ_10 };
>> +static const unsigned int eth_txd1_pins[]		= { GPIOZ_11 };
>> +static const unsigned int eth_txd2_rgmii_pins[]		= { GPIOZ_12 };
>> +static const unsigned int eth_txd3_rgmii_pins[]		= { GPIOZ_13 };
>> +static const unsigned int eth_link_led_pins[]		= { GPIOZ_14 };
>> +static const unsigned int eth_act_led_pins[]		= { GPIOZ_15 };
>> +
>> +/* pwm_a */
>> +static const unsigned int pwm_a_pins[]			= { GPIOX_6 };
>> +
>> +/* pwm_b */
>> +static const unsigned int pwm_b_x7_pins[]		= { GPIOX_7 };
>> +static const unsigned int pwm_b_x19_pins[]		= { GPIOX_19 };
>> +
>> +/* pwm_c */
>> +static const unsigned int pwm_c_c4_pins[]		= { GPIOC_4 };
>> +static const unsigned int pwm_c_x5_pins[]		= { GPIOX_5 };
>> +static const unsigned int pwm_c_x8_pins[]		= { GPIOX_8 };
>> +
>> +/* pwm_d */
>> +static const unsigned int pwm_d_x3_pins[]		= { GPIOX_3 };
>> +static const unsigned int pwm_d_x6_pins[]		= { GPIOX_6 };
>> +
>> +/* pwm_e */
>> +static const unsigned int pwm_e_pins[]			= { GPIOX_16 };
>> +
>> +/* pwm_f */
>> +static const unsigned int pwm_f_x_pins[]		= { GPIOX_7 };
>> +static const unsigned int pwm_f_h_pins[]		= { GPIOH_5 };
>> +
>> +/* cec_ao_ee */
>> +static const unsigned int cec_ao_a_ee_pins[]		= { GPIOH_3 };
>> +static const unsigned int cec_ao_b_ee_pins[]		= { GPIOH_3 };
> 
> Naming consistency : cec_ao_ee_a ? cec_ao_ee_b ?
> 
I'd prefer the original version, which mean cec_ao controller at port a
route to EE domain's physical pin.

I would check this driver to see if there is inconsistency.


>> +
>> +/* jtag_b */
>> +static const unsigned int jtag_b_tdo_pins[]		= { GPIOC_0 };
>> +static const unsigned int jtag_b_tdi_pins[]		= { GPIOC_1 };
>> +static const unsigned int jtag_b_clk_pins[]		= { GPIOC_4 };
>> +static const unsigned int jtag_b_tms_pins[]		= { GPIOC_5 };
>> +
>> +/* bt565 */
>> +static const unsigned int bt565_a_vs_pins[]		= { GPIOZ_0 };
>> +static const unsigned int bt565_a_hs_pins[]		= { GPIOZ_1 };
>> +static const unsigned int bt565_a_clk_pins[]		= { GPIOZ_3 };
>> +static const unsigned int bt565_a_din0_pins[]		= { GPIOZ_4 };
>> +static const unsigned int bt565_a_din1_pins[]		= { GPIOZ_5 };
>> +static const unsigned int bt565_a_din2_pins[]		= { GPIOZ_6 };
>> +static const unsigned int bt565_a_din3_pins[]		= { GPIOZ_7 };
>> +static const unsigned int bt565_a_din4_pins[]		= { GPIOZ_8 };
>> +static const unsigned int bt565_a_din5_pins[]		= { GPIOZ_9 };
>> +static const unsigned int bt565_a_din6_pins[]		= { GPIOZ_10 };
>> +static const unsigned int bt565_a_din7_pins[]		= { GPIOZ_11 };
> 
> Why bt565_a and no bt565 only ?
> 

After talking to Xingyu, this naming is actually taken from the pin mux
documentation, it's BT565_A there.

I'm not sure if you insist to drop the _a suffix, personally I'd just
leave it as it is, for better consistence with documentation.


>> +
>> +/* tsin_a */
>> +static const unsigned int tsin_a_valid_pins[]		= { GPIOX_2 };
>> +static const unsigned int tsin_a_sop_pins[]		= { GPIOX_1 };
>> +static const unsigned int tsin_a_din0_pins[]		= { GPIOX_0 };
>> +static const unsigned int tsin_a_clk_pins[]		= { GPIOX_3 };
>> +
>> +/* tsin_b */
>> +static const unsigned int tsin_b_valid_x_pins[]		= { GPIOX_9 };
>> +static const unsigned int tsin_b_sop_x_pins[]		= { GPIOX_8 };
>> +static const unsigned int tsin_b_din0_x_pins[]		= { GPIOX_10 };
>> +static const unsigned int tsin_b_clk_x_pins[]		= { GPIOX_11 };
>> +
>> +static const unsigned int tsin_b_valid_z_pins[]		= { GPIOZ_2 };
>> +static const unsigned int tsin_b_sop_z_pins[]		= { GPIOZ_3 };
>> +static const unsigned int tsin_b_din0_z_pins[]		= { GPIOZ_4 };
>> +static const unsigned int tsin_b_clk_z_pins[]		= { GPIOZ_5 };
>> +
>> +static const unsigned int tsin_b_fail_pins[]		= { GPIOZ_6 };
>> +static const unsigned int tsin_b_din1_pins[]		= { GPIOZ_7 };
>> +static const unsigned int tsin_b_din2_pins[]		= { GPIOZ_8 };
>> +static const unsigned int tsin_b_din3_pins[]		= { GPIOZ_9 };
>> +static const unsigned int tsin_b_din4_pins[]		= { GPIOZ_10 };
>> +static const unsigned int tsin_b_din5_pins[]		= { GPIOZ_11 };
>> +static const unsigned int tsin_b_din6_pins[]		= { GPIOZ_12 };
>> +static const unsigned int tsin_b_din7_pins[]		= { GPIOZ_13 };
>> +
>> +/* hdmitx */
>> +static const unsigned int hdmitx_sda_pins[]		= { GPIOH_0 };
>> +static const unsigned int hdmitx_sck_pins[]		= { GPIOH_1 };
>> +static const unsigned int hdmitx_hpd_in_pins[]		= { GPIOH_2 };
>> +
>> +/* pdm */
>> +static const unsigned int pdm_din0_c_pins[]		= { GPIOC_0 };
>> +static const unsigned int pdm_din1_c_pins[]		= { GPIOC_1 };
>> +static const unsigned int pdm_din2_c_pins[]		= { GPIOC_2 };
>> +static const unsigned int pdm_din3_c_pins[]		= { GPIOC_3 };
>> +static const unsigned int pdm_dclk_c_pins[]		= { GPIOC_4 };
>> +
>> +static const unsigned int pdm_din0_x_pins[]		= { GPIOX_0 };
>> +static const unsigned int pdm_din1_x_pins[]		= { GPIOX_1 };
>> +static const unsigned int pdm_din2_x_pins[]		= { GPIOX_2 };
>> +static const unsigned int pdm_din3_x_pins[]		= { GPIOX_3 };
>> +static const unsigned int pdm_dclk_x_pins[]		= { GPIOX_4 };
>> +
>> +static const unsigned int pdm_din0_z_pins[]		= { GPIOZ_2 };
>> +static const unsigned int pdm_din1_z_pins[]		= { GPIOZ_3 };
>> +static const unsigned int pdm_din2_z_pins[]		= { GPIOZ_4 };
>> +static const unsigned int pdm_din3_z_pins[]		= { GPIOZ_5 };
>> +static const unsigned int pdm_dclk_z_pins[]		= { GPIOZ_6 };
>> +
>> +static const unsigned int pdm_din0_a_pins[]		= { GPIOA_8 };
>> +static const unsigned int pdm_din1_a_pins[]		= { GPIOA_9 };
>> +static const unsigned int pdm_din2_a_pins[]		= { GPIOA_6 };
>> +static const unsigned int pdm_din3_a_pins[]		= { GPIOA_5 };
>> +static const unsigned int pdm_dclk_a_pins[]		= { GPIOA_7 };
>> +
>> +/* spdif_in */
>> +static const unsigned int spdif_in_h_pins[]		= { GPIOH_5 };
>> +static const unsigned int spdif_in_a10_pins[]		= { GPIOA_10 };
>> +static const unsigned int spdif_in_a12_pins[]		= { GPIOA_12 };
>> +
>> +/* spdif_out */
>> +static const unsigned int spdif_out_h_pins[]		= { GPIOH_4 };
>> +static const unsigned int spdif_out_a11_pins[]		= { GPIOA_11 };
>> +static const unsigned int spdif_out_a13_pins[]		= { GPIOA_13 };
>> +
>> +/* mclk0 */
>> +static const unsigned int mclk0_a_pins[]		= { GPIOA_0 };
>> +
>> +/* mclk1 */
>> +static const unsigned int mclk1_x_pins[]		= { GPIOX_5 };
>> +static const unsigned int mclk1_z_pins[]		= { GPIOZ_8 };
>> +static const unsigned int mclk1_a_pins[]		= { GPIOA_11 };
>> +
>> +/* tdma_in */
>> +static const unsigned int tdma_slv_sclk_pins[]		= { GPIOX_11 };
>> +static const unsigned int tdma_slv_fs_pins[]		= { GPIOX_10 };
>> +static const unsigned int tdma_din0_pins[]		= { GPIOX_9 };
>> +static const unsigned int tdma_din1_pins[]		= { GPIOX_8 };
>> +
>> +/* tdma_out */
>> +static const unsigned int tdma_sclk_pins[]		= { GPIOX_11 };
>> +static const unsigned int tdma_fs_pins[]		= { GPIOX_10 };
>> +static const unsigned int tdma_dout0_pins[]		= { GPIOX_9 };
>> +static const unsigned int tdma_dout1_pins[]		= { GPIOX_8 };
>> +
>> +/* tdmb_in */
>> +static const unsigned int tdmb_slv_sclk_pins[]		= { GPIOA_1 };
>> +static const unsigned int tdmb_slv_fs_pins[]		= { GPIOA_2 };
> 
> tdm slave and master don't belong in a tdmin group or tdmout group.
> Both tdmin and tdmout use this clock. You should have only one function (tdm)
> and not two 
> 

there are a few comments relate to tdm iteam, let me rephase as
following, see if it's correct

we could divide tdm funtion into four part (same in pinctrl driver):
a) tdm clk
b) tdm data out
c) tdm clk slv
d) tdm data in

the combination can be like this from the use case perspective:
a + b, a + d, c + b, c + d

so in this patch, we could write as
tdm_ao_b_clk_groups[]
tdm_ao_b_clk_slv_groups[]
tdm_ao_b_data_in_groups[]
tdm_ao_b_data_out_groups[]

look into the pin mux documentation, the tdm_ao_b clock function is set
by value=5, while tdm_ao_b clock_slv functioin is set by value=6.

>> +static const unsigned int tdmb_din0_pins[]		= { GPIOA_3 };
>> +static const unsigned int tdmb_din1_pins[]		= { GPIOA_4 };
>> +static const unsigned int tdmb_din2_pins[]		= { GPIOA_5 };
>> +static const unsigned int tdmb_din3_a_pins[]		= { GPIOA_6 };
>> +static const unsigned int tdmb_din3_h_pins[]		= { GPIOH_5 };
>> +
>> +/* tdmb_out */
>> +static const unsigned int tdmb_sclk_pins[]		= { GPIOA_1 };
>> +static const unsigned int tdmb_fs_pins[]		= { GPIOA_2 };
>> +static const unsigned int tdmb_dout0_pins[]		= { GPIOA_3 };
>> +static const unsigned int tdmb_dout1_pins[]		= { GPIOA_4 };
>> +static const unsigned int tdmb_dout2_pins[]		= { GPIOA_5 };
>> +static const unsigned int tdmb_dout3_a_pins[]		= { GPIOA_6 };
>> +static const unsigned int tdmb_dout3_h_pins[]		= { GPIOH_5 };
>> +
>> +/* tdmc_in */
>> +static const unsigned int tdmc_slv_sclk_a_pins[]	= { GPIOA_12 };
>> +static const unsigned int tdmc_slv_fs_a_pins[]		= { GPIOA_13 };
>> +static const unsigned int tdmc_din0_a_pins[]		= { GPIOA_10 };
>> +static const unsigned int tdmc_din1_a_pins[]		= { GPIOA_9 };
>> +static const unsigned int tdmc_din2_a_pins[]		= { GPIOA_8 };
>> +static const unsigned int tdmc_din3_a_pins[]		= { GPIOA_7 };
>> +
>> +static const unsigned int tdmc_slv_sclk_z_pins[]	= { GPIOZ_7 };
>> +static const unsigned int tdmc_slv_fs_z_pins[]		= { GPIOZ_6 };
>> +static const unsigned int tdmc_din0_z_pins[]		= { GPIOZ_2 };
>> +static const unsigned int tdmc_din1_z_pins[]		= { GPIOZ_3 };
>> +static const unsigned int tdmc_din2_z_pins[]		= { GPIOZ_4 };
>> +static const unsigned int tdmc_din3_z_pins[]		= { GPIOZ_5 };
>> +
>> +/* tdmc_out */
>> +static const unsigned int tdmc_sclk_a_pins[]		= { GPIOA_12 };
>> +static const unsigned int tdmc_fs_a_pins[]		= { GPIOA_13 };
>> +static const unsigned int tdmc_dout0_a_pins[]		= { GPIOA_10 };
>> +static const unsigned int tdmc_dout1_a_pins[]		= { GPIOA_9 };
>> +static const unsigned int tdmc_dout2_a_pins[]		= { GPIOA_8 };
>> +static const unsigned int tdmc_dout3_a_pins[]		= { GPIOA_7 };
>> +
>> +static const unsigned int tdmc_sclk_z_pins[]		= { GPIOZ_7 };
>> +static const unsigned int tdmc_fs_z_pins[]		= { GPIOZ_6 };
>> +static const unsigned int tdmc_dout0_z_pins[]		= { GPIOZ_2 };
>> +static const unsigned int tdmc_dout1_z_pins[]		= { GPIOZ_3 };
>> +static const unsigned int tdmc_dout2_z_pins[]		= { GPIOZ_4 };
>> +static const unsigned int tdmc_dout3_z_pins[]		= { GPIOZ_5 };
>> +
>> +static struct meson_pmx_group meson_g12a_periphs_groups[] = {
>> +	GPIO_GROUP(GPIOZ_0),
>> +	GPIO_GROUP(GPIOZ_1),
>> +	GPIO_GROUP(GPIOZ_2),
>> +	GPIO_GROUP(GPIOZ_3),
>> +	GPIO_GROUP(GPIOZ_4),
>> +	GPIO_GROUP(GPIOZ_5),
>> +	GPIO_GROUP(GPIOZ_6),
>> +	GPIO_GROUP(GPIOZ_7),
>> +	GPIO_GROUP(GPIOZ_8),
>> +	GPIO_GROUP(GPIOZ_9),
>> +	GPIO_GROUP(GPIOZ_10),
>> +	GPIO_GROUP(GPIOZ_11),
>> +	GPIO_GROUP(GPIOZ_12),
>> +	GPIO_GROUP(GPIOZ_13),
>> +	GPIO_GROUP(GPIOZ_14),
>> +	GPIO_GROUP(GPIOZ_15),
>> +	GPIO_GROUP(GPIOH_0),
>> +	GPIO_GROUP(GPIOH_1),
>> +	GPIO_GROUP(GPIOH_2),
>> +	GPIO_GROUP(GPIOH_3),
>> +	GPIO_GROUP(GPIOH_4),
>> +	GPIO_GROUP(GPIOH_5),
>> +	GPIO_GROUP(GPIOH_6),
>> +	GPIO_GROUP(GPIOH_7),
>> +	GPIO_GROUP(GPIOH_8),
>> +	GPIO_GROUP(BOOT_0),
>> +	GPIO_GROUP(BOOT_1),
>> +	GPIO_GROUP(BOOT_2),
>> +	GPIO_GROUP(BOOT_3),
>> +	GPIO_GROUP(BOOT_4),
>> +	GPIO_GROUP(BOOT_5),
>> +	GPIO_GROUP(BOOT_6),
>> +	GPIO_GROUP(BOOT_7),
>> +	GPIO_GROUP(BOOT_8),
>> +	GPIO_GROUP(BOOT_9),
>> +	GPIO_GROUP(BOOT_10),
>> +	GPIO_GROUP(BOOT_11),
>> +	GPIO_GROUP(BOOT_12),
>> +	GPIO_GROUP(BOOT_13),
>> +	GPIO_GROUP(BOOT_14),
>> +	GPIO_GROUP(BOOT_15),
>> +	GPIO_GROUP(GPIOC_0),
>> +	GPIO_GROUP(GPIOC_1),
>> +	GPIO_GROUP(GPIOC_2),
>> +	GPIO_GROUP(GPIOC_3),
>> +	GPIO_GROUP(GPIOC_4),
>> +	GPIO_GROUP(GPIOC_5),
>> +	GPIO_GROUP(GPIOC_6),
>> +	GPIO_GROUP(GPIOC_7),
>> +	GPIO_GROUP(GPIOA_0),
>> +	GPIO_GROUP(GPIOA_1),
>> +	GPIO_GROUP(GPIOA_2),
>> +	GPIO_GROUP(GPIOA_3),
>> +	GPIO_GROUP(GPIOA_4),
>> +	GPIO_GROUP(GPIOA_5),
>> +	GPIO_GROUP(GPIOA_6),
>> +	GPIO_GROUP(GPIOA_7),
>> +	GPIO_GROUP(GPIOA_8),
>> +	GPIO_GROUP(GPIOA_9),
>> +	GPIO_GROUP(GPIOA_10),
>> +	GPIO_GROUP(GPIOA_11),
>> +	GPIO_GROUP(GPIOA_12),
>> +	GPIO_GROUP(GPIOA_13),
>> +	GPIO_GROUP(GPIOA_14),
>> +	GPIO_GROUP(GPIOA_15),
>> +	GPIO_GROUP(GPIOX_0),
>> +	GPIO_GROUP(GPIOX_1),
>> +	GPIO_GROUP(GPIOX_2),
>> +	GPIO_GROUP(GPIOX_3),
>> +	GPIO_GROUP(GPIOX_4),
>> +	GPIO_GROUP(GPIOX_5),
>> +	GPIO_GROUP(GPIOX_6),
>> +	GPIO_GROUP(GPIOX_7),
>> +	GPIO_GROUP(GPIOX_8),
>> +	GPIO_GROUP(GPIOX_9),
>> +	GPIO_GROUP(GPIOX_10),
>> +	GPIO_GROUP(GPIOX_11),
>> +	GPIO_GROUP(GPIOX_12),
>> +	GPIO_GROUP(GPIOX_13),
>> +	GPIO_GROUP(GPIOX_14),
>> +	GPIO_GROUP(GPIOX_15),
>> +	GPIO_GROUP(GPIOX_16),
>> +	GPIO_GROUP(GPIOX_17),
>> +	GPIO_GROUP(GPIOX_18),
>> +	GPIO_GROUP(GPIOX_19),
>> +
>> +	/* bank BOOT */
>> +	GROUP(emmc_nand_d0,	1),
>> +	GROUP(emmc_nand_d1,	1),
>> +	GROUP(emmc_nand_d2,	1),
>> +	GROUP(emmc_nand_d3,	1),
>> +	GROUP(emmc_nand_d4,	1),
>> +	GROUP(emmc_nand_d5,	1),
>> +	GROUP(emmc_nand_d6,	1),
>> +	GROUP(emmc_nand_d7,	1),
>> +	GROUP(emmc_clk,		1),
>> +	GROUP(emmc_cmd,		1),
>> +	GROUP(emmc_nand_ds,	1),
>> +	GROUP(nand_ce0,		2),
>> +	GROUP(nand_ale,		2),
>> +	GROUP(nand_cle,		2),
>> +	GROUP(nand_wen_clk,	2),
>> +	GROUP(nand_ren_wr,	2),
>> +	GROUP(nand_rb0,		2),
>> +	GROUP(nand_ce1,		2),
>> +	GROUP(nor_hold,		3),
>> +	GROUP(nor_d,		3),
>> +	GROUP(nor_q,		3),
>> +	GROUP(nor_c,		3),
>> +	GROUP(nor_wp,		3),
>> +	GROUP(nor_cs,		3),
>> +
>> +	/* bank GPIOZ */
>> +	GROUP(sdcard_d0_z,	5),
>> +	GROUP(sdcard_d1_z,	5),
>> +	GROUP(sdcard_d2_z,	5),
>> +	GROUP(sdcard_d3_z,	5),
>> +	GROUP(sdcard_clk_z,	5),
>> +	GROUP(sdcard_cmd_z,	5),
>> +	GROUP(i2c0_sda_z0,	4),
>> +	GROUP(i2c0_sck_z1,	4),
>> +	GROUP(i2c0_sda_z7,	7),
>> +	GROUP(i2c0_sck_z8,	7),
>> +	GROUP(i2c2_sda_z,	3),
>> +	GROUP(i2c2_sck_z,	3),
>> +	GROUP(iso7816_clk_z,	3),
>> +	GROUP(iso7816_data_z,	3),
>> +	GROUP(eth_mdio,		1),
>> +	GROUP(eth_mdc,		1),
>> +	GROUP(eth_rgmii_rx_clk,	1),
>> +	GROUP(eth_rx_dv,	1),
>> +	GROUP(eth_rxd0,		1),
>> +	GROUP(eth_rxd1,		1),
>> +	GROUP(eth_rxd2_rgmii,	1),
>> +	GROUP(eth_rxd3_rgmii,	1),
>> +	GROUP(eth_rgmii_tx_clk,	1),
>> +	GROUP(eth_txen,		1),
>> +	GROUP(eth_txd0,		1),
>> +	GROUP(eth_txd1,		1),
>> +	GROUP(eth_txd2_rgmii,	1),
>> +	GROUP(eth_txd3_rgmii,	1),
>> +	GROUP(eth_link_led,	1),
>> +	GROUP(eth_act_led,	1),
>> +	GROUP(bt565_a_vs,	2),
>> +	GROUP(bt565_a_hs,	2),
>> +	GROUP(bt565_a_clk,	2),
>> +	GROUP(bt565_a_din0,	2),
>> +	GROUP(bt565_a_din1,	2),
>> +	GROUP(bt565_a_din2,	2),
>> +	GROUP(bt565_a_din3,	2),
>> +	GROUP(bt565_a_din4,	2),
>> +	GROUP(bt565_a_din5,	2),
>> +	GROUP(bt565_a_din6,	2),
>> +	GROUP(bt565_a_din7,	2),
>> +	GROUP(tsin_b_valid_z,	3),
>> +	GROUP(tsin_b_sop_z,	3),
>> +	GROUP(tsin_b_din0_z,	3),
>> +	GROUP(tsin_b_clk_z,	3),
>> +	GROUP(tsin_b_fail,	3),
>> +	GROUP(tsin_b_din1,	3),
>> +	GROUP(tsin_b_din2,	3),
>> +	GROUP(tsin_b_din3,	3),
>> +	GROUP(tsin_b_din4,	3),
>> +	GROUP(tsin_b_din5,	3),
>> +	GROUP(tsin_b_din6,	3),
>> +	GROUP(tsin_b_din7,	3),
>> +	GROUP(pdm_din0_z,	7),
>> +	GROUP(pdm_din1_z,	7),
>> +	GROUP(pdm_din2_z,	7),
>> +	GROUP(pdm_din3_z,	7),
>> +	GROUP(pdm_dclk_z,	7),
>> +	GROUP(tdmc_slv_sclk_z,	6),
>> +	GROUP(tdmc_slv_fs_z,	6),
>> +	GROUP(tdmc_din0_z,	6),
>> +	GROUP(tdmc_din1_z,	6),
>> +	GROUP(tdmc_din2_z,	6),
>> +	GROUP(tdmc_din3_z,	6),
>> +	GROUP(tdmc_sclk_z,	4),
>> +	GROUP(tdmc_fs_z,	4),
>> +	GROUP(tdmc_dout0_z,	4),
>> +	GROUP(tdmc_dout1_z,	4),
>> +	GROUP(tdmc_dout2_z,	4),
>> +	GROUP(tdmc_dout3_z,	4),
>> +	GROUP(mclk1_z,		4),
>> +
>> +	/* bank GPIOX */
>> +	GROUP(sdio_d0,		1),
>> +	GROUP(sdio_d1,		1),
>> +	GROUP(sdio_d2,		1),
>> +	GROUP(sdio_d3,		1),
>> +	GROUP(sdio_clk,		1),
>> +	GROUP(sdio_cmd,		1),
>> +	GROUP(spi0_mosi_x,	4),
>> +	GROUP(spi0_miso_x,	4),
>> +	GROUP(spi0_ss0_x,	4),
>> +	GROUP(spi0_clk_x,	4),
>> +	GROUP(i2c1_sda_x,	5),
>> +	GROUP(i2c1_sck_x,	5),
>> +	GROUP(i2c2_sda_x,	1),
>> +	GROUP(i2c2_sck_x,	1),
>> +	GROUP(uart_tx_a,	1),
>> +	GROUP(uart_rx_a,	1),
>> +	GROUP(uart_cts_a,	1),
>> +	GROUP(uart_rts_a,	1),
>> +	GROUP(uart_tx_b,	2),
>> +	GROUP(uart_rx_b,	2),
>> +	GROUP(iso7816_clk_x,	6),
>> +	GROUP(iso7816_data_x,	6),
>> +	GROUP(pwm_a,		1),
>> +	GROUP(pwm_b_x7,		4),
>> +	GROUP(pwm_b_x19,	1),
>> +	GROUP(pwm_c_x5,		4),
>> +	GROUP(pwm_c_x8,		5),
>> +	GROUP(pwm_d_x3,		4),
>> +	GROUP(pwm_d_x6,		4),
>> +	GROUP(pwm_e,		1),
>> +	GROUP(pwm_f_x,		1),
>> +	GROUP(tsin_a_valid,	3),
>> +	GROUP(tsin_a_sop,	3),
>> +	GROUP(tsin_a_din0,	3),
>> +	GROUP(tsin_a_clk,	3),
>> +	GROUP(tsin_b_valid_x,	3),
>> +	GROUP(tsin_b_sop_x,	3),
>> +	GROUP(tsin_b_din0_x,	3),
>> +	GROUP(tsin_b_clk_x,	3),
>> +	GROUP(pdm_din0_x,	2),
>> +	GROUP(pdm_din1_x,	2),
>> +	GROUP(pdm_din2_x,	2),
>> +	GROUP(pdm_din3_x,	2),
>> +	GROUP(pdm_dclk_x,	2),
>> +	GROUP(tdma_slv_sclk,	2),
>> +	GROUP(tdma_slv_fs,	2),
>> +	GROUP(tdma_din0,	2),
>> +	GROUP(tdma_din1,	2),
>> +	GROUP(tdma_sclk,	1),
>> +	GROUP(tdma_fs,		1),
>> +	GROUP(tdma_dout0,	1),
>> +	GROUP(tdma_dout1,	1),
>> +	GROUP(mclk1_x,		2),
>> +
>> +	/* bank GPIOC */
>> +	GROUP(sdcard_d0_c,	1),
>> +	GROUP(sdcard_d1_c,	1),
>> +	GROUP(sdcard_d2_c,	1),
>> +	GROUP(sdcard_d3_c,	1),
>> +	GROUP(sdcard_clk_c,	1),
>> +	GROUP(sdcard_cmd_c,	1),
>> +	GROUP(spi0_mosi_c,	5),
>> +	GROUP(spi0_miso_c,	5),
>> +	GROUP(spi0_ss0_c,	5),
>> +	GROUP(spi0_clk_c,	5),
>> +	GROUP(i2c0_sda_c,	3),
>> +	GROUP(i2c0_sck_c,	3),
>> +	GROUP(uart_ao_rx_a_c2,	2),
>> +	GROUP(uart_ao_tx_a_c3,	2),
>> +	GROUP(iso7816_clk_c,	5),
>> +	GROUP(iso7816_data_c,	5),
>> +	GROUP(pwm_c_c4,		5),
>> +	GROUP(jtag_b_tdo,	2),
>> +	GROUP(jtag_b_tdi,	2),
>> +	GROUP(jtag_b_clk,	2),
>> +	GROUP(jtag_b_tms,	2),
>> +	GROUP(pdm_din0_c,	4),
>> +	GROUP(pdm_din1_c,	4),
>> +	GROUP(pdm_din2_c,	4),
>> +	GROUP(pdm_din3_c,	4),
>> +	GROUP(pdm_dclk_c,	4),
>> +
>> +	/* bank GPIOH */
>> +	GROUP(spi1_mosi,	3),
>> +	GROUP(spi1_miso,	3),
>> +	GROUP(spi1_ss0,		3),
>> +	GROUP(spi1_clk,		3),
>> +	GROUP(i2c1_sda_h2,	2),
>> +	GROUP(i2c1_sck_h3,	2),
>> +	GROUP(i2c1_sda_h6,	4),
>> +	GROUP(i2c1_sck_h7,	4),
>> +	GROUP(i2c3_sda_h,	2),
>> +	GROUP(i2c3_sck_h,	2),
>> +	GROUP(uart_tx_c,	2),
>> +	GROUP(uart_rx_c,	2),
>> +	GROUP(uart_cts_c,	2),
>> +	GROUP(uart_rts_c,	2),
>> +	GROUP(iso7816_clk_h,	1),
>> +	GROUP(iso7816_data_h,	1),
>> +	GROUP(pwm_f_h,		4),
>> +	GROUP(cec_ao_a_ee,	4),
>> +	GROUP(cec_ao_b_ee,	5),
>> +	GROUP(hdmitx_sda,	1),
>> +	GROUP(hdmitx_sck,	1),
>> +	GROUP(hdmitx_hpd_in,	1),
>> +	GROUP(spdif_out_h,	1),
>> +	GROUP(spdif_in_h,	1),
>> +	GROUP(tdmb_din3_h,	6),
>> +	GROUP(tdmb_dout3_h,	5),
>> +
>> +	/* bank GPIOA */
>> +	GROUP(i2c3_sda_a,	2),
>> +	GROUP(i2c3_sck_a,	2),
>> +	GROUP(pdm_din0_a,	1),
>> +	GROUP(pdm_din1_a,	1),
>> +	GROUP(pdm_din2_a,	1),
>> +	GROUP(pdm_din3_a,	1),
>> +	GROUP(pdm_dclk_a,	1),
>> +	GROUP(spdif_in_a10,	1),
>> +	GROUP(spdif_in_a12,	1),
>> +	GROUP(spdif_out_a11,	1),
>> +	GROUP(spdif_out_a13,	1),
>> +	GROUP(tdmb_slv_sclk,	2),
>> +	GROUP(tdmb_slv_fs,	2),
>> +	GROUP(tdmb_din0,	2),
>> +	GROUP(tdmb_din1,	2),
>> +	GROUP(tdmb_din2,	2),
>> +	GROUP(tdmb_din3_a,	2),
>> +	GROUP(tdmb_sclk,	1),
>> +	GROUP(tdmb_fs,		1),
>> +	GROUP(tdmb_dout0,	1),
>> +	GROUP(tdmb_dout1,	1),
>> +	GROUP(tdmb_dout2,	3),
>> +	GROUP(tdmb_dout3_a,	3),
>> +	GROUP(tdmc_slv_sclk_a,	3),
>> +	GROUP(tdmc_slv_fs_a,	3),
>> +	GROUP(tdmc_din0_a,	3),
>> +	GROUP(tdmc_din1_a,	3),
>> +	GROUP(tdmc_din2_a,	3),
>> +	GROUP(tdmc_din3_a,	3),
>> +	GROUP(tdmc_sclk_a,	2),
>> +	GROUP(tdmc_fs_a,	2),
>> +	GROUP(tdmc_dout0_a,	2),
>> +	GROUP(tdmc_dout1_a,	2),
>> +	GROUP(tdmc_dout2_a,	2),
>> +	GROUP(tdmc_dout3_a,	2),
>> +	GROUP(mclk0_a,		1),
>> +	GROUP(mclk1_a,		2),
>> +};
>> +
>> +/* uart_ao_a */
>> +static const unsigned int uart_ao_tx_a_pins[]		= { GPIOAO_0 };
>> +static const unsigned int uart_ao_rx_a_pins[]		= { GPIOAO_1 };
>> +static const unsigned int uart_ao_cts_a_pins[]		= { GPIOE_0 };
>> +static const unsigned int uart_ao_rts_a_pins[]		= { GPIOE_1 };
>> +
> 
> consistency please: uart_ao_a_{tx,rx,cts,rts}

I'm confused here, just checked the naming scheme, previous
in gxbb, gxl, we use:
  drivers/pinctrl/meson/pinctrl-meson-gxbb.c
  line 267: uart_tx_ao_a_pins[]

in axg (code I pushed), use:
  drivers/pinctrl/meson/pinctrl-meson-axg.c
  line 225: uart_ao_tx_b_z_pins[]

I do not against to change the naming scheme, so long as we could reach
a agreement first, and if we do the change, should we fix the old code?
(which will cause the DT change)

> 
>> +/* uart_ao_b */
>> +static const unsigned int uart_ao_tx_b_2_pins[]		= { GPIOAO_2 };
>> +static const unsigned int uart_ao_rx_b_3_pins[]		= { GPIOAO_3 };
>> +
>> +static const unsigned int uart_ao_tx_b_8_pins[]		= { GPIOAO_8 };
>> +static const unsigned int uart_ao_rx_b_9_pins[]		= { GPIOAO_9 };
>> +
>> +static const unsigned int uart_ao_cts_b_pins[]		= { GPIOE_0 };
>> +static const unsigned int uart_ao_rts_b_pins[]		= { GPIOE_1 };
>> +
> 
> same comment for ao_b
> 
ditto

>> +/* i2c_ao */
>> +static const unsigned int i2c_ao_sck_pins[]		= { GPIOAO_2 };
>> +static const unsigned int i2c_ao_sda_pins[]		= { GPIOAO_3 };
>> +
>> +static const unsigned int i2c_ao_sck_e_pins[]		= { GPIOE_0 };
>> +static const unsigned int i2c_ao_sda_e_pins[]		= { GPIOE_1 };
>> +
>> +/* i2c_ao_slave */
>> +static const unsigned int i2c_ao_slave_sck_pins[]	= { GPIOAO_2 };
>> +static const unsigned int i2c_ao_slave_sda_pins[]	= { GPIOAO_3 };
>> +
>> +/* ir_in */
>> +static const unsigned int remote_input_ao_pins[]	= { GPIOAO_5 };
>> +
>> +/* ir_out */
>> +static const unsigned int remote_out_ao_pins[]		= { GPIOAO_4 };
>> +
>> +/* pwm_ao_a */
>> +static const unsigned int pwm_ao_a_pins[]		= { GPIOAO_11 };
>> +static const unsigned int pwm_ao_a_hiz_pins[]		= { GPIOAO_11 };
>> +
> 
> Could you please comment on this "hiz" pin ? what is this exactly ?

it's special mode from pwm, so there are two mode: pwm, hiz pwm (hi/low
mode)

normal pwm:

   |--|  |--|
   |  |  |  |
___|  |__|  |__



a) hi/hiz mode:

   ---\   |--\
___|   \__|   \__


b) low/hiz mode:


    /--|   /--|
___/   |__/   |__


> 
>> +/* pwm_ao_b */
>> +static const unsigned int pwm_ao_b_pins[]		= { GPIOE_0 };
>> +
>> +/* pwm_ao_c */
>> +static const unsigned int pwm_ao_c_4_pins[]		= { GPIOAO_4 };
>> +static const unsigned int pwm_ao_c_hiz_4_pins[]		= { GPIOAO_4 };
>> +static const unsigned int pwm_ao_c_6_pins[]		= { GPIOAO_6 };
>> +
>> +/* pwm_ao_d */
>> +static const unsigned int pwm_ao_d_5_pins[]		= { GPIOAO_5 };
>> +static const unsigned int pwm_ao_d_10_pins[]		= { GPIOAO_10 };
>> +static const unsigned int pwm_ao_d_e_pins[]		= { GPIOE_1 };
>> +
>> +/* jtag_a */
>> +static const unsigned int jtag_a_tdi_pins[]		= { GPIOAO_8 };
>> +static const unsigned int jtag_a_tdo_pins[]		= { GPIOAO_9 };
>> +static const unsigned int jtag_a_clk_pins[]		= { GPIOAO_6 };
>> +static const unsigned int jtag_a_tms_pins[]		= { GPIOAO_7 };
>> +
>> +/* cec_ao */
>> +static const unsigned int cec_ao_a_pins[]		= { GPIOAO_10 };
>> +static const unsigned int cec_ao_b_pins[]		= { GPIOAO_10 };
>> +
>> +/* tsin_a_ao */
>> +static const unsigned int tsin_a_sop_ao_pins[]		= { GPIOAO_6 };
>> +static const unsigned int tsin_a_din0_ao_pins[]		= { GPIOAO_7 };
>> +static const unsigned int tsin_a_clk_ao_pins[]		= { GPIOAO_8 };
>> +static const unsigned int tsin_a_valid_ao_pins[]	= { GPIOAO_9 };
>> +
>> +/* spdif_out_ao */
>> +static const unsigned int spdif_out_ao_pins[]		= { GPIOAO_10 };
>> +
>> +/* tdmb_out_ao */
> 
> again, tdm not tdmout. clocks are shared between both of them

comments in tdm

> 
>> +static const unsigned int tdmb_dout0_ao_pins[]		= { GPIOAO_4 };
>> +static const unsigned int tdmb_dout1_ao_pins[]		= { GPIOAO_10 };
>> +static const unsigned int tdmb_dout2_ao_pins[]		= { GPIOAO_6 };
>> +static const unsigned int tdmb_fs_ao_pins[]		= { GPIOAO_7 };
>> +static const unsigned int tdmb_sclk_ao_pins[]		= { GPIOAO_8 };
>> +
>> +/* tdmb_in_ao */
>> +static const unsigned int tdmb_din0_ao_pins[]		= { GPIOAO_4 };
>> +static const unsigned int tdmb_din1_ao_pins[]		= { GPIOAO_10 };
>> +static const unsigned int tdmb_din2_ao_pins[]		= { GPIOAO_6 };
>> +static const unsigned int tdmb_slv_fs_ao_pins[]		= { GPIOAO_7 };
>> +static const unsigned int tdmb_slv_sclk_ao_pins[]	= { GPIOAO_8 };
>> +
>> +/* mclk0_ao */
>> +static const unsigned int mclk0_ao_pins[]		= { GPIOAO_9 };
>> +
>> +static struct meson_pmx_group meson_g12a_aobus_groups[] = {
>> +	GPIO_GROUP(GPIOAO_0),
>> +	GPIO_GROUP(GPIOAO_1),
>> +	GPIO_GROUP(GPIOAO_2),
>> +	GPIO_GROUP(GPIOAO_3),
>> +	GPIO_GROUP(GPIOAO_4),
>> +	GPIO_GROUP(GPIOAO_5),
>> +	GPIO_GROUP(GPIOAO_6),
>> +	GPIO_GROUP(GPIOAO_7),
>> +	GPIO_GROUP(GPIOAO_8),
>> +	GPIO_GROUP(GPIOAO_9),
>> +	GPIO_GROUP(GPIOAO_10),
>> +	GPIO_GROUP(GPIOAO_11),
>> +	GPIO_GROUP(GPIOE_0),
>> +	GPIO_GROUP(GPIOE_1),
>> +	GPIO_GROUP(GPIOE_2),
>> +
>> +	/* bank AO */
>> +	GROUP(uart_ao_tx_a,	1),
>> +	GROUP(uart_ao_rx_a,	1),
>> +	GROUP(uart_ao_cts_a,	1),
>> +	GROUP(uart_ao_rts_a,	1),
>> +	GROUP(uart_ao_tx_b_2,	2),
>> +	GROUP(uart_ao_rx_b_3,	2),
>> +	GROUP(uart_ao_tx_b_8,	3),
>> +	GROUP(uart_ao_rx_b_9,	3),
>> +	GROUP(uart_ao_cts_b,	2),
>> +	GROUP(uart_ao_rts_b,	2),
>> +	GROUP(i2c_ao_sck,	1),
>> +	GROUP(i2c_ao_sda,	1),
>> +	GROUP(i2c_ao_sck_e,	4),
>> +	GROUP(i2c_ao_sda_e,	4),
>> +	GROUP(i2c_ao_slave_sck,	3),
>> +	GROUP(i2c_ao_slave_sda,	3),
>> +	GROUP(remote_input_ao,	1),
>> +	GROUP(remote_out_ao,	1),
>> +	GROUP(pwm_ao_a,		3),
>> +	GROUP(pwm_ao_a_hiz,	2),
>> +	GROUP(pwm_ao_b,		3),
>> +	GROUP(pwm_ao_c_4,	3),
>> +	GROUP(pwm_ao_c_hiz_4,	4),
>> +	GROUP(pwm_ao_c_6,	3),
>> +	GROUP(pwm_ao_d_5,	3),
>> +	GROUP(pwm_ao_d_10,	3),
>> +	GROUP(pwm_ao_d_e,	3),
>> +	GROUP(jtag_a_tdi,	1),
>> +	GROUP(jtag_a_tdo,	1),
>> +	GROUP(jtag_a_clk,	1),
>> +	GROUP(jtag_a_tms,	1),
>> +	GROUP(cec_ao_a,		1),
>> +	GROUP(cec_ao_b,		2),
>> +	GROUP(tsin_a_sop_ao,	4),
>> +	GROUP(tsin_a_din0_ao,	4),
>> +	GROUP(tsin_a_clk_ao,	4),
>> +	GROUP(tsin_a_valid_ao,	4),
>> +	GROUP(spdif_out_ao,	4),
>> +	GROUP(tdmb_dout0_ao,	5),
>> +	GROUP(tdmb_dout1_ao,	5),
>> +	GROUP(tdmb_dout2_ao,	5),
>> +	GROUP(tdmb_fs_ao,	5),
>> +	GROUP(tdmb_sclk_ao,	5),
>> +	GROUP(tdmb_din0_ao,	6),
>> +	GROUP(tdmb_din1_ao,	6),
>> +	GROUP(tdmb_din2_ao,	6),
>> +	GROUP(tdmb_slv_fs_ao,	6),
>> +	GROUP(tdmb_slv_sclk_ao,	6),
>> +	GROUP(mclk0_ao,		5),
>> +};
>> +
>> +static const char * const gpio_periphs_groups[] = {
>> +	"GPIOZ_0", "GPIOZ_1", "GPIOZ_2", "GPIOZ_3", "GPIOZ_4",
>> +	"GPIOZ_5", "GPIOZ_6", "GPIOZ_7", "GPIOZ_8", "GPIOZ_9",
>> +	"GPIOZ_10", "GPIOZ_11", "GPIOZ_12", "GPIOZ_13", "GPIOZ_14",
>> +	"GPIOZ_15",
>> +
>> +	"GPIOH_0", "GPIOH_1", "GPIOH_2", "GPIOH_3", "GPIOH_4",
>> +	"GPIOH_5", "GPIOH_6", "GPIOH_7", "GPIOH_8",
>> +
>> +	"BOOT_0", "BOOT_1", "BOOT_2", "BOOT_3", "BOOT_4",
>> +	"BOOT_5", "BOOT_6", "BOOT_7", "BOOT_8", "BOOT_9",
>> +	"BOOT_10", "BOOT_11", "BOOT_12", "BOOT_13", "BOOT_14",
>> +	"BOOT_15",
>> +
>> +	"GPIOC_0", "GPIOC_1", "GPIOC_2", "GPIOC_3", "GPIOC_4",
>> +	"GPIOC_5", "GPIOC_6", "GPIOC_7",
>> +
>> +	"GPIOA_0", "GPIOA_1", "GPIOA_2", "GPIOA_3", "GPIOA_4",
>> +	"GPIOA_5", "GPIOA_6", "GPIOA_7", "GPIOA_8", "GPIOA_9",
>> +	"GPIOA_10", "GPIOA_11", "GPIOA_12", "GPIOA_13", "GPIOA_14",
>> +	"GPIOA_15",
>> +
>> +	"GPIOX_0", "GPIOX_1", "GPIOX_2", "GPIOX_3", "GPIOX_4",
>> +	"GPIOX_5", "GPIOX_6", "GPIOX_7", "GPIOX_8", "GPIOX_9",
>> +	"GPIOX_10", "GPIOX_11", "GPIOX_12", "GPIOX_13", "GPIOX_14",
>> +	"GPIOX_15", "GPIOX_16", "GPIOX_17", "GPIOX_18", "GPIOX_19",
>> +};
>> +
>> +static const char * const emmc_groups[] = {
>> +	"emmc_nand_d0", "emmc_nand_d1", "emmc_nand_d2",
>> +	"emmc_nand_d3", "emmc_nand_d4", "emmc_nand_d5",
>> +	"emmc_nand_d6", "emmc_nand_d7",
>> +	"emmc_clk", "emmc_cmd", "emmc_nand_ds",
>> +};
>> +
>> +static const char * const nand_groups[] = {
>> +	"emmc_nand_d0", "emmc_nand_d1", "emmc_nand_d2",
>> +	"emmc_nand_d3", "emmc_nand_d4", "emmc_nand_d5",
>> +	"emmc_nand_d6", "emmc_nand_d7",
>> +	"nand_ce0", "nand_ale", "nand_cle",
>> +	"nand_wen_clk", "nand_ren_wr", "nand_rb0",
>> +	"emmc_nand_ds", "nand_ce1",
>> +};
>> +
>> +static const char * const nor_groups[] = {
>> +	"nor_d", "nor_q", "nor_c", "nor_cs",
>> +	"nor_hold", "nor_wp",
>> +};
>> +
>> +static const char * const sdio_groups[] = {
>> +	"sdio_d0", "sdio_d1", "sdio_d2", "sdio_d3",
>> +	"sdio_cmd", "sdio_clk", "sdio_dummy",
>> +};
>> +
>> +static const char * const sdcard_groups[] = {
>> +	"sdcard_d0_c", "sdcard_d1_c", "sdcard_d2_c", "sdcard_d3_c",
>> +	"sdcard_clk_c", "sdcard_cmd_c",
>> +	"sdcard_d0_z", "sdcard_d1_z", "sdcard_d2_z", "sdcard_d3_z",
>> +	"sdcard_clk_z", "sdcard_cmd_z",
>> +};
>> +
>> +static const char * const spi0_groups[] = {
>> +	"spi0_mosi_c", "spi0_miso_c", "spi0_ss0_c", "spi0_clk_c",
>> +	"spi0_mosi_x", "spi0_miso_x", "spi0_ss0_x", "spi0_clk_x",
>> +};
>> +
>> +static const char * const spi1_groups[] = {
>> +	"spi1_mosi", "spi1_miso", "spi1_ss0", "spi1_clk",
>> +};
>> +
>> +static const char * const i2c0_groups[] = {
>> +	"i2c0_sda_c", "i2c0_sck_c",
>> +	"i2c0_sda_z0", "i2c0_sck_z1",
>> +	"i2c0_sda_z7", "i2c0_sck_z8",
>> +};
>> +
>> +static const char * const i2c1_groups[] = {
>> +	"i2c1_sda_x", "i2c1_sck_x",
>> +	"i2c1_sda_h2", "i2c1_sck_h3",
>> +	"i2c1_sda_h6", "i2c1_sck_h7",
>> +};
>> +
>> +static const char * const i2c2_groups[] = {
>> +	"i2c2_sda_x", "i2c2_sck_x",
>> +	"i2c2_sda_z", "i2c2_sck_z",
>> +};
>> +
>> +static const char * const i2c3_groups[] = {
>> +	"i2c3_sda_h", "i2c3_sck_h",
>> +	"i2c3_sda_a", "i2c3_sck_a",
>> +};
>> +
>> +static const char * const uart_a_groups[] = {
>> +	"uart_tx_a", "uart_rx_a", "uart_cts_a", "uart_rts_a",
>> +};
>> +
>> +static const char * const uart_b_groups[] = {
>> +	"uart_tx_b", "uart_rx_b",
>> +};
>> +
>> +static const char * const uart_c_groups[] = {
>> +	"uart_tx_c", "uart_rx_c", "uart_cts_c", "uart_rts_c",
>> +};
>> +
>> +static const char * const uart_ao_a_ee_groups[] = {
> 
> uart_ao_ee_a_groups
I'd prefer the old way, same as reason above

> 
>> +	"uart_ao_rx_a_c2", "uart_ao_tx_a_c3",
>> +};
>> +
>> +static const char * const iso7816_groups[] = {
>> +	"iso7816_clk_c", "iso7816_data_c",
>> +	"iso7816_clk_x", "iso7816_data_x",
>> +	"iso7816_clk_h", "iso7816_data_h",
>> +	"iso7816_clk_z", "iso7816_data_z",
>> +};
>> +
>> +static const char * const eth_groups[] = {
>> +	"eth_rxd2_rgmii", "eth_rxd3_rgmii", "eth_rgmii_tx_clk",
>> +	"eth_txd2_rgmii", "eth_txd3_rgmii", "eth_rgmii_rx_clk",
>> +	"eth_txd0", "eth_txd1", "eth_txen", "eth_mdc",
>> +	"eth_rxd0", "eth_rxd1", "eth_rx_dv", "eth_mdio",
>> +	"eth_link_led", "eth_act_led",
>> +};
>> +
>> +static const char * const pwm_a_groups[] = {
>> +	"pwm_a",
>> +};
>> +
>> +static const char * const pwm_b_groups[] = {
>> +	"pwm_b_x7", "pwm_b_x19",
>> +};
>> +
>> +static const char * const pwm_c_groups[] = {
>> +	"pwm_c_c4", "pwm_c_x5", "pwm_c_x8",
>> +};
>> +
>> +static const char * const pwm_d_groups[] = {
>> +	"pwm_d_x3", "pwm_d_x6",
>> +};
>> +
>> +static const char * const pwm_e_groups[] = {
>> +	"pwm_e",
>> +};
>> +
>> +static const char * const pwm_f_groups[] = {
>> +	"pwm_f_x", "pwm_f_h",
>> +};
>> +
>> +static const char * const cec_ao_ee_groups[] = {
>> +	"cec_ao_a_ee", "cec_ao_b_ee",
>> +};
>> +
>> +static const char * const jtag_b_groups[] = {
>> +	"jtag_b_tdi", "jtag_b_tdo", "jtag_b_clk", "jtag_b_tms",
>> +};
>> +
>> +static const char * const bt565_groups[] = {
>> +	"bt565_a_vs", "bt565_a_hs", "bt565_a_clk",
>> +	"bt565_a_din0", "bt565_a_din1", "bt565_a_din2",
>> +	"bt565_a_din3", "bt565_a_din4", "bt565_a_din5",
>> +	"bt565_a_din6", "bt565_a_din7",
>> +};
>> +
>> +static const char * const tsin_a_groups[] = {
>> +	"tsin_a_valid", "tsin_a_sop", "tsin_a_din0",
>> +	"tsin_a_clk",
>> +};
>> +
>> +static const char * const tsin_b_groups[] = {
>> +	"tsin_b_valid_x", "tsin_b_sop_x", "tsin_b_din0_x", "tsin_b_clk_x",
>> +	"tsin_b_valid_z", "tsin_b_sop_z", "tsin_b_din0_z", "tsin_b_clk_z",
>> +	"tsin_b_fail", "tsin_b_din1", "tsin_b_din2", "tsin_b_din3",
>> +	"tsin_b_din4", "tsin_b_din5", "tsin_b_din6", "tsin_b_din7",
>> +};
>> +
>> +static const char * const hdmitx_groups[] = {
>> +	"hdmitx_sda", "hdmitx_sck", "hdmitx_hpd_in",
>> +};
>> +
>> +static const char * const pdm_groups[] = {
>> +	"pdm_din0_c", "pdm_din1_c", "pdm_din2_c", "pdm_din3_c",
>> +	"pdm_dclk_c",
>> +	"pdm_din0_x", "pdm_din1_x", "pdm_din2_x", "pdm_din3_x",
>> +	"pdm_dclk_x",
>> +	"pdm_din0_z", "pdm_din1_z", "pdm_din2_z", "pdm_din3_z",
>> +	"pdm_dclk_z",
>> +	"pdm_din0_a", "pdm_din1_a", "pdm_din2_a", "pdm_din3_a",
>> +	"pdm_dclk_a",
>> +};
>> +
>> +static const char * const spdif_in_groups[] = {
>> +	"spdif_in_h", "spdif_in_a10", "spdif_in_a12",
>> +};
>> +
>> +static const char * const spdif_out_groups[] = {
>> +	"spdif_out_h", "spdif_out_a11", "spdif_out_a13",
>> +};
>> +
>> +static const char * const mclk0_groups[] = {
>> +	"mclk0_a",
>> +};
>> +
>> +static const char * const mclk1_groups[] = {
>> +	"mclk1_x", "mclk1_z", "mclk1_a",
>> +};
>> +
>> +static const char * const tdma_in_groups[] = {
>> +	"tdma_slv_sclk", "tdma_slv_fs", "tdma_din0", "tdma_din1",
>> +	"tdma_sclk", "tdma_fs",
>> +};
>> +
>> +static const char * const tdma_out_groups[] = {
>> +	"tdma_sclk", "tdma_fs", "tdma_dout0", "tdma_dout1",
>> +	"tdma_slv_sclk", "tdma_slv_fs",
>> +};
> 
> merge above groups
comment in tdm

> 
>> +
>> +static const char * const tdmb_in_groups[] = {
>> +	"tdmb_slv_sclk", "tdmb_slv_fs", "tdmb_din0", "tdmb_din1",
>> +	"tdmb_din2", "tdmb_din3_a", "tdmb_din3_h",
>> +	"tdmb_sclk", "tdmb_fs",
>> +};
>> +
>> +static const char * const tdmb_out_groups[] = {
>> +	"tdmb_sclk", "tdmb_fs", "tdmb_dout0", "tdmb_dout1",
>> +	"tdmb_dout2", "tdmb_dout3_a", "tdmb_dout3_h",
>> +	"tdmb_slv_sclk", "tdmb_slv_fs",
>> +};
> 
>  
> same here
comment in tdm

> 
>> +
>> +static const char * const tdmc_in_groups[] = {
>> +	"tdmc_slv_sclk_a", "tdmc_slv_fs_a", "tdmc_din0_a", "tdmc_din1_a",
>> +	"tdmc_din2_a", "tdmc_din3_a", "tdmc_sclk_a", "tdmc_fs_a",
>> +	"tdmc_slv_sclk_z", "tdmc_slv_fs_z", "tdmc_din0_z", "tdmc_din1_z",
>> +	"tdmc_din2_z", "tdmc_din3_z", "tdmc_sclk_z", "tdmc_fs_z",
>> +};
>> +
>> +static const char * const tdmc_out_groups[] = {
>> +	"tdmc_sclk_a", "tdmc_fs_a", "tdmc_dout0_a", "tdmc_dout1_a",
>> +	"tdmc_dout2_a", "tdmc_dout3_a", "tdmc_slv_sclk_a", "tdmc_slv_fs_a",
>> +	"tdmc_sclk_z", "tdmc_fs_z", "tdmc_dout0_z", "tdmc_dout1_z",
>> +	"tdmc_dout2_z", "tdmc_dout3_z", "tdmc_slv_sclk_z", "tdmc_slv_fs_z",
>> +};
> 
> same here
comment in tdm


> 
>> +
>> +static const char * const gpio_aobus_groups[] = {
>> +	"GPIOAO_0", "GPIOAO_1", "GPIOAO_2", "GPIOAO_3", "GPIOAO_4",
>> +	"GPIOAO_5", "GPIOAO_6", "GPIOAO_7", "GPIOAO_8", "GPIOAO_9",
>> +	"GPIOAO_10", "GPIOAO_11", "GPIOE_0", "GPIOE_1", "GPIOE_2",
>> +};
>> +
>> +static const char * const uart_ao_a_groups[] = {
>> +	"uart_ao_tx_a", "uart_ao_rx_a",
>> +	"uart_ao_cts_a", "uart_ao_rts_a",
>> +};
>> +
>> +static const char * const uart_ao_b_groups[] = {
>> +	"uart_ao_tx_b_2", "uart_ao_rx_b_3",
>> +	"uart_ao_tx_b_8", "uart_ao_rx_b_9",
>> +	"uart_ao_cts_b", "uart_ao_rts_b",
>> +};
>> +
>> +static const char * const i2c_ao_groups[] = {
>> +	"i2c_ao_sck", "i2c_ao_sda",
>> +	"i2c_ao_sck_e", "i2c_ao_sda_e",
>> +};
>> +
>> +static const char * const i2c_ao_slave_groups[] = {
>> +	"i2c_ao_slave_sck", "i2c_ao_slave_sda",
>> +};
>> +
>> +static const char * const remote_input_ao_groups[] = {
>> +	"remote_input_ao",
>> +};
>> +
>> +static const char * const remote_out_ao_groups[] = {
>> +	"remote_out_ao",
>> +};
>> +
>> +static const char * const pwm_ao_a_groups[] = {
>> +	"pwm_ao_a", "pwm_ao_a_hiz",
>> +};
>> +
>> +static const char * const pwm_ao_b_groups[] = {
>> +	"pwm_ao_b",
>> +};
>> +
>> +static const char * const pwm_ao_c_groups[] = {
>> +	"pwm_ao_c_4", "pwm_ao_c_hiz_4",
>> +	"pwm_ao_c_6",
>> +};
>> +
>> +static const char * const pwm_ao_d_groups[] = {
>> +	"pwm_ao_d_5", "pwm_ao_d_10", "pwm_ao_d_e",
>> +};
>> +
>> +static const char * const jtag_a_groups[] = {
>> +	"jtag_a_tdi", "jtag_a_tdo", "jtag_a_clk", "jtag_a_tms",
>> +};
>> +
>> +static const char * const cec_ao_groups[] = {
>> +	"cec_ao_a", "cec_ao_b",
>> +};
>> +
>> +static const char * const tsin_a_ao_groups[] = {
>> +	"tsin_a_sop_ao", "tsin_a_din0_ao", "tsin_a_clk_ao", "tsin_a_valid_ao",
>> +};
>> +
>> +static const char * const spdif_out_ao_groups[] = {
>> +	"spdif_out_ao",
>> +};
>> +
>> +static const char * const tdmb_out_ao_groups[] = {
>> +	"tdmb_dout0_ao", "tdmb_dout1_ao", "tdmb_dout2_ao",
>> +	"tdmb_fs_ao", "tdmb_sclk_ao",
>> +};
>> +
>> +static const char * const tdmb_in_ao_groups[] = {
>> +	"tdmb_din0_ao", "tdmb_din1_ao", "tdmb_din2_ao",
>> +	"tdmb_slv_fs_ao", "tdmb_slv_sclk_ao",
>> +};
> 
> same here
> 
comment in tdm

>> +
>> +static const char * const mclk0_ao_groups[] = {
>> +	"mclk0_ao",
>> +};
>> +
>> +static struct meson_pmx_func meson_g12a_periphs_functions[] = {
>> +	FUNCTION(gpio_periphs),
>> +	FUNCTION(emmc),
>> +	FUNCTION(nor),
>> +	FUNCTION(spi0),
>> +	FUNCTION(spi1),
>> +	FUNCTION(sdio),
>> +	FUNCTION(nand),
>> +	FUNCTION(sdcard),
>> +	FUNCTION(i2c0),
>> +	FUNCTION(i2c1),
>> +	FUNCTION(i2c2),
>> +	FUNCTION(i2c3),
>> +	FUNCTION(uart_a),
>> +	FUNCTION(uart_b),
>> +	FUNCTION(uart_c),
>> +	FUNCTION(uart_ao_a_ee),
>> +	FUNCTION(iso7816),
>> +	FUNCTION(eth),
>> +	FUNCTION(pwm_a),
>> +	FUNCTION(pwm_b),
>> +	FUNCTION(pwm_c),
>> +	FUNCTION(pwm_d),
>> +	FUNCTION(pwm_e),
>> +	FUNCTION(pwm_f),
>> +	FUNCTION(cec_ao_ee),
>> +	FUNCTION(jtag_b),
>> +	FUNCTION(bt565),
>> +	FUNCTION(tsin_a),
>> +	FUNCTION(tsin_b),
>> +	FUNCTION(hdmitx),
>> +	FUNCTION(pdm),
>> +	FUNCTION(spdif_out),
>> +	FUNCTION(spdif_in),
>> +	FUNCTION(mclk0),
>> +	FUNCTION(mclk1),
>> +	FUNCTION(tdma_in),
>> +	FUNCTION(tdma_out),
>> +	FUNCTION(tdmb_in),
>> +	FUNCTION(tdmb_out),
>> +	FUNCTION(tdmc_in),
>> +	FUNCTION(tdmc_out),
>> +};
>> +
>> +static struct meson_pmx_func meson_g12a_aobus_functions[] = {
>> +	FUNCTION(gpio_aobus),
>> +	FUNCTION(uart_ao_a),
>> +	FUNCTION(uart_ao_b),
>> +	FUNCTION(i2c_ao),
>> +	FUNCTION(i2c_ao_slave),
>> +	FUNCTION(remote_input_ao),
>> +	FUNCTION(remote_out_ao),
>> +	FUNCTION(pwm_ao_a),
>> +	FUNCTION(pwm_ao_b),
>> +	FUNCTION(pwm_ao_c),
>> +	FUNCTION(pwm_ao_d),
>> +	FUNCTION(jtag_a),
>> +	FUNCTION(cec_ao),
>> +	FUNCTION(tsin_a_ao),
>> +	FUNCTION(spdif_out_ao),
>> +	FUNCTION(tdmb_out_ao),
>> +	FUNCTION(tdmb_in_ao),
>> +	FUNCTION(mclk0_ao),
>> +};
>> +
>> +static struct meson_bank meson_g12a_periphs_banks[] = {
>> +	/* name  first  last  irq  pullen  pull  dir  out  in */
>> +	BANK("Z",    GPIOZ_0,    GPIOZ_15, 12, 27,
>> +	     4,  0,  4,  0,  12,  0,  13, 0,  14, 0),
>> +	BANK("H",    GPIOH_0,    GPIOH_8, 28, 36,
>> +	     3,  0,  3,  0,  9,  0,  10,  0,  11,  0),
>> +	BANK("BOOT", BOOT_0,     BOOT_15,  37, 52,
>> +	     0,  0,  0,  0,  0, 0,  1, 0,  2, 0),
>> +	BANK("C",    GPIOC_0,    GPIOC_7,  53, 60,
>> +	     1,  0,  1,  0,  3, 0,  4, 0,  5, 0),
>> +	BANK("A",    GPIOA_0,    GPIOA_15,  61, 76,
>> +	     5,  0,  5,  0,  16,  0,  17,  0,  18,  0),
>> +	BANK("X",    GPIOX_0,    GPIOX_19,   77, 96,
>> +	     2,  0,  2,  0,  6,  0,  7,  0,  8,  0),
>> +};
>> +
>> +static struct meson_bank meson_g12a_aobus_banks[] = {
>> +	/* name  first  last  irq  pullen  pull  dir  out  in  */
>> +	BANK("AO",   GPIOAO_0,  GPIOAO_11,  0, 11,
>> +	     3,  0,  2, 0,  0,  0,  4, 0,  1,  0),
>> +	/* GPIOE actually located in the AO bank */
>> +	BANK("E",   GPIOE_0,  GPIOE_2,   97, 99,
>> +	     3,  16,  2, 16,  0,  16,  4, 16,  1,  16),
>> +};
>> +
>> +static struct meson_pmx_bank meson_g12a_periphs_pmx_banks[] = {
>> +	/*	 name	 first		lask	   reg	offset  */
>> +	BANK_PMX("Z",    GPIOZ_0, GPIOZ_15, 0x6, 0),
>> +	BANK_PMX("H",    GPIOH_0, GPIOH_8,  0xb, 0),
>> +	BANK_PMX("BOOT", BOOT_0,  BOOT_15,  0x0, 0),
>> +	BANK_PMX("C",    GPIOC_0, GPIOC_7,  0x9, 0),
>> +	BANK_PMX("A",    GPIOA_0, GPIOA_15, 0xd, 0),
>> +	BANK_PMX("X",    GPIOX_0, GPIOX_19, 0x3, 0),
>> +};
>> +
>> +static struct meson_axg_pmx_data meson_g12a_periphs_pmx_banks_data = {
>> +	.pmx_banks	= meson_g12a_periphs_pmx_banks,
>> +	.num_pmx_banks	= ARRAY_SIZE(meson_g12a_periphs_pmx_banks),
>> +};
>> +
>> +static struct meson_pmx_bank meson_g12a_aobus_pmx_banks[] = {
>> +	BANK_PMX("AO", GPIOAO_0, GPIOAO_11, 0x0, 0),
>> +	BANK_PMX("E", GPIOE_0, GPIOE_2, 0x1, 16),
>> +};
>> +
>> +static struct meson_axg_pmx_data meson_g12a_aobus_pmx_banks_data = {
>> +	.pmx_banks	= meson_g12a_aobus_pmx_banks,
>> +	.num_pmx_banks	= ARRAY_SIZE(meson_g12a_aobus_pmx_banks),
>> +};
>> +
>> +static struct meson_pinctrl_data meson_g12a_periphs_pinctrl_data = {
>> +	.name		= "periphs-banks",
>> +	.pins		= meson_g12a_periphs_pins,
>> +	.groups		= meson_g12a_periphs_groups,
>> +	.funcs		= meson_g12a_periphs_functions,
>> +	.banks		= meson_g12a_periphs_banks,
>> +	.num_pins	= ARRAY_SIZE(meson_g12a_periphs_pins),
>> +	.num_groups	= ARRAY_SIZE(meson_g12a_periphs_groups),
>> +	.num_funcs	= ARRAY_SIZE(meson_g12a_periphs_functions),
>> +	.num_banks	= ARRAY_SIZE(meson_g12a_periphs_banks),
>> +	.pmx_ops	= &meson_axg_pmx_ops,
>> +	.pmx_data	= &meson_g12a_periphs_pmx_banks_data,
>> +};
>> +
>> +static struct meson_pinctrl_data meson_g12a_aobus_pinctrl_data = {
>> +	.name		= "aobus-banks",
>> +	.pins		= meson_g12a_aobus_pins,
>> +	.groups		= meson_g12a_aobus_groups,
>> +	.funcs		= meson_g12a_aobus_functions,
>> +	.banks		= meson_g12a_aobus_banks,
>> +	.num_pins	= ARRAY_SIZE(meson_g12a_aobus_pins),
>> +	.num_groups	= ARRAY_SIZE(meson_g12a_aobus_groups),
>> +	.num_funcs	= ARRAY_SIZE(meson_g12a_aobus_functions),
>> +	.num_banks	= ARRAY_SIZE(meson_g12a_aobus_banks),
>> +	.pmx_ops	= &meson_axg_pmx_ops,
>> +	.pmx_data	= &meson_g12a_aobus_pmx_banks_data,
>> +};
>> +
>> +static const struct of_device_id meson_g12a_pinctrl_dt_match[] = {
>> +	{
>> +		.compatible = "amlogic,meson-g12a-periphs-pinctrl",
>> +		.data = &meson_g12a_periphs_pinctrl_data,
>> +	},
>> +	{
>> +		.compatible = "amlogic,meson-g12a-aobus-pinctrl",
>> +		.data = &meson_g12a_aobus_pinctrl_data,
>> +	},
>> +	{ },
>> +};
>> +
>> +static struct platform_driver meson_g12a_pinctrl_driver = {
>> +	.probe  = meson_pinctrl_probe,
>> +	.driver = {
>> +		.name	= "meson-g12a-pinctrl",
>> +		.of_match_table = meson_g12a_pinctrl_dt_match,
>> +	},
>> +};
>> +
>> +builtin_platform_driver(meson_g12a_pinctrl_driver);
> 
> .
> 

