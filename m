Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751048AbeFAVlU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 17:41:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43778 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbeFAVlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 17:41:16 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EF1B46044B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
Subject: Re: [PATCH v4 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
To: Mark Brown <broonie@kernel.org>
Cc: Doug Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
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
 <75088820-f20d-32ac-780a-5e7dacdf20ff@codeaurora.org>
 <20180531114816.GC13319@sirena.org.uk>
From: David Collins <collinsd@codeaurora.org>
Message-ID: <949e1a0c-11d6-1423-caae-834649bd11d0@codeaurora.org>
Date: Fri, 1 Jun 2018 14:41:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20180531114816.GC13319@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

On 05/31/2018 04:48 AM, Mark Brown wrote:
> On Wed, May 30, 2018 at 04:39:10PM -0700, David Collins wrote:
>> The DRMS modes to use and max allowed current per mode need to be
>> specified at the board level in device tree instead of hard-coded per
>> regulator type in the driver.  There are at least two use cases driving
>> this need: LDOs shared between RPMh client processors and SMPSes requiring
>> PWM mode in certain circumstances.
> 
> Is there really no way to improve the RPM firmware?

This aggregation takes place in a discrete hardware block, not in a
general purpose processor.  Theoretically, future chips could have
redesigned VRM hardware; however, there is no plan to make such a change.


>> Consider the case of a regulator with physical 10 mA LPM max current. Say
>> that modem and application processors each have a load on the regulator
>> that draws 9 mA. If they each respect the 10 mA limit, then they'd each
>> vote for LPM. The VRM block in RPMh hardware will aggregate these requests
> 
> This is, of course, why the regulator API aggregates this stuff based on
> the current not based on having every individual user select a mode.
> 
>> together using a max function which will result in the regulator being set
>> to LPM, even though the total load is 18 mA (which would require high
>> power mode (HPM)). To get around this corner case, a LPM max current of 1
>> uA can be used for all LDO supplies that have non-application processor
>> consumers. Thus, any non-zero regulator_set_load() current request will
>> result in setting the regulator to HPM (which is always safe).
> 
> That's obviously just never going to work well, the best you can do here
> is just pretend that the other components are always operating at full
> power (which I assume all the other components are doing too...) or not
> try to use load based mode switching in the first place.

I will remove the DT-based mode and max load current mapping support.  In
its place, I'll implement hard coded LPM current limits for LDOs of 10 mA
or 30 mA (depending upon subtype) like is done in other regulator drivers.

If we actually encounter an issue caused by the APPS processor and another
RPMh client both voting for LPM when HPM is needed for the combination,
then we can disable load-based mode control for the affected regulator in
DT and configure its initial mode as HPM.


>> The second situation that needs board-level DRMS mode and current limit
>> specification is SMPS regulator AUTO mode to PWM (HPM) mode switching.
>> SMPS regulators should theoretically always be able to operate in AUTO
>> mode as it switches automatically between PWM mode (which can provide the
>> maximum current) and PFM mode (which supports lower current but has higher
>> efficiency). However, there may be board/system issues that require
>> switching to PWM mode for certain use cases as it has better load
>> regulation (i.e. no PFM ripple for lower loads) and supports more
>> aggressive load current steps (i.e. greater A/ns).
> 
>> If a Linux consumer requires the ability to force a given SMPS regulator
>> from AUTO mode into PWM mode and that SMPS is shared by other Linux
>> consumers (which may be the case, but at least must be guaranteed to work
>> architecturally), then regulator_set_load() is the only option since it
>> provides aggregation, where as regulator_set_mode() does not.
> 
> That's obviously broken though, what you're describing is just clearly
> nothing to do with load so trying to configure it using load is just
> going to lead to problems later on.  Honestly it sounds like you just
> want to force the regulator into forced PWM mode all the time, otherwise
> you need to look into implementing support for describing the thing
> you're actually trying to do and add a mechanism for per consumer mode
> configuration.
> 
> This has been a frequent pattern with these RPM drivers, trying to find
> some way to shoehorn something that happens to work right now into the
> code.  That's going to make things fragile and hard to maintain, we need
> code that does the thing it's saying it does so that it's easier to
> understand and work with - getting things running isn't enough, they
> need to be clear.

I agree that using regulator_set_load() to handle SMPS AUTO mode to PWM
mode switching is hacky.  Since there is no natural way to pick SMPS modes
based on load current, I will remove the functionality completely.  In its
place, we can configure the SMPSes to have an initial mode of AUTO.  If a
use case requiring PWM mode arises, then the consumer driver responsible
for it can call regulator_set_mode() to switch between AUTO and PWM modes
explicitly.

Since regulator_set_mode() does not support aggregation currently, this
technique would work only if there is exactly one consumer per regulator
that needs explicit mode control.  Should we hit a situation that needs
multiple consumers to have such mode control, then we could simply default
the SMPS to PWM mode.

I'll also start looking into per-consumer mode configuration and
regulator_set_mode() aggregation within the regulator framework.  I think
that we should be able to function without it for now; however, it would
be good to have going forward.

Take care,
David

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
