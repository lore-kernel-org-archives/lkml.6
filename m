Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751812AbeCVSnF convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 14:43:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:48606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751595AbeCVSnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 14:43:03 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 996E820685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Manu Gautam <mgautam@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1521708646-5379-2-git-send-email-mgautam@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Varadarajan Narayanan <varada@codeaurora.org>,
        smuthayy <smuthayy@codeaurora.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Fengguang Wu <fengguang.wu@intel.com>
References: <1521708646-5379-1-git-send-email-mgautam@codeaurora.org>
 <1521708646-5379-2-git-send-email-mgautam@codeaurora.org>
Message-ID: <152174418191.178046.10173529959609556848@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 1/6] phy: qcom-qmp: Enable pipe_clk before checking USB3
 PHY_STATUS
Date: Thu, 22 Mar 2018 11:43:01 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Manu Gautam (2018-03-22 01:50:41)
> QMP PHY for USB mode requires pipe_clk for calibration and PLL lock
> to take place. This lock is output from PHY to GCC clock_ctl and then

s/lock/clock/

> fed back to QMP PHY and is output from PHY only after PHY is reset
> and initialized, hence it can't be enabled too early in initialization
> sequence.
> 
> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index 6470c5d..73aa282 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -797,8 +797,13 @@ static int qcom_qmp_phy_poweron(struct phy *phy)
>  {
>         struct qmp_phy *qphy = phy_get_drvdata(phy);
>         struct qcom_qmp *qmp = qphy->qmp;
> +       const struct qmp_phy_cfg *cfg = qmp->cfg;
>         int ret;
>  
> +       /* Not needed for USB3 PHY as pipe_clk is enabled from phy_init */
> +       if (cfg->type == PHY_TYPE_USB3)
> +               return 0;

Would be nice to not even assign phy_poweron when the PHY is USB3 type.

> +
>         ret = clk_prepare_enable(qphy->pipe_clk);
>         if (ret)
>                 dev_err(qmp->dev, "pipe_clk enable failed, err=%d\n", ret);
> @@ -1008,6 +1013,19 @@ static int qcom_qmp_phy_init(struct phy *phy)
>         status = pcs + cfg->regs[QPHY_PCS_READY_STATUS];
>         mask = cfg->mask_pcs_ready;
>  
> +       /* USB3 PHY requires pipe_clk for PLL lock and calibration */
> +       if (cfg->type == PHY_TYPE_USB3) {
> +               ret = clk_prepare_enable(qphy->pipe_clk);
> +               if (ret)
> +                       dev_err(qmp->dev, "pipe_clk enable err=%d\n", ret);
> +               /*
> +                * Ignore this error as pipe_clk might take some time to get
> +                * enabled. In any case following check for PHY PLL lock would
> +                * timeout below if there is a fatal error and clock is not fed
> +                * to PHY
> +                */
> +

This is odd. If clk_enable() fails then we don't keep parent clks (or
the clk that's being operated on) up refcounted and enabled. How is that
going to work?
