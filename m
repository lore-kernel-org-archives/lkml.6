Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751718AbeCWEjB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 00:39:01 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41374 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751175AbeCWEi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 00:38:59 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E78CA6055D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
Subject: Re: [PATCH v2 1/6] phy: qcom-qmp: Enable pipe_clk before checking
 USB3 PHY_STATUS
To: Stephen Boyd <sboyd@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Varadarajan Narayanan <varada@codeaurora.org>,
        smuthayy <smuthayy@codeaurora.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Fengguang Wu <fengguang.wu@intel.com>
References: <1521708646-5379-1-git-send-email-mgautam@codeaurora.org>
 <1521708646-5379-2-git-send-email-mgautam@codeaurora.org>
 <152174418191.178046.10173529959609556848@swboyd.mtv.corp.google.com>
From: Manu Gautam <mgautam@codeaurora.org>
Message-ID: <7bffd76a-7a14-d62c-7e12-2d4eb2ba7ff2@codeaurora.org>
Date: Fri, 23 Mar 2018 10:08:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <152174418191.178046.10173529959609556848@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,


On 3/23/2018 12:13 AM, Stephen Boyd wrote:
> Quoting Manu Gautam (2018-03-22 01:50:41)
>> QMP PHY for USB mode requires pipe_clk for calibration and PLL lock
>> to take place. This lock is output from PHY to GCC clock_ctl and then
> s/lock/clock/
Yes, will fix typo.
>> fed back to QMP PHY and is output from PHY only after PHY is reset
>> and initialized, hence it can't be enabled too early in initialization
>> sequence.
>>
>> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
>> ---
>>  drivers/phy/qualcomm/phy-qcom-qmp.c | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
>> index 6470c5d..73aa282 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
>> @@ -797,8 +797,13 @@ static int qcom_qmp_phy_poweron(struct phy *phy)
>>  {
>>         struct qmp_phy *qphy = phy_get_drvdata(phy);
>>         struct qcom_qmp *qmp = qphy->qmp;
>> +       const struct qmp_phy_cfg *cfg = qmp->cfg;
>>         int ret;
>>  
>> +       /* Not needed for USB3 PHY as pipe_clk is enabled from phy_init */
>> +       if (cfg->type == PHY_TYPE_USB3)
>> +               return 0;
> Would be nice to not even assign phy_poweron when the PHY is USB3 type.
Yes, that should be better.

>
>> +
>>         ret = clk_prepare_enable(qphy->pipe_clk);
>>         if (ret)
>>                 dev_err(qmp->dev, "pipe_clk enable failed, err=%d\n", ret);
>> @@ -1008,6 +1013,19 @@ static int qcom_qmp_phy_init(struct phy *phy)
>>         status = pcs + cfg->regs[QPHY_PCS_READY_STATUS];
>>         mask = cfg->mask_pcs_ready;
>>  
>> +       /* USB3 PHY requires pipe_clk for PLL lock and calibration */
>> +       if (cfg->type == PHY_TYPE_USB3) {
>> +               ret = clk_prepare_enable(qphy->pipe_clk);
>> +               if (ret)
>> +                       dev_err(qmp->dev, "pipe_clk enable err=%d\n", ret);
>> +               /*
>> +                * Ignore this error as pipe_clk might take some time to get
>> +                * enabled. In any case following check for PHY PLL lock would
>> +                * timeout below if there is a fatal error and clock is not fed
>> +                * to PHY
>> +                */
>> +
> This is odd. If clk_enable() fails then we don't keep parent clks (or
> the clk that's being operated on) up refcounted and enabled. How is that
> going to work?

I agree. My intent was to ignore only halt_check errors from clock driver.
In any case this condition (to ignore clk_enable error) should probably
be handled in clock driver. And I see that clock driver is already using
halt_check as BRANCH_HALT_DELAY, so I don't need to worry about that
in phy driver.



-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
