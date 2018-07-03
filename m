Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15043C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19A020836
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:40:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C19A020836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932440AbeGCOkG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 10:40:06 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50224 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932234AbeGCOkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 10:40:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD6A27A9;
        Tue,  3 Jul 2018 07:40:04 -0700 (PDT)
Received: from [10.1.210.23] (e110467-lin.cambridge.arm.com [10.1.210.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 207A43F5AD;
        Tue,  3 Jul 2018 07:40:00 -0700 (PDT)
Subject: Re: [PATCH 1/7 v5] Docs: dt: add fsl-mc iommu-map device-tree binding
To:     Nipun Gupta <nipun.gupta@nxp.com>, will.deacon@arm.com,
        robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, gregkh@linuxfoundation.org,
        laurentiu.tudor@nxp.com, bhelgaas@google.com
Cc:     hch@lst.de, joro@8bytes.org, m.szyprowski@samsung.com,
        shawnguo@kernel.org, frowand.list@gmail.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        bharat.bhushan@nxp.com, stuyoder@gmail.com, leoyang.li@nxp.com
References: <1526824191-7000-1-git-send-email-nipun.gupta@nxp.com>
 <1526824191-7000-2-git-send-email-nipun.gupta@nxp.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <cd70dc56-ce6a-f6ef-1362-143d9c31bb46@arm.com>
Date:   Tue, 3 Jul 2018 15:39:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1526824191-7000-2-git-send-email-nipun.gupta@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/18 14:49, Nipun Gupta wrote:
> The existing IOMMU bindings cannot be used to specify the relationship
> between fsl-mc devices and IOMMUs. This patch adds a generic binding for
> mapping fsl-mc devices to IOMMUs, using iommu-map property.
> 
> Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>   .../devicetree/bindings/misc/fsl,qoriq-mc.txt      | 39 ++++++++++++++++++++++
>   1 file changed, 39 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> index 6611a7c..8cbed4f 100644
> --- a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> +++ b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> @@ -9,6 +9,25 @@ blocks that can be used to create functional hardware objects/devices
>   such as network interfaces, crypto accelerator instances, L2 switches,
>   etc.
>   
> +For an overview of the DPAA2 architecture and fsl-mc bus see:
> +drivers/staging/fsl-mc/README.txt

Nit: Looks like that's Documentation/networking/dpaa2/overview.rst now.

> +
> +As described in the above overview, all DPAA2 objects in a DPRC share the
> +same hardware "isolation context" and a 10-bit value called an ICID
> +(isolation context id) is expressed by the hardware to identify
> +the requester.
> +
> +The generic 'iommus' property is insufficient to describe the relationship
> +between ICIDs and IOMMUs, so an iommu-map property is used to define
> +the set of possible ICIDs under a root DPRC and how they map to
> +an IOMMU.
> +
> +For generic IOMMU bindings, see
> +Documentation/devicetree/bindings/iommu/iommu.txt.
> +
> +For arm-smmu binding, see:
> +Documentation/devicetree/bindings/iommu/arm,smmu.txt.
> +
>   Required properties:
>   
>       - compatible
> @@ -88,14 +107,34 @@ Sub-nodes:
>                 Value type: <phandle>
>                 Definition: Specifies the phandle to the PHY device node associated
>                             with the this dpmac.
> +Optional properties:
> +
> +- iommu-map: Maps an ICID to an IOMMU and associated iommu-specifier
> +  data.
> +
> +  The property is an arbitrary number of tuples of
> +  (icid-base,iommu,iommu-base,length).
> +
> +  Any ICID i in the interval [icid-base, icid-base + length) is
> +  associated with the listed IOMMU, with the iommu-specifier
> +  (i - icid-base + iommu-base).
>   
>   Example:
>   
> +        smmu: iommu@5000000 {
> +               compatible = "arm,mmu-500";
> +               #iommu-cells = <2>;

This should be 1 if stream-match-mask is present. Bad example is bad :)

Robin.

> +               stream-match-mask = <0x7C00>;
> +               ...
> +        };
> +
>           fsl_mc: fsl-mc@80c000000 {
>                   compatible = "fsl,qoriq-mc";
>                   reg = <0x00000008 0x0c000000 0 0x40>,    /* MC portal base */
>                         <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
>                   msi-parent = <&its>;
> +                /* define map for ICIDs 23-64 */
> +                iommu-map = <23 &smmu 23 41>;
>                   #address-cells = <3>;
>                   #size-cells = <1>;
>   
> 
