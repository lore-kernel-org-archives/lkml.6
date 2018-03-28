Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752532AbeC1HXn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 03:23:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38524 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752121AbeC1HXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 03:23:40 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E1BAC60710
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
Subject: Re: [PATCH v3 1/6] phy: qcom-qmp: Enable pipe_clk before checking
 USB3 PHY_STATUS
To: Doug Anderson <dianders@chromium.org>
Cc: Vivek Gautam <vivek.gautam@codeaurora.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        Varadarajan Narayanan <varada@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Amit Nischal <anischal@codeaurora.org>
References: <1521785487-29866-1-git-send-email-mgautam@codeaurora.org>
 <1521785487-29866-2-git-send-email-mgautam@codeaurora.org>
 <CAD=FV=V7xDh6fvG12xOV9=WwTDLiuQxdWFr7Bq6wjPJ5gShrVA@mail.gmail.com>
 <8724ae37-5d71-4d5f-f750-da0cb8838f47@codeaurora.org>
 <921929e2-405e-703a-038e-732f8c790a2c@codeaurora.org>
 <2e26f672-c6d4-6f8f-00ec-231df3f71802@codeaurora.org>
 <CAD=FV=WsKinyZq7hRxV=y+uLS7NFP77VjTuO9OWhFobB+qQYpA@mail.gmail.com>
From: Manu Gautam <mgautam@codeaurora.org>
Message-ID: <189cf906-c481-24b1-51cc-b1bd91c38471@codeaurora.org>
Date: Wed, 28 Mar 2018 12:53:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=WsKinyZq7hRxV=y+uLS7NFP77VjTuO9OWhFobB+qQYpA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 3/28/2018 1:44 AM, Doug Anderson wrote:
> Hi,
>
> On Tue, Mar 27, 2018 at 12:50 AM, Manu Gautam <mgautam@codeaurora.org> wrote:
>> Hi,
>>
>>
>> On 3/27/2018 12:26 PM, Vivek Gautam wrote:
>>>
>>> On 3/27/2018 10:37 AM, Manu Gautam wrote:
>>>> Hi Doug,
>>>>
>>>>
>>>> On 3/27/2018 9:56 AM, Doug Anderson wrote:
>>>>> Manu
>>>>>
>>>>> On Thu, Mar 22, 2018 at 11:11 PM, Manu Gautam <mgautam@codeaurora.org> wrote:
>>>>>> QMP PHY for USB mode requires pipe_clk for calibration and PLL lock
>>>>>> to take place. This clock is output from PHY to GCC clock_ctl and then
>>>>>> fed back to QMP PHY and is available from PHY only after PHY is reset
>>>>>> and initialized, hence it can't be enabled too early in initialization
>>>>>> sequence.
>>>>>>
>>>>>> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
>>>>>> ---
>>>>>>   drivers/phy/qualcomm/phy-qcom-qmp.c | 33 ++++++++++++++++++++++++++++++++-
>>>>>>   1 file changed, 32 insertions(+), 1 deletion(-)
>>>>> So it's now new with this patch, but it's more obvious with this
>>>>> patch.  It seems like "UFS/PCIE" is kinda broken w/ respect to how it
>>>>> controls its clock.  Specifically:
>>>>>
>>>>> * If you init the PHY but don't power it on, then you "exit" the PHY:
>>>>> you'll disable/unprepare "pipe_clk" even though you never
>>>>> prepare/enabled it.
>>>>>
>>>>> * If you init the PHY, power it on, power it off, power it on, and
>>>>> exit the PHY: you'll leave the clock prepared one extra time.
>>>>>
>>>>> Specifically I'd expect: for UFS/PCIE the disable/unprepare should be
>>>>> symmetric with the enable/prepare and should be in "power off", not in
>>>>> exit.
>>>>>
>>>>> ...or did I miss something?
>>>>>
>>>>>
>>>>> Interestingly, your patch fixes this problem for USB3 (where init/exit
>>>>> are now symmetric), but leaves the problem there for UFS/PCIE.
>>>>>
>>>> Thanks for review.
>>>> One of the reason why pipe_clk is disabled as part of phy_exit is that
>>>> halt_check from clk_disable reports error if called after PHY has been
>>>> powered down or phy_exit.
>>>> I believe that warning should be ignored in qcom gcc-clock driver
>>>> (for applicable platforms) by using BRANCH_HALT_DELAY as halt_check
>>>> for pipe_clk and performing clk_disable from power_off for UFS/PCIE.
>>> UFS doesn't use PIPE clock.
> Just to confirm: we no longer need to do this "BRANCH_HALT_DELAY" now
> that we've figured everything out, right?

That is still needed as PHY might take some time to generate pipe_clk
after its PLL is locked (or while initialization sequence is carried out).
Performing clk_enable will throw a warning. Hence, it is better to
have halt_check that will allow to club pipe_clk with other clocks and
enable it at the beginning of phy_init.

>
>
>> Yes, UFS PHY doesn't use one. But similar to pipe_clk there are rx/tx symbol_clk
>> output from PHY that is used by UFS controller. I will update code comments
>> to not refer UFS for pipe_clk.
>>
>>> But considering for PCIe, if we disable pipe clock when phy is still running, then
>>> it shouldn't be a problem. We should also not see the halt warning as the gcc
>>> driver should be able to just turn the gate off.
>>> The reason why it will throw that error is when the parent clock to that gate
>>> is gated, i.e. the pipe clock is not flowing on that branch.
>> I got the confirmation that pipe_clk is needed for PCIE as well for its
>> initialization to happen successfully. So we do need clock driver change
>> to fix this in PHY driver.
> So basically if I'm understanding this correctly:
>
> * Both USB and PCIE need the clk_enable() in qcom_qmp_phy_init()
>
> * UFS doesn't even use a pipe clock (pipe_clk is NULL and thus these
> calls are no-ops).
>
> So that means the next version of this code will simply get rid of
> qcom_qmp_phy_poweron() and we can now use the same phy_ops for both
> everything again?  That also makes everything symmetric and gets rid
> of the possible imbalance of clock enable/disable, so I'm happy.
Yes.
>
>
> Actually: I'll also throw out a drastic idea here.  Maybe instead of
> having a NULL power_on/power_off, we should have a NULL init/exit.
> Does anything break if all the stuff that happens today in
> qcom_qmp_phy_com_init() happens at power_on() time instead of init()
> time?  I suggest this because:
>
> * It sounds like init() is supposed to be for initialization that can
> happen _before_ power on of the PHY.
>
> * Any initialization that happens after the PHY has been powered on
> seems expected to just be in the power_on() function after the
> regulator was enabled.
>
>
> Presumably moving this stuff to power_on could save you some power in
> some cases (since the client of the PHY presumably turns power off to
> the PHY with the idea of saving power).

This could be ok for DWC3 USB core driver which uses both phy_init and
power_on together on init/suspend.
But it looks like ufs-qcom and pcie-qcom (mainly ufs) handle power_on
and phy_init differently. They also reset core while running init/power_on.
Changing power_on/init could affect those cores.
Regarding power_management, I think we can just update ufc/pcie
qcom glue drivers to either use phy_init/exit for power_management.
Or PHY runtime_PM if client doesn't want to power_down or reset phy
during suspend/resume.

>
> -Doug

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
