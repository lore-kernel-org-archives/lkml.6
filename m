Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05C0C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96425217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfAVUKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 15:10:43 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59898 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfAVUKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 15:10:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6DA6EBD;
        Tue, 22 Jan 2019 12:10:41 -0800 (PST)
Received: from [10.37.10.44] (unknown [10.37.10.44])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BA943F589;
        Tue, 22 Jan 2019 12:10:37 -0800 (PST)
Subject: Re: [PATCHv4 1/4] arm64: dts: qcom: sdm845: Add Coresight support
To:     saiprakash.ranjan@codeaurora.org, robh+dt@kernel.org,
        mathieu.poirier@linaro.org, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, andy.gross@linaro.org,
        david.brown@linaro.org, vivek.gautam@codeaurora.org,
        dianders@chromium.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com
Cc:     rnayak@codeaurora.org, sibis@codeaurora.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, john.horley@arm.com
References: <cover.1548133311.git.saiprakash.ranjan@codeaurora.org>
 <ad16cfb9b6f5efb85149458d5f5a1abf43fa027c.1548133311.git.saiprakash.ranjan@codeaurora.org>
 <1bd39862-0725-70ce-6535-fdb59569f683@arm.com>
 <75ed74af-6946-b86d-092e-42dc16e55308@codeaurora.org>
 <91a90daa-9e14-2d2e-e633-2ddfdc0955bf@arm.com>
 <3906faf1-abbd-9c28-ad55-ed3800f06352@codeaurora.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <c03b63bf-aca8-ea46-70ad-ee4558f0319e@arm.com>
Date:   Tue, 22 Jan 2019 20:12:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <3906faf1-abbd-9c28-ad55-ed3800f06352@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sai,

On 01/22/2019 04:48 PM, Sai Prakash Ranjan wrote:
> Hi Suzuki,
> 
> On 1/22/2019 9:38 PM, Suzuki K Poulose wrote:
>>
>> By inconsistent, I meant the registers provides values which are not
>> the same on two different CPUs of the *same type*. And it is expected
>> that two different CPU/ETM implementations will have different PIDs.
>>
> 
> SDM845 has 4 Kryo 385 Gold (ARM A75) + 4 Kryo 385 Silver (ARM A55),
> so the PID values should be same for 4 ETMs atleast. But here one
> pid value(001bb803) is same for 6 ETMs and other one for 2
> ETMs(001bb802) which seems odd and hence the doubt if these pids
> are even valid ones.

Have you checked other SoCs with A55 for the ETM PID ? The drivers
usually only care about PID0[7-0], PID1[7-0], PID2[3-0] and ignores
the other fields that may change over revisions of the core. So, in your
case the ETM ID could be treated as 0xbb802 and 0xbb803.

> 
>>>
>>> Below are the PIDs read for SDM845:
>>>
>>> [    5.996448] resname=etm@7040000 pid=001bb803
>>> [    6.052891] resname=etm@7140000 pid=001bb803
>>>
>>> <snip> .. (Same pid=001bb803 for etm@7240000 to etm@7540000 but differs
>>> for other 2 cpus as shown below)

So thats 4 CPUs with 0x1bb803.

>>>
>>> [    6.266687] resname=etm@7640000 pid=001bb802
>>> [    6.329171] resname=etm@7740000 pid=001bb802
>>>


>>> This is the case for MSM8996 also as shown below where PID
>>> value is not correct and has to be hardcoded.
>>
>> They differ because they are two different types of CPU cores (and 
>> thus different ETM PIDs). What does the Register descriptions say for
>> the Cores ?
>>
>> To me it looks like there are two different types of Qualcomm
>> Cores with their respective ETMs which are missing in the ETM4x
>> driver and we are trying to "make the ETM" work by faking it as
>> something else, which is not nice. I would rather prefer
>> to add the appropriate masks and the expected value for these
>> two different ETM implementations and be done with it, instead
>> of faking it in all the DTs where these cores appear.
>>
> 
> ETM4x driver does not have entries for A55 and A75. Could you please
> let me know the PIDs for these CPUs so that we can compare?

FWIW, here is the PID list:

A75: 0xB_BD_0A
A55: 0xB_BD_05

Btw, I am not sure if the ETM has been changed/tuned for the Cores in
SDM845. Please could you get this clarified internally within your
organisation ?

> 
>>>
>>> For MSM8996:
>>>
>>> resname=etm@3b40000 pid=102f0205
>>
>> I don't know what CPUs the MSM8996 have. If they don't have A53, you
>> must add the actual PIDs to the table once and for all.
>>
> 
> But again, this PID is some invalid value. And does not correspond
> to any of the ARM CPU cores and would be MSM8996 specific.
> MSM8996 has 2+2 Kryo cores which are not ARM derivative as SDM845
> if I am right.

As long as the JEP106 coding standard is followed and is indicated in
the appropriate fields (PIDR2[3]), we should be fine. In the case above:
PID of the ETM is 0xf0205, implies JEP106 code[6:0] of the designer is 
0x70 and ETM part number is : 0x205, which makes sense to me.

> 
>>>
>>>>> +        etm@7040000 {
>>>>> +            compatible = "arm,coresight-etm4x", "arm,primecell";
>>>>> +            arm,primecell-periphid = <0x000bb95d> > + reg = <0 
>>>>> 0x07040000 0 0x1000>;
>>>>> +
>>>>> +            cpu = <&CPU0>;
>>>>> +
>>>>
>>>> You seem to be specifying the PID of A53 ETM all over, while at least
>>>> one of your cores is ETMv4.2 (from the other patch) and A53 is not
>>>> ETMv4.2. As above, it would be good to add the PID to the table.
>>>>
>>>
>>> As explained in above comment, PID values read are not correct. 
>>> Please let me know if I am not clear.
>>
>> There is no measure for "correctness" here. If the ETM exposes different
>> PID than what you expect from the TRM, then we could think of overriding
>> it. Otherwise please add the PIDs to the table.
>>
> 
> This is exactly the case, ETM PID registers are exposing some invalid
> value and hence we override in DT.

It would be good to have this clarified. I will check with the internal
teams here for any details.

Thanks
Suzuki
