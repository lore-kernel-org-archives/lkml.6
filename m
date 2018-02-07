Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753951AbeBGLoD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 06:44:03 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:41295 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753736AbeBGLoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 06:44:01 -0500
X-Google-Smtp-Source: AH8x227RDlBHhfuvmq0mPaMDXzaZkYlYS0aLpYIqjYjdXrGKo4RQGAgPDFt41wYbdejHyLuy9hIGvA==
Subject: Re: [PATCH v2 14/16] arm64: dts: mt7622: add thermal and related
 nodes
To: sean.wang@mediatek.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1517910489.git.sean.wang@mediatek.com>
 <687a7c43e3e3260ebdf004a96d2cde143f563250.1517910489.git.sean.wang@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <4db5c81b-0e55-3676-d7c8-d1b6aefb99c4@gmail.com>
Date: Wed, 7 Feb 2018 12:43:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <687a7c43e3e3260ebdf004a96d2cde143f563250.1517910489.git.sean.wang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/06/2018 10:53 AM, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> add nodes for the thermal controller and associated thermal zone using
> CPU as the cooling device for each trip point. In addition, add a fixup
> for thermal_calibration on nvmem should be 12 bytes as the minimal
> requirement.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt7622.dtsi | 72 +++++++++++++++++++++++++++++++-
>  1 file changed, 71 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> index e6dd4f6..6cf67dd 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> @@ -12,6 +12,7 @@
>  #include <dt-bindings/phy/phy.h>
>  #include <dt-bindings/power/mt7622-power.h>
>  #include <dt-bindings/reset/mt7622-reset.h>
> +#include <dt-bindings/thermal/thermal.h>
>  
>  / {
>  	compatible = "mediatek,mt7622";
> @@ -75,6 +76,7 @@
>  				 <&apmixedsys CLK_APMIXED_MAIN_CORE_EN>;
>  			clock-names = "cpu", "intermediate";
>  			operating-points-v2 = <&cpu_opp_table>;
> +			#cooling-cells = <2>;
>  			enable-method = "psci";
>  			clock-frequency = <1300000000>;
>  		};
> @@ -119,6 +121,58 @@
>  		};
>  	};
>  
> +	thermal-zones {
> +		cpu_thermal: cpu-thermal {
> +			polling-delay-passive = <1000>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&thermal 0>;
> +
> +			trips {
> +				cpu_passive: cpu-passive {
> +					temperature = <47000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu_active: cpu-active {
> +					temperature = <67000>;
> +					hysteresis = <2000>;
> +					type = "active";
> +				};
> +
> +				cpu_hot: cpu-hot {
> +					temperature = <87000>;
> +					hysteresis = <2000>;
> +					type = "hot";
> +				};
> +
> +				cpu-crit {
> +					temperature = <107000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu_passive>;
> +					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +
> +				map1 {
> +					trip = <&cpu_active>;
> +					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +
> +				map2 {
> +					trip = <&cpu_hot>;
> +					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +	};
> +
>  	timer {
>  		compatible = "arm,armv8-timer";
>  		interrupt-parent = <&gic>;
> @@ -201,7 +255,7 @@
>  		#size-cells = <1>;
>  
>  		thermal_calibration: calib@198 {
> -			reg = <0x198 0x8>;
> +			reg = <0x198 0xc>;

Any reason why this is not part of patch 8/16?

Regards,
Matthias
