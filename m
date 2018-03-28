Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753389AbeC1He2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 03:34:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45488 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752547AbeC1HeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 03:34:24 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A5AF0603AF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
Subject: Re: [PATCH v3 6/6] phy: qcom-qusb2: Add QUSB2 PHYs support for sdm845
To: Doug Anderson <dianders@chromium.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <1521785487-29866-1-git-send-email-mgautam@codeaurora.org>
 <1521785487-29866-7-git-send-email-mgautam@codeaurora.org>
 <CAD=FV=WjQk420k8CxeXHuxHMPHd6ZEJ+zkR2iT_Fpw8conD+pg@mail.gmail.com>
From: Manu Gautam <mgautam@codeaurora.org>
Message-ID: <e49425b6-e7f9-5c50-b1e7-98e22dcb401e@codeaurora.org>
Date: Wed, 28 Mar 2018 13:04:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=WjQk420k8CxeXHuxHMPHd6ZEJ+zkR2iT_Fpw8conD+pg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 3/28/2018 4:22 AM, Doug Anderson wrote:
> Hi,
>
> On Thu, Mar 22, 2018 at 11:11 PM, Manu Gautam <mgautam@codeaurora.org> wrote:
>> There are two QUSB2 PHYs present on sdm845. Update PHY
>> registers programming for both the PHYs related to
>> electrical parameters to improve eye diagram.
> This tuning difference is truly associated with the SoC itself?  Are
> you sure?  Are the two different PHYs in the SoC somehow using
> different silicon processes?  ...or is one close to another IP block
> that is noisy?  ...or something else to account for this difference?
>
> It seems more likely that this tuning difference is associated with
> the board.  If you're _certain_ this is really due to internal SoC
> differences you'll have to come up with some darn good evidence to
> convince me...

This difference must be due to board only.

>
> If the tuning is truly associated with the board then:
>
> 1. You should have a single device tree compatible string.  IMHO it
> should contain the name of the SoC in it, so "qcom,sdm845-qusb2-phy".
> It's generally OK to name something in Linux using the name of the
> first thing that happened to support it in Linux (even if later
> processors use the exact same component).  Leaving it as just
> "qcom,qusb2-v2-phy" is OK with me too if that's what everyone wants.
I will remove "qcom,qusb2-v2-phy" as I don't expect any users of that.
>
>
> 2. You should figure out how to describe the needed board-to-board
> tuning in device tree.
>
> The only two differences you have right now are:
>
> QUSB2PHY_IMP_CTRL1: 0 => 0x8
> QUSB2PHY_PORT_TUNE1: 0x30 => 0x48
>
> I'm not sure I found all the correct documentation for the PHY (the
> docs I have say that "TUNE1" bit 3 is "reserved") so I can't come up
> with all of these for you.  But I think I found the difference
> accounting for the upper nybble of TUNE1 changing from 0x3 to 0x4.
> For this, I think you'd want a device tree property like:
>
> qcom,hstx_trim_mv
>
> ...and the values of that property would be the values from 800 to 950
> in 8 steps, or [800, 821, 842, 864, 885, 907, 928, 950].
>
> You'd want to do similar things for the other differences.
>
> You don't need to encode every possible difference right now.  When
> you come up with something that needs to be different you add a new
> optional device tree property (defaulting to whatever the driver used
> to do) to describe your new property.

Sure. I will come up with separate device tree properties to specify
board-to-board differences in PHY tuning.


>
> -Doug

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
