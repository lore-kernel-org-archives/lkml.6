Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751513AbeC2Uy6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 16:54:58 -0400
Received: from mail-ua0-f175.google.com ([209.85.217.175]:34227 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751070AbeC2Uyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 16:54:53 -0400
X-Google-Smtp-Source: AIpwx4+tqGgYBlCxl9hHzIM4ED3kpm6tGf2rTB11JL9nPbUZZLc//uXcR3abh0jJYpIEvY6XOpO6g5PRm8xMAIjDVBM=
MIME-Version: 1.0
In-Reply-To: <CAD=FV=XtviSYq=2w=Ld1xq5U2VPy=u=q6a3+4qd2zVGB+f9P8A@mail.gmail.com>
References: <1522321466-21755-1-git-send-email-mgautam@codeaurora.org>
 <1522321466-21755-3-git-send-email-mgautam@codeaurora.org> <CAD=FV=XtviSYq=2w=Ld1xq5U2VPy=u=q6a3+4qd2zVGB+f9P8A@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 29 Mar 2018 13:54:51 -0700
X-Google-Sender-Auth: TsvjoHVuGOkJW__1YQTJaHtfN-o
Message-ID: <CAD=FV=WGEKy98De_zH9rp+g-tE2YuVK2vRxLJrjeeSx=ijBAww@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] phy: qcom-qmp: Enable pipe_clk before PHY initialization
To: Manu Gautam <mgautam@codeaurora.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>, linux-arm-msm@vger.kernel.org,
        Varadarajan Narayanan <varada@codeaurora.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Fengguang Wu <fengguang.wu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 29, 2018 at 11:44 AM, Doug Anderson <dianders@chromium.org> wrote:
> Hi,
>
> On Thu, Mar 29, 2018 at 4:04 AM, Manu Gautam <mgautam@codeaurora.org> wrote:
>> QMP PHY for USB/PCIE requires pipe_clk for locking of
>> retime buffers at the pipe interface. Driver checks for
>> PHY_STATUS without enabling pipe_clk due to which
>> phy_init() fails with initialization timeout.
>> Though pipe_clk is output from PHY (after PLL is programmed
>> during initialization sequence) to GCC clock_ctl and then fed
>> back to PHY but for PHY_STATUS register to reflect successful
>> initialization pipe_clk from GCC must be present.
>> Since, clock driver now ignores status_check for pipe_clk on
>> clk_enable/disable, driver can safely enable/disable pipe_clk
>> from phy_init/exit.
>>
>> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
>> ---
>>  drivers/phy/qualcomm/phy-qcom-qmp.c | 22 ++++++++--------------
>>  1 file changed, 8 insertions(+), 14 deletions(-)
>
> Overall this looks much better than the previous version.  Thanks!  :)
>
> I wonder one thing though.  You describe the original problem as this:
>
> 1. If you don't turn the clock on in qcom_qmp_phy_init() then the PHY
> never sets the "ready" status.
>
> 2. If you don't have the PHY powered on / out of reset (which happens
> in qcom_qmp_phy_init()) then when you enable/disable the clock it
> doesn't properly update the status.  That's why you needed patch #1 in
> this series.
>
>
> I wonder: could you solve the above _without_ needing to use
> BRANCH_HALT_DELAY in the clock driver?  Specifically, can you tell me
> what happens if you put the clk_prepare_enable() after you've powered
> on the PHY and taken it out of reset but before you check the status?
> Said another way, put the "clk_prepare_enable(qphy->pipe_clk)" call
> right before the "readl_poll_timeout" of the ready status?
>
>
> If you do that, you'll turn everything on.  Then you'll check that the
> clock's status is OK and then that the PHY's status is OK.

Oh!  This is what you did in the previous version of the patch, then you said:

"That is still needed as PHY might take some time to generate pipe_clk
after its PLL is locked".

It's really going to take more than the 200 us that the clock driver
is giving it?  If so, I'd prefer to increase the amount of time waited
in the clock driver, or adding a fixed delay _before_ the clk_enable()
so that the 200 us that the clock driver gives it would be enough.

I'm just not a fan of ignoring status bits if it can be helped.


-Doug
