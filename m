Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754243AbeDBJLS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 05:11:18 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38153 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754175AbeDBJLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 05:11:15 -0400
X-Google-Smtp-Source: AIpwx4+RLCnJJj9ZxebXhL1B59luIzChfNYd+R7FkHCGRp1/atBFjnwFYPMqBeTXeLtVrSbf8Y8qzA==
Subject: Re: [PATCH v3 2/2] drivers: soc: Add LLCC driver
To: Channa <ckadabi@codeaurora.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc: Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-arm@lists.infradead.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, kyan@codeaurora.org,
        linux-kernel-owner@vger.kernel.org
References: <1522176722-12691-1-git-send-email-rishabhb@codeaurora.org>
 <1522176722-12691-3-git-send-email-rishabhb@codeaurora.org>
 <ff949d44-1b2a-15d4-511d-8686a973b081@linaro.org>
 <79f87ed77b4b6b446d0ee065ecefe6fa@codeaurora.org>
From: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <faddb372-4efa-9032-e5cd-54778071b0dd@linaro.org>
Date: Mon, 2 Apr 2018 12:11:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <79f87ed77b4b6b446d0ee065ecefe6fa@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please adjust your mail client to drop on new line on 80 column!

On 03/29/2018 08:55 PM, Channa wrote:
> On 2018-03-29 01:08, Stanimir Varbanov wrote:
>> Hi,
>>
>> On 03/27/2018 09:52 PM, Rishabh Bhatnagar wrote:
>>> LLCC (Last Level Cache Controller) provides additional cache memory
>>> in the system. LLCC is partitioned into muliple slices and each
>>> slice getting its own priority, size, ID and other config parameters.
>>> LLCC driver programs these parameters for each slice. Clients that
>>> are assigned to use LLCC need to get information such size & ID of the
>>>  slice they get and activate or deactivate the slice as needed. LLCC
>>> driver
>>> provides API interfaces for the clients to perform these operations.
>>>
>>> Signed-off-by: Channagoud Kadabi <ckadabi@codeaurora.org>
>>> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
>>> ---
>>>  drivers/soc/qcom/Kconfig           |  16 ++
>>>  drivers/soc/qcom/Makefile          |   2 +
>>>  drivers/soc/qcom/llcc-sdm845.c     | 120 ++++++++++
>>>  drivers/soc/qcom/llcc-slice.c      | 454
>>> +++++++++++++++++++++++++++++++++++++
>>
>> I'd name it just llcc.c, slice suffix didn't add any value.
>>
>>>  include/linux/soc/qcom/llcc-qcom.h | 178 +++++++++++++++
>>>  5 files changed, 770 insertions(+)
>>>  create mode 100644 drivers/soc/qcom/llcc-sdm845.c
>>>  create mode 100644 drivers/soc/qcom/llcc-slice.c
>>>  create mode 100644 include/linux/soc/qcom/llcc-qcom.h
>>>
>>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>>> index e050eb8..28237fc 100644
>>> --- a/drivers/soc/qcom/Kconfig
>>> +++ b/drivers/soc/qcom/Kconfig
>>> @@ -21,6 +21,22 @@ config QCOM_GSBI
>>>            functions for connecting the underlying serial UART, SPI,
>>> and I2C
>>>            devices to the output pins.
>>>
>>> +config QCOM_LLCC
>>> +    tristate "Qualcomm Technologies, Inc. LLCC driver"
>>> +    depends on ARCH_QCOM
>>> +    help
>>> +      Qualcomm Technologies, Inc. platform specific LLCC driver for
>>> Last
>>> +      Level Cache. This provides interfaces to client's that use the
>>> LLCC.
>>> +      Say yes here to enable LLCC slice driver.
>>> +
>>> +config QCOM_SDM845_LLCC
>>> +    tristate "Qualcomm Technologies, Inc. SDM845 LLCC driver"
>>> +    depends on QCOM_LLCC
>>> +    help
>>> +      Say yes here to enable the LLCC driver for SDM845. This is
>>> provides
>>> +      data required to configure LLCC so that clients can start
>>> using the
>>> +      LLCC slices.
>>> +
>>>  config QCOM_MDT_LOADER
>>>      tristate
>>>      select QCOM_SCM
>>> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
>>> index dcebf28..e16d6a2 100644
>>> --- a/drivers/soc/qcom/Makefile
>>> +++ b/drivers/soc/qcom/Makefile
>>> @@ -12,3 +12,5 @@ obj-$(CONFIG_QCOM_SMEM_STATE) += smem_state.o
>>>  obj-$(CONFIG_QCOM_SMP2P)    += smp2p.o
>>>  obj-$(CONFIG_QCOM_SMSM)    += smsm.o
>>>  obj-$(CONFIG_QCOM_WCNSS_CTRL) += wcnss_ctrl.o
>>> +obj-$(CONFIG_QCOM_LLCC) += llcc-slice.o
>>> +obj-$(CONFIG_QCOM_SDM845_LLCC) += llcc-sdm845.o
>>> diff --git a/drivers/soc/qcom/llcc-sdm845.c
>>> b/drivers/soc/qcom/llcc-sdm845.c
>>> new file mode 100644
>>> index 0000000..cd431d9
>>> --- /dev/null
>>> +++ b/drivers/soc/qcom/llcc-sdm845.c
>>> @@ -0,0 +1,120 @@
>>> +/* Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License version 2 and
>>> + * only version 2 as published by the Free Software Foundation.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + * GNU General Public License for more details.
>>> + */
>>> +
>>> +#include <linux/err.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of.h>
>>> +#include <linux/of_device.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/soc/qcom/llcc-qcom.h>
>>> +#include <linux/mfd/syscon.h>
>>> +#include <linux/regmap.h>
>>> +
>>> +
>>> +/*
>>> + * SCT entry contains of the following parameters
>>> + * name: Name of the client's use case for which the llcc slice is used
>>> + * uid: Unique id for the client's use case
>>> + * slice_id: llcc slice id for each client
>>> + * max_cap: The maximum capacity of the cache slice provided in KB
>>> + * priority: Priority of the client used to select victim line for
>>> replacement
>>> + * fixed_size: Determine of the slice has a fixed capacity
>>> + * bonus_ways: Bonus ways to be used by any slice, bonus way is used
>>> only if
>>> + *             it't not a reserved way.
>>> + * res_ways: Reserved ways for the cache slice, the reserved ways
>>> cannot be used
>>> + *           by any other client than the one its assigned to.
>>> + * cache_mode: Each slice operates as a cache, this controls the
>>> mode of the
>>> + *             slice normal or TCM
>>> + * probe_target_ways: Determines what ways to probe for access hit.
>>> When
>>> + *                    configured to 1 only bonus and reseved ways
>>> are probed.
>>> + *                    when configured to 0 all ways in llcc are probed.
>>> + * dis_cap_alloc: Disable capacity based allocation for a client
>>> + * retain_on_pc: If this bit is set and client has maitained active
>>> vote
>>> + *               then the ways assigned to this client are not
>>> flushed on power
>>> + *               collapse.
>>> + * activate_on_init: Activate the slice immidiately after the SCT is
>>> programmed
>>> + */
>>> +#define SCT_ENTRY(n, uid, sid, mc, p, fs, bway, rway, cmod, ptw,
>>> dca, rp, a) \
>>> +    {                    \
>>> +        .name = n,            \
>>> +        .usecase_id = uid,        \
>>> +        .slice_id = sid,        \
>>> +        .max_cap = mc,            \
>>> +        .priority = p,            \
>>> +        .fixed_size = fs,        \
>>> +        .bonus_ways = bway,        \
>>> +        .res_ways = rway,        \
>>> +        .cache_mode = cmod,        \
>>> +        .probe_target_ways = ptw,    \
>>> +        .dis_cap_alloc = dca,        \
>>> +        .retain_on_pc = rp,        \
>>> +        .activate_on_init = a,        \
>>> +    }
>>> +
>>> +
>>> +static struct llcc_slice_config sdm845_data[] =  {
>>> +    SCT_ENTRY("cpuss",       1, 1, 2816, 1, 0, 0xFFC, 0x2, 0, 0, 1,
>>> 1, 1),
>>> +    SCT_ENTRY("vidsc0",      2, 2, 512, 2, 1, 0x0,  0x0F0, 0, 0, 1,
>>> 1, 0),
>>> +    SCT_ENTRY("vidsc1",      3, 3, 512, 2, 1, 0x0,  0x0F0, 0, 0, 1,
>>> 1, 0),
>>> +    SCT_ENTRY("rotator",     4, 4, 563, 2, 1, 0x0,  0x00e, 2, 0, 1,
>>> 1, 0),
>>> +    SCT_ENTRY("voice",       5, 5, 2816, 1, 0, 0xFFC, 0x2, 0, 0, 1,
>>> 1, 0),
>>> +    SCT_ENTRY("audio",       6, 6, 2816, 1, 0, 0xFFC, 0x2, 0, 0, 1,
>>> 1, 0),
>>> +    SCT_ENTRY("modemhp_grow", 7, 7, 1024, 2, 0, 0x0FC, 0xF00, 0, 0,
>>> 1, 1, 0),
>>> +    SCT_ENTRY("modem",       8, 8, 2816, 1, 0, 0xFFC, 0x2, 0, 0, 1,
>>> 1, 0),
>>> +    SCT_ENTRY("compute",     10, 10, 2816, 1, 0, 0xFFC, 0x2, 0, 0,
>>> 1, 1, 0),
>>> +    SCT_ENTRY("gpuhtw",      11, 11, 512, 1, 1, 0xC,  0x0, 0, 0, 1,
>>> 1, 0),
>>> +    SCT_ENTRY("gpu",         12, 12, 2304, 1, 0, 0xFF0, 0x2, 0, 0,
>>> 1, 1, 0),
>>> +    SCT_ENTRY("mmuhwt",      13, 13, 256, 2, 0, 0x0,  0x1, 0, 0, 1,
>>> 0, 1),
>>> +    SCT_ENTRY("compute_dma", 15, 15, 2816, 1, 0, 0xFFC, 0x2, 0, 0,
>>> 1, 1, 0),
>>> +    SCT_ENTRY("display",     16, 16, 2816, 1, 0, 0xFFC, 0x2, 0, 0,
>>> 1, 1, 0),
>>> +    SCT_ENTRY("videofw",     17, 17, 2816, 1, 0, 0xFFC, 0x2, 0, 0,
>>> 1, 1, 0),
>>> +    SCT_ENTRY("modemhp_fix", 20, 20, 1024, 2, 1, 0x0,  0xF00, 0, 0,
>>> 1, 1, 0),
>>> +    SCT_ENTRY("modem_paging", 21, 21, 1024, 0, 1, 0x1e, 0x0, 0, 0,
>>> 1, 1, 0),
>>> +    SCT_ENTRY("audiohw",     22, 22, 1024, 1, 1, 0xFFC, 0x2, 0, 0,
>>> 1, 1, 0),
>>> +};
>>> +
>>> +
>>> +static int sdm845_qcom_llcc_probe(struct platform_device *pdev)
>>> +{
>>> +    return qcom_llcc_probe(pdev, sdm845_data, ARRAY_SIZE(sdm845_data));
>>
>> I think having separate driver just for this config structure is
>> pointless. Please move this in llcc driver and select the configuration
>> based on compatible string.
> 
> Thanks Stan for your review.
> 
> Wanted to highlight the reason we chose this approach. The System cache
> table data
> changes from chipset to chipset and overtime the table could have more
> parameters.
> Adding it as part of the core driver and selecting the table based on
> compatible
> would clutter the core driver. If we have 4 chipsets supporting system
> cache then
> core driver would have 4 tables as above and we select one of them based
> on compatible
> string. That is why we followed the pin control approach to have data in
> per chipset
> driver and pass it to common driver.

OK, do you plan to extend this with some more code?

-- 
regards,
Stan
