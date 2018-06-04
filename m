Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751892AbeFDWZN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 18:25:13 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33627 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751498AbeFDWYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 18:24:33 -0400
X-Google-Smtp-Source: ADUXVKJ6Rblhdpx4+P7DwDiLBX7VwT08q302MvLK8bdsKglLLWwPAfVsgRvYOFXHXcDueK7tvG8j5A==
Subject: Re: [PATCH] arm64: dts: stingray: move common board components to
 stingray-board-base
To: Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc: BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1527015342-9317-1-git-send-email-scott.branden@broadcom.com>
 <05b33af8-c938-f124-f918-a9d7f8679d90@gmail.com>
From: Scott Branden <scott.branden@broadcom.com>
Message-ID: <dcf364c7-2488-9c3b-9b55-4080b746c83d@broadcom.com>
Date: Mon, 4 Jun 2018 15:24:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <05b33af8-c938-f124-f918-a9d7f8679d90@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,


On 18-06-04 02:09 PM, Florian Fainelli wrote:
> On 05/22/2018 11:55 AM, Scott Branden wrote:
>> Move common board components from base bcm958742 dtsi file to new
>> stingray-board-base dtsi file so they can be shared between many stingray
>> boards following common design.
>>
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>
> Applied to devicetree-arm64/next, though this did not apply cleanly,
> please check the results at:
>
> https://github.com/Broadcom/stblinux/commit/0b2cf5a855cd235fa95fbdfedfc524a97a71a7fe
It's looks fine.
>
>> ---
>>   .../boot/dts/broadcom/stingray/bcm958742-base.dtsi | 35 +--------------
>>   .../dts/broadcom/stingray/stingray-board-base.dtsi | 51 ++++++++++++++++++++++
>>   2 files changed, 52 insertions(+), 34 deletions(-)
>>   create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-board-base.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi b/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
>> index cacc25e..d74f6df 100644
>> --- a/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
>> +++ b/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
>> @@ -30,20 +30,9 @@
>>    *  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>>    */
>>   
>> -#include "stingray.dtsi"
>> +#include "stingray-board-base.dtsi"
>>   
>>   / {
>> -	chosen {
>> -		stdout-path = "serial0:115200n8";
>> -	};
>> -
>> -	aliases {
>> -		serial0 = &uart1;
>> -		serial1 = &uart0;
>> -		serial2 = &uart2;
>> -		serial3 = &uart3;
>> -	};
>> -
>>   	sdio0_vddo_ctrl_reg: sdio0_vddo_ctrl {
>>   		compatible = "regulator-gpio";
>>   		regulator-name = "sdio0_vddo_ctrl_reg";
>> @@ -67,23 +56,6 @@
>>   	};
>>   };
>>   
>> -&memory { /* Default DRAM banks */
>> -	reg = <0x00000000 0x80000000 0x0 0x80000000>, /* 2G @ 2G */
>> -	      <0x00000008 0x80000000 0x1 0x80000000>; /* 6G @ 34G */
>> -};
>> -
>> -&mdio_mux_iproc {
>> -	mdio@10 {
>> -		gphy0: eth-phy@10 {
>> -			reg = <0x10>;
>> -		};
>> -	};
>> -};
>> -
>> -&uart1 {
>> -	status = "okay";
>> -};
>> -
>>   &pwm {
>>   	status = "okay";
>>   };
>> @@ -111,8 +83,6 @@
>>   };
>>   
>>   &enet {
>> -	phy-mode = "rgmii-id";
>> -	phy-handle = <&gphy0>;
>>   	status = "okay";
>>   };
>>   
>> @@ -133,13 +103,10 @@
>>   
>>   &sdio0 {
>>   	vqmmc-supply = <&sdio0_vddo_ctrl_reg>;
>> -	non-removable;
>> -	full-pwr-cycle;
>>   	status = "okay";
>>   };
>>   
>>   &sdio1 {
>>   	vqmmc-supply = <&sdio1_vddo_ctrl_reg>;
>> -	full-pwr-cycle;
>>   	status = "okay";
>>   };
>> diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray-board-base.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray-board-base.dtsi
>> new file mode 100644
>> index 0000000..82a2471
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/broadcom/stingray/stingray-board-base.dtsi
>> @@ -0,0 +1,51 @@
>> +// SPDX-License-Identifier: (GPL-2.0 or BSD-3-Clause)
>> +/*
>> + *  Copyright(c) 2016-2018 Broadcom
>> + */
>> +
>> +#include "stingray.dtsi"
>> +#include <dt-bindings/gpio/gpio.h>
>> +
>> +/ {
>> +	aliases {
>> +		serial0 = &uart1;
>> +		serial1 = &uart0;
>> +		serial2 = &uart2;
>> +		serial3 = &uart3;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +};
>> +
>> +&memory { /* Default DRAM banks */
>> +	reg = <0x00000000 0x80000000 0x0 0x80000000>, /* 2G @ 2G */
>> +	      <0x00000008 0x80000000 0x1 0x80000000>; /* 6G @ 34G */
>> +};
>> +
>> +&enet {
>> +	phy-mode = "rgmii-id";
>> +	phy-handle = <&gphy0>;
>> +};
>> +
>> +&uart1 {
>> +	status = "okay";
>> +};
>> +
>> +&sdio0 {
>> +	non-removable;
>> +	full-pwr-cycle;
>> +};
>> +
>> +&sdio1 {
>> +	full-pwr-cycle;
>> +};
>> +
>> +&mdio_mux_iproc {
>> +	mdio@10 {
>> +		gphy0: eth-phy@10 {
>> +			reg = <0x10>;
>> +		};
>> +	};
>> +};
>>
>
