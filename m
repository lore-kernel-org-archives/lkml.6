Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753710AbeDKPht (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 11:37:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60956 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753268AbeDKPhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 11:37:46 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 67D8C6090E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
Subject: Re: [PATCH v4 2/7] phy: qcom-qmp: Enable pipe_clk before PHY
 initialization
To: Stephen Boyd <sboyd@kernel.org>, Doug Anderson <dianders@chromium.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>, linux-arm-msm@vger.kernel.org,
        Varadarajan Narayanan <varada@codeaurora.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Fengguang Wu <fengguang.wu@intel.com>
References: <1522321466-21755-1-git-send-email-mgautam@codeaurora.org>
 <1522321466-21755-3-git-send-email-mgautam@codeaurora.org>
 <CAD=FV=XtviSYq=2w=Ld1xq5U2VPy=u=q6a3+4qd2zVGB+f9P8A@mail.gmail.com>
 <CAD=FV=WGEKy98De_zH9rp+g-tE2YuVK2vRxLJrjeeSx=ijBAww@mail.gmail.com>
 <19c66b02-4f8e-902a-9397-21e7690db7b8@codeaurora.org>
 <CAD=FV=XqH69_LXcCyTS1nF5fHpen=PnRxd-WTz=y3dKvMsRtuw@mail.gmail.com>
 <152338515540.180276.4273344163431724770@swboyd.mtv.corp.google.com>
From: Manu Gautam <mgautam@codeaurora.org>
Message-ID: <f8f47dc2-74ab-96c6-b3bd-a476bd19514d@codeaurora.org>
Date: Wed, 11 Apr 2018 21:07:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <152338515540.180276.4273344163431724770@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 4/11/2018 12:02 AM, Stephen Boyd wrote:
> Quoting Doug Anderson (2018-04-10 08:05:27)
>> On Mon, Apr 9, 2018 at 11:36 PM, Manu Gautam <mgautam@codeaurora.org> wrote:
>>> On 3/30/2018 2:24 AM, Doug Anderson wrote:
>>>> Oh!  This is what you did in the previous version of the patch, then you said:
>>>>
>>>> "That is still needed as PHY might take some time to generate pipe_clk
>>>> after its PLL is locked".
>>>>
>>>> It's really going to take more than the 200 us that the clock driver
>>>> is giving it?  If so, I'd prefer to increase the amount of time waited
>>>> in the clock driver, or adding a fixed delay _before_ the clk_enable()
>>>> so that the 200 us that the clock driver gives it would be enough.
>>>>
>>>> I'm just not a fan of ignoring status bits if it can be helped.
>>> I too would want to do that but it is not just about the delay.
>>> As per QMP PHY hardware designers, pipe_clk should be enabled in GCC
>>> as first thing in the PHY initialization sequence. Same sequence also has
>>> been used in downstream phy driver always.
>>> Changing the sequence might work but I would like to stick to the HPG
>>> recommendation and avoid any deviation as PHY issues are very hard to
>>> debug.
>> So hardware guys tell you that you're _supposed to_ ignore the clock
>> ready bit for that clock and just hope it turns on and settles in time
>> once power comes on for the clock?  That doesn't seem ideal.  My guess
>> is that it's a bug in the specification that the QMP PHY hardware
>> designers gave you.
It could be a bug in specification. But same sequence has been well tested on both
msm8996 and sdm845, so I would for now like to stick with that for now.
>> Stephen can feel free to override me if he disagrees since he's in
>> charge of the clock part of this, but IMHO we should get the
>> specification fixed and turn things on in the order that lets us check
>> the status bits.
>>
> Presumably there's a PLL "enable" bit in the QMP phy init sequence that
> we can use to enable the PLL output at a bypass rate and then enable the
> clk in GCC and then resume the PLL enable sequence. That would allow us
> to make sure the clk is working.
>
> Are the branches in GCC ever turned on or off at runtime though? Or do
> we just turn them on because they're defaulted off out of reset and then
> leave them on?
It can be left on always.
>
> I ask because it may be easier to never expose these clks in Linux, hit
> the enable bits in the branches during clk driver probe, and then act
> like they never exist because we don't really use them.
This sounds better idea. Let me check if I can get a patch for same in msm8996
and sdm845 clock drivers.


-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
