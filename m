Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933348AbeCNDHS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 23:07:18 -0400
Received: from regular1.263xmail.com ([211.150.99.136]:59685 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933180AbeCNDHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 23:07:12 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: chenjh@rock-chips.com
X-FST-TO: tony.xie@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: chenjh@rock-chips.com
X-UNIQUE-TAG: <5f16742f8a69a9a53bfdcb6fd8da0343>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH v2 2/2] mfd: rk808: Add restart functionality
To: Daniel Schultz <d.schultz@phytec.de>, Lee Jones <lee.jones@linaro.org>
Cc: zyw@rock-chips.com, zhangqing@rock-chips.com,
        linux-kernel@vger.kernel.org, w.egorov@phytec.de,
        "xsf@rock-chips.com" <xsf@rock-chips.com>,
        =?UTF-8?B?6LCi5L+u6ZGr?= <tony.xie@rock-chips.com>
References: <1520442110-28420-1-git-send-email-d.schultz@phytec.de>
 <1520442110-28420-2-git-send-email-d.schultz@phytec.de>
 <20180312141012.bc3xkhymkgd4q6b7@dell>
 <b5fb541f-cc48-bd4e-372c-789411b214f2@rock-chips.com>
 <2f6f31a4-b249-dc68-bf5c-5bbc3f900c77@phytec.de>
From: Joseph Chen <chenjh@rock-chips.com>
Message-ID: <2466b0b9-ab22-1631-03cd-a668c421de1f@rock-chips.com>
Date: Wed, 14 Mar 2018 11:08:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <2f6f31a4-b249-dc68-bf5c-5bbc3f900c77@phytec.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Daniel：

     I discussed with my colleagues, we agree with your idear to make 
PMIC restart as a option and controlled by a new DTS property.


在 2018/3/13 17:48, Daniel Schultz 写道:
> Hi,
>
> I can add a DTS property to enable the PMIC restart functions? So this 
> feature can be used if its desired.
>
> My problem with the CRU reset is a strange behaviour in the ROM code. 
> During a reset from MMC1 (eMMC), the ROM tries to load the SPL from 
> MMC0 (SD).
>
> Daniel
>
>
> On 03/13/2018 04:32 AM, Joseph Chen wrote:
>> Hi, Daniel：
>>
>>         On Rockchip platforms, we always use CRU to restart system. 
>> From your patch, I think you would like to support restart by CRU or 
>> PMIC, right ?
>>
>>         I think restart by PMIC is not accepted, because PMIC restart 
>> means all regualtors are reset (voltage drops to 0mv and then power 
>> on again), including vdd_arm, vdd_logic, vcc_ddr, etc. This is like a 
>> cold boot for machine.
>>
>>        We use CRU reset, because we want to keep status of last log, 
>> GRF, CRU or other registers, but PMIC restart can make them lost.
>>
>>
>> 在 2018/3/12 22:10, Lee Jones 写道:
>>> Rockchip guys,
>>>
>>> I'd really appreciate your input on these two patches please.
>>>
>>> Please provide Reviewed-by/Tested-by tags.
>>>
>>> On Wed, 07 Mar 2018, Daniel Schultz wrote:
>>>> When using Rockchip SoCs with rk805/808/818 PMICs, restarts are 
>>>> realized by
>>>> setting the reset registers in the "Clock and Reset Unit".
>>>>
>>>> Since all three shutdown functions have almost the same code, all 
>>>> logic
>>>> from the shutdown functions can be refactored to a new function
>>>> "rk808_update_bits", which can update a register by a given address 
>>>> and
>>>> bitmask.
>>>>
>>>> After that, notifier blocks and the restart functions were added to 
>>>> the
>>>> driver. Like the shutdown function, the restart is bound to the
>>>> "rockchip,system-power-controller" device tree property and can easily
>>>> revoked to the software restart by removing the property.
>>>>
>>>> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
>>>> ---
>>>> Changes:
>>>>     v2: Re-submit with recipients from Rockchip.
>>>>
>>>>   drivers/mfd/rk808.c       | 97 
>>>> ++++++++++++++++++++++++++++++-----------------
>>>>   include/linux/mfd/rk808.h |  1 +
>>>>   2 files changed, 63 insertions(+), 35 deletions(-)
>>>>
>>>> diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
>>>> index d138721..2c68f8c 100644
>>>> --- a/drivers/mfd/rk808.c
>>>> +++ b/drivers/mfd/rk808.c
>>>> @@ -27,6 +27,7 @@
>>>>   #include <linux/module.h>
>>>>   #include <linux/of_device.h>
>>>>   #include <linux/regmap.h>
>>>> +#include <linux/reboot.h>
>>>>     struct rk808_reg_data {
>>>>       int addr;
>>>> @@ -369,59 +370,73 @@ static const struct regmap_irq_chip 
>>>> rk818_irq_chip = {
>>>>     static struct i2c_client *rk808_i2c_client;
>>>>   -static void rk805_device_shutdown(void)
>>>> +static void rk808_update_bits(unsigned int reg, unsigned int 
>>>> bit_mask)
>>>>   {
>>>>       int ret;
>>>>       struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
>>>>         if (!rk808) {
>>>>           dev_warn(&rk808_i2c_client->dev,
>>>> -             "have no rk805, so do nothing here\n");
>>>> +             "have no %s, so do nothing here\n",
>>>> +             rk808->regmap_irq_chip->name);
>>>>           return;
>>>>       }
>>>>         ret = regmap_update_bits(rk808->regmap,
>>>> -                 RK805_DEV_CTRL_REG,
>>>> -                 DEV_OFF, DEV_OFF);
>>>> +                 reg,
>>>> +                 bit_mask, bit_mask);
>>>>       if (ret)
>>>> -        dev_err(&rk808_i2c_client->dev, "power off error!\n");
>>>> +        dev_err(&rk808_i2c_client->dev, "can't write to DEVCTRL: 
>>>> %x!\n",
>>>> +            ret);
>>>>   }
>>>>   -static void rk808_device_shutdown(void)
>>>> +static void rk805_device_shutdown(void)
>>>>   {
>>>> -    int ret;
>>>> -    struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
>>>> -
>>>> -    if (!rk808) {
>>>> -        dev_warn(&rk808_i2c_client->dev,
>>>> -             "have no rk808, so do nothing here\n");
>>>> -        return;
>>>> -    }
>>>> +    rk808_update_bits(RK805_DEV_CTRL_REG, DEV_OFF);
>>>> +}
>>>> +static int rk805_restart_notify(struct notifier_block *this,
>>>> +                   unsigned long mode, void *cmd)
>>>> +{
>>>> +    rk808_update_bits(RK805_DEV_CTRL_REG, DEV_OFF_RST);
>>>> +    return NOTIFY_DONE;
>>>> +}
>>>>   -    ret = regmap_update_bits(rk808->regmap,
>>>> -                 RK808_DEVCTRL_REG,
>>>> -                 DEV_OFF_RST, DEV_OFF_RST);
>>>> -    if (ret)
>>>> -        dev_err(&rk808_i2c_client->dev, "power off error!\n");
>>>> +static void rk808_device_shutdown(void)
>>>> +{
>>>> +    rk808_update_bits(RK808_DEVCTRL_REG, DEV_OFF_RST);
>>>> +}
>>>> +static int rk808_restart_notify(struct notifier_block *this,
>>>> +                   unsigned long mode, void *cmd)
>>>> +{
>>>> +    rk808_update_bits(RK808_DEVCTRL_REG, DEV_OFF);
>>>> +    return NOTIFY_DONE;
>>>>   }
>>>>     static void rk818_device_shutdown(void)
>>>>   {
>>>> -    int ret;
>>>> -    struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
>>>> +    rk808_update_bits(RK818_DEVCTRL_REG, DEV_OFF_RST);
>>>> +}
>>>> +static int rk818_restart_notify(struct notifier_block *this,
>>>> +                   unsigned long mode, void *cmd)
>>>> +{
>>>> +    rk808_update_bits(RK818_DEVCTRL_REG, DEV_OFF);
>>>> +    return NOTIFY_DONE;
>>>> +}
>>>>   -    if (!rk808) {
>>>> -        dev_warn(&rk808_i2c_client->dev,
>>>> -             "have no rk818, so do nothing here\n");
>>>> -        return;
>>>> -    }
>>>> +static struct notifier_block rk805_restart_handler = {
>>>> +    .notifier_call = rk805_restart_notify,
>>>> +    .priority = 196,
>>>> +};
>>>>   -    ret = regmap_update_bits(rk808->regmap,
>>>> -                 RK818_DEVCTRL_REG,
>>>> -                 DEV_OFF_RST, DEV_OFF_RST);
>>>> -    if (ret)
>>>> -        dev_err(&rk808_i2c_client->dev, "power off error!\n");
>>>> -}
>>>> +static struct notifier_block rk808_restart_handler = {
>>>> +    .notifier_call = rk808_restart_notify,
>>>> +    .priority = 196,
>>>> +};
>>>> +
>>>> +static struct notifier_block rk818_restart_handler = {
>>>> +    .notifier_call = rk818_restart_notify,
>>>> +    .priority = 196,
>>>> +};
>>>>     static const struct of_device_id rk808_of_match[] = {
>>>>       { .compatible = "rockchip,rk805" },
>>>> @@ -476,6 +491,7 @@ static int rk808_probe(struct i2c_client *client,
>>>>           cells = rk805s;
>>>>           nr_cells = ARRAY_SIZE(rk805s);
>>>>           pm_pwroff_fn = rk805_device_shutdown;
>>>> +        rk808->nb = &rk805_restart_handler;
>>>>           break;
>>>>       case RK808_ID:
>>>>           rk808->regmap_cfg = &rk808_regmap_config;
>>>> @@ -485,6 +501,7 @@ static int rk808_probe(struct i2c_client *client,
>>>>           cells = rk808s;
>>>>           nr_cells = ARRAY_SIZE(rk808s);
>>>>           pm_pwroff_fn = rk808_device_shutdown;
>>>> +        rk808->nb = &rk808_restart_handler;
>>>>           break;
>>>>       case RK818_ID:
>>>>           rk808->regmap_cfg = &rk818_regmap_config;
>>>> @@ -494,6 +511,7 @@ static int rk808_probe(struct i2c_client *client,
>>>>           cells = rk818s;
>>>>           nr_cells = ARRAY_SIZE(rk818s);
>>>>           pm_pwroff_fn = rk818_device_shutdown;
>>>> +        rk808->nb = &rk818_restart_handler;
>>>>           break;
>>>>       default:
>>>>           dev_err(&client->dev, "Unsupported RK8XX ID %lu\n",
>>>> @@ -546,11 +564,18 @@ static int rk808_probe(struct i2c_client 
>>>> *client,
>>>>         pm_off = of_property_read_bool(np,
>>>>                   "rockchip,system-power-controller");
>>>> -    if (pm_off && !pm_power_off) {
>>>> +    if (pm_off) {
>>>>           rk808_i2c_client = client;
>>>> -        pm_power_off = pm_pwroff_fn;
>>>> +        if (!pm_power_off)
>>>> +            pm_power_off = pm_pwroff_fn;
>>>> +        if (rk808->nb) {
>>>> +            ret = register_restart_handler(rk808->nb);
>>>> +            if (ret)
>>>> +                dev_err(&client->dev,
>>>> +                    "cannot register restart handler, %d\n",
>>>> +                    ret);
>>>> +        }
>>>>       }
>>>> -
>>>>       return 0;
>>>>     err_irq:
>>>> @@ -564,6 +589,8 @@ static int rk808_remove(struct i2c_client *client)
>>>>         regmap_del_irq_chip(client->irq, rk808->irq_data);
>>>>       pm_power_off = NULL;
>>>> +    if (rk808->nb)
>>>> +        unregister_restart_handler(rk808->nb);
>>>>         return 0;
>>>>   }
>>>> diff --git a/include/linux/mfd/rk808.h b/include/linux/mfd/rk808.h
>>>> index 338e0f6..9c26ca2 100644
>>>> --- a/include/linux/mfd/rk808.h
>>>> +++ b/include/linux/mfd/rk808.h
>>>> @@ -453,5 +453,6 @@ struct rk808 {
>>>>       long                variant;
>>>>       const struct regmap_config    *regmap_cfg;
>>>>       const struct regmap_irq_chip    *regmap_irq_chip;
>>>> +    struct notifier_block        *nb;
>>>>   };
>>>>   #endif /* __LINUX_REGULATOR_RK808_H */
>>
>
>
>

-- 
Best Regards
----------------------------------------------------------------------------
陈健洪 (Joseph Chen)
E-mail：chenjh@rock-chips.com
福州瑞芯微电子股份有限公司
Fuzhou Rockchip Electronics Co.Ltd
福建省福州市铜盘路软件大道89号软件园A区21号楼 (350003)
No. 21 Building, A District, No.89,software Boulevard Fuzhou,Fujian,PRC
TEL：0591-83991906/07-8573
