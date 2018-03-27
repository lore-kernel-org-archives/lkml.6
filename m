Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751060AbeC0E0x (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 00:26:53 -0400
Received: from mail-vk0-f42.google.com ([209.85.213.42]:33312 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750881AbeC0E0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 00:26:51 -0400
X-Google-Smtp-Source: AG47ELsEbIjwtCHY4nSt9U0KQ8+X6550U1O1vS2AUKekqlZpD3Mc+ErP8Xf5k/HURC/LJ93/cjlH3DoA92hPJr6ev/M=
MIME-Version: 1.0
In-Reply-To: <1521785487-29866-2-git-send-email-mgautam@codeaurora.org>
References: <1521785487-29866-1-git-send-email-mgautam@codeaurora.org> <1521785487-29866-2-git-send-email-mgautam@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 26 Mar 2018 21:26:49 -0700
X-Google-Sender-Auth: GnUKBH3DQnGmcScjILUGGDOTHhY
Message-ID: <CAD=FV=V7xDh6fvG12xOV9=WwTDLiuQxdWFr7Bq6wjPJ5gShrVA@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] phy: qcom-qmp: Enable pipe_clk before checking
 USB3 PHY_STATUS
To: Manu Gautam <mgautam@codeaurora.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Varadarajan Narayanan <varada@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Fengguang Wu <fengguang.wu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Manu

On Thu, Mar 22, 2018 at 11:11 PM, Manu Gautam <mgautam@codeaurora.org> wrote:
> QMP PHY for USB mode requires pipe_clk for calibration and PLL lock
> to take place. This clock is output from PHY to GCC clock_ctl and then
> fed back to QMP PHY and is available from PHY only after PHY is reset
> and initialized, hence it can't be enabled too early in initialization
> sequence.
>
> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)

So it's now new with this patch, but it's more obvious with this
patch.  It seems like "UFS/PCIE" is kinda broken w/ respect to how it
controls its clock.  Specifically:

* If you init the PHY but don't power it on, then you "exit" the PHY:
you'll disable/unprepare "pipe_clk" even though you never
prepare/enabled it.

* If you init the PHY, power it on, power it off, power it on, and
exit the PHY: you'll leave the clock prepared one extra time.

Specifically I'd expect: for UFS/PCIE the disable/unprepare should be
symmetric with the enable/prepare and should be in "power off", not in
exit.

...or did I miss something?


Interestingly, your patch fixes this problem for USB3 (where init/exit
are now symmetric), but leaves the problem there for UFS/PCIE.


-Doug
