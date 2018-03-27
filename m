Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751173AbeC0Hdz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 03:33:55 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44204 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751195AbeC0Hdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 03:33:41 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AD90060558
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
Subject: Re: [PATCH v3 1/6] phy: qcom-qmp: Enable pipe_clk before checking
 USB3 PHY_STATUS
To: Vivek Gautam <vivek.gautam@codeaurora.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        Varadarajan Narayanan <varada@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Fengguang Wu <fengguang.wu@intel.com>
References: <1521785487-29866-1-git-send-email-mgautam@codeaurora.org>
 <1521785487-29866-2-git-send-email-mgautam@codeaurora.org>
 <e09a4059-d43b-236b-f0f4-1a45dbaa65fc@codeaurora.org>
From: Manu Gautam <mgautam@codeaurora.org>
Message-ID: <7bd4d3d9-1317-b63b-4243-aafb2cfda8a6@codeaurora.org>
Date: Tue, 27 Mar 2018 13:03:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <e09a4059-d43b-236b-f0f4-1a45dbaa65fc@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vivek,


On 3/27/2018 12:21 PM, Vivek Gautam wrote:
> Hi Manu,
>
>
> On 3/23/2018 11:41 AM, Manu Gautam wrote:
>> QMP PHY for USB mode requires pipe_clk for calibration and PLL lock
>> to take place.
>
> AFAIK, that's not true. The pipe clock is the *output* of the PLL, and it's should not
> be needed for PLL calibration and locking. The PLL locking happens when the phy is
> configured and powered on.
> Atleast that's what the PIPE spec also says.
>
>            CLK
>              |
>              |
>              Y
>    ----------------
>   |      PLL        |--------> PCLK (this is pipe clock 125/250/... MHz corresponding to the data width)
>    ----------------
>
> That's the reason we were enabling it after the PLL was locked.

I got this clarified by QMP PHY hardware designer that pipe_clk is indeed
needed for PHY to complete init sequence and reflect in PHY_STATUS (mainly
for calibration and I should remove PLL lock from commit subject).
It might work on some platforms without this change if boot code
leaves pipe clock enabled during bootup.


>
>> This clock is output from PHY to GCC clock_ctl and then
>> fed back to QMP PHY and is available from PHY only after PHY is reset
>> and initialized, hence it can't be enabled too early in initialization
>> sequence.
>>
>> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
>> ---
>>   drivers/phy/qualcomm/phy-qcom-qmp.c | 33 ++++++++++++++++++++++++++++++++-
>>   1 file changed, 32 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
>> index 6470c5d..5d8df6a 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
>> @@ -1008,6 +1008,19 @@ static int qcom_qmp_phy_init(struct phy *phy)
>>       status = pcs + cfg->regs[QPHY_PCS_READY_STATUS];
>>       mask = cfg->mask_pcs_ready;
>>   +    /*
>> +     * USB3 PHY requires pipe_clk for PLL lock and calibration.
>> +     * Enable it from here for USB. For UFS/PCIE, it gets enabled
>> +     * from poweron.
>> +     */
>> +    if (cfg->type == PHY_TYPE_USB3) {
>> +        ret = clk_prepare_enable(qphy->pipe_clk);
>
> As mentioned before AFAIU, pipe clock is just an output coming out of the PHY's PLL
> and we shouldn't try to enable pipe clock before PHY even gets initialized.
> We should may just try to first fix the unbalanced pipe clock enable/disable problem.
>
> Moreover, lets take care of all USB, PCIe and DP phys when we want to enable/disbale
> pipe clock as all of them use this clock.

I will get the pipe_clk requirement for PCIE as well and do it for both
(depending on gcc change).

>
> Best regards
> Vivek
>
>> +        if (ret) {
>> +            dev_err(qmp->dev, "pipe_clk enable err=%d\n", ret);
>> +            goto err_clk_enable;
>> +        }
>> +    }
>> +
>>       ret = readl_poll_timeout(status, val, !(val & mask), 1,
>>                    PHY_INIT_COMPLETE_TIMEOUT);
>>       if (ret) {
>> @@ -1019,6 +1032,9 @@ static int qcom_qmp_phy_init(struct phy *phy)
>>       return ret;
>>     err_pcs_ready:
>> +    if (cfg->type == PHY_TYPE_USB3)
>> +        clk_disable_unprepare(qphy->pipe_clk);
>> +err_clk_enable:
>>       if (cfg->has_lane_rst)
>>           reset_control_assert(qphy->lane_rst);
>>   err_lane_rst:
>> @@ -1288,10 +1304,19 @@ static int phy_pipe_clk_register(struct qcom_qmp *qmp, struct device_node *np)
>>       .owner        = THIS_MODULE,
>>   };
>>   +/* USB PHY doesn't require power_on op */
>> +static const struct phy_ops qcom_qmp_usb_phy_gen_ops = {
>> +    .init        = qcom_qmp_phy_init,
>> +    .exit        = qcom_qmp_phy_exit,
>> +    .set_mode    = qcom_qmp_phy_set_mode,
>> +    .owner        = THIS_MODULE,
>> +};
>> +
>>   static
>>   int qcom_qmp_phy_create(struct device *dev, struct device_node *np, int id)
>>   {
>>       struct qcom_qmp *qmp = dev_get_drvdata(dev);
>> +    const struct phy_ops *ops;
>>       struct phy *generic_phy;
>>       struct qmp_phy *qphy;
>>       char prop_name[MAX_PROP_NAME];
>> @@ -1354,7 +1379,13 @@ int qcom_qmp_phy_create(struct device *dev, struct device_node *np, int id)
>>           }
>>       }
>>   -    generic_phy = devm_phy_create(dev, np, &qcom_qmp_phy_gen_ops);
>> +    /* USB PHY doesn't use power_on op */
>> +    if (qmp->cfg->type == PHY_TYPE_USB3)
>> +        ops = &qcom_qmp_usb_phy_gen_ops;
>> +    else
>> +        ops = &qcom_qmp_phy_gen_ops;
>> +
>> +    generic_phy = devm_phy_create(dev, np, ops);
>>       if (IS_ERR(generic_phy)) {
>>           ret = PTR_ERR(generic_phy);
>>           dev_err(dev, "failed to create qphy %d\n", ret);
>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
