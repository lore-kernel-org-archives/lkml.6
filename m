Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755226AbeDWMnr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 08:43:47 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37311 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754942AbeDWMnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 08:43:45 -0400
X-Google-Smtp-Source: AIpwx486Ayq2LBRvLiLL7bAcEeJ+zfi3o1u54zjDAlOD+tf/C1Y+nqogwI7ffRnSV81X4Wql5l/nIA==
Subject: Re: [PATCH 0/7] Level-triggered MSI support
To: Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org
References: <20180423103440.26592-1-marc.zyngier@arm.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <5d7e8fa9-e1d2-acc2-4137-443b5a82b488@linaro.org>
Date: Mon, 23 Apr 2018 13:43:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180423103440.26592-1-marc.zyngier@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/04/18 11:34, Marc Zyngier wrote:
> This series is a first shot at teaching the kernel about the oxymoron
> expressed in $SUBJECT. Over the past couple of years, we've seen some
> SoCs coming up with ways of signalling level interrupts using a new
> flavor of MSIs, where the MSI controller uses two distinct messages:
> one that raises a virtual line, and one that lowers it. The target MSI
> controller is in charge of maintaining the state of the line.
> 
> This allows for a much simplified HW signal routing (no need to have
> hundreds of discrete lines to signal level interrupts if you already
> have a memory bus), but results in a departure from the current idea
> the kernel has of MSIs.
> 
> This series takes a minimal approach to the problem, which is to allow
> MSI controllers to use not only one, but up to two messages at a
> time. This is controlled by a flag exposed at MSI irq domain creation,
> and is only supported with platform MSI.
> 
> The rest of the series repaints the Marvell ICU/GICP drivers which
> already make use of this feature with a side-channel, and adds support
> for the same feature in GICv3. A side effect of the last GICv3 patch
> is that you can also use SPIs to signal PCI MSIs. This is a last
> resort measure for SoCs where the ITS is unusable for unspeakable
> reasons.
> 
> Marc Zyngier (7):
>    genirq/msi: Allow level-triggered MSIs to be exposed by MSI providers
>    genirq/msi: Limit level-triggered MSI to platform devices
>    irqchip/mvebu-gicp: Use level-triggered MSIs between ICU and GICP
>    dma-iommu: Fix compilation when !CONFIG_IOMMU_DMA
>    irqchip/gic-v3: Add support for Message Based Interrupts as an MSI
>      controller
>    irqchip/gic-v3: Add PCI/MSI support to the GICv3 MBI sub-driver
>    dt-bindings/gic-v3: Add documentation for MBI support
> 

Thanks for the patches,

Am able to get PCIe MSI interrupts on Qualcomm DragonBoard DB820c with 
this patchset.

root@linaro-alip:~# cat /proc/interrupts  | grep -i MSI
  44:          0          0          0          0     GICv3 437 Edge 
  qcom-pcie-msi
  45:          0          0          0          0     GICv3 445 Edge 
  qcom-pcie-msi
  46:          0          0          0          0     GICv3 453 Edge 
  qcom-pcie-msi
  80:          0          0          0          0       MSI 134217728 
Edge      PCIe PME, aerdrv
114:          0          0          0          0       MSI 268435456 
Edge      PCIe PME, aerdrv
115:          0          0          0          0       MSI 134742016 
Edge      ahci[0001:01:00.0]
197:          0          0          0          0       MSI   0 Edge 
PCIe PME, aerdrv
199:       2108          0          0          0       MSI 524288 Edge 
    ath10k_pci
202:        295          0          0          0       MSI 268959744 
Edge      eth0


Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

--srini
