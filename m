Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50512ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C562152C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C562152C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732564AbeITRcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 13:32:52 -0400
Received: from foss.arm.com ([217.140.101.70]:44504 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbeITRcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 13:32:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3210980D;
        Thu, 20 Sep 2018 04:49:45 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.Emea.Arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 851BC3F5BD;
        Thu, 20 Sep 2018 04:49:43 -0700 (PDT)
Subject: Re: [PATCH 00/21] SMMU enablement for NXP LS1043A and LS1046A
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Cc:     Roy Pledge <roy.pledge@nxp.com>, Leo Li <leoyang.li@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Madalin-cristian Bucur <madalin.bucur@nxp.com>
References: <20180919123613.15092-1-laurentiu.tudor@nxp.com>
 <7d7646dc-9d0b-013d-75d7-a6cb4453f41f@arm.com>
 <fd8ab351-46aa-f73e-593b-502a57de1975@nxp.com>
 <39211e7a-034b-cdca-f182-1b6f6e5fbc53@arm.com>
 <33eac426-cbb7-f899-5a35-aea28f8e5dc4@nxp.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <c2acecc8-5357-6cbe-f93c-00d71470dff5@arm.com>
Date:   Thu, 20 Sep 2018 12:49:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <33eac426-cbb7-f899-5a35-aea28f8e5dc4@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/18 11:38, Laurentiu Tudor wrote:
> 
> 
> On 19.09.2018 17:37, Robin Murphy wrote:
>> On 19/09/18 15:18, Laurentiu Tudor wrote:
>>> Hi Robin,
>>>
>>> On 19.09.2018 16:25, Robin Murphy wrote:
>>>> Hi Laurentiu,
>>>>
>>>> On 19/09/18 13:35, laurentiu.tudor@nxp.com wrote:
>>>>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>>>>
>>>>> This patch series adds SMMU support for NXP LS1043A and LS1046A chips
>>>>> and consists mostly in important driver fixes and the required device
>>>>> tree updates. It touches several subsystems and consists of three main
>>>>> parts:
>>>>>     - changes in soc/drivers/fsl/qbman drivers adding iommu mapping of
>>>>>       reserved memory areas, fixes and defered probe support
>>>>>     - changes in drivers/net/ethernet/freescale/dpaa_eth drivers
>>>>>       consisting in misc dma mapping related fixes and probe ordering
>>>>>     - addition of the actual arm smmu device tree node together with
>>>>>       various adjustments to the device trees
>>>>>
>>>>> Performance impact
>>>>>
>>>>>        Running iperf benchmarks in a back-to-back setup (both sides
>>>>>        having smmu enabled) on a 10GBps port show an important
>>>>>        networking performance degradation of around %40 (9.48Gbps
>>>>>        linerate vs 5.45Gbps). If you need performance but without
>>>>>        SMMU support you can use "iommu.passthrough=1" to disable
>>>>>        SMMU.

I should have said before - thanks for the numbers there as well. Always 
good to add another datapoint to my collection. If you're interested 
I've added SMMUv2 support to the "non-strict mode" series (of which I 
should be posting v8 soon), so it might be fun to see how well that 
works on MMU-500 in the real world.

>>>>>
>>>>> USB issue and workaround
>>>>>
>>>>>        There's a problem with the usb controllers in these chips
>>>>>        generating smaller, 40-bit wide dma addresses instead of the
>>>>> 48-bit
>>>>>        supported at the smmu input. So you end up in a situation
>>>>> where the
>>>>>        smmu is mapped with 48-bit address translations, but the device
>>>>>        generates transactions with clipped 40-bit addresses, thus smmu
>>>>>        context faults are triggered. I encountered a similar
>>>>> situation for
>>>>>        mmc that I  managed to fix in software [1] however for USB I
>>>>> did not
>>>>>        find a proper place in the code to add a similar fix. The only
>>>>>        workaround I found was to add this kernel parameter which
>>>>> limits the
>>>>>        usb dma to 32-bit size: "xhci-hcd.quirks=0x800000".
>>>>>        This workaround if far from ideal, so any suggestions for a code
>>>>>        based workaround in this area would be greatly appreciated.
>>>>
>>>> If you have a nominally-64-bit device with a
>>>> narrower-than-the-main-interconnect link in front of it, that should
>>>> already be fixed in 4.19-rc by bus_dma_mask picking up DT dma-ranges,
>>>> provided the interconnect hierarchy can be described appropriately (or
>>>> at least massaged sufficiently to satisfy the binding), e.g.:
>>>>
>>>> / {
>>>>        ...
>>>>
>>>>        soc {
>>>>            ranges;
>>>>            dma-ranges = <0 0 10000 0>;
>>>>
>>>>            dev_48bit { ... };
>>>>
>>>>            periph_bus {
>>>>                ranges;
>>>>                dma-ranges = <0 0 100 0>;
>>>>
>>>>                dev_40bit { ... };
>>>>            };
>>>>        };
>>>> };
>>>>
>>>> and if that fails to work as expected (except for PCI hosts where
>>>> handling dma-ranges properly still needs sorting out), please do let us
>>>> know ;)
>>>>
>>>
>>> Just to confirm, Is this [1] the change I was supposed to test?
>>
>> Not quite - dma-ranges is only valid for nodes representing a bus, so
>> putting it directly in the USB device nodes doesn't work (FWIW that's
>> why PCI is broken, because the parser doesn't expect the
>> bus-as-leaf-node case). That's teh point of that intermediate simple-bus
>> node represented by "periph_bus" in my example (sorry, I should have put
>> compatibles in to make it clearer) - often that's actually true to life
>> (i.e. "soc" is something like a CCI and "periph_bus" is something like
>> an AXI NIC gluing a bunch of lower-bandwidth DMA masters to one of the
>> CCI ports) but at worst it's just a necessary evil to make the binding
>> happy (if it literally only represents the point-to-point link between
>> the device master port and interconnect slave port).
>>
> 
> Quick update: so I adjusted to device tree according to your example and
> it works so now I can get rid of that nasty kernel arg based workaround,
> yey! :-)

Cool! In fact, judging by the block diagrams on the website, the "basic 
peripherals and interconnect" section hanging off the side of the CCI 
implies that probably is true to the real topology as I imagined, so it 
doesn't even count as a horrible hack :)

> Thanks a lot, that was really helpful.

No problem. FWIW if you ever come to doing ACPI support for these SoCs, 
the equivalent is merely a case of setting the device memory address 
size limit field appropriately for all the named components.

Robin.
