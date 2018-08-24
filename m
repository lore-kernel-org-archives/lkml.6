Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEBEC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 164C5208FE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:34:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 164C5208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbeHXRJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 13:09:09 -0400
Received: from mail-sz2.amlogic.com ([211.162.65.114]:10424 "EHLO
        mail-sz2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbeHXRJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 13:09:09 -0400
Received: from [10.28.16.194] (10.28.16.194) by mail-sz2.amlogic.com
 (10.28.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Fri, 24 Aug
 2018 21:34:26 +0800
Subject: Re: [PATCH 2/2] clk: meson-g12a: Add AO Clock controller driver
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        "Rob Herring" <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        <linux-clk@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1533894868-85815-1-git-send-email-jian.hu@amlogic.com>
 <1533894868-85815-3-git-send-email-jian.hu@amlogic.com>
 <6c855dc62fe6ed1a01216bd708d401a280f8762c.camel@baylibre.com>
From:   Jian Hu <jian.hu@amlogic.com>
Message-ID: <fff1f982-c9f3-8aa4-b108-6c0998827e79@amlogic.com>
Date:   Fri, 24 Aug 2018 21:34:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <6c855dc62fe6ed1a01216bd708d401a280f8762c.camel@baylibre.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.16.194]
X-ClientProxiedBy: mail-sz2.amlogic.com (10.28.11.6) To mail-sz2.amlogic.com
 (10.28.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi: Jerome

Please see my commits.

On 2018/8/14 20:40, Jerome Brunet wrote:
> On Fri, 2018-08-10 at 17:54 +0800, Jian Hu wrote:
>> Add a Clock driver for the ALways-On part
>> of the Amlogic Meson-G12A SoC.
>>
>> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
>> ---
>>   drivers/clk/meson/Makefile     |   2 +-
>>   drivers/clk/meson/g12a-aoclk.c | 170 +++++++++++++++++++++++++++++++++++++++++
>>   drivers/clk/meson/g12a-aoclk.h |  36 +++++++++
>>   3 files changed, 207 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/clk/meson/g12a-aoclk.c
>>   create mode 100644 drivers/clk/meson/g12a-aoclk.h
>>
>> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
>> index 2b1a562..d5c2dcd 100644
>> --- a/drivers/clk/meson/Makefile
>> +++ b/drivers/clk/meson/Makefile
>> @@ -9,5 +9,5 @@ obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
>>   obj-$(CONFIG_COMMON_CLK_GXBB)	 += gxbb.o gxbb-aoclk.o gxbb-aoclk-32k.o
>>   obj-$(CONFIG_COMMON_CLK_AXG)	 += axg.o axg-aoclk.o
>>   obj-$(CONFIG_COMMON_CLK_AXG_AUDIO)	+= axg-audio.o
>> -obj-$(CONFIG_COMMON_CLK_G12A)	 += g12a.o
>> +obj-$(CONFIG_COMMON_CLK_G12A)	 += g12a.o g12a-aoclk.c
>>   obj-$(CONFIG_COMMON_CLK_REGMAP_MESON)	+= clk-regmap.o
>> diff --git a/drivers/clk/meson/g12a-aoclk.c b/drivers/clk/meson/g12a-aoclk.c
>> new file mode 100644
>> index 0000000..a5cd95c
>> --- /dev/null
>> +++ b/drivers/clk/meson/g12a-aoclk.c
>> @@ -0,0 +1,170 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Amlogic Meson-G12A Clock Controller Driver
>> + *
>> + * Copyright (c) 2016 Baylibre SAS.
>> + * Author: Michael Turquette <mturquette@baylibre.com>
>> + *
>> + * Copyright (c) 2018 Amlogic, inc.
>> + * Author: Jian Hu <jian.hu@amlogic.com>
>> + */
>> +#include <linux/clk-provider.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/reset-controller.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/init.h>
>> +#include "clkc.h"
>> +#include "g12a-aoclk.h"
>> +
>> +#define G12A_AO_GATE0(_name, _bit)					\
>> +static struct clk_regmap _name##_ao = {					\
>> +	.data = &(struct clk_regmap_gate_data) {			\
>> +		.offset = (AO_CLK_GATE0),			\
>> +		.bit_idx = (_bit),					\
>> +	},								\
>> +	.hw.init = &(struct clk_init_data) {				\
>> +		.name = #_name "_ao",					\
>> +		.ops = &clk_regmap_gate_ops,				\
>> +		.parent_names = (const char *[]){ "clk81" },		\
>> +		.num_parents = 1,					\
>> +	},								\
>> +}
>> +
>> +G12A_AO_GATE0(ahb_bus,		0);
>> +G12A_AO_GATE0(remote,		1);
>> +G12A_AO_GATE0(i2c_master,	2);
>> +G12A_AO_GATE0(i2c_slave,	3);
>> +G12A_AO_GATE0(uart1,		4);
>> +G12A_AO_GATE0(prod_i2c,		5);
>> +G12A_AO_GATE0(uart2,		6);
>> +G12A_AO_GATE0(ir_blaster,	7);
>> +G12A_AO_GATE0(saradc,		8);
>> +
>> +static struct clk_regmap ao_clk81 = {
>> +	.data = &(struct clk_regmap_mux_data) {
>> +		.offset = AO_RTI_PWR_CNTL_REG0,
>> +		.mask = 0x1,
>> +		.shift = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "ao_clk81",
>> +		.ops = &clk_regmap_mux_ro_ops,
>> +		.parent_names = (const char *[]){ "clk81", "ao_alt_xtal"},
> 
> I think it is time we stop taking clock input from nowhere.
> With the addition of the axg audio clock controller, there is now an example of
> how do so.
> 
> This clock controller apparently has 3 inputs:
> * xtal
> * ao_xtal
> * clk_81
> 
> I'd like to see that appear this DT bindings and the probe function
> 
> Same goes for the EE controller which should only take the xtal.
> 

I am confued about aoclk81's parent clocks.

I can not get the example of axg audio clock driver, Could you provide 
the link? Had it merged into clk-meson.git?

my local latest commit is:

commit cd2b3132bd7e84dc6a739fef73e5b5c3f2b3a0bb
Author: Jerome Brunet <jbrunet@baylibre.com>
Date:   Wed Aug 1 16:00:53 2018 +0200

     clk: meson: clk-pll: drop hard-coded rates from pll tables

     Putting hard-coded rates inside the parameter tables assumes that
     the parent is known and will never change. That's a big assumption
     we should not make.

     We have everything we need to recalculate the output rate using
     the parent rate and the rest of the parameters. Let's do so and
     drop the rates from the tables.

     Acked-by: Neil Armstrong <narmstrong@baylibre.com>
     Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

>> +		.num_parents = 2,
>> +	},
>> +};
>> +
>> +static struct clk_regmap g12a_saradc_mux = {
>> +	.data = &(struct clk_regmap_mux_data) {
>> +		.offset = AO_SAR_CLK,
>> +		.mask = 0x3,
>> +		.shift = 9,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "g12a_saradc_mux",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_names = (const char *[]){ "xtal", "ao_clk81" },
>> +		.num_parents = 2,
>> +	},
>> +};
>> +
>> +static struct clk_regmap g12a_saradc_div = {
>> +	.data = &(struct clk_regmap_div_data) {
>> +		.offset = AO_SAR_CLK,
>> +		.shift = 0,
>> +		.width = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "g12a_saradc_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_names = (const char *[]){ "g12a_saradc_mux" },
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap g12a_saradc_gate = {
>> +	.data = &(struct clk_regmap_gate_data) {
>> +		.offset = AO_SAR_CLK,
>> +		.bit_idx = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "g12a_saradc_gate",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_names = (const char *[]){ "g12a_saradc_div" },
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static unsigned int g12a_aoclk_reset[] = {
>> +	[RESET_AO_REMOTE] =	16,
>> +	[RESET_AO_UART1] =	17,
>> +	[RESET_AO_I2C_MASTER] = 18,
>> +	[RESET_AO_I2C_SLAVE] =	19,
>> +	[RESET_AO_SARADC] =	20,
>> +	[RESET_AO_UART2] =	22,
>> +	[RESET_AO_IR_BLASTER] = 23,
>> +};
>> +
>> +static struct clk_regmap *g12a_aoclk_regmap[] = {
>> +	[CLKID_AO_AHB_BUS]	= &ahb_bus_ao,
>> +	[CLKID_AO_REMOTE]	= &remote_ao,
>> +	[CLKID_AO_I2C_MASTER]	= &i2c_master_ao,
>> +	[CLKID_AO_I2C_SLAVE]	= &i2c_slave_ao,
>> +	[CLKID_AO_UART1]	= &uart1_ao,
>> +	[CLKID_AO_PROD_I2C]	= &prod_i2c_ao,
>> +	[CLKID_AO_UART2]	= &uart2_ao,
>> +	[CLKID_AO_IR_BLASTER]	= &ir_blaster_ao,
>> +	[CLKID_AO_SAR_ADC]	= &saradc_ao,
>> +	[CLKID_AO_CLK81]	= &ao_clk81,
>> +	[CLKID_AO_SAR_ADC_SEL]	= &g12a_saradc_mux,
>> +	[CLKID_AO_SAR_ADC_DIV]	= &g12a_saradc_div,
>> +	[CLKID_AO_SAR_ADC_CLK]	= &g12a_saradc_gate,
> 
> Please be consistent while naming the clock, either prefix all with g12a, or
> none.
> 
OK, I will add g12a prefix to be consistent with other clocks
>> +};
>> +
>> +static struct clk_hw_onecell_data g12a_aoclk_onecell_data = {
>> +	.hws = {
>> +		[CLKID_AO_AHB_BUS]	= &ahb_bus_ao.hw,
>> +		[CLKID_AO_REMOTE]	= &remote_ao.hw,
>> +		[CLKID_AO_I2C_MASTER]	= &i2c_master_ao.hw,
>> +		[CLKID_AO_I2C_SLAVE]	= &i2c_slave_ao.hw,
>> +		[CLKID_AO_UART1]	= &uart1_ao.hw,
>> +		[CLKID_AO_PROD_I2C]	= &prod_i2c_ao.hw,
>> +		[CLKID_AO_UART2]	= &uart2_ao.hw,
>> +		[CLKID_AO_IR_BLASTER]	= &ir_blaster_ao.hw,
>> +		[CLKID_AO_SAR_ADC]	= &saradc_ao.hw,
>> +		[CLKID_AO_CLK81]	= &ao_clk81.hw,
>> +		[CLKID_AO_SAR_ADC_SEL]	= &g12a_saradc_mux.hw,
>> +		[CLKID_AO_SAR_ADC_DIV]	= &g12a_saradc_div.hw,
>> +		[CLKID_AO_SAR_ADC_CLK]	= &g12a_saradc_gate.hw,
>> +	},
>> +	.num = NR_CLKS,
>> +};
>> +
>> +static struct meson_aoclk_data g12a_aoclkc_data = {
>> +	.reset_reg	= AO_RTI_GEN_CNTL_REG0,
>> +	.num_reset	= ARRAY_SIZE(g12a_aoclk_reset),
>> +	.reset		= g12a_aoclk_reset,
>> +	.num_clks	= ARRAY_SIZE(g12a_aoclk_regmap),
>> +	.clks		= g12a_aoclk_regmap,
>> +	.hw_data	= &g12a_aoclk_onecell_data,
>> +};
>> +
>> +static const struct of_device_id g12a_aoclkc_match_table[] = {
>> +	{
>> +		.compatible	= "amlogic,g12a-aoclkc",
>> +		.data		= &g12a_aoclkc_data,
>> +	},
>> +	{ }
>> +};
>> +
>> +static struct platform_driver g12a_aoclkc_driver = {
>> +	.probe		= meson_aoclkc_probe,
>> +	.driver		= {
>> +		.name	= "g12a-aoclkc",
>> +		.of_match_table = g12a_aoclkc_match_table,
>> +	},
>> +};
>> +
>> +builtin_platform_driver(g12a_aoclkc_driver);
>> diff --git a/drivers/clk/meson/g12a-aoclk.h b/drivers/clk/meson/g12a-aoclk.h
>> new file mode 100644
>> index 0000000..007183e
>> --- /dev/null
>> +++ b/drivers/clk/meson/g12a-aoclk.h
>> @@ -0,0 +1,36 @@
>> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
>> +/*
>> + * Copyright (c) 2017 BayLibre, SAS
>> + * Author: Neil Armstrong <narmstrong@baylibre.com>
>> + *
>> + * Copyright (c) 2018 Amlogic, inc.
>> + * Author: Jian Hu <Jian.Hu@amlogic.com>
>> + */
>> +
>> +#ifndef __G12A_AOCLKC_H
>> +#define __G12A_AOCLKC_H
>> +
>> +//#include "meson-aoclk.h"
> 
> ??? Do you need this or not ?
> It is useless,I will delete it, Thanks for review.
>> +
>> +#define NR_CLKS				14
>> +
>> +/* AO Configuration Clock registers offsets
>> + * Register offsets from the data sheet must be multiplied by 4.
>> + */
>> +#define AO_RTI_PWR_CNTL_REG0		0x10
>> +#define AO_RTI_GEN_CNTL_REG0		0x40
>> +#define AO_OSCIN_CNTL			0x58
>> +#define AO_CRT_CLK_CNTL1		0x68
>> +#define AO_SAR_CLK			0x90
>> +#define AO_RTC_ALT_CLK_CNTL0		0x94
>> +#define AO_RTC_ALT_CLK_CNTL1		0x98
>> +
>> +/*
>> + *AO CLK81 gate clocks
>> + */
>> +#define AO_CLK_GATE0			0x4c
>> +
>> +#include <dt-bindings/clock/g12a-aoclkc.h>
>> +#include <dt-bindings/reset/g12a-aoclkc.h>
>> +
>> +#endif /* __G12A_AOCLKC_H */
> 
> 
> .
> 
