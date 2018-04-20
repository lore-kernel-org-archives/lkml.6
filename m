Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752792AbeDTSvp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 14:51:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44662 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750927AbeDTSvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 14:51:42 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 20 Apr 2018 11:51:40 -0700
From: Channa <ckadabi@codeaurora.org>
To: Rob Herring <robh@kernel.org>
Cc: Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm@lists.infradead.org,
        linux-kernel@vger.kernel.org, Trilok Soni <tsoni@codeaurora.org>,
        Kyle Yan <kyan@codeaurora.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Evan Green <evgreen@chromium.org>, linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v4 1/2] Documentation: Documentation for qcom, llcc
In-Reply-To: <589e84221ca7723c1739f713216abce5@codeaurora.org>
References: <1523390893-10904-1-git-send-email-rishabhb@codeaurora.org>
 <1523390893-10904-2-git-send-email-rishabhb@codeaurora.org>
 <20180416145912.ja7d2xd2kqiukrgl@rob-hp-laptop>
 <9a9ffe61f85dd28199bcc2d449097059@codeaurora.org>
 <1d31f2d727d32922aaf98c345723229e@codeaurora.org>
 <CAL_JsqKihiUwPW-aKYtG2cSFnOZonygahUeO5kgLjL3GYO7w=Q@mail.gmail.com>
 <589e84221ca7723c1739f713216abce5@codeaurora.org>
Message-ID: <8cb9bd887d94bedfb43225569647337e@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-18 11:11, Channa wrote:
> On 2018-04-18 07:52, Rob Herring wrote:
>> On Tue, Apr 17, 2018 at 5:12 PM,  <rishabhb@codeaurora.org> wrote:
>>> On 2018-04-17 10:43, rishabhb@codeaurora.org wrote:
>>>> 
>>>> On 2018-04-16 07:59, Rob Herring wrote:
>>>>> 
>>>>> On Tue, Apr 10, 2018 at 01:08:12PM -0700, Rishabh Bhatnagar wrote:
>>>>>> 
>>>>>> Documentation for last level cache controller device tree 
>>>>>> bindings,
>>>>>> client bindings usage examples.
>>>>> 
>>>>> 
>>>>> "Documentation: Documentation ..."? That wastes a lot of the 
>>>>> subject
>>>>> line... The preferred prefix is "dt-bindings: ..."
>>>>> 
>>>>>> 
>>>>>> Signed-off-by: Channagoud Kadabi <ckadabi@codeaurora.org>
>>>>>> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
>>>>>> ---
>>>>>>  .../devicetree/bindings/arm/msm/qcom,llcc.txt      | 58
>>>>>> ++++++++++++++++++++++
>>>>>>  1 file changed, 58 insertions(+)
>>>>>>  create mode 100644
>>>>>> Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
>>>>>> 
>>>>>> diff --git 
>>>>>> a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
>>>>>> b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
>>>>>> new file mode 100644
>>>>>> index 0000000..497cf0f
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
>>>>>> @@ -0,0 +1,58 @@
>>>>>> +== Introduction==
>>>>>> +
>>>>>> +LLCC (Last Level Cache Controller) provides last level of cache 
>>>>>> memory
>>>>>> in SOC,
>>>>>> +that can be shared by multiple clients. Clients here are 
>>>>>> different
>>>>>> cores in the
>>>>>> +SOC, the idea is to minimize the local caches at the clients and
>>>>>> migrate to
>>>>>> +common pool of memory
>>>>>> +
>>>>>> +Properties:
>>>>>> +- compatible:
>>>>>> +        Usage: required
>>>>>> +        Value type: <string>
>>>>>> +        Definition: must be "qcom,sdm845-llcc"
>>>>>> +
>>>>>> +- reg:
>>>>>> +        Usage: required
>>>>>> +        Value Type: <prop-encoded-array>
>>>>>> +        Definition: must be addresses and sizes of the LLCC 
>>>>>> registers
>>>>> 
>>>>> 
>>>>> How many address ranges?
>>>>> 
>>>> It consists of just one address range. I'll edit the definition to 
>>>> make
>>>> it more clear.
>>>>>> 
>>>>>> +
>>>>>> +- #cache-cells:
>>>>> 
>>>>> 
>>>>> This is all written as it is a common binding, but it is not one.
>>>>> 
>>>>> You already have most of the configuration data for each client in 
>>>>> the
>>>>> driver, I think I'd just put the client connection there too. Is 
>>>>> there
>>>>> any variation of this for a given SoC?
>>>>> 
>>>> #cache-cells and max-slices won't change for a given SOC. So you 
>>>> want me
>>>> to hard-code in the driver itself?
>>>> 
>>> I can use of_parse_phandle_with_fixed_args function and fix the 
>>> number of
>>> args as 1 instead of keeping #cache-cells here in DT. Does that look 
>>> fine?
>> 
>> No, I'm saying why even put cache-slices properties in DT to begin
>> with? You could just define client id's within the kernel and clients
>> can use those instead of getting the id from the DT.
> 
> The reason to add cache-slices here is to establish a connection 
> between
> client and system cache. For example if we have multiple instances of
> system cache blocks and client wants to choose a system cache instance
> based on the usecase then its easier to establish this connection using
> device tree than hard coding in the driver.
> 
>> 
>> I have a couple of hesitations with putting this into the DT. First, I
>> think a cache is just one aspect of describing the interconnect
>> between masters and memory (and there's been discussions on
>> interconnect bindings too) and any binding needs to consider all of
>> the aspects of the interconnect. Second, I'd expect this cache
>> architecture will change SoC to SoC and the binding here is pretty
>> closely tied to the current cache implementation (e.g. slices). If
>> there were a bunch of SoCs with the same design and just different
>> client IDs (like interrupt IDs), then I'd feel differently.
> 
> This is partially true, a bunch of SoCs would support this design but
> clients IDs are not expected to change. So Ideally client drivers could
> hard code these IDs.
> 
> However I have other concerns of moving the client Ids in the driver.
> The way the APIs implemented today are as follows:
> #1. Client calls into system cache driver to get cache slice handle
> with the usecase Id as input.
> #2. System cache driver gets the phandle of system cache instance from
> the client device to obtain the private data.
> #3. Based on the usecase Id perform look up in the private data to get
> cache slice handle.
> #4. Return the cache slice handle to client
> 
> If we don't have the connection between client & system cache then the
> private data needs to declared as static global in the system cache 
> driver,
> that limits us to have just once instance of system cache block.
> 
> 
>> 
>> Rob

Hi Rob:

Can you please provide your opinion on the approach here?

Thanks,
Channa

-- 
--
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project
