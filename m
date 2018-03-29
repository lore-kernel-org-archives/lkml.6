Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752105AbeC2RzI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 13:55:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45684 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750866AbeC2RzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 13:55:05 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 29 Mar 2018 10:55:01 -0700
From: Channa <ckadabi@codeaurora.org>
To: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc: Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-arm@lists.infradead.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, kyan@codeaurora.org,
        linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v3 2/2] drivers: soc: Add LLCC driver
In-Reply-To: <ff949d44-1b2a-15d4-511d-8686a973b081@linaro.org>
References: <1522176722-12691-1-git-send-email-rishabhb@codeaurora.org>
 <1522176722-12691-3-git-send-email-rishabhb@codeaurora.org>
 <ff949d44-1b2a-15d4-511d-8686a973b081@linaro.org>
Message-ID: <79f87ed77b4b6b446d0ee065ecefe6fa@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-29 01:08, Stanimir Varbanov wrote:
> Hi,
> 
> On 03/27/2018 09:52 PM, Rishabh Bhatnagar wrote:
>> LLCC (Last Level Cache Controller) provides additional cache memory
>> in the system. LLCC is partitioned into muliple slices and each
>> slice getting its own priority, size, ID and other config parameters.
>> LLCC driver programs these parameters for each slice. Clients that
>> are assigned to use LLCC need to get information such size & ID of the
>>  slice they get and activate or deactivate the slice as needed. LLCC 
>> driver
>> provides API interfaces for the clients to perform these operations.
>> 
>> Signed-off-by: Channagoud Kadabi <ckadabi@codeaurora.org>
>> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
>> ---
>>  drivers/soc/qcom/Kconfig           |  16 ++
>>  drivers/soc/qcom/Makefile          |   2 +
>>  drivers/soc/qcom/llcc-sdm845.c     | 120 ++++++++++
>>  drivers/soc/qcom/llcc-slice.c      | 454 
>> +++++++++++++++++++++++++++++++++++++
> 
> I'd name it just llcc.c, slice suffix didn't add any value.
> 
>>  include/linux/soc/qcom/llcc-qcom.h | 178 +++++++++++++++
>>  5 files changed, 770 insertions(+)
>>  create mode 100644 drivers/soc/qcom/llcc-sdm845.c
>>  create mode 100644 drivers/soc/qcom/llcc-slice.c
>>  create mode 100644 include/linux/soc/qcom/llcc-qcom.h
>> 
>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>> index e050eb8..28237fc 100644
>> --- a/drivers/soc/qcom/Kconfig
>> +++ b/drivers/soc/qcom/Kconfig
>> @@ -21,6 +21,22 @@ config QCOM_GSBI
>>            functions for connecting the underlying serial UART, SPI, 
>> and I2C
>>            devices to the output pins.
>> 
>> +config QCOM_LLCC
>> +	tristate "Qualcomm Technologies, Inc. LLCC driver"
>> +	depends on ARCH_QCOM
>> +	help
>> +	  Qualcomm Technologies, Inc. platform specific LLCC driver for Last
>> +	  Level Cache. This provides interfaces to client's that use the 
>> LLCC.
>> +	  Say yes here to enable LLCC slice driver.
>> +
>> +config QCOM_SDM845_LLCC
>> +	tristate "Qualcomm Technologies, Inc. SDM845 LLCC driver"
>> +	depends on QCOM_LLCC
>> +	help
>> +	  Say yes here to enable the LLCC driver for SDM845. This is 
>> provides
>> +	  data required to configure LLCC so that clients can start using 
>> the
>> +	  LLCC slices.
>> +
>>  config QCOM_MDT_LOADER
>>  	tristate
>>  	select QCOM_SCM
>> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
>> index dcebf28..e16d6a2 100644
>> --- a/drivers/soc/qcom/Makefile
>> +++ b/drivers/soc/qcom/Makefile
>> @@ -12,3 +12,5 @@ obj-$(CONFIG_QCOM_SMEM_STATE) += smem_state.o
>>  obj-$(CONFIG_QCOM_SMP2P)	+= smp2p.o
>>  obj-$(CONFIG_QCOM_SMSM)	+= smsm.o
>>  obj-$(CONFIG_QCOM_WCNSS_CTRL) += wcnss_ctrl.o
>> +obj-$(CONFIG_QCOM_LLCC) += llcc-slice.o
>> +obj-$(CONFIG_QCOM_SDM845_LLCC) += llcc-sdm845.o
>> diff --git a/drivers/soc/qcom/llcc-sdm845.c 
>> b/drivers/soc/qcom/llcc-sdm845.c
>> new file mode 100644
>> index 0000000..cd431d9
>> --- /dev/null
>> +++ b/drivers/soc/qcom/llcc-sdm845.c
>> @@ -0,0 +1,120 @@
>> +/* Copyright (c) 2017-2018, The Linux Foundation. All rights 
>> reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or 
>> modify
>> + * it under the terms of the GNU General Public License version 2 and
>> + * only version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/err.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/soc/qcom/llcc-qcom.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/regmap.h>
>> +
>> +
>> +/*
>> + * SCT entry contains of the following parameters
>> + * name: Name of the client's use case for which the llcc slice is 
>> used
>> + * uid: Unique id for the client's use case
>> + * slice_id: llcc slice id for each client
>> + * max_cap: The maximum capacity of the cache slice provided in KB
>> + * priority: Priority of the client used to select victim line for 
>> replacement
>> + * fixed_size: Determine of the slice has a fixed capacity
>> + * bonus_ways: Bonus ways to be used by any slice, bonus way is used 
>> only if
>> + *             it't not a reserved way.
>> + * res_ways: Reserved ways for the cache slice, the reserved ways 
>> cannot be used
>> + *           by any other client than the one its assigned to.
>> + * cache_mode: Each slice operates as a cache, this controls the mode 
>> of the
>> + *             slice normal or TCM
>> + * probe_target_ways: Determines what ways to probe for access hit. 
>> When
>> + *                    configured to 1 only bonus and reseved ways are 
>> probed.
>> + *                    when configured to 0 all ways in llcc are 
>> probed.
>> + * dis_cap_alloc: Disable capacity based allocation for a client
>> + * retain_on_pc: If this bit is set and client has maitained active 
>> vote
>> + *               then the ways assigned to this client are not 
>> flushed on power
>> + *               collapse.
>> + * activate_on_init: Activate the slice immidiately after the SCT is 
>> programmed
>> + */
>> +#define SCT_ENTRY(n, uid, sid, mc, p, fs, bway, rway, cmod, ptw, dca, 
>> rp, a) \
>> +	{					\
>> +		.name = n,			\
>> +		.usecase_id = uid,		\
>> +		.slice_id = sid,		\
>> +		.max_cap = mc,			\
>> +		.priority = p,			\
>> +		.fixed_size = fs,		\
>> +		.bonus_ways = bway,		\
>> +		.res_ways = rway,		\
>> +		.cache_mode = cmod,		\
>> +		.probe_target_ways = ptw,	\
>> +		.dis_cap_alloc = dca,		\
>> +		.retain_on_pc = rp,		\
>> +		.activate_on_init = a,		\
>> +	}
>> +
>> +
>> +static struct llcc_slice_config sdm845_data[] =  {
>> +	SCT_ENTRY("cpuss",       1, 1, 2816, 1, 0, 0xFFC, 0x2, 0, 0, 1, 1, 
>> 1),
>> +	SCT_ENTRY("vidsc0",      2, 2, 512, 2, 1, 0x0,  0x0F0, 0, 0, 1, 1, 
>> 0),
>> +	SCT_ENTRY("vidsc1",      3, 3, 512, 2, 1, 0x0,  0x0F0, 0, 0, 1, 1, 
>> 0),
>> +	SCT_ENTRY("rotator",     4, 4, 563, 2, 1, 0x0,  0x00e, 2, 0, 1, 1, 
>> 0),
>> +	SCT_ENTRY("voice",       5, 5, 2816, 1, 0, 0xFFC, 0x2, 0, 0, 1, 1, 
>> 0),
>> +	SCT_ENTRY("audio",       6, 6, 2816, 1, 0, 0xFFC, 0x2, 0, 0, 1, 1, 
>> 0),
>> +	SCT_ENTRY("modemhp_grow", 7, 7, 1024, 2, 0, 0x0FC, 0xF00, 0, 0, 1, 
>> 1, 0),
>> +	SCT_ENTRY("modem",       8, 8, 2816, 1, 0, 0xFFC, 0x2, 0, 0, 1, 1, 
>> 0),
>> +	SCT_ENTRY("compute",     10, 10, 2816, 1, 0, 0xFFC, 0x2, 0, 0, 1, 1, 
>> 0),
>> +	SCT_ENTRY("gpuhtw",      11, 11, 512, 1, 1, 0xC,  0x0, 0, 0, 1, 1, 
>> 0),
>> +	SCT_ENTRY("gpu",         12, 12, 2304, 1, 0, 0xFF0, 0x2, 0, 0, 1, 1, 
>> 0),
>> +	SCT_ENTRY("mmuhwt",      13, 13, 256, 2, 0, 0x0,  0x1, 0, 0, 1, 0, 
>> 1),
>> +	SCT_ENTRY("compute_dma", 15, 15, 2816, 1, 0, 0xFFC, 0x2, 0, 0, 1, 1, 
>> 0),
>> +	SCT_ENTRY("display",     16, 16, 2816, 1, 0, 0xFFC, 0x2, 0, 0, 1, 1, 
>> 0),
>> +	SCT_ENTRY("videofw",     17, 17, 2816, 1, 0, 0xFFC, 0x2, 0, 0, 1, 1, 
>> 0),
>> +	SCT_ENTRY("modemhp_fix", 20, 20, 1024, 2, 1, 0x0,  0xF00, 0, 0, 1, 
>> 1, 0),
>> +	SCT_ENTRY("modem_paging", 21, 21, 1024, 0, 1, 0x1e, 0x0, 0, 0, 1, 1, 
>> 0),
>> +	SCT_ENTRY("audiohw",     22, 22, 1024, 1, 1, 0xFFC, 0x2, 0, 0, 1, 1, 
>> 0),
>> +};
>> +
>> +
>> +static int sdm845_qcom_llcc_probe(struct platform_device *pdev)
>> +{
>> +	return qcom_llcc_probe(pdev, sdm845_data, ARRAY_SIZE(sdm845_data));
> 
> I think having separate driver just for this config structure is
> pointless. Please move this in llcc driver and select the configuration
> based on compatible string.

Thanks Stan for your review.

Wanted to highlight the reason we chose this approach. The System cache 
table data
changes from chipset to chipset and overtime the table could have more 
parameters.
Adding it as part of the core driver and selecting the table based on 
compatible
would clutter the core driver. If we have 4 chipsets supporting system 
cache then
core driver would have 4 tables as above and we select one of them based 
on compatible
string. That is why we followed the pin control approach to have data in 
per chipset
driver and pass it to common driver.

> 
> On first sight the driver has many coding style issues and flooding err
> messages which should be dropped. Did you run checkpatch?
> 
>> +}
>> +
>> +static const struct of_device_id sdm845_qcom_llcc_of_match[] = {
>> +	{ .compatible = "qcom,sdm845-llcc", },
>> +	{ },
>> +};
>> +
>> +static struct platform_driver sdm845_qcom_llcc_driver = {
>> +	.driver = {
>> +		.name = "sdm845-llcc",
>> +		.owner = THIS_MODULE,
>> +		.of_match_table = sdm845_qcom_llcc_of_match,
>> +	},
>> +	.probe = sdm845_qcom_llcc_probe,
>> +	.remove = qcom_llcc_remove,
>> +};
>> +
>> +static int __init sdm845_init_qcom_llcc_init(void)
>> +{
>> +	return platform_driver_register(&sdm845_qcom_llcc_driver);
>> +}
>> +module_init(sdm845_init_qcom_llcc_init);
>> +
>> +static void __exit sdm845_exit_qcom_llcc_exit(void)
>> +{
>> +	platform_driver_unregister(&sdm845_qcom_llcc_driver);
>> +}
>> +module_exit(sdm845_exit_qcom_llcc_exit);
>> +
>> +MODULE_DESCRIPTION("QTI sdm845 LLCC driver");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/soc/qcom/llcc-slice.c 
>> b/drivers/soc/qcom/llcc-slice.c
>> new file mode 100644
>> index 0000000..6e86770
>> --- /dev/null
>> +++ b/drivers/soc/qcom/llcc-slice.c
>> @@ -0,0 +1,454 @@
>> +/* Copyright (c) 2017-2018, The Linux Foundation. All rights 
>> reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or 
>> modify
>> + * it under the terms of the GNU General Public License version 2 and
>> + * only version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#define pr_fmt(fmt)  "%s:" fmt, __func__
> 
> drop this and use dev_xxx instead.
> 
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/device.h>
>> +#include <linux/delay.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/mutex.h>
>> +#include <linux/bitmap.h>
>> +#include <linux/bitops.h>
>> +#include <linux/slab.h>
>> +#include <linux/io.h>
>> +#include <linux/err.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/regmap.h>
>> +#include <linux/soc/qcom/llcc-qcom.h>
>> +
>> +#define ACTIVATE                      0x1
>> +#define DEACTIVATE                    0x2
>> +#define ACT_CTRL_OPCODE_ACTIVATE      0x1
>> +#define ACT_CTRL_OPCODE_DEACTIVATE    0x2
>> +#define ACT_CTRL_ACT_TRIG             0x1
>> +#define ACT_CTRL_OPCODE_SHIFT         0x1
>> +#define ATTR1_PROBE_TARGET_WAYS_SHIFT 0x2
>> +#define ATTR1_FIXED_SIZE_SHIFT        0x3
>> +#define ATTR1_PRIORITY_SHIFT          0x4
>> +#define ATTR1_MAX_CAP_SHIFT           0x10
>> +#define ATTR0_RES_WAYS_MASK           0x00000fff
>> +#define ATR0_BONUS_WAYS_MASK          0x0fff0000
>> +#define ATR0_BONUS_WAYS_SHIFT         0x10
>> +#define LLCC_STATUS_READ_DELAY 100
>> +
>> +#define CACHE_LINE_SIZE_SHIFT 6
>> +
>> +#define LLCC_COMMON_STATUS0		0x0003000C
>> +#define LLCC_LB_CNT_MASK		0xf0000000
>> +#define LLCC_LB_CNT_SHIFT		28
>> +
>> +#define MAX_CAP_TO_BYTES(n) (n * 1024)
>> +#define LLCC_TRP_ACT_CTRLn(n) (n * 0x1000)
>> +#define LLCC_TRP_STATUSn(n)   (4 + n * 0x1000)
>> +#define LLCC_TRP_ATTR0_CFGn(n) (0x21000 + 0x8 * n)
>> +#define LLCC_TRP_ATTR1_CFGn(n) (0x21004 + 0x8 * n)
>> +
>> +
>> +
>> +static const struct regmap_config llcc_regmap_config = {
>> +		.reg_bits = 32,
>> +		.reg_stride = 4,
>> +		.val_bits = 32,
>> +		.fast_io = true,
>> +};
>> +
>> +
>> +/* Get the slice entry by index */
>> +static struct llcc_slice_desc *llcc_slice_get_entry(struct device 
>> *dev, int n)
> 
> drop this *slice* word from function names
> 
>> +{
>> +	struct of_phandle_args phargs;
>> +	struct llcc_drv_data *drv;
>> +	const struct llcc_slice_config *llcc_data_ptr;
>> +	struct llcc_slice_desc *desc;
>> +	struct platform_device *pdev;
>> +	u32 sz, count;
>> +
>> +	if (of_parse_phandle_with_args(dev->of_node, "cache-slices",
>> +				       "#cache-cells", n, &phargs)) {
>> +		pr_err("can't parse \"cache-slices\" property\n");
> 
> drop all pr_err here and below.
> 
>> +		return ERR_PTR(-ENODEV);
>> +	}
>> +
>> +	pdev = of_find_device_by_node(phargs.np);
>> +	if (!pdev) {
>> +		pr_err("Cannot find platform device from phandle\n");
>> +		return ERR_PTR(-ENODEV);
>> +	}
>> +
>> +	drv = platform_get_drvdata(pdev);
>> +	if (!drv) {
>> +		pr_err("cannot find platform driver data\n");
>> +		return ERR_PTR(-EFAULT);
>> +	}
>> +
>> +	llcc_data_ptr = drv->slice_data;
>> +	sz = drv->llcc_config_data_sz;
>> +	count = 0;
>> +
>> +	while (llcc_data_ptr && count < sz) {
>> +		if (llcc_data_ptr->usecase_id == phargs.args[0])
>> +			break;
>> +		llcc_data_ptr++;
>> +		count++;
>> +	}
>> +
>> +	if (llcc_data_ptr == NULL || count == sz) {
>> +		pr_err("can't find %d usecase id\n", phargs.args[0]);
>> +		return ERR_PTR(-ENODEV);
>> +	}
>> +
>> +	desc = kzalloc(sizeof(struct llcc_slice_desc), GFP_KERNEL);
>> +	if (!desc)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	desc->llcc_slice_id = llcc_data_ptr->slice_id;
>> +	desc->llcc_slice_size = llcc_data_ptr->max_cap;
>> +	desc->dev = &pdev->dev;
>> +
>> +	return desc;
>> +}
>> +
>> +/**
>> + * llcc_slice_getd - get llcc slice descriptor
>> + * @dev: Device pointer of the client
>> + * @name: Name of the use case
>> + *
>> + * A pointer to llcc slice descriptor will be returned on success and
>> + * and error pointer is returned on failure
>> + */
>> +struct llcc_slice_desc *llcc_slice_getd(struct device *dev, const 
>> char *name)
>> +{
>> +	struct device_node *np = dev->of_node;
>> +	int index = 0;
>> +	const char *slice_name;
>> +	struct property *prop;
>> +
>> +	if (!np) {
>> +		dev_err(dev, "%s() currently only supports DT\n", __func__);
>> +		return ERR_PTR(-ENOENT);
>> +	}
>> +
>> +	if (!of_get_property(np, "cache-slice-names", NULL)) {
>> +		dev_err(dev,
>> +			"%s() requires a \"cache-slice-names\" property\n",
>> +			__func__);
>> +		return ERR_PTR(-ENOENT);
>> +	}
>> +
>> +	of_property_for_each_string(np, "cache-slice-names", prop, 
>> slice_name) {
>> +		if (!strcmp(name, slice_name))
>> +			break;
>> +		index++;
>> +	}
>> +
>> +	return llcc_slice_get_entry(dev, index);
>> +}
>> +EXPORT_SYMBOL(llcc_slice_getd);
> 
> should be EXPORT_SYMBOL_GPL here and on all other places.
> 
>> +
>> +/**
>> + * llcc_slice_putd - llcc slice descritpor
>> + * @desc: Pointer to llcc slice descriptor
>> + */
>> +void llcc_slice_putd(struct llcc_slice_desc *desc)
>> +{
>> +	kfree(desc);
>> +}
>> +EXPORT_SYMBOL(llcc_slice_putd);
>> +
>> +static int llcc_update_act_ctrl(struct llcc_drv_data *drv, u32 sid,
>> +				u32 act_ctrl_reg_val, u32 status)
>> +{
>> +	u32 act_ctrl_reg;
>> +	u32 status_reg;
>> +	u32 slice_status;
>> +	unsigned long timeout;
>> +
>> +	act_ctrl_reg = drv->b_off + LLCC_TRP_ACT_CTRLn(sid);
>> +	status_reg = drv->b_off + LLCC_TRP_STATUSn(sid);
>> +
>> +	regmap_write(drv->llcc_map, act_ctrl_reg, act_ctrl_reg_val);
> 
> check for regmap_write error? Infact you don't check for regmap errors
> at all.
> 
>> +
>> +	/* Make sure the activate trigger is applied before clearing it */
>> +	mb();
>> +
>> +	/* Clear the ACTIVE trigger */
>> +	act_ctrl_reg_val &= ~ACT_CTRL_ACT_TRIG;
>> +	regmap_write(drv->llcc_map, act_ctrl_reg, act_ctrl_reg_val);
>> +
>> +	timeout = jiffies + usecs_to_jiffies(LLCC_STATUS_READ_DELAY);
>> +	while (time_before(jiffies, timeout)) {
>> +		regmap_read(drv->llcc_map, status_reg, &slice_status);
>> +		if (!(slice_status & status))
>> +			return 0;
>> +	}
>> +
>> +	return -ETIMEDOUT;
>> +}
>> +
>> +/**
>> + * llcc_slice_activate - Activate the llcc slice
>> + * @desc: Pointer to llcc slice descriptor
>> + *
>> + * A value zero will be returned on success and a negative errno will
>> + * be returned in error cases
>> + */
>> +int llcc_slice_activate(struct llcc_slice_desc *desc)
>> +{
>> +	int rc = -EINVAL;
> 
> please use 'ret' for variable name, here and on all other places.
> 
>> +	u32 act_ctrl_val;
>> +	struct llcc_drv_data *drv;
>> +
>> +	if (desc == NULL)
>> +		return rc;
>> +
>> +	drv = dev_get_drvdata(desc->dev);
>> +	if (!drv)
>> +		return rc;
> 
> return -EINVAL;
> 
>> +
>> +	mutex_lock(&drv->slice_mutex);
>> +	if (test_bit(desc->llcc_slice_id, drv->llcc_slice_map)) {
>> +		mutex_unlock(&drv->slice_mutex);
>> +		return 0;
>> +	}
>> +
>> +	act_ctrl_val = ACT_CTRL_OPCODE_ACTIVATE << ACT_CTRL_OPCODE_SHIFT;
>> +	act_ctrl_val |= ACT_CTRL_ACT_TRIG;
>> +
>> +	rc = llcc_update_act_ctrl(drv, desc->llcc_slice_id, act_ctrl_val,
>> +				  DEACTIVATE);
>> +
>> +	__set_bit(desc->llcc_slice_id, drv->llcc_slice_map);
>> +	mutex_unlock(&drv->slice_mutex);
>> +
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL(llcc_slice_activate);
>> +
>> +/**
>> + * llcc_slice_deactivate - Deactivate the llcc slice
>> + * @desc: Pointer to llcc slice descriptor
>> + *
>> + * A value zero will be returned on success and a negative errno will
>> + * be returned in error cases
>> + */
>> +int llcc_slice_deactivate(struct llcc_slice_desc *desc)
> 
> just llcc_activate
> 
>> +{
>> +	u32 act_ctrl_val;
>> +	int rc = -EINVAL;
>> +	struct llcc_drv_data *drv;
>> +
>> +	if (desc == NULL)
>> +		return rc;
>> +
>> +	drv = dev_get_drvdata(desc->dev);
>> +	if (!drv)
>> +		return rc;
>> +
>> +	mutex_lock(&drv->slice_mutex);
>> +	if (!test_bit(desc->llcc_slice_id, drv->llcc_slice_map)) {
>> +		mutex_unlock(&drv->slice_mutex);
>> +		return 0;
>> +	}
>> +	act_ctrl_val = ACT_CTRL_OPCODE_DEACTIVATE << ACT_CTRL_OPCODE_SHIFT;
>> +	act_ctrl_val |= ACT_CTRL_ACT_TRIG;
>> +
>> +	rc = llcc_update_act_ctrl(drv, desc->llcc_slice_id, act_ctrl_val,
>> +				  ACTIVATE);
>> +
>> +	__clear_bit(desc->llcc_slice_id, drv->llcc_slice_map);
>> +	mutex_unlock(&drv->slice_mutex);
>> +
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL(llcc_slice_deactivate);
>> +
>> +/**
>> + * llcc_get_slice_id - return the slice id
>> + * @desc: Pointer to llcc slice descriptor
>> + *
>> + * A positive value will be returned on success and a negative errno 
>> will
>> + * be returned on error
>> + */
>> +int llcc_get_slice_id(struct llcc_slice_desc *desc)
>> +{
>> +	if (!desc)
>> +		return -EINVAL;
>> +
>> +	return desc->llcc_slice_id;
>> +}
>> +EXPORT_SYMBOL(llcc_get_slice_id);
>> +
>> +/**
>> + * llcc_get_slice_size - return the slice id
>> + * @desc: Pointer to llcc slice descriptor
>> + *
>> + * A positive value will be returned on success and zero will 
>> returned on
>> + * error
>> + */
>> +size_t llcc_get_slice_size(struct llcc_slice_desc *desc)
>> +{
>> +	if (!desc)
>> +		return 0;
>> +
>> +	return desc->llcc_slice_size;
>> +}
>> +EXPORT_SYMBOL(llcc_get_slice_size);
>> +
>> +static void qcom_llcc_cfg_program(struct platform_device *pdev)
>> +{
>> +	int i;
>> +	u32 attr1_cfg;
>> +	u32 attr0_cfg;
>> +	u32 attr1_val;
>> +	u32 attr0_val;
>> +	u32 max_cap_cacheline;
>> +	u32 sz;
>> +	const struct llcc_slice_config *llcc_table;
>> +	struct llcc_slice_desc desc;
>> +	struct llcc_drv_data *drv = platform_get_drvdata(pdev);
>> +	u32 b_off = drv->b_off;
>> +
>> +	sz = drv->llcc_config_data_sz;
>> +	llcc_table = drv->slice_data;
>> +
>> +	for (i = 0; i < sz; i++) {
>> +		attr1_cfg = b_off + LLCC_TRP_ATTR1_CFGn(llcc_table[i].slice_id);
>> +		attr0_cfg = b_off + LLCC_TRP_ATTR0_CFGn(llcc_table[i].slice_id);
>> +
>> +		attr1_val = llcc_table[i].cache_mode;
>> +		attr1_val |= (llcc_table[i].probe_target_ways <<
>> +				ATTR1_PROBE_TARGET_WAYS_SHIFT);
> 
> braces are not needed, here and below.
> 
>> +		attr1_val |= (llcc_table[i].fixed_size <<
>> +				ATTR1_FIXED_SIZE_SHIFT);
>> +		attr1_val |= (llcc_table[i].priority << ATTR1_PRIORITY_SHIFT);
>> +
>> +		max_cap_cacheline = MAX_CAP_TO_BYTES(llcc_table[i].max_cap);
>> +
>> +		/* LLCC instances can vary for each target.
>> +		 * The SW writes to broadcast register which gets propagated
>> +		 * to each llcc instace (llcc0,.. llccN).
>> +		 * Since the size of the memory is divided equally amongst the
>> +		 * llcc instances, we need to configure the max cap accordingly.
>> +		 */
>> +		max_cap_cacheline = (max_cap_cacheline / drv->num_banks);
>> +		max_cap_cacheline >>= CACHE_LINE_SIZE_SHIFT;
>> +		attr1_val |= (max_cap_cacheline << ATTR1_MAX_CAP_SHIFT);
>> +
>> +		attr0_val = llcc_table[i].res_ways & ATTR0_RES_WAYS_MASK;
>> +		attr0_val |= llcc_table[i].bonus_ways << ATR0_BONUS_WAYS_SHIFT;
>> +
>> +		regmap_write(drv->llcc_map, attr1_cfg, attr1_val);
>> +		regmap_write(drv->llcc_map, attr0_cfg, attr0_val);
>> +
>> +		/* Make sure that the SCT is programmed before activating */
>> +		mb();
> 
> shouldn't this be wmb()?
> 
>> +
>> +		if (llcc_table[i].activate_on_init) {
>> +			desc.llcc_slice_id = llcc_table[i].slice_id;
>> +			desc.dev = &pdev->dev;
>> +			if (llcc_slice_activate(&desc)) {
>> +				pr_err("activate slice id: %d timed out\n",
>> +						desc.llcc_slice_id);
> 
> Make the fucntion to return int and propagate the error. And please 
> drop
> all pr_err.
> 
>> +			}
>> +		}
>> +	}
>> +}
>> +
>> +int qcom_llcc_probe(struct platform_device *pdev,
>> +		      const struct llcc_slice_config *llcc_cfg, u32 sz)
>> +{
>> +	int rc = 0;
>> +	u32 num_banks = 0;
>> +	struct device *dev = &pdev->dev;
>> +	static struct llcc_drv_data *drv_data;
> 
> static ??
> 
>> +	struct resource *res;
>> +	void __iomem *base;
>> +
>> +	drv_data = devm_kzalloc(dev, sizeof(*drv_data), GFP_KERNEL);
>> +	if (!drv_data)
>> +		return PTR_ERR(drv_data);
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	base = devm_ioremap_resource(&pdev->dev, res);
>> +	if (IS_ERR(base)) {
>> +		dev_err(&pdev->dev, "Cannot find the resource in device\n");
> 
> this error message is not needed.
> 
>> +		return PTR_ERR(base);
>> +	}
>> +
>> +	drv_data->llcc_map = devm_regmap_init_mmio(dev, base, 
>> &llcc_regmap_config);
>> +	if (IS_ERR(drv_data->llcc_map)) {
>> +		dev_err(&pdev->dev, "Cannot init the regmap for llcc\n");
> 
> again not needed.
> 
>> +		return PTR_ERR(drv_data->llcc_map);
>> +	}
>> +
>> +	regmap_read(drv_data->llcc_map, LLCC_COMMON_STATUS0,
>> +		    &num_banks);
>> +
>> +	num_banks &= LLCC_LB_CNT_MASK;
>> +	num_banks >>= LLCC_LB_CNT_SHIFT;
>> +	drv_data->num_banks = num_banks;
>> +
>> +	rc = of_property_read_u32(pdev->dev.of_node, "max-slices",
>> +				  &drv_data->max_slices);
>> +	if (rc) {
>> +		dev_err(&pdev->dev, "Invalid max-slices dt entry\n");
> 
> and this too.
> 
>> +		devm_kfree(&pdev->dev, drv_data);
>> +		return rc;
>> +	}
> 
> need blank line here.
> 
>> +	drv_data->offsets = devm_kzalloc(dev, num_banks*sizeof(u32), 
>> GFP_KERNEL);
>> +	if (!drv_data->offsets) {
>> +		devm_kfree(&pdev->dev, drv_data);
>> +		return PTR_ERR(drv_data->offsets);
>> +	}
>> +
>> +	drv_data->offsets[0] = 0x0;
>> +	drv_data->offsets[1] = 0x80000;
>> +	drv_data->offsets[2] = 0x100000;
>> +	drv_data->offsets[3] = 0x180000;
>> +	drv_data->b_off = 0x200000;
> 
> shouln't this be SoC or llcc version specific?
> 
>> +
>> +	drv_data->llcc_slice_map = 
>> kcalloc(BITS_TO_LONGS(drv_data->max_slices),
>> +				   sizeof(unsigned long), GFP_KERNEL);
>> +
>> +	if (!drv_data->llcc_slice_map) {
>> +		devm_kfree(&pdev->dev, drv_data);
>> +		return PTR_ERR(drv_data->llcc_slice_map);
>> +	}
>> +
>> +	bitmap_zero(drv_data->llcc_slice_map, drv_data->max_slices);
>> +	drv_data->slice_data = llcc_cfg;
>> +	drv_data->llcc_config_data_sz = sz;
>> +	mutex_init(&drv_data->slice_mutex);
>> +	platform_set_drvdata(pdev, drv_data);
>> +
>> +	qcom_llcc_cfg_program(pdev);
>> +
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL(qcom_llcc_probe);
>> +
>> +int qcom_llcc_remove(struct platform_device *pdev)
>> +{
>> +	static struct llcc_drv_data *drv_data;
>> +
>> +	drv_data = platform_get_drvdata(pdev);
>> +
>> +	mutex_destroy(&drv_data->slice_mutex);
>> +	kfree(drv_data->llcc_slice_map);
>> +	devm_kfree(&pdev->dev, drv_data);
>> +	platform_set_drvdata(pdev, NULL);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(qcom_llcc_remove);
>> diff --git a/include/linux/soc/qcom/llcc-qcom.h 
>> b/include/linux/soc/qcom/llcc-qcom.h
>> new file mode 100644
>> index 0000000..c408a8d
>> --- /dev/null
>> +++ b/include/linux/soc/qcom/llcc-qcom.h
>> @@ -0,0 +1,178 @@
>> +/* Copyright (c) 2017-2018, The Linux Foundation. All rights 
>> reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or 
>> modify
>> + * it under the terms of the GNU General Public License version 2 and
>> + * only version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#ifndef __LLCC_QCOM__
>> +#define __LLCC_QCOM__
>> +
>> +/**
>> + * llcc_slice_desc - Cache slice descriptor
>> + * @llcc_slice_id: llcc slice id
>> + * @llcc_slice_size: Size allocated for the llcc slice
>> + * @dev: pointer to llcc device
>> + */
>> +struct llcc_slice_desc {
> 
> 'llcc_desc' is enough.
> 
>> +	int llcc_slice_id;
> 
> 'slice_id' or even better 'id'.
> 
>> +	size_t llcc_slice_size;
> 
> 'slice_size' or just 'size'
> 
>> +	struct device *dev;
>> +};
>> +
>> +/**
>> + * llcc_slice_config - Data associated with the llcc slice
>> + * @name: name of the use case associated with the llcc slice
>> + * @usecase_id: usecase id for which the llcc slice is used
>> + * @slice_id: llcc slice id assigned to each slice
>> + * @max_cap: maximum capacity of the llcc slice
>> + * @priority: priority of the llcc slice
>> + * @fixed_size: whether the llcc slice can grow beyond its size
>> + * @bonus_ways: bonus ways associated with llcc slice
>> + * @res_ways: reserved ways associated with llcc slice
>> + * @cache_mode: mode of the llcce slice
>> + * @probe_target_ways: Probe only reserved and bonus ways on a cache 
>> miss
>> + * @dis_cap_alloc: Disable capacity based allocation
>> + * @retain_on_pc: Retain through power collapse
>> + * @activate_on_init: activate the slice on init
>> + */
>> +struct llcc_slice_config {
> 
> Once you move struct llcc_slice_config sdm845_data in llcc.c this
> structure must not be exported.
> 
>> +	const char *name;
>> +	int usecase_id;
> 
> unsigned int?
> 
>> +	int slice_id;
> 
> unsingned int?
> 
>> +	u32 max_cap;
>> +	u32 priority;
>> +	bool fixed_size;
>> +	u32 bonus_ways;
>> +	u32 res_ways;
>> +	u32 cache_mode;
>> +	u32 probe_target_ways;
>> +	bool dis_cap_alloc;
>> +	bool retain_on_pc;
>> +	u32 activate_on_init;
>> +};
>> +
>> +/**
>> + * llcc_drv_data - Data associated with the llcc driver
>> + * @llcc_map: regmap associated with the llcc device
>> + * @slice_data: pointer to the data structure associated with slice
> 
> should be better 'data structure for slice configuration'?
> 
>> + * @slice_mutex: mutex associated with each slice
>> + * @llcc_config_data_sz: size of the config data table
>> + * @max_slices: max slices as read from device tree
>> + * @b_off: Offset of the broadcast bank
>> + * @num_banks: Number of llcc banks
>> + * @llcc_slice_map: Bit map to track the active slice ids
>> + * @offsets: Pointer to the bank offsets array
>> + */
>> +
>> +struct llcc_drv_data {
>> +		struct regmap *llcc_map;
> 
> s/llcc_map/regmap
> 
>> +		const struct llcc_slice_config *slice_data;
> 
> s/slice_data/cfg
> 
>> +		struct mutex slice_mutex;
> 
> just 'lock'
> 
>> +		u32 llcc_config_data_sz;
> 
> cfg_size?
> 
>> +		u32 max_slices;
>> +		u32 b_off;
>> +		u32 num_banks;
>> +		unsigned long *llcc_slice_map;
> 
> only 'bitmap'?
> 
>> +		u32 *offsets;
>> +};
>> +
>> +
> 
> <cut>

-- 
--
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project
