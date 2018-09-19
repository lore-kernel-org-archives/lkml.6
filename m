Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752F2ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB442150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FB442150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732031AbeISUP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 16:15:29 -0400
Received: from foss.arm.com ([217.140.101.70]:60734 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731742AbeISUP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 16:15:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6467C7A9;
        Wed, 19 Sep 2018 07:37:15 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.emea.arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93A683F557;
        Wed, 19 Sep 2018 07:37:13 -0700 (PDT)
Subject: Re: [PATCH 00/21] SMMU enablement for NXP LS1043A and LS1046A
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Cc:     Madalin-cristian Bucur <madalin.bucur@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>, Leo Li <leoyang.li@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
References: <20180919123613.15092-1-laurentiu.tudor@nxp.com>
 <7d7646dc-9d0b-013d-75d7-a6cb4453f41f@arm.com>
 <fd8ab351-46aa-f73e-593b-502a57de1975@nxp.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <39211e7a-034b-cdca-f182-1b6f6e5fbc53@arm.com>
Date:   Wed, 19 Sep 2018 15:37:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <fd8ab351-46aa-f73e-593b-502a57de1975@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/18 15:18, Laurentiu Tudor wrote:
> Hi Robin,
> 
> On 19.09.2018 16:25, Robin Murphy wrote:
>> Hi Laurentiu,
>>
>> On 19/09/18 13:35, laurentiu.tudor@nxp.com wrote:
>>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>>
>>> This patch series adds SMMU support for NXP LS1043A and LS1046A chips
>>> and consists mostly in important driver fixes and the required device
>>> tree updates. It touches several subsystems and consists of three main
>>> parts:
>>>    - changes in soc/drivers/fsl/qbman drivers adding iommu mapping of
>>>      reserved memory areas, fixes and defered probe support
>>>    - changes in drivers/net/ethernet/freescale/dpaa_eth drivers
>>>      consisting in misc dma mapping related fixes and probe ordering
>>>    - addition of the actual arm smmu device tree node together with
>>>      various adjustments to the device trees
>>>
>>> Performance impact
>>>
>>>       Running iperf benchmarks in a back-to-back setup (both sides
>>>       having smmu enabled) on a 10GBps port show an important
>>>       networking performance degradation of around %40 (9.48Gbps
>>>       linerate vs 5.45Gbps). If you need performance but without
>>>       SMMU support you can use "iommu.passthrough=1" to disable
>>>       SMMU.
>>>
>>> USB issue and workaround
>>>
>>>       There's a problem with the usb controllers in these chips
>>>       generating smaller, 40-bit wide dma addresses instead of the 48-bit
>>>       supported at the smmu input. So you end up in a situation where the
>>>       smmu is mapped with 48-bit address translations, but the device
>>>       generates transactions with clipped 40-bit addresses, thus smmu
>>>       context faults are triggered. I encountered a similar situation for
>>>       mmc that I  managed to fix in software [1] however for USB I did not
>>>       find a proper place in the code to add a similar fix. The only
>>>       workaround I found was to add this kernel parameter which limits the
>>>       usb dma to 32-bit size: "xhci-hcd.quirks=0x800000".
>>>       This workaround if far from ideal, so any suggestions for a code
>>>       based workaround in this area would be greatly appreciated.
>>
>> If you have a nominally-64-bit device with a
>> narrower-than-the-main-interconnect link in front of it, that should
>> already be fixed in 4.19-rc by bus_dma_mask picking up DT dma-ranges,
>> provided the interconnect hierarchy can be described appropriately (or
>> at least massaged sufficiently to satisfy the binding), e.g.:
>>
>> / {
>>       ...
>>
>>       soc {
>>           ranges;
>>           dma-ranges = <0 0 10000 0>;
>>
>>           dev_48bit { ... };
>>
>>           periph_bus {
>>               ranges;
>>               dma-ranges = <0 0 100 0>;
>>
>>               dev_40bit { ... };
>>           };
>>       };
>> };
>>
>> and if that fails to work as expected (except for PCI hosts where
>> handling dma-ranges properly still needs sorting out), please do let us
>> know ;)
>>
> 
> Just to confirm, Is this [1] the change I was supposed to test?

Not quite - dma-ranges is only valid for nodes representing a bus, so 
putting it directly in the USB device nodes doesn't work (FWIW that's 
why PCI is broken, because the parser doesn't expect the 
bus-as-leaf-node case). That's teh point of that intermediate simple-bus 
node represented by "periph_bus" in my example (sorry, I should have put 
compatibles in to make it clearer) - often that's actually true to life 
(i.e. "soc" is something like a CCI and "periph_bus" is something like 
an AXI NIC gluing a bunch of lower-bandwidth DMA masters to one of the 
CCI ports) but at worst it's just a necessary evil to make the binding 
happy (if it literally only represents the point-to-point link between 
the device master port and interconnect slave port).

> Because if so, I'm still seeing context faults [2] with what looks like
> clipped to 40-bits addresses. :-(
> IIRC, the usb subsystem explicitly set 64-bit dma masks which in turn
> will be limited to the SMMU input size of 48-bit. Won't that overwrite
> the default dma mask derived from dma-ranges?

Indeed it will, but those default masks were effectively only ever a 
best-effort thing anyway - it's an ease-of-implementation detail that 
bus_dma_mask is not currently reflected in the device masks, although we 
may eventually change that; the crucial part is that the DMA ops 
implementations know about it and should now enforce it properly 
regardless of whether drivers set something wider.

Robin.

> 
> ---
> Best Regards, Laurentiu
> 
> [1] -----------------------------------------------------------------
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> index 3bdea0470f69..a214c3df37fd 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> @@ -612,6 +612,7 @@
>                           compatible = "snps,dwc3";
>                           reg = <0x0 0x2f00000 0x0 0x10000>;
>                           interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
> +                       dma-ranges = <0x0 0x0 0x0 0x0 0x100 0x00000000>;
>                           dr_mode = "host";
>                           snps,quirk-frame-length-adjustment = <0x20>;
>                           snps,dis_rxdet_inp3_quirk;
> @@ -621,6 +622,7 @@
>                           compatible = "snps,dwc3";
>                           reg = <0x0 0x3000000 0x0 0x10000>;
>                           interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
> +                       dma-ranges = <0x0 0x0 0x0 0x0 0x100 0x00000000>;
>                           dr_mode = "host";
>                           snps,quirk-frame-length-adjustment = <0x20>;
>                           snps,dis_rxdet_inp3_quirk;
> @@ -630,6 +632,7 @@
>                           compatible = "snps,dwc3";
>                           reg = <0x0 0x3100000 0x0 0x10000>;
>                           interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
> +                       dma-ranges = <0x0 0x0 0x0 0x0 0x100 0x00000000>;
>                           dr_mode = "host";
>                           snps,quirk-frame-length-adjustment = <0x20>;
>                           snps,dis_rxdet_inp3_quirk;
> 
> [2] -----------------------------------------------------------------
> [    2.090577] xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
> [    2.096064] xhci-hcd xhci-hcd.0.auto: new USB bus registered,
> assigned bus number 2
> [    2.103720] xhci-hcd xhci-hcd.0.auto: Host supports USB 3.0  SuperSpeed
> [    2.110346] arm-smmu 9000000.iommu: Unhandled context fault:
> fsr=0x402, iova=0xffffffb000, fsynr=0x1b0000, cb=3
> [    2.120449] usb usb2: We don't know the algorithms for LPM for this
> host, disabling LPM.
> [    2.128717] hub 2-0:1.0: USB hub found
> [    2.132473] hub 2-0:1.0: 1 port detected
> [    2.136527] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
> [    2.142014] xhci-hcd xhci-hcd.1.auto: new USB bus registered,
> assigned bus number 3
> [    2.149747] xhci-hcd xhci-hcd.1.auto: hcc params 0x0220f66d hci
> version 0x100 quirks 0x0000000002010010
> [    2.159149] xhci-hcd xhci-hcd.1.auto: irq 50, io mem 0x03000000
> [    2.165284] hub 3-0:1.0: USB hub found
> [    2.169039] hub 3-0:1.0: 1 port detected
> [    2.173051] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
> [    2.178536] xhci-hcd xhci-hcd.1.auto: new USB bus registered,
> assigned bus number 4
> [    2.186193] xhci-hcd xhci-hcd.1.auto: Host supports USB 3.0  SuperSpeed
> [    2.192809] arm-smmu 9000000.iommu: Unhandled context fault:
> fsr=0x402, iova=0xffffffb000, fsynr=0x1f0000, cb=4
> [    2.192822] usb usb4: We don't know the algorithms for LPM for this
> host, disabling LPM.
> [    2.211141] hub 4-0:1.0: USB hub found
> [    2.214896] hub 4-0:1.0: 1 port detected
> [    2.218935] xhci-hcd xhci-hcd.2.auto: xHCI Host Controller
> [    2.224425] xhci-hcd xhci-hcd.2.auto: new USB bus registered,
> assigned bus number 5
> [    2.232153] xhci-hcd xhci-hcd.2.auto: hcc params 0x0220f66d hci
> version 0x100 quirks 0x0000000002010010
> [    2.241562] xhci-hcd xhci-hcd.2.auto: irq 51, io mem 0x03100000
> [    2.247694] hub 5-0:1.0: USB hub found
> [    2.251449] hub 5-0:1.0: 1 port detected
> [    2.255458] xhci-hcd xhci-hcd.2.auto: xHCI Host Controller
> [    2.260945] xhci-hcd xhci-hcd.2.auto: new USB bus registered,
> assigned bus number 6
> [    2.268601] xhci-hcd xhci-hcd.2.auto: Host supports USB 3.0  SuperSpeed
> [    2.275218] arm-smmu 9000000.iommu: Unhandled context fault:
> fsr=0x402, iova=0xffffffb000, fsynr=0x110000, cb=5
> [    2.275230] usb usb6: We don't know the algorithms for LPM for this
> host, disabling LPM.
> 
> 
>>> The patch set is based on net-next so, if generally agreed, I'd suggest
>>> to get the patches through the netdev tree after getting all the Acks.
>>>
>>> [1]
>>> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.kernel.org%2Fpatch%2F10506627%2F&amp;data=02%7C01%7Claurentiu.tudor%40nxp.com%7C63c4e1dfc126488eb4ba08d61e336607%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636729603447603039&amp;sdata=XhjOX9aLgoe%2BSTBgZztv6zCz0vMebSXW%2Fnb2QcD5shY%3D&amp;reserved=0
>>>
>>>
>>> Laurentiu Tudor (21):
>>>     soc/fsl/qman: fixup liodns only on ppc targets
>>>     soc/fsl/bman: map FBPR area in the iommu
>>>     soc/fsl/qman: map FQD and PFDR areas in the iommu
>>>     soc/fsl/qman-portal: map CENA area in the iommu
>>>     soc/fsl/qbman: add APIs to retrieve the probing status
>>>     soc/fsl/qman_portals: defer probe after qman's probe
>>>     soc/fsl/bman_portals: defer probe after bman's probe
>>>     soc/fsl/qbman_portals: add APIs to retrieve the probing status
>>>     fsl/fman: backup and restore ICID registers
>>>     fsl/fman: add API to get the device behind a fman port
>>>     dpaa_eth: defer probing after qbman
>>>     dpaa_eth: base dma mappings on the fman rx port
>>>     dpaa_eth: fix iova handling for contiguous frames
>>>     dpaa_eth: fix iova handling for sg frames
>>>     dpaa_eth: fix SG frame cleanup
>>>     arm64: dts: ls1046a: add smmu node
>>>     arm64: dts: ls1043a: add smmu node
>>>     arm64: dts: ls104xa: set mask to drop TBU ID from StreamID
>>>     arm64: dts: ls104x: add missing dma ranges property
>>>     arm64: dts: ls104x: add iommu-map to pci controllers
>>>     arm64: dts: ls104x: make dma-coherent global to the SoC
>>>
>>>    .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi |  52 ++++++-
>>>    .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi |  48 +++++++
>>>    .../net/ethernet/freescale/dpaa/dpaa_eth.c    | 136 ++++++++++++------
>>>    drivers/net/ethernet/freescale/fman/fman.c    |  35 ++++-
>>>    drivers/net/ethernet/freescale/fman/fman.h    |   4 +
>>>    .../net/ethernet/freescale/fman/fman_port.c   |  14 ++
>>>    .../net/ethernet/freescale/fman/fman_port.h   |   2 +
>>>    drivers/soc/fsl/qbman/bman_ccsr.c             |  23 +++
>>>    drivers/soc/fsl/qbman/bman_portal.c           |  20 ++-
>>>    drivers/soc/fsl/qbman/qman_ccsr.c             |  30 ++++
>>>    drivers/soc/fsl/qbman/qman_portal.c           |  35 +++++
>>>    include/soc/fsl/bman.h                        |  16 +++
>>>    include/soc/fsl/qman.h                        |  17 +++
>>>    13 files changed, 379 insertions(+), 53 deletions(-)
>> >
