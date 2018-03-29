Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752206AbeC2R31 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 13:29:27 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:43312 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752058AbeC2R3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 13:29:25 -0400
X-Google-Smtp-Source: AIpwx4+NqnbEB44GM+wnnphq0BobiKVoT9lFJMoRyk5YEZpY6FTJM8pQ/sINrHPhkrJD2e3CHJkDPQ==
MIME-Version: 1.0
References: <1522321466-21755-1-git-send-email-mgautam@codeaurora.org> <1522321466-21755-3-git-send-email-mgautam@codeaurora.org>
In-Reply-To: <1522321466-21755-3-git-send-email-mgautam@codeaurora.org>
From: Evan Green <evgreen@chromium.org>
Date: Thu, 29 Mar 2018 17:28:46 +0000
X-Gmail-Original-Message-ID: <CAE=gft5+xXk0BOEDTm5k7JLUrp63ARsROKoe68kMRdDqBkC11Q@mail.gmail.com>
Message-ID: <CAE=gft5+xXk0BOEDTm5k7JLUrp63ARsROKoe68kMRdDqBkC11Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] phy: qcom-qmp: Enable pipe_clk before PHY initialization
To: Manu Gautam <mgautam@codeaurora.org>
Cc: kishon@ti.com, robh@kernel.org, sboyd@codeaurora.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, vivek.gautam@codeaurora.org,
        Doug Anderson <dianders@chromium.org>, linux-arm-msm@vger.kernel.org,
        varada@codeaurora.org, weiyongjun1@huawei.com, fengguang.wu@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manu,

On Thu, Mar 29, 2018 at 4:06 AM Manu Gautam <mgautam@codeaurora.org> wrote:

> QMP PHY for USB/PCIE requires pipe_clk for locking of
> retime buffers at the pipe interface. Driver checks for
> PHY_STATUS without enabling pipe_clk due to which
> phy_init() fails with initialization timeout.
> Though pipe_clk is output from PHY (after PLL is programmed
> during initialization sequence) to GCC clock_ctl and then fed
> back to PHY but for PHY_STATUS register to reflect successful
> initialization pipe_clk from GCC must be present.
> Since, clock driver now ignores status_check for pipe_clk on
> clk_enable/disable, driver can safely enable/disable pipe_clk
> from phy_init/exit.

> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp.c | 22 ++++++++--------------
>   1 file changed, 8 insertions(+), 14 deletions(-)

> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c
b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index 6470c5d..fddb1c9 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -793,19 +793,6 @@ static void qcom_qmp_phy_configure(void __iomem
*base,
>          }
>   }

> -static int qcom_qmp_phy_poweron(struct phy *phy)
> -{
> -       struct qmp_phy *qphy = phy_get_drvdata(phy);
> -       struct qcom_qmp *qmp = qphy->qmp;
> -       int ret;
> -
> -       ret = clk_prepare_enable(qphy->pipe_clk);
> -       if (ret)
> -               dev_err(qmp->dev, "pipe_clk enable failed, err=%d\n",
ret);
> -
> -       return ret;
> -}
> -
>   static int qcom_qmp_phy_com_init(struct qcom_qmp *qmp)
>   {

This change looks good to me, it has much nicer symmetry. It did get me
looking at qcom_qmp_phy_com_init though. This isn't directly related to
your change, but I think there might be an issue with qmp->init_count. We
increment it at the start of the function, but then if init fails we don't
decrement it. So if we then try init again later, it magically succeeds
without actually initing anything. The other side, qcom_qmp_phy_com_exit
doesn't have this problem because exit doesn't fail (which begs the
question of why it has a return value).

I don't need to hold up this series, since this isn't strictly related to
your changes, but if you do spin again, you could include it. Otherwise you
or I could send it along as a followup.

-Evan
