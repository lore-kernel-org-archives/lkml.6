Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752047AbeDTT21 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 15:28:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45270 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750985AbeDTT2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 15:28:24 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4BF5E60398
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
Subject: Re: [PATCH 1/2] regulator: add QCOM RPMh regulator driver
To: Mark Brown <broonie@kernel.org>, Stephen Boyd <swboyd@chromium.org>
Cc: lgirdwood@gmail.com, mark.rutland@arm.com, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rnayak@codeaurora.org, ilina@codeaurora.org
References: <cover.1521246069.git.collinsd@codeaurora.org>
 <71fab82672524b95632cdb588c16edfc9711866a.1521246069.git.collinsd@codeaurora.org>
 <152165924074.91116.13025068669916027026@swboyd.mtv.corp.google.com>
 <493c1f5d-df99-ca68-0f90-a7937a696f5d@codeaurora.org>
 <152411734938.46528.9676451637772936597@swboyd.mtv.corp.google.com>
 <20180419120813.GD27188@sirena.org.uk>
From: David Collins <collinsd@codeaurora.org>
Message-ID: <38f42537-f801-115a-4120-1344a67a0462@codeaurora.org>
Date: Fri, 20 Apr 2018 12:28:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20180419120813.GD27188@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/19/2018 05:08 AM, Mark Brown wrote:
> On Wed, Apr 18, 2018 at 10:55:49PM -0700, Stephen Boyd wrote:
>>>> Is this regulator-microvolt-offset? Ah I guess it's a thing in the RPMh
>>>> registers. This probably needs to be pushed into the framework and come
>>>> down through a 'set_headroom' op in the regulator ops via a
>>>> regulator-headroom-microvolt property that's parsed in of_regulator.c.
> 
>>> The qcom,headroom-voltage property is equivalent to struct
>>> regulator_desc.min_dropout_uV, but handled in hardware.  I don't see the
>>> need to make a new regulator op to configure this value dynamically.
> 
>> Ok? We have other regulator ops just to configure boot time things. The
>> goal is to come up with generic regulator properties that can be applied
>> from the framework perspective and be used by other regulator drivers in
>> the future.
> 
> This doesn't sound like what the min_dropout_uV constraint is intended
> to handle - that's there for the regulator driver (not constraints) to
> indicate how much headroom the regulator needs in the supply voltage in
> order to provide regulation.  It's not something the regulator uses,
> it's something that gets fed into voltage requests made on the supply of
> the regulator which I can't see that the hardware is going to be able to
> handle unaided.

RPMh hardware enforces the requested minimum headroom voltage for all
regulators with a parent.  It has full knowledge of the parent-child
connections of regulators on the board (as programmed by the bootloader).
It automatically reconfigures the parent voltage when needed as a result
of requests changing the voltage of any of its child regulators.


>> Cool. This should be a generic regulator DT property that all regulators
>> can use. We have the same problem on other RPM based regulator drivers
>> where boot sends a bunch of voltages because we don't know what it is by
>> default out of boot and we can't read it.
> 
> Ideally future versions of the RPM will have improved interfaces,
> there's a bunch of problems like this :(

Do you have a preference for qcom,regulator-initial-microvolt vs a generic
framework supported regulator-initial-microvolt property for configuring a
specific voltage at registration time?  We'll need to have support for one
or the other in order for the qcom_rpmh-regulator driver to be functional.


>>>>> +       if (type == RPMH_REGULATOR_TYPE_XOB && init_data->constraints.min_uV) {
>>>>> +               vreg->rdesc.fixed_uV = init_data->constraints.min_uV;
>>>>> +               init_data->constraints.apply_uV = 0;
>>>>> +               vreg->rdesc.n_voltages = 1;
>>>>> +       }
> 
>>>> What is this doing? Usually constraints aren't touched by the driver.
> 
>>> For XOB managed regulators, we need to set fixed_uV to match the DT
>>> constraint voltage and n_voltages = 1.  This allows consumers
>>> regulator_set_voltage() calls to succeed for such regulators.  It works
>>> the same as a fixed regulator.  I think that apply_uV = 0 could be left out.
> 
>> Wouldn't XOB regulators only have one voltage specified for min/max in
>> DT already though? I seem to recall that's how we make set_voltage() in
>> those cases work. Or it could be that drivers aren't supposed to call
>> set_voltage() on single or fixed voltage regulators anyway, because
>> constraints take care of it for them.
> 
> Yes, constraints that specify a single voltage are done by setting min
> and max to the same value.  fixed_uV is *only* for regulators that have
> a physically fixed voltage.

XOB managed regulators physically cannot change voltage.  Therefore, do
you agree that it is reasonable to use fixed_uV for them?  Note that I
removed init_data->constraints.apply_uV manipulation in version 2 of this
patch.


>>>>> +       if (vreg->hw_data->mode_map) {
>>>>> +               init_data->constraints.valid_ops_mask |= REGULATOR_CHANGE_MODE;
> 
> A driver must *NEVER* modify any constraints.
> 
>>>> Huh, I thought this was assigned by the framework.
> 
>>> No, this is not set anywhere in the regulator framework.  There isn't a DT
>>> method to configure it.  It seems that it could only be handled before
>>> with board files.  Other regulator drivers also configure it.
> 
>> Hmm ok. Would something be bad if we did support it through DT? I can't
>> seem to recall the history here.
> 
> Yes, if someone wants to configure this through DT they should add
> support for configuring it using DT.  The mode support in most
> regulators is not practically useful so nobody did that yet.  Mostly the
> hardware does a much better job of adjusting modes on the fly for
> anything that's going on at runtime than software is ever likely to do
> so it's not worth it.

I'll send out a patch to add generic support for this configuration via
device tree in the of_get_regulation_constraints() function.

Thanks,
David

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
