Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751437AbeCNK1X (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 06:27:23 -0400
Received: from mga07.intel.com ([134.134.136.100]:62334 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750751AbeCNK1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 06:27:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,469,1515484800";
   d="scan'208";a="25591039"
Subject: Re: [PATCH] PCI/MSI: Don't set up INTx if MSI or MSI-X is enabled
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        David Howells <dhowells@redhat.com>, linux-cris-kernel@axis.com,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-am33-list@redhat.com
References: <152097754955.241946.9551793957889760940.stgit@bhelgaas-glaptop.roam.corp.google.com>
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <c3f097e6-9347-58f5-579a-21b40a7bef3e@intel.com>
Date: Wed, 14 Mar 2018 11:27:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <152097754955.241946.9551793957889760940.stgit@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/2018 10:45 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> If a device already has MSI or MSI-X enabled, there's no need to set up its
> legacy INTx interrupt.
>
> bba6f6fc68e7 ("[PATCH] MSI-X: fix resume crash") changed the cris, frv,
> x86, and ia64 arches to skip INTx setup when MSI is enabled.
>
> 16cf0ebc35dd ("x86/PCI: Do not use interrupt links for devices using
> MSI-X") extended that by changing x86 to also skip INTx setup when MSI-X is
> enabled.
>
> Change the remaining arches (cris, frv, and ia64) to skip INTx setup when
> either MSI or MSI-X is enabled.
>
> Also update mn10300 (which didn't exist at the time of bba6f6fc68e7) to
> follow the same pattern.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>   arch/cris/arch-v32/drivers/pci/bios.c |    2 +-
>   arch/frv/mb93090-mb00/pci-vdk.c       |    2 +-
>   arch/ia64/pci/pci.c                   |    4 ++--
>   arch/mn10300/unit-asb2305/pci.c       |    8 +++++---
>   4 files changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/arch/cris/arch-v32/drivers/pci/bios.c b/arch/cris/arch-v32/drivers/pci/bios.c
> index 6b9e6cfaa29e..c2bed0cc060b 100644
> --- a/arch/cris/arch-v32/drivers/pci/bios.c
> +++ b/arch/cris/arch-v32/drivers/pci/bios.c
> @@ -68,7 +68,7 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
>   	if ((err = pcibios_enable_resources(dev, mask)) < 0)
>   		return err;
>   
> -	if (!dev->msi_enabled)
> +	if (!pci_dev_msi_enabled(dev))
>   		pcibios_enable_irq(dev);
>   	return 0;
>   }
> diff --git a/arch/frv/mb93090-mb00/pci-vdk.c b/arch/frv/mb93090-mb00/pci-vdk.c
> index f211839e2cae..4a55d1b82d21 100644
> --- a/arch/frv/mb93090-mb00/pci-vdk.c
> +++ b/arch/frv/mb93090-mb00/pci-vdk.c
> @@ -413,7 +413,7 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
>   
>   	if ((err = pci_enable_resources(dev, mask)) < 0)
>   		return err;
> -	if (!dev->msi_enabled)
> +	if (!pci_dev_msi_enabled(dev))
>   		pcibios_enable_irq(dev);
>   	return 0;
>   }
> diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
> index f5ec736100ee..7ccc64d5fe3e 100644
> --- a/arch/ia64/pci/pci.c
> +++ b/arch/ia64/pci/pci.c
> @@ -398,7 +398,7 @@ pcibios_enable_device (struct pci_dev *dev, int mask)
>   	if (ret < 0)
>   		return ret;
>   
> -	if (!dev->msi_enabled)
> +	if (!pci_dev_msi_enabled(dev))
>   		return acpi_pci_irq_enable(dev);
>   	return 0;
>   }
> @@ -407,7 +407,7 @@ void
>   pcibios_disable_device (struct pci_dev *dev)
>   {
>   	BUG_ON(atomic_read(&dev->enable_cnt));
> -	if (!dev->msi_enabled)
> +	if (!pci_dev_msi_enabled(dev))
>   		acpi_pci_irq_disable(dev);
>   }
>   
> diff --git a/arch/mn10300/unit-asb2305/pci.c b/arch/mn10300/unit-asb2305/pci.c
> index 3dfe2d31c67b..4d36ea517679 100644
> --- a/arch/mn10300/unit-asb2305/pci.c
> +++ b/arch/mn10300/unit-asb2305/pci.c
> @@ -399,10 +399,12 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
>   {
>   	int err;
>   
> -	err = pci_enable_resources(dev, mask);
> -	if (err == 0)
> +	if ((err = pci_enable_resources(dev, mask)) < 0)
> +		return err;
> +
> +	if (!pci_dev_msi_enabled(dev))
>   		pcibios_enable_irq(dev);
> -	return err;
> +	return 0;
>   }
>   
>   /*
>
