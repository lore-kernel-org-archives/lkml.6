Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751420AbeDXUdg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 16:33:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40398 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751275AbeDXUdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 16:33:20 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A90FC6081C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
Subject: Re: [PATCH 1/2] regulator: add QCOM RPMh regulator driver
To: Lina Iyer <ilina@codeaurora.org>
Cc: Stephen Boyd <swboyd@chromium.org>, broonie@kernel.org,
        lgirdwood@gmail.com, mark.rutland@arm.com, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rnayak@codeaurora.org
References: <cover.1521246069.git.collinsd@codeaurora.org>
 <71fab82672524b95632cdb588c16edfc9711866a.1521246069.git.collinsd@codeaurora.org>
 <152165924074.91116.13025068669916027026@swboyd.mtv.corp.google.com>
 <493c1f5d-df99-ca68-0f90-a7937a696f5d@codeaurora.org>
 <152411734938.46528.9676451637772936597@swboyd.mtv.corp.google.com>
 <dcd4e178-cfd3-1c3f-da7c-1eb66a58cf15@codeaurora.org>
 <20180420224445.GB18235@codeaurora.org>
From: David Collins <collinsd@codeaurora.org>
Message-ID: <916d2d21-3a49-5818-3fb9-66b2ee5fc359@codeaurora.org>
Date: Tue, 24 Apr 2018 13:33:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20180420224445.GB18235@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>>> +       ret = cmd_db_ready();
>>>>>> +       if (ret < 0) {
>>>>>> +               if (ret != -EPROBE_DEFER)
>>>>>> +                       dev_err(dev, "Command DB not available,
>>>>>> ret=%d\n", ret);
>>>>>> +               return ret;
>>>>>> +       }
>>>>>
>>>>> We should just make rpmh parent device call cmd_db_ready() so that these
>>>>> devices aren't even populated until then and so that cmd_db_ready() is
>>>>> only in one place. Lina?
>>>>
>>>> Let's see if Lina has qualms about this plan.
>>>
>>> Sounds like you're ok with it.
>>
>> Sure, I'll remove this check if Lina agrees to add it in the rpmh driver.
>>
> We want to make the RSC nodes child of Command DB? That way we probe the
> controllers only if the command DB is ready?
> 
> I could do that. Just so you know, there is are no strict directives to
> use Command DB. If a driver knows the information it needs to pass to
> the accelerator, it may choose to skip command DB completely.

The ask here is for the rpmh driver to call cmd_db_ready() in its probe
function and return any error encountered (e.g. -EPROBE_DEFER).

I suppose that specifying the rpmh rsc device tree node as a child inside
of the command DB node could achieve the same result.  However, that seems
a little hacky as the rsc device is describing a hardware block physically
found on the SoC as opposed to a subcomponent of the command DB SMEM data
structure.  I defer to device tree maintainers to comment on the
acceptability of this approach.

While technically it is possible for an rpmh consumer to intrinsically
know the addresses for its resources without polling command DB, do you
have any examples where this is the case?

Thanks,
David

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
