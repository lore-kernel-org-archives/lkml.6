Return-Path: <robin.murphy@arm.com>
X-Google-Smtp-Source: AG47ELsJCbp1j67UtUjUzYMAlmUInGBe/ihUjPEyZVrBi/L80dW40eq8NO65+AtWI+qtNMiNdBjj
ARC-Seal: i=1; a=rsa-sha256; t=1520261607; cv=none;
        d=google.com; s=arc-20160816;
        b=F96BzSIVxE85M1pH8uxkLVvuZYSxjIDV0j80docTlCgJR8K8WuPuByGOynN9rwjrvU
         kQJ62RyUEroPsaKXt42IZFlNkWQGpRhOdYNa8zwXG1jb74vMzz41KPlRPzWlPgoS0h1o
         CYJ83npVgUlTYNwXqWAoc+MQuCBpn7MMUceBfE9BSJ5EtIX/0ZC4LEDIRUm02dm4Lm/s
         Ov7sTmhSzWvfIE4eUwTBeYfNY7al38hdkjOAovaIwwHyD7UvsVo9WxZA4AJ2IUADGsJU
         yPz0sEJ8dvGzvGgwGYH9DXkS9329U3XhxgC7zF+sa732EaNgHQiJFUSBb2y+Ql55IG91
         EBaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=JW3TUQhgTO6csdbZU8ieDnnq0UDT6i2CqeBlYxcbuT0=;
        b=RaDex7x+ADvlneoAFNNNuFPZwf7f8x7rRhrB6twSShl5VRWBQlkoA4lY1MJRfys53z
         p7Sls+RMH9BxQtPa35OhjE52tdqMME6cLjCthCyf3IGajm32PCvWBvIyQLLTWBZ7gxmA
         ZJVH6UgO+U5CjAVrNEkcqG9EVJfSRBqysJshvOtojWTZlQIyu0fYSF1pSCdBX1jkMJ2X
         0CzLJvsjn+aHQDwJkpthKL1lDe3McQZFX03BIiOPUCldCeQSRGrxhaZftaWIanczXNyB
         IXrwlZbYD8jhNUs/TCjRDt5RYY9Mkkk0YJrAYLuDGmI0cvRC+A+DWNWk2LDO5AwrfKer
         JsEA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Subject: Re: [PATCH 1/6] Docs: dt: add fsl-mc iommu-parent device-tree binding
To: Nipun Gupta <nipun.gupta@nxp.com>, will.deacon@arm.com,
 mark.rutland@arm.com, catalin.marinas@arm.com
Cc: iommu@lists.linux-foundation.org, robh+dt@kernel.org, hch@lst.de,
 m.szyprowski@samsung.com, gregkh@linuxfoundation.org, joro@8bytes.org,
 leoyang.li@nxp.com, shawnguo@kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, bharat.bhushan@nxp.com, stuyoder@gmail.com,
 laurentiu.tudor@nxp.com
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
 <1520260166-29387-2-git-send-email-nipun.gupta@nxp.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <5cdeded1-ca3c-339a-bf73-73401e7dd4ed@arm.com>
Date: Mon, 5 Mar 2018 14:53:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520260166-29387-2-git-send-email-nipun.gupta@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594108370915742934?=
X-GMAIL-MSGID: =?utf-8?q?1594109835212347529?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/03/18 14:29, Nipun Gupta wrote:
> The existing IOMMU bindings cannot be used to specify the relationship
> between fsl-mc devices and IOMMUs. This patch adds a binding for
> mapping fsl-mc devices to IOMMUs, using a new iommu-parent property.

Given that allowing "msi-parent" for #msi-cells > 1 is merely a 
backward-compatibility bodge full of hard-coded assumptions, why would 
we want to knowingly introduce a similarly unpleasant equivalent for 
IOMMUs? What's wrong with "iommu-map"?

> Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> ---
>   .../devicetree/bindings/misc/fsl,qoriq-mc.txt      | 31 ++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> index 6611a7c..011c7d6 100644
> --- a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> +++ b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> @@ -9,6 +9,24 @@ blocks that can be used to create functional hardware objects/devices
>   such as network interfaces, crypto accelerator instances, L2 switches,
>   etc.
>   
> +For an overview of the DPAA2 architecture and fsl-mc bus see:
> +drivers/staging/fsl-mc/README.txt
> +
> +As described in the above overview, all DPAA2 objects in a DPRC share the
> +same hardware "isolation context" and a 10-bit value called an ICID
> +(isolation context id) is expressed by the hardware to identify
> +the requester.

IOW, precisely the case for which "{msi,iommu}-map" exist. Yes, I know 
they're currently documented under bindings/pci, but they're not really 
intended to be absolutely PCI-specific.

Robin.

> +The generic 'iommus' property is cannot be used to describe the relationship
> +between fsl-mc and IOMMUs, so an iommu-parent property is used to define
> +the same.
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
> @@ -88,14 +106,27 @@ Sub-nodes:
>                 Value type: <phandle>
>                 Definition: Specifies the phandle to the PHY device node associated
>                             with the this dpmac.
> +Optional properties:
> +
> +- iommu-parent: Maps the devices on fsl-mc bus to an IOMMU.
> +  The property specifies the IOMMU behind which the devices on
> +  fsl-mc bus are residing.
>   
>   Example:
>   
> +        smmu: iommu@5000000 {
> +               compatible = "arm,mmu-500";
> +               #iommu-cells = <1>;
> +               stream-match-mask = <0x7C00>;
> +               ...
> +        };
> +
>           fsl_mc: fsl-mc@80c000000 {
>                   compatible = "fsl,qoriq-mc";
>                   reg = <0x00000008 0x0c000000 0 0x40>,    /* MC portal base */
>                         <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
>                   msi-parent = <&its>;
> +                iommu-parent = <&smmu>;
>                   #address-cells = <3>;
>                   #size-cells = <1>;
>   
> 
