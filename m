Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751301AbeDXVJw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 17:09:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44048 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbeDXVJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 17:09:49 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E8EA5601CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
Subject: Re: [PATCH v2 2/2] regulator: add QCOM RPMh regulator driver
To: Mark Brown <broonie@kernel.org>
Cc: Doug Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>, Matthias Kaehlcke <mka@chromium.org>
References: <cover.1523673467.git.collinsd@codeaurora.org>
 <4b45f41996ea3344340e44fab2dc9e487572e209.1523673467.git.collinsd@codeaurora.org>
 <CAD=FV=XKYCDtF93RtYi+dokR2BcT-z6Ex3UjgJ0ia_kF=847eA@mail.gmail.com>
 <4e3353fe-ebb5-46bb-aa58-49ad04c4d9db@codeaurora.org>
 <CAD=FV=W28_exRv+H0MJvPnHWGEeUG=SMKr=UqEKpBzkH44Fzmg@mail.gmail.com>
 <132ab845-52d6-6192-4d8c-5a9c95410688@codeaurora.org>
 <20180424174507.GI22073@sirena.org.uk>
From: David Collins <collinsd@codeaurora.org>
Message-ID: <20a8f736-2687-f14f-eaa1-2b2c06eed629@codeaurora.org>
Date: Tue, 24 Apr 2018 14:09:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20180424174507.GI22073@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/24/2018 10:45 AM, Mark Brown wrote:
>>> You'd need to ask Mark if he's OK with it, but a option #3 is to add a
>>> patch to your series fix the regulator framework to try setting the
>>> voltage if _regulator_get_voltage() fails.  Presumably in
>>> machine_constraints_voltage() you'd now do something like:
>>>
>>>   int target_min, target_max;
>>>   int current_uV = _regulator_get_voltage(rdev);
>>>   if (current_uV < 0) {
>>>     /* Maybe this regulator's hardware can't be read and needs to be initted */
>>>     _regulator_do_set_voltage(
>>>       rdev, rdev->constraints->min_uV, rdev->constraints->min_uV);
>>>     current_uV = _regulator_get_voltage(rdev);
>>>   }
>>>   if (current_uV < 0) {
>>>     rdev_err(rdev,
>>>       "failed to get the current voltage(%d)\n",
>>>       current_uV);
>>>       return current_uV;
>>>   }
> 
>>> If Mark doesn't like that then I guess I'd be OK w/ initting it to 0
>>> but this needs to be documented _somewhere_ (unlike for bypass it's
>>> not obvious, so you need to find someplace to put it).  I'd rather not
>>> hack the DT to deal with our software limitations.
> 
>> I'm not opposed to your option #3 though it does seem a little hacky and
>> tailored to the qcom_rpmh-regulator specific case.  Note that I think it
>> would be better to vote for min_uV to max_uV than min_uV to min_uV though.
> 
>> Mark, what are your thoughts on the best way to handle this situation?
> 
> I think that's probably only OK if we have a specific error code for the
> regulator being limited in this way otherwise our error handling for I/O
> problems involves us trying to reconfigure supplies which seems like it
> would be risky.  

Would you be ok with -EAGAIN being used for this purpose?

Thanks,
David

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
