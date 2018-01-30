Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753082AbeA3PWt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 10:22:49 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:15021 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751678AbeA3PWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 10:22:46 -0500
From: Gabriel FERNANDEZ <gabriel.fernandez@st.com>
To: Rob Herring <robh@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Nicolas Pitre <nico@linaro.org>,
        "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        Philippe CORNU <philippe.cornu@st.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "gabriel.fernandez.st@gmail.com" <gabriel.fernandez.st@gmail.com>
Subject: Re: [PATCH 2/2] clk: stm32: Add DSI clock for STM32F469 Board
Thread-Topic: [PATCH 2/2] clk: stm32: Add DSI clock for STM32F469 Board
Thread-Index: AQHTkGuZUGeG6BMQgkSbvIMvtiza56OLNBwAgAFWgQA=
Date: Tue, 30 Jan 2018 15:22:16 +0000
Message-ID: <df882957-9d04-cda8-abd4-0b731ffa62d3@st.com>
References: <1516286980-8603-1-git-send-email-gabriel.fernandez@st.com>
 <1516286980-8603-3-git-send-email-gabriel.fernandez@st.com>
 <20180129185624.zesocq2siiikwnog@rob-hp-laptop>
In-Reply-To: <20180129185624.zesocq2siiikwnog@rob-hp-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="utf-8"
Content-ID: <18E21C1388473A46841D89185BBFA011@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-01-30_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w0UFMtcv018418

Hi Rob,

Thanks for reviewing.


On 01/29/2018 07:56 PM, Rob Herring wrote:
> On Thu, Jan 18, 2018 at 03:49:40PM +0100, gabriel.fernandez@st.com wrote:
>> From: Gabriel Fernandez <gabriel.fernandez@st.com>
>>
>> This patch adds DSI clock for STM32F469 board
>>
>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
>> ---
>>   drivers/clk/clk-stm32f4.c                 | 11 ++++++++++-
>>   include/dt-bindings/clock/stm32fx-clock.h |  3 ++-
>>   2 files changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
>> index da44f8d..3c28798 100644
>> --- a/drivers/clk/clk-stm32f4.c
>> +++ b/drivers/clk/clk-stm32f4.c
>> @@ -521,7 +521,7 @@ struct stm32f4_pll_data {
>>   };
>>   
>>   static const struct stm32f4_pll_data stm32f469_pll[MAX_PLL_DIV] = {
>> -	{ PLL,	   50, { "pll",	     "pll-q",    NULL	    } },
>> +	{ PLL,	   50, { "pll",	     "pll-q",    "pll-r"    } },
>>   	{ PLL_I2S, 50, { "plli2s-p", "plli2s-q", "plli2s-r" } },
>>   	{ PLL_SAI, 50, { "pllsai-p", "pllsai-q", "pllsai-r" } },
>>   };
>> @@ -1047,6 +1047,8 @@ static struct clk_hw *stm32_register_cclk(struct device *dev, const char *name,
>>   	"no-clock", "lse", "lsi", "hse-rtc"
>>   };
>>   
>> +static const char *dsi_parent[2] = { NULL, "pll-r" };
>> +
>>   static const char *lcd_parent[1] = { "pllsai-r-div" };
>>   
>>   static const char *i2s_parents[2] = { "plli2s-r", NULL };
>> @@ -1156,6 +1158,12 @@ struct stm32f4_clk_data {
>>   		NO_GATE, 0,
>>   		0
>>   	},
>> +	{
>> +		CLK_F469_DSI, "dsi", dsi_parent, ARRAY_SIZE(dsi_parent),
>> +		STM32F4_RCC_DCKCFGR, 29, 1,
>> +		STM32F4_RCC_APB2ENR, 27,
>> +		CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT
>> +	},
>>   };
>>   
>>   static const struct stm32_aux_clk stm32f746_aux_clk[] = {
>> @@ -1450,6 +1458,7 @@ static void __init stm32f4_rcc_init(struct device_node *np)
>>   	stm32f4_gate_map = data->gates_map;
>>   
>>   	hse_clk = of_clk_get_parent_name(np, 0);
>> +	dsi_parent[0] = hse_clk;
>>   
>>   	i2s_in_clk = of_clk_get_parent_name(np, 1);
>>   
>> diff --git a/include/dt-bindings/clock/stm32fx-clock.h b/include/dt-bindings/clock/stm32fx-clock.h
>> index 4d523b0..58d8b51 100644
>> --- a/include/dt-bindings/clock/stm32fx-clock.h
>> +++ b/include/dt-bindings/clock/stm32fx-clock.h
>> @@ -35,8 +35,9 @@
>>   #define CLK_SAIQ_PDIV		13
>>   #define CLK_HSI			14
>>   #define CLK_SYSCLK		15
>> +#define CLK_F469_DSI		16
>>   
>> -#define END_PRIMARY_CLK		16
>> +#define END_PRIMARY_CLK		17
>>   
>>   #define CLK_HDMI_CEC		16
>>   #define CLK_SPDIF		17
> This looks suspicious. What's the relationship of these clocks?
I have just added CLK_F469_DSI in the binding, and shifted the end of 
primary clock for F4 clocks.

'CLK_F469_DSI' binding is only used for STM32F469 and not for STM32F746 
(that why CLK_HDMI_CEC can use the index 16)


BR

Gabriel.
>
> Rob
