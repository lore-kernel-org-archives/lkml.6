Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520462420; cv=none;
        d=google.com; s=arc-20160816;
        b=AK6vevvaJuWNnt6d/kBiRNe0REpJr9KNyv8NDRe0k1/i2IejRbHfJTsTXkymTG/0//
         Bd0/NLarfQyLo0xd+IRIF+FXaFsTDvf9bmgWnRIxcBr89cok3vx78uBy8nGL65ga6TFC
         C8tL2SEeSxriQUOrgErkv5ws39Rz1Aeh3Gh5qYakn6pCUFUomdUt4t4jMdtt/gKu+YTh
         y6VZXlZ2IWhZVaCBfmItI6JWGMVotuDhn6cLqBNpKD+7MVImsPMvOTr+gy3FE6G+68/5
         bLw0GLf7jFMhcV8brmMYsiT9lQdbPpfVz8I6BrVNg/z0Am7hNuNszGAHYd+bPPC9yCwk
         vixg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=3pnOiW156ZRIkIuVH8T81LkPA6AcnfV6htJxIzOGlwA=;
        b=tqUIGbPYoZFKTBDtahN9e03rYa6AFdg1geO93GeNOr9tJVhZiGmdGfzEiWsolH0Qx6
         bAxT/PilvHsKbDNAKsrJ72vncy0giwQw+ZxiGP4HM72dItwqiURopHcHWyts8d4KzzzW
         2HUtw5TQZ7zIo0SZ5wKpkuaycem5TgaswjvqZkLo86cMkmlXCinNNHamrgaD7YZib/gs
         UfQ+ZyEXCkSDdOYyxQWBSWTZjifY53daoJd1PxBh5t9gKVjCYZWj6HRqzdYELIEXOO7v
         V8uWaFrkx9HkZeoL8cx8FRluKqEgIkDp4FNmNy/eVW3C5uZ5UyTgfIcluQ/0xNiAlPjN
         Xljw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AG47ELtgDAcWJjZuhgb5mUu2LlwGgnuSSQhWO+Th9Tg4AqNu0HQFikIbJFEteVn3uod7NMNZXVzsHg==
Date: Wed, 7 Mar 2018 16:40:19 -0600
From: Rob Herring <robh@kernel.org>
To: Nipun Gupta <nipun.gupta@nxp.com>
Cc: will.deacon@arm.com, robin.murphy@arm.com, mark.rutland@arm.com,
	catalin.marinas@arm.com, devicetree@vger.kernel.org,
	stuyoder@gmail.com, bharat.bhushan@nxp.com,
	gregkh@linuxfoundation.org, joro@8bytes.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	leoyang.li@nxp.com, iommu@lists.linux-foundation.org,
	laurentiu.tudor@nxp.com, shawnguo@kernel.org, hch@lst.de,
	linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Subject: Re: [PATCH 1/6] Docs: dt: add fsl-mc iommu-parent device-tree binding
Message-ID: <20180307224019.oowh74pkbi5izuft@rob-hp-laptop>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
 <1520260166-29387-2-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520260166-29387-2-git-send-email-nipun.gupta@nxp.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594108370915742934?=
X-GMAIL-MSGID: =?utf-8?q?1594320403451826732?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 05, 2018 at 07:59:21PM +0530, Nipun Gupta wrote:
> The existing IOMMU bindings cannot be used to specify the relationship
> between fsl-mc devices and IOMMUs. This patch adds a binding for
> mapping fsl-mc devices to IOMMUs, using a new iommu-parent property.
> 
> Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> ---
>  .../devicetree/bindings/misc/fsl,qoriq-mc.txt      | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> index 6611a7c..011c7d6 100644
> --- a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> +++ b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> @@ -9,6 +9,24 @@ blocks that can be used to create functional hardware objects/devices
>  such as network interfaces, crypto accelerator instances, L2 switches,
>  etc.
>  
> +For an overview of the DPAA2 architecture and fsl-mc bus see:
> +drivers/staging/fsl-mc/README.txt
> +
> +As described in the above overview, all DPAA2 objects in a DPRC share the
> +same hardware "isolation context" and a 10-bit value called an ICID
> +(isolation context id) is expressed by the hardware to identify
> +the requester.
> +
> +The generic 'iommus' property is cannot be used to describe the relationship
> +between fsl-mc and IOMMUs, so an iommu-parent property is used to define
> +the same.

Why not? It is just a link between 2 nodes.

> +
> +For generic IOMMU bindings, see
> +Documentation/devicetree/bindings/iommu/iommu.txt.
> +
> +For arm-smmu binding, see:
> +Documentation/devicetree/bindings/iommu/arm,smmu.txt.
> +
>  Required properties:
>  
>      - compatible
> @@ -88,14 +106,27 @@ Sub-nodes:
>                Value type: <phandle>
>                Definition: Specifies the phandle to the PHY device node associated
>                            with the this dpmac.
> +Optional properties:
> +
> +- iommu-parent: Maps the devices on fsl-mc bus to an IOMMU.
> +  The property specifies the IOMMU behind which the devices on
> +  fsl-mc bus are residing.

If you want a generic property, this should be documented in the common 
binding.

Couldn't you have more than 1 IOMMU upstream of a MC?

>  
>  Example:
>  
> +        smmu: iommu@5000000 {
> +               compatible = "arm,mmu-500";
> +               #iommu-cells = <1>;
> +               stream-match-mask = <0x7C00>;
> +               ...
> +        };
> +
>          fsl_mc: fsl-mc@80c000000 {
>                  compatible = "fsl,qoriq-mc";
>                  reg = <0x00000008 0x0c000000 0 0x40>,    /* MC portal base */
>                        <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
>                  msi-parent = <&its>;
> +                iommu-parent = <&smmu>;
>                  #address-cells = <3>;
>                  #size-cells = <1>;
>  
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
