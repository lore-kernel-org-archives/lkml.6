Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbeERHQN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:16:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35566 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbeERHQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 03:16:11 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Fri, 18 May 2018 00:16:07 -0700
From: skannan@codeaurora.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM / devfreq: Add support for QCOM devfreq FW
In-Reply-To: <5AFE3A30.4040505@samsung.com>
References: <CGME20180517060257epcas2p1b42e6969c806473ccdf38ea52a74ca04@epcas2p1.samsung.com>
 <1526536958-29419-1-git-send-email-skannan@codeaurora.org>
 <5AFE3A30.4040505@samsung.com>
Message-ID: <56e9cd3e57d809ef6cd5765a97101e6e@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-17 19:28, Chanwoo Choi wrote:
> Hi,
> 
> On 2018년 05월 17일 15:02, Saravana Kannan wrote:
>> The firmware present in some QCOM chipsets offloads the steps 
>> necessary for
>> changing the frequency of some devices (Eg: L3). This driver 
>> implements the
>> devfreq interface for this firmware so that various governors could be 
>> used
>> to scale the frequency of these devices.
> 
> The description doesn't include what kind of firmware. You have to 
> explain
> the type and role of firmware.

Not exactly sure what you mean. I described exactly what the firmware 
does. Not sure what you mean by what kind of firmware. I just understand 
the interface with it -- not the implementation of the firmware or 
hardware.

> And it doesn't contain the description
> of correlation
> between 'qcom,devfreq-fw' and 'qcom,devfreq-fw-voter'.
> 

Will do.

>> 
>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>> ---
>>  .../bindings/devfreq/devfreq-qcom-fw.txt           |  31 ++
>>  drivers/devfreq/Kconfig                            |  14 +
>>  drivers/devfreq/Makefile                           |   1 +
>>  drivers/devfreq/devfreq_qcom_fw.c                  | 326 
>> +++++++++++++++++++++
>>  4 files changed, 372 insertions(+)
>>  create mode 100644 
>> Documentation/devicetree/bindings/devfreq/devfreq-qcom-fw.txt
>>  create mode 100644 drivers/devfreq/devfreq_qcom_fw.c
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/devfreq/devfreq-qcom-fw.txt 
>> b/Documentation/devicetree/bindings/devfreq/devfreq-qcom-fw.txt
>> new file mode 100644
>> index 0000000..5e1aecf
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/devfreq/devfreq-qcom-fw.txt
>> @@ -0,0 +1,31 @@
>> +QCOM Devfreq FW device
>> +
>> +Some Qualcomm Technologies, Inc. (QTI) chipsets have a FW that 
>> offloads the
>> +child devices of the corresponding qcom,devfreq-fw device.
>> +
>> +Required properties:
>> +- compatible:		Must be "qcom,devfreq-fw" or "qcom,devfreq-fw-voter"
> 
> The use of 'devfreq' word is not proper because 'devfreq' is framework 
> name.
> I think you have to use the specific SoC name for the compatible.

I don't think it's mandatory to use chip name. Typically you pick the IP 
name. This IP is a firmware just for scaling device frequency - so 
called it qcom,devfreq-fw. I'll see what the DT maintainers say about 
this.

> In the future,
> if you need to support the new SoC with this driver, just you can add
> the new compatible.
> 
>> +Only for qcom,devfreq-fw:
>> +- reg:			Pairs of physical base addresses and region sizes of
>> +			memory mapped registers.
>> +- reg-names:		Names of the bases for the above registers. Expected
>> +			bases are: "en-base", "lut-base" and "perf-base".
> 
> It is not possible to understand what are meaning of "en-base",
> "lut-base" and "perf-base".
> because they depend on specific H/W specification. You have to add the
> detailed description
> why they are necessary. Also, you should explain whether thery are
> mandatory or optional.

The are all mandatory, that's why I didn't have the "Optional" heading. 
I can add descriptions.

> 
>> +
>> +Example:
>> +
>> +	qcom,devfreq-l3 {
>> +		compatible = "qcom,devfreq-fw";
>> +		reg-names = "en-base", "lut-base", "perf-base";
>> +		reg = <0x18321000 0x4>, <0x18321110 0x600>, <0x18321920 0x4>;
>> +
>> +		qcom,cpu0-l3 {
>> +			compatible = "qcom,devfreq-fw-voter";
>> +		};
>> +
>> +		qcom,cpu4-l3 {
>> +			compatible = "qcom,devfreq-fw-voter";
>> +		};
>> +	};
>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
>> index 6a172d3..8503018 100644
>> --- a/drivers/devfreq/Kconfig
>> +++ b/drivers/devfreq/Kconfig
>> @@ -113,6 +113,20 @@ config ARM_RK3399_DMC_DEVFREQ
>>            It sets the frequency for the memory controller and reads 
>> the usage counts
>>            from hardware.
>> 
>> +config ARM_QCOM_DEVFREQ_FW
>> +	bool "Qualcomm Technologies Inc. DEVFREQ FW driver"
>> +	depends on ARCH_QCOM
>> +	select DEVFREQ_GOV_PERFORMANCE
>> +	select DEVFREQ_GOV_POWERSAVE
>> +	select DEVFREQ_GOV_USERSPACE
>> +	default n
>> +	help
>> +	  The firmware present in some QCOM chipsets offloads the steps
>> +	  necessary for changing the frequency of some devices (Eg: L3). 
>> This
>> +	  driver implements the devfreq interface for this firmware so that
>> +	  various governors could be used to scale the frequency of these
>> +	  devices.
> 
> As I commented, you need to add a description of what kind of firmwar.

Again, not sure what you mean by "what kind of firmware". It's exactly 
what I've described here. Can you please elaborate?

>> +
>>  source "drivers/devfreq/event/Kconfig"
>> 
>>  endif # PM_DEVFREQ
>> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
>> index 32b8d4d..f1cc8990 100644
>> --- a/drivers/devfreq/Makefile
>> +++ b/drivers/devfreq/Makefile
>> @@ -11,6 +11,7 @@ obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= 
>> governor_passive.o
>>  obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
>>  obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
>>  obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra-devfreq.o
>> +obj-$(CONFIG_ARM_QCOM_DEVFREQ_FW)	+= devfreq_qcom_fw.o
>> 
>>  # DEVFREQ Event Drivers
>>  obj-$(CONFIG_PM_DEVFREQ_EVENT)		+= event/
>> diff --git a/drivers/devfreq/devfreq_qcom_fw.c 
>> b/drivers/devfreq/devfreq_qcom_fw.c
>> new file mode 100644
>> index 0000000..3e85f76
>> --- /dev/null
>> +++ b/drivers/devfreq/devfreq_qcom_fw.c
>> @@ -0,0 +1,326 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> 
> Is it right? or Qualcomm?

Yup, it's right.

> 
>> + */
>> +
>> +#include <linux/err.h>
>> +#include <linux/errno.h>
>> +#include <linux/init.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +#include <linux/list.h>
>> +#include <linux/devfreq.h>
>> +#include <linux/pm_opp.h>
>> +
>> +#define INIT_RATE			300000000UL
>> +#define XO_RATE				19200000UL
>> +#define LUT_MAX_ENTRIES			40U
>> +#define LUT_ROW_SIZE			32
> 
> I don't know what are the meaning of 'XO', 'LUT'.

XO is a very common term for crystal oscillator. I don't want to change 
these symbols.
LUT stands for Look up table. But I can rename it to FREQ_TBL_.

Thanks,
Saravana
