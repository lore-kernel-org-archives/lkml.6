Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932608AbeE3XjQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 19:39:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59770 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932408AbeE3XjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 19:39:13 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4242E6063A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
Subject: Re: [PATCH v4 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
To: Doug Anderson <dianders@chromium.org>, Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>
References: <cover.1527040878.git.collinsd@codeaurora.org>
 <6d03576cf90f06afb1194301cb41fc31704def1d.1527040878.git.collinsd@codeaurora.org>
 <CAD=FV=VH0bTxPOmRr+jUyV0cGNQHLcwQTV9L-t0bxZOqD8FnHA@mail.gmail.com>
 <20180530103720.GH6920@sirena.org.uk>
 <CAD=FV=WTTKXwPchuWRh-RNTc8=X8Xo28oTqk=3wW4+SiTHhxuA@mail.gmail.com>
 <20180530155044.GR6920@sirena.org.uk>
 <CAD=FV=WVUmvPPd5BxXv9Sa_2CRPrrjQvYFyqroY-3fRr4f0Bzg@mail.gmail.com>
 <20180530162007.GU6920@sirena.org.uk>
 <CAD=FV=WL9enzYCoSx0fT_ny40ciLJU-hhS9joJ6nySXvWPqAxQ@mail.gmail.com>
From: David Collins <collinsd@codeaurora.org>
Message-ID: <75088820-f20d-32ac-780a-5e7dacdf20ff@codeaurora.org>
Date: Wed, 30 May 2018 16:39:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CAD=FV=WL9enzYCoSx0fT_ny40ciLJU-hhS9joJ6nySXvWPqAxQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark and Doug,

On 05/30/2018 09:24 AM, Doug Anderson wrote:
> On Wed, May 30, 2018 at 9:20 AM, Mark Brown <broonie@kernel.org> wrote:
>> On Wed, May 30, 2018 at 09:12:25AM -0700, Doug Anderson wrote:
>>> On Wed, May 30, 2018 at 8:50 AM, Mark Brown <broonie@kernel.org> wrote:
>>
>>>> No, I'm saying that I don't know why that property exists at all.  This
>>>> sounds like it's intended to be the amount of current the regulator can
>>>> deliver in each mode which is normally a design property of the silicon.
>>
>>> Ah, got it.  So the whole point here is to be able to implement either
>>> the function "set_load" or the function "get_optimum_mode".  We need
>>> some sort of table to convert from current to mode.  That's what this
>>> table does.
>>
>> We do need that table, my expectation would be that this table would be
>> in the driver as it's not something I'd expect to vary between different
>> systems but rather be a property of the silicon design.  No sense in
>> every single board having to copy it in.
> 
> Ah, got it!  I'd be OK with it being hardcoded in the driver.
> 
> At one point I think David was making the argument that some boards
> have different noise needs for the rails and thus you might want to
> change modes at different currents.  I don't know if this is realistic
> but I believe it was part of his original argument for why this needed
> to be specified.  If we can hardcode this in the driver I'm fine with
> it...  That would actually solve many of my objections too...

The DRMS modes to use and max allowed current per mode need to be
specified at the board level in device tree instead of hard-coded per
regulator type in the driver.  There are at least two use cases driving
this need: LDOs shared between RPMh client processors and SMPSes requiring
PWM mode in certain circumstances.

For LDOs the maximum low power mode (LPM) current is typically 10 mA or 30
mA (depending upon subtype) per hardware documentation. Unfortunately,
sharing control of regulators with other processors adds some subtlety to
the LPM current limit that should actually be applied at runtime.

Consider the case of a regulator with physical 10 mA LPM max current. Say
that modem and application processors each have a load on the regulator
that draws 9 mA. If they each respect the 10 mA limit, then they'd each
vote for LPM. The VRM block in RPMh hardware will aggregate these requests
together using a max function which will result in the regulator being set
to LPM, even though the total load is 18 mA (which would require high
power mode (HPM)). To get around this corner case, a LPM max current of 1
uA can be used for all LDO supplies that have non-application processor
consumers. Thus, any non-zero regulator_set_load() current request will
result in setting the regulator to HPM (which is always safe).

The second situation that needs board-level DRMS mode and current limit
specification is SMPS regulator AUTO mode to PWM (HPM) mode switching.
SMPS regulators should theoretically always be able to operate in AUTO
mode as it switches automatically between PWM mode (which can provide the
maximum current) and PFM mode (which supports lower current but has higher
efficiency). However, there may be board/system issues that require
switching to PWM mode for certain use cases as it has better load
regulation (i.e. no PFM ripple for lower loads) and supports more
aggressive load current steps (i.e. greater A/ns).

If a Linux consumer requires the ability to force a given SMPS regulator
from AUTO mode into PWM mode and that SMPS is shared by other Linux
consumers (which may be the case, but at least must be guaranteed to work
architecturally), then regulator_set_load() is the only option since it
provides aggregation, where as regulator_set_mode() does not.
regulator_set_load() can be utilized in this case by specifying AUTO mode
and PWM mode as drms modes and specifying some particular AUTO mode
maximum current (that is known by the consumer) in device tree.  The
consumer can then call regulator_set_load() with the imposed AUTO mode
limit + delta when PWM mode is required and a lower value when AUTO mode
is sufficient.

Note that I previously mentioned the need for board-level drms mode and
current limit specification in [1].

Take care,
David

[1]: https://lkml.org/lkml/2018/3/22/802

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
