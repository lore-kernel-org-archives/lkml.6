Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753555AbeA3RFT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 12:05:19 -0500
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34975 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751474AbeA3RFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 12:05:17 -0500
X-Google-Smtp-Source: AH8x225iYL5u9jbslEx6ejwL8/YidtL/GvrMUfkvu/Iu9vBperbsCEgAT9pn+/CVyV2+cInfYMBGew==
Date: Tue, 30 Jan 2018 11:05:15 -0600
From: Rob Herring <robh@kernel.org>
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, jcliang@chromium.org,
        robin.murphy@arm.com, xxm@rock-chips.com, tfiga@chromium.org,
        devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org,
        Mark Rutland <mark.rutland@arm.com>, Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 08/13] iommu/rockchip: Control clocks needed to access
 the IOMMU
Message-ID: <20180130170515.3g6wtadqgmehxh5b@rob-hp-laptop>
References: <20180124103516.2571-1-jeffy.chen@rock-chips.com>
 <20180124103516.2571-9-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180124103516.2571-9-jeffy.chen@rock-chips.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 24, 2018 at 06:35:11PM +0800, Jeffy Chen wrote:
> From: Tomasz Figa <tfiga@chromium.org>
> 
> Current code relies on master driver enabling necessary clocks before
> IOMMU is accessed, however there are cases when the IOMMU should be
> accessed while the master is not running yet, for example allocating
> V4L2 videobuf2 buffers, which is done by the VB2 framework using DMA
> mapping API and doesn't engage the master driver at all.
> 
> This patch fixes the problem by letting clocks needed for IOMMU
> operation to be listed in Device Tree and making the driver enable them
> for the time of accessing the hardware.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> ---
> 
> Changes in v5:
> Use clk_bulk APIs.
> 
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  .../devicetree/bindings/iommu/rockchip,iommu.txt   |  8 +++

Please split binding patches to a separate patch.

>  drivers/iommu/rockchip-iommu.c                     | 74 ++++++++++++++++++++--
>  2 files changed, 76 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt b/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
> index 2098f7732264..33dd853359fa 100644
> --- a/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
> +++ b/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
> @@ -14,6 +14,13 @@ Required properties:
>                      "single-master" device, and needs no additional information
>                      to associate with its master device.  See:
>                      Documentation/devicetree/bindings/iommu/iommu.txt
> +Optional properties:
> +- clocks : A list of master clocks requires for the IOMMU to be accessible
> +           by the host CPU. The number of clocks depends on the master
> +           block and might as well be zero. See [1] for generic clock
> +           bindings description.

Hardware blocks don't have a variable number of clock connections. This 
needs to be a defined number of clocks (per compatible string if there 
are different implementations with different # of clocks).

> +
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
>  
>  Optional properties:
>  - rockchip,disable-mmu-reset : Don't use the mmu reset operation.
> @@ -27,5 +34,6 @@ Example:
>  		reg = <0xff940300 0x100>;
>  		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
>  		interrupt-names = "vopl_mmu";
> +		clocks = <&cru ACLK_VOP1>, <&cru DCLK_VOP1>, <&cru HCLK_VOP1>;
>  		#iommu-cells = <0>;
>  	};
