Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3F9E9C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5435208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:35:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5435208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935347AbeFMNfP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 09:35:15 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47616 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934508AbeFMNfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 09:35:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D02B1529;
        Wed, 13 Jun 2018 06:35:13 -0700 (PDT)
Received: from [10.1.206.73] (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C471F3F59D;
        Wed, 13 Jun 2018 06:35:10 -0700 (PDT)
Subject: Re: [RFC PATCH 6/8] dts: coresight: Clean up the device tree graph
 bindings
To:     Matt Sealey <Matt.Sealey@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>,
        John Horley <John.Horley@arm.com>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>,
        "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <1527858967-16047-1-git-send-email-suzuki.poulose@arm.com>
 <1527858967-16047-7-git-send-email-suzuki.poulose@arm.com>
 <20180612204802.GA15817@rob-hp-laptop>
 <a1c0749b-9c97-b45f-716f-a62ae07af278@arm.com>
 <5448BBB7-93FE-400F-9D87-FABF5DE0539C@arm.com>
From:   Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <c0d531ec-9201-bfd8-e6c3-9140698b0697@arm.com>
Date:   Wed, 13 Jun 2018 14:35:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <5448BBB7-93FE-400F-9D87-FABF5DE0539C@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

Thanks for your comments, responses inline.

On 13/06/18 13:49, Matt Sealey wrote:
> Suzuki,
> 
> Why not use “unit”?
> 
> I believe we had this discussion years ago about numbering serial ports and sdhci (i.e. how do you know it’s UART0 or UART1 from just the address? Some SoC’s don’t address sequentially *or* in a forward direction) - I believe it’s not exactly codified in ePAPR, not am I sure where it may be otherwise, but it exists.

We have different situation here. We need to know *the port number* as understood by the
hardware, so that we can enable *the specific* port for a given path.

> 
> I agree with Rob on the slave-mode nonsense, this is an SPI controller concept weirdly stuffed into a directed graph which implicitly tells you the data direction - it’s a rooted tree (just like DT!).

Btw, the "slave-mode" is not a standard DT graph binding. It is not part of the
generic DT graph binding. In fact the generic bindings stay away from the direction
aspect and explicitly mentions the same.

> 
> For the case of a funnel each device supplying trace should end up into an input node - numbered with a unit - and all those nodes should point to the output node as endpoints. Describing the hardware as a black box is probably less of a good idea than showing that it’s a funnel, or replicator by showing the internal paths. You wouldn’t need to “number” ports with a unit except where the HW needs to differentiate between them, and you don’t need reg or a node address to do it.
> 

As I mentioned above, we need the hardware numbers to enable the "specific" port.

E.g, :

static void funnel_enable_hw(struct funnel_drvdata *drvdata, int port)
{
         u32 functl;

         CS_UNLOCK(drvdata->base);

         functl = readl_relaxed(drvdata->base + FUNNEL_FUNCTL);
         functl &= ~FUNNEL_HOLDTIME_MASK;
         functl |= FUNNEL_HOLDTIME;
         functl |= (1 << port);
         writel_relaxed(functl, drvdata->base + FUNNEL_FUNCTL);
         writel_relaxed(drvdata->priority, drvdata->base + FUNNEL_PRICTL);

         CS_LOCK(drvdata->base);
}


> If you really need to parse full graphs in both directions (find root, find leaf) then could we simply introduce properties which list the phandles of all uplink sources, as linked lists point to the list head?

No we don't need to parse it in both ways, up and down. Btw, the trace paths
are not statically created. They are done at runtime, as configured by the
user. So all we need to do is have a list of the ports and the devices it
is connected to (of course with direction information). I would stay
away from duplicating the platform code when something already does
a good job.

> 
> This gives a way to validate that the graph starts and ends the way we expect, and also allows every port to be associated with being a required path between any two devices without parsing the *whole* graph (although you still need to do that to find the route to sinks).

Coming back to your suggestion of "unit", what does it imply ?
Its too generic a term for something as concrete as a port number.

Cheers
Suzuki

> 
> Ta,
> Matt
> 
> Sent from my iPhone
> 
>> On Jun 13, 2018, at 04:45, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
>>
>> Hi Rob,
>>
>>> On 12/06/18 21:48, Rob Herring wrote:
>>>> On Fri, Jun 01, 2018 at 02:16:05PM +0100, Suzuki K Poulose wrote:
>>>> The coresight drivers relied on default bindings for graph
>>>> in DT, while reusing the "reg" field of the "ports" to indicate
>>>> the actual hardware port number for the connections. However,
>>>> with the rules getting stricter w.r.t to the address mismatch
>>>> with the label, it is no longer possible to use the port address
>>>> field for the hardware port number. Hence, we add an explicit
>>>> property to denote the hardware port number, "coresight,hwid"
>>>> which must be specified for each "endpoint".
>>>>
>>>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>>>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>>>> Cc: Rob Herring <robh@kernel.org>
>>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>> ---
>>>>   .../devicetree/bindings/arm/coresight.txt          | 26 +++++++++---
>>>>   drivers/hwtracing/coresight/of_coresight.c         | 46 ++++++++++++++++------
>>>>   2 files changed, 54 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
>>>> index bd36e40..385581a 100644
>>>> --- a/Documentation/devicetree/bindings/arm/coresight.txt
>>>> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
>>>> @@ -104,7 +104,11 @@ properties to uniquely identify the connection details.
>>>>       "slave-mode"
>>>>      * Hardware Port number at the component:
>>>> -     -  The hardware port number is assumed to be the address of the "port" component.
>>>> +   - (Obsolete) The hardware port number is assumed to be the address of the "port" component.
>>>> +   - Each "endpoint" must define the hardware port of the local end of the
>>>> +     connection using the following property:
>>>> +    "coresight,hwid" - 32bit integer, hardware port number at the local end.
>>> "coresight" is not a vendor and properties are in the form
>>> [<vendor>,]<prop-name>.
>>
>> OK. The issue here is that a coresight component could be an Arm IP or
>> a custom partner IP. So, the vendor could be either arm or the partner id.
>> However, this property is kind of a generic one for the Coresight family,
>> which is why we opted for "coresight". What is the guideline for such
>> cases ?
>>
>> Or in other words I see the following possible options :
>>
>> 1) coresight,hwid    - coresight generic
>> 2) arm,coresight-hwid    - arm vendor, however the device could be from any vendor.
>> 3) hwid            - Generic
>> 4) none of the above, something completely different.
>>
>> What do you recommend from the above ?
>>
>>>> +
>>>>       Example:
>>>> @@ -120,6 +124,7 @@ Example:
>>>>               etb_in_port: endpoint@0 {
>>> There shouldn't be a unit address here because there is no reg property.
>>>>                   slave-mode;
>>>>                   remote-endpoint = <&replicator_out_port0>;
>>>> +                coresight,hwid = <0>;
>>> It doesn't make sense for these to be in the endpoint. If you had
>>> multiple endpoints, then you would have to duplicate it. "ports" are
>>> a single data stream. "endpoints" are connections to that stream. So if
>>> you have a muxed (input) or fanout/1-to-many (output) connection, then
>>> you have multiple endpoints.
>>
>> We do have many-to-1 input (e.g, funnels) and 1-to-many outputs
>> (e.g replicators). However, we have (so far) used only one endpoint per
>> port.
>>
>> Also we could potentially have multiple data streams flowing through
>> the ports, which gets filtered to different ports in 1-to-many components
>> (read programmable-replicator).
>>
>> So the point is we have a shared path which carries different data
>> streams with mux/demux components. I am open for suggestions based on
>> the above facts.
>>
>>> The same applied to the slave-mode property, but that ship has sailed.
>>> No reason to continue that though.
>>>>               };
>>>>           };
>>>>       };
>>>> @@ -134,6 +139,7 @@ Example:
>>>>               tpiu_in_port: endpoint@0 {
>>>>                   slave-mode;
>>>>                   remote-endpoint = <&replicator_out_port1>;
>>>> +                coresight,hwid = <0>;
>>>>               };
>>>>           };
>>>>       };
>>>> @@ -154,6 +160,7 @@ Example:
>>>>                   reg = <0>;
>>>>                   replicator_out_port0: endpoint {
>>>>                       remote-endpoint = <&etb_in_port>;
>>>> +                    coresight,hwid = <0>;
>>>>                   };
>>>>               };
>>>>   @@ -161,15 +168,17 @@ Example:
>>>>                   reg = <1>;
>>>>                   replicator_out_port1: endpoint {
>>>>                       remote-endpoint = <&tpiu_in_port>;
>>>> +                    coresight,hwid = <1>;
>>>>                   };
>>>>               };
>>>>                 /* replicator input port */
>>>>               port@2 {
>>>> -                reg = <0>;
>>>> +                reg = <1>;
>>> This will still get flagged as an error. reg must be 2 here.
>>
>> Sorry, thats a mistake. I will fix it.
>>
>> Cheers
>> Suzuki

