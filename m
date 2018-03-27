Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752349AbeC0XiM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 19:38:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35274 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbeC0XiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 19:38:11 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4B5C260588
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
Subject: Re: [PATCH 1/2] regulator: add QCOM RPMh regulator driver
To: Mark Brown <broonie@kernel.org>, Doug Anderson <dianders@chromium.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, sboyd@kernel.org,
        ilina@codeaurora.org
References: <cover.1521246069.git.collinsd@codeaurora.org>
 <71fab82672524b95632cdb588c16edfc9711866a.1521246069.git.collinsd@codeaurora.org>
 <CAD=FV=Xz01ra=WS--vtA+dkb1H8wcw3UnFzXPS=zYWAQCPP5eg@mail.gmail.com>
 <184378e4-caf8-6ce3-e089-3690588fcb28@codeaurora.org>
 <CAD=FV=WsVDDaV-mMUvQWUomyBFCJZunKiyDt_K81_syoNhGRZQ@mail.gmail.com>
 <20180327115606.GC29239@sirena.org.uk>
From: David Collins <collinsd@codeaurora.org>
Message-ID: <172d1da4-bde0-1f0c-b907-5582c31c8156@codeaurora.org>
Date: Tue, 27 Mar 2018 16:38:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20180327115606.GC29239@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/27/2018 04:56 AM, Mark Brown wrote:
> On Fri, Mar 23, 2018 at 01:00:47PM -0700, Doug Anderson wrote:
>> On Thu, Mar 22, 2018 at 3:31 PM, David Collins <collinsd@codeaurora.org> wrote:
> 
>>> There are two cases that I can think of: 1. Having a set_voltage()
>>> callback allows for delaying for an RPMh request ACK during certain
>>> voltage set point decreasing scenarios (to be elaborated below).
> 
>> Can't you still have a delay in set_voltage_sel()?
> 
> We have specific support for adding ramp delays, no need to open code it
> in operations.

I'll switch to using set_voltage_sel().  No ramp delay is need in Linux.
RPMh hardware sends an ACK back to Linux after the voltage reaches the
desired set point (i.e. is greater than or equal to the set point).  The
qcom_rpmh-regulator driver just needs to decide if it is going to wait for
the ACK from RPMh or not.


>>> 2.
>>> Having a get_voltage() as opposed to get_voltage_sel() callback allows an
>>> uninitialized voltage of 0 to be returned in the case that no initial
>>> voltage is specified in device tree.  This eliminates the possibility of
>>> the regulator framework short-circuiting a regulator_set_voltage() call
>>> that happens to match the voltage corresponding to selector 0.
> 
>> Interesting.  I suppose you could mix them (have set_voltage_sel() and
>> get_voltage()) as long as you documented why you were doing it.  Then
>> we'd have to see if Mark was happy with that...
> 
> This is a *terrible* idea which will almost certainly break.  If the
> driver can't read values it should return an appropriate error code.

I'll switch to using get_voltage_sel().  I'll test out returning an error
value in the case of an uninitialized voltage.  Hopefully the regulator
framework won't halt regulator registration because of it.


>>> I'm aware of one important instance in which decreasing voltage needs a
>>> delay: SD card voltage change from 3.3 V to 1.8 V.  This is the use case
>>> that I had in mind with the 'max_uv < vreg->voltage' check.  However, you
>>> are correct that hardware will report completion of the voltage slewing
>>> early in this case since the comparator is checking for output >= set
>>> point.  I can remove this special case check.
> 
> You can't usefully wait for voltages to fall, you can never guarantee
> what the loading on the device is.  It's something the user has to
> manage if they care.

I agree.  This case can't be handled in the regulator driver.


>>> Here is an explanation for why the "device tree mode" abstraction is
>>> present in the first place.  Between different Qualcomm Technologies, Inc.
>>> PMICs, regulators support a subset of the same modes (HPM/PWM, AUTO,
>>> LPM/PFM, Retention, and pass-through).  However, the register values for
>>> the same modes vary between different regulator types and different PMIC
>>> families.  This patch is adding support for several PMIC4 family PMICs.
>>> The values needed for to-be-released PMIC5 PMIC regulators are different.
>>> As an example, here are the different values for LPM/PFM across PMIC
>>> families and regulator types: PMIC4 LDO/SMPS = 5, PMIC4 BOB = 1, PMIC5
>>> LDO/HFSMPS/BOB = 4, PMIC5 FTSMPS = N/A.  Having the "device tree mode"
>>> ensures that it is not possible to inadvertently specify a PMIC specific
>>> mode in device tree which corresponds to the wrong type or family but
>>> which aliases a value that would be accepted as correct.
> 
>> I'm OK with having the "device tree mode" abstraction, and in fact the
>> current regulator framework seems to want you to have this anyway.  If
>> I read the code correctly, you're required to have the conversion
>> function and there's no default.
> 
> I didn't spot this in the code but something called "device tree mode"
> sounds like it's going to be awfully confusing...

As I explained in the earlier email, it makes the device tree
configurations much simpler and less confusing/error prone.  I'd like to
keep this concept around unless their are strong objections.


>>> Pass-through mode (PASS) a.k.a. bypass is supported by Qualcomm
>>> Technologies, Inc. buck-or-boost regulators (BOB).  When PASS is selected,
>>> the BOB output is directly connected to the BOB input (typically Vbat).
> 
> ...
> 
>>> qcom_rpmh-regulator substantially simpler.  I suppose that BOB PASS mode
>>> could be handled via get_bypass() and set_bypass() regulator ops.  Doing
>>> this would require more complicated ops selections in the driver since it
> 
> This is exactly the functionality supported by the bypass operations.
> Any complexity due to the hardware design is unfortunate but honestly
> the way the QC regulator stuff is designed they seem like a bit of a
> lost cause on that front - they look very different to any other
> hardware we've seen.
> 
>> I've never poked at the get_bypass() / set_bypass(), but it sounds
>> better to me to use them.  I'm not a fan of the current hack.  Even
>> aside from the bit of hackiness, I'm slightly concerned that some of
>> your logic that generally assumes lower integers = lower power modes
>> would break.
> 
> Yes, abusing the framework is just going to make things even worse.  

I'll implement get_bypass() and set_bypass() callbacks for BOB.


>>>>> +arch_initcall(rpmh_regulator_init);
> 
>>>> I always get yelled at when I try to use arch_initcall() for stuff
>>>> like this.  You should do what everyone else does and use
> 
>>> I agree that consumers should handle probe deferral.  Unfortunately,
>>> reality isn't always so nice.  Also, probe deferrals increase boot-up time
>>> which is particularly problematic in the mobile space.
> 
>> Sigh, yeah.  I'm not a fan either.  If you can convince Mark that you
>> should use arch_initcall() or subsys_initcall() I won't yell.  ...but
>> in the past I've seen others get yelled at.
> 
> Do you have concrete consumers that have a good reason for doing this?

I don't have any examples off the top of my head.


>> Note: in actuality it doesn't always increase boot time a whole lot.
> 
> Note also that we now have the device dependency mechanism that Raphael
> implemented with the explicit idea that that it'd be used to avoid
> unneeded deferrals.
> 
>> ...but deferrals _do_ for sure increase the time for certain
>> peripherals to come up, and if those peripherals are things like the
>> LCD displays then it sucks.
> 
> There's been some discussion of allowing the user to specific certain
> devices to target as priorities for probing which should deal with that.

I'll look into these features.

Take care,
David

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
