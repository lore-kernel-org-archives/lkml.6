Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752608AbeC0MgF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 08:36:05 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:33562 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752567AbeC0MgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 08:36:02 -0400
Subject: Re: [PATCH 3/3] ARM64: dts: meson: fix clock source of the pclk for
 UART_AO
To: Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
References: <20180326081809.49493-1-yixun.lan@amlogic.com>
 <20180326081809.49493-4-yixun.lan@amlogic.com>
 <1522142450.2632.41.camel@baylibre.com>
CC: <yixun.lan@amlogic.com>, Rob Herring <robh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
From: Yixun Lan <yixun.lan@amlogic.com>
Message-ID: <23c2d3bd-9c3e-2a3f-eb1f-2657c6920738@amlogic.com>
Date: Tue, 27 Mar 2018 20:35:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <1522142450.2632.41.camel@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [61.173.93.211]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/27/2018 05:20 PM, Jerome Brunet wrote:
> On Mon, 2018-03-26 at 16:18 +0800, Yixun Lan wrote:
>> From the hardware perspective, the clk81 is the parent of
>> the UART_AO clocks. So it make more sense to mark
>> the CLKID_AO_UART1/2 as the pclk.
>>
>> Previous we had flag=CLK_IGNORE_UNUSED in AO clock driver.
>> This will make kernel leave clock as it is while bootloader
>> set the clock on.
>>
> 
> Hi Yixun,
> 
> I'm not sure I understand your description correctly so I'll phrase. Please tell
> me if I misunderstood something
> 
> The actual pclk of the AO uarts is the corresponding clkc_ao uart gate, not the
> main clock controller clk81. This was not problem so far, because the uart_gate
> had the CLK_IGNORE_UNUSED flag, which kept the gate open.
> 
Yes, exactly

> In another patch, you removed this flag, so you need to give the correct clock
> in DT to make things work again ? right ?
> 
Yes, right.


> If I got it correctly, please rephrase the description a bit.
> Also you need to be careful in which order patches get merged.
> 
> 1. You need the clkc_ao in place, exporting CLKID_AO_UARTx with
> CLK_IGNORE_UNUSED.
> 
> 2. This patch can be merged (still with CLK_IGNORE_UNUSED)
> 
> 3. Once the DT patch have reached mainline, you should a patch to remove to
> CLK_IGNORE_UNUSED flag
> 
> This way, we avoid breaking bisect, with revision where CLKID_AO_UARTx would get
> disabled by the CCF clk_disable_unused() mechanism while the UART driver does
> not claim the appropriate clock.
> 
I wasn't sure about what's the best approach
I just gave a warning about that patch 2 (removing CLK_IGNORE_UNUSED)
and patch 3 (fix the DTS) should be merged together

and your suggestion sounds good, I will adjust

> 
>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi  | 4 ++--
>>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 4 ++--
>>  arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 4 ++--
>>  3 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>> index 48584d5a329b..e538e2448bb5 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>> @@ -533,7 +533,7 @@
>>  				compatible = "amlogic,meson-gx-uart", "amlogic,meson-ao-uart";
>>  				reg = <0x0 0x3000 0x0 0x18>;
>>  				interrupts = <GIC_SPI 193 IRQ_TYPE_EDGE_RISING>;
>> -				clocks = <&xtal>, <&clkc CLKID_CLK81>, <&xtal>;
>> +				clocks = <&xtal>, <&clkc_AO CLKID_AO_UART1>, <&xtal>;
>>  				clock-names = "xtal", "pclk", "baud";
>>  				status = "disabled";
>>  			};
>> @@ -542,7 +542,7 @@
>>  				compatible = "amlogic,meson-gx-uart", "amlogic,meson-ao-uart";
>>  				reg = <0x0 0x4000 0x0 0x18>;
>>  				interrupts = <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>;
>> -				clocks = <&xtal>, <&clkc CLKID_CLK81>, <&xtal>;
>> +				clocks = <&xtal>, <&clkc_AO CLKID_AO_UART2>, <&xtal>;
>>  				clock-names = "xtal", "pclk", "baud";
>>  				status = "disabled";
>>  			};
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
>> index 3290a4dc3522..a458ea50c2ef 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
>> @@ -783,12 +783,12 @@
>>  };
>>  
>>  &uart_AO {
>> -	clocks = <&xtal>, <&clkc CLKID_CLK81>, <&xtal>;
>> +	clocks = <&xtal>, <&clkc_AO CLKID_AO_UART1>, <&xtal>;
>>  	clock-names = "xtal", "pclk", "baud";
>>  };
>>  
>>  &uart_AO_B {
>> -	clocks = <&xtal>, <&clkc CLKID_CLK81>, <&xtal>;
>> +	clocks = <&xtal>, <&clkc_AO CLKID_AO_UART2>, <&xtal>;
>>  	clock-names = "xtal", "pclk", "baud";
>>  };
>>  
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
>> index 4f355f17eed6..474f4f9630e4 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
>> @@ -733,12 +733,12 @@
>>  };
>>  
>>  &uart_AO {
>> -	clocks = <&xtal>, <&clkc CLKID_CLK81>, <&xtal>;
>> +	clocks = <&xtal>, <&clkc_AO CLKID_AO_UART1>, <&xtal>;
>>  	clock-names = "xtal", "pclk", "baud";
>>  };
>>  
>>  &uart_AO_B {
>> -	clocks = <&xtal>, <&clkc CLKID_CLK81>, <&xtal>;
>> +	clocks = <&xtal>, <&clkc_AO CLKID_AO_UART2>, <&xtal>;
>>  	clock-names = "xtal", "pclk", "baud";
>>  };
>>  
> 
> .
> 
