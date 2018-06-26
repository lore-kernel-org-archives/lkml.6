Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFFAC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5578226E4B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggJ3vKU0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5578226E4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932898AbeFZRKY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:10:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:45144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932579AbeFZRKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:10:20 -0400
Received: from localhost (unknown [207.160.231.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF9632142A;
        Tue, 26 Jun 2018 17:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530033019;
        bh=69j7eZR3CQyOW3oWr4LYEjEqSCUnrzGbM3qYppBEIg0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ggJ3vKU0qSYNUQwpKy30NB3ApXog2V8JgRvb+75WUVrUqXRn57FD4hbO+X/MWAjuZ
         hz5wcTlNQm9NtE5WAHy1YTXiB496q0JQfMVEafNPc50yBxnPcu+ntuW9npNZykFX95
         I1CyQpDKV+M0ZO7IDkaJGQLT5D1rVUFTlIoZkEdE=
Date:   Tue, 26 Jun 2018 12:10:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>,
        Will Deacon <will.deacon@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Ley Foon Tan <lftan@altera.com>
Subject: Re: [PATCH v2] PCI: controller: Move PCI_DOMAINS selection to arch
 Kconfig
Message-ID: <20180626171018.GB146680@bhelgaas-glaptop.roam.corp.google.com>
References: <20180619112105.14457-1-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619112105.14457-1-lorenzo.pieralisi@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 12:21:05PM +0100, Lorenzo Pieralisi wrote:
> Commit 51bc085d6454 ("PCI: Improve host drivers compile test coverage")
> added configuration options to allow PCI host controller drivers to be
> compile tested on all architectures.
> 
> Some host controller drivers (eg PCIE_ALTERA) config entries select
> the PCI_DOMAINS config option to enable PCI domains management in
> the kernel. Now that host controller drivers can be compiled on
> all architectures, this triggers build regressions on arches that
> do not implement the PCI_DOMAINS required API (ie pci_domain_nr()):
> 
> drivers/ata/pata_ali.c: In function 'ali_init_chipset':
> drivers/ata/pata_ali.c:469:38: error:
>         implicit declaration of function 'pci_domain_nr';
>                                           did you mean 'pci_iomap_wc'?
> 
> Furthemore, some software configurations (ie Jailhouse) require a
> PCI_DOMAINS enabled kernel to configure multiple host controllers
> without having an explicit dependency on the ARM platform on which
> they run.
> 
> Make PCI_DOMAINS a visible configuration option on ARM so that software
> configurations that need it can manually select it and move the
> PCI_DOMAINS selection from PCI controllers configuration file to ARM
> sub-arch config entries that currently require it, fixing the issue.
> 
> Fixes: 51bc085d6454 ("PCI: Improve host drivers compile test coverage")
> Link: https://lkml.kernel.org/r/20180612170229.GA10141@roeck-us.net
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Scott Branden <scott.branden@broadcom.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Ley Foon Tan <lftan@altera.com>

I applied this to for-linus for v4.18, with acks from Jan, Ley Foon, and
Rob.  Thanks!

> ---
> v1 -> v2
> 	- Removed ARCH_VIRT PCI_DOMAINS selection
> 	- Added PCI_DOMAINS visible config option
> 
> v1: https://marc.info/?l=linux-pci&m=152932092612352&w=2
> 
>  arch/arm/Kconfig               | 8 +++++++-
>  arch/arm/mach-bcm/Kconfig      | 1 +
>  arch/arm/mach-socfpga/Kconfig  | 1 +
>  drivers/pci/controller/Kconfig | 3 ---
>  4 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 54eeb8d00bc6..843edfd000be 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1245,8 +1245,14 @@ config PCI
>  	  VESA. If you have PCI, say Y, otherwise N.
>  
>  config PCI_DOMAINS
> -	bool
> +	bool "Support for multiple PCI domains"
>  	depends on PCI
> +	help
> +	  Enable PCI domains kernel management. Say Y if your machine
> +	  has a PCI bus hierarchy that requires more than one PCI
> +	  domain (aka segment) to be correctly managed. Say N otherwise.
> +
> +	  If you don't know what to do here, say N.
>  
>  config PCI_DOMAINS_GENERIC
>  	def_bool PCI_DOMAINS
> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
> index c46a728df44e..25aac6ee2ab1 100644
> --- a/arch/arm/mach-bcm/Kconfig
> +++ b/arch/arm/mach-bcm/Kconfig
> @@ -20,6 +20,7 @@ config ARCH_BCM_IPROC
>  	select GPIOLIB
>  	select ARM_AMBA
>  	select PINCTRL
> +	select PCI_DOMAINS if PCI
>  	help
>  	  This enables support for systems based on Broadcom IPROC architected SoCs.
>  	  The IPROC complex contains one or more ARM CPUs along with common
> diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
> index d0f62eacf59d..4adb901dd5eb 100644
> --- a/arch/arm/mach-socfpga/Kconfig
> +++ b/arch/arm/mach-socfpga/Kconfig
> @@ -10,6 +10,7 @@ menuconfig ARCH_SOCFPGA
>  	select HAVE_ARM_SCU
>  	select HAVE_ARM_TWD if SMP
>  	select MFD_SYSCON
> +	select PCI_DOMAINS if PCI
>  
>  if ARCH_SOCFPGA
>  config SOCFPGA_SUSPEND
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 18fa09b3ac8f..cc9fa02d32a0 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -96,7 +96,6 @@ config PCI_HOST_GENERIC
>  	depends on OF
>  	select PCI_HOST_COMMON
>  	select IRQ_DOMAIN
> -	select PCI_DOMAINS
>  	help
>  	  Say Y here if you want to support a simple generic PCI host
>  	  controller, such as the one emulated by kvmtool.
> @@ -138,7 +137,6 @@ config PCI_VERSATILE
>  
>  config PCIE_IPROC
>  	tristate
> -	select PCI_DOMAINS
>  	help
>  	  This enables the iProc PCIe core controller support for Broadcom's
>  	  iProc family of SoCs. An appropriate bus interface driver needs
> @@ -176,7 +174,6 @@ config PCIE_IPROC_MSI
>  config PCIE_ALTERA
>  	bool "Altera PCIe controller"
>  	depends on ARM || NIOS2 || COMPILE_TEST
> -	select PCI_DOMAINS
>  	help
>  	  Say Y here if you want to enable PCIe controller support on Altera
>  	  FPGA.
> -- 
> 2.15.0
> 
