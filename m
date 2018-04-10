Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752240AbeDJGoW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 02:44:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41996 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751849AbeDJGoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 02:44:19 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BB90A60250
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
Subject: Re: [PATCH v4 1/7] clk: msm8996-gcc: change halt check for USB/PCIE
 pipe_clk
To: Stephen Boyd <sboyd@kernel.org>, Doug Anderson <dianders@chromium.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>, linux-arm-msm@vger.kernel.org,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>
References: <1522321466-21755-1-git-send-email-mgautam@codeaurora.org>
 <1522321466-21755-2-git-send-email-mgautam@codeaurora.org>
 <CAD=FV=UXvf+_rvbFGrHAQ1N0kbrMR_c2=LBVD=AMuL6DAjWO+Q@mail.gmail.com>
 <152295883900.91052.4792431636170417291@swboyd.mtv.corp.google.com>
From: Manu Gautam <mgautam@codeaurora.org>
Message-ID: <b2ad0e6f-addb-5d68-1f5d-ba7e44ce3d70@codeaurora.org>
Date: Tue, 10 Apr 2018 12:14:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <152295883900.91052.4792431636170417291@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 4/6/2018 1:37 AM, Stephen Boyd wrote:
> Quoting Doug Anderson (2018-03-29 13:55:55)
>> Hi,
>>
>> On Thu, Mar 29, 2018 at 4:04 AM, Manu Gautam <mgautam@codeaurora.org> wrote:
>>> The USB and PCIE pipe clocks are sourced from external clocks
>>> inside the QMP USB/PCIE PHYs. Enabling or disabling of PIPE RCG
>>> clocks is dependent on PHY initialization sequence hence
>>> update halt_check to BRANCH_HALT_DELAY for these clocks so
>>> that clock status bit is not polled when enabling or disabling
>>> the clocks. It allows to simplify PHY client driver code which
>>> is both user and source of the pipe_clk and avoid error logging
>>> related status check on clk_disable/enable.
>>>
>>> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
>>> ---
>>>  drivers/clk/qcom/gcc-msm8996.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>> As per my feedback on <https://patchwork.kernel.org/patch/10314937/>,
>> I'm not a fan of this.  Hopefully we can adjust the PHY driver so it's
>> not needed.
>>
> Agreed. We should be able to enable the clks at the right time and halt
> bits should work. From what I can recall we had that working before on
> db820c, so has something changed?

As replied in other patch IMO it is better to stick to the recommended
sequence and have this change as it would allow to cleanup PHY driver
and align with HPG. One reason I can think of why it works
on db820c is that there is some code in bootloader that enables
all USB clocks (including pipe_clk). Same is the case with SDM845.
And I start seeing errors if bootloader is changed or skip pipe_clk enable.



-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
