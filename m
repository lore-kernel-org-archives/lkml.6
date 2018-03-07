Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754291AbeCGK1N (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 05:27:13 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:41527 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751151AbeCGK1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 05:27:09 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Sinan Kaya <okaya@codeaurora.org>, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v1 3/9] PCI/PM: Clear PCIe PME Status bit for Root Complex Event Collectors
Date: Wed, 07 Mar 2018 11:27:51 +0100
Message-ID: <1953703.7ExAQMbr3z@aspire.rjw.lan>
In-Reply-To: <152040322027.240786.13965159319024774656.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152040297576.240786.1532465558381209070.stgit@bhelgaas-glaptop.roam.corp.google.com> <152040322027.240786.13965159319024774656.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, March 7, 2018 7:13:40 AM CET Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Per PCIe r4.0, sec 6.1.6, Root Complex Event Collectors can generate PME
> interrupts on behalf of Root Complex Integrated Endpoints.
> 
> Linux does not currently enable PME interrupts from RC Event Collectors,
> but fe31e69740ed ("PCI/PCIe: Clear Root PME Status bits early during system
> resume") suggests PME interrupts may be enabled by the platform for ACPI-
> based runtime wakeup.
> 
> Clear the PCIe PME Status bit for Root Complex Event Collectors during
> resume, just like we already do for Root Ports.
> 
> If the BIOS enables PME interrupts for an event collector and neglects to
> clear the status bit on resume, this change should fix the same bug as
> fe31e69740ed (PMEs not working after waking from a sleep state), but for
> Root Complex Integrated Endpoints.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pci-driver.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index bf0704b75f79..38ee7c8b4d1a 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -533,7 +533,8 @@ static void pcie_resume_early(struct pci_dev *pci_dev)
>  	 * bits now just in case (shouldn't hurt).
>  	 */
>  	if (pci_is_pcie(pci_dev) &&
> -	    pci_pcie_type(pci_dev) == PCI_EXP_TYPE_ROOT_PORT)
> +	    (pci_pcie_type(pci_dev) == PCI_EXP_TYPE_ROOT_PORT ||
> +	     pci_pcie_type(pci_dev) == PCI_EXP_TYPE_RC_EC))
>  		pcie_clear_root_pme_status(pci_dev);
>  }
>  
> 
> 

Reveiwed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
