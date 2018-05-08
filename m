Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932400AbeEHPsl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 11:48:41 -0400
Received: from foss.arm.com ([217.140.101.70]:60258 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755041AbeEHPsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 11:48:40 -0400
Subject: Re: [PATCH v2 10/27] dts: bindings: Restrict coresight tmc-etr
 scatter-gather mode
To: Rob Herring <robh@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        John Horley <john.horley@arm.com>,
        Mathieu Poirier <matheiu.poirier@linaro.org>,
        devicetree@vger.kernel.org
References: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
 <1525165857-11096-11-git-send-email-suzuki.poulose@arm.com>
 <20180501131300.GA31425@rob-hp-laptop>
 <CANLsYkwozU7QC5EeEy46KrEd4X7J9S69SiNg8-GhSSuMkhQrBw@mail.gmail.com>
 <CAL_JsqJDTx2UWN7VdsvDctyXw_rco6Q8NmoWQ5EBx6uhwJu=0Q@mail.gmail.com>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <514f69b1-2219-aa83-dfe8-09c26ed4f5b1@arm.com>
Date: Tue, 8 May 2018 16:48:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJDTx2UWN7VdsvDctyXw_rco6Q8NmoWQ5EBx6uhwJu=0Q@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/18 23:56, Rob Herring wrote:
> On Thu, May 3, 2018 at 3:32 PM, Mathieu Poirier
> <mathieu.poirier@linaro.org> wrote:
>> On 1 May 2018 at 07:13, Rob Herring <robh@kernel.org> wrote:
>>> On Tue, May 01, 2018 at 10:10:40AM +0100, Suzuki K Poulose wrote:
>>>> We are about to add the support for ETR builtin scatter-gather mode
>>>> for dealing with large amount of trace buffers. However, on some of
>>>> the platforms, using the ETR SG mode can lock up the system due to
>>>> the way the ETR is connected to the memory subsystem.
>>>>
>>>> In SG mode, the ETR performs READ from the scatter-gather table to
>>>> fetch the next page and regular WRITE of trace data. If the READ
>>>> operation doesn't complete(due to the memory subsystem issues,
>>>> which we have seen on a couple of platforms) the trace WRITE
>>>> cannot proceed leading to issues. So, we by default do not
>>>> use the SG mode, unless it is known to be safe on the platform.
>>>> We define a DT property for the TMC node to specify whether we
>>>> have a proper SG mode.


>>>> ---
>>>>   Documentation/devicetree/bindings/arm/coresight.txt | 3 +++
>>>>   drivers/hwtracing/coresight/coresight-tmc.c         | 8 +++++++-
>>>>   2 files changed, 10 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
>>>> index cdd84d0..7c0c8f0 100644
>>>> --- a/Documentation/devicetree/bindings/arm/coresight.txt
>>>> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
>>>> @@ -88,6 +88,9 @@ its hardware characteristcs.
>>>>        * arm,buffer-size: size of contiguous buffer space for TMC ETR
>>>>         (embedded trace router)
>>>>
>>>> +     * scatter-gather: boolean. Indicates that the TMC-ETR can safely
>>>> +       use the SG mode on this system.
>>>> +
>>>
>>> Needs a vendor prefix.
>>>
>>
>> Thinking further on this, do we need to make it device specific as
>> well - something like "arm,etr-scatter-gather"?  That way we don't
>> have to redefine "scatter-gather" for other ARM devices if they happen
>> to need the same property but for different reasons.
> 
> No. If we had a bunch of cases, then we'd probably want to have just
> 'scatter-gather'.

Does it mean "arm,scatter-gather" ? If we ever wanted to add the device
specific information, I would prefer to go with "arm,tmc-scatter-gather"
and not "etr-scatter-gather". They both could mean different things.

> 
> BTW, if SG had already been supported, then I'd say this is a quirk
> and we should invert this property. Otherwise, you'd be disabling once
> enabled SG and require working platforms to update their dtb. Of
> course, I shouldn't really let the state of an OS driver influence the
> DT binding.
> 

The SG support is added with this series. So, the OS has never made use
of the feature.

Suzuki
