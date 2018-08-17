Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACF5C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 11:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABACF20666
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 11:24:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABACF20666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbeHQO1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 10:27:40 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46266 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbeHQO1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 10:27:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3201F7A9;
        Fri, 17 Aug 2018 04:24:35 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.emea.arm.com [10.4.13.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 898073F5BD;
        Fri, 17 Aug 2018 04:24:33 -0700 (PDT)
Date:   Fri, 17 Aug 2018 12:24:24 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
        Jayachandran C <jchandra@broadcom.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Tomasz Nowicki <tn@semihalf.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: how to fix acpi_pci_root_remap_iospace?
Message-ID: <20180817112424.GA31375@e107981-ln.cambridge.arm.com>
References: <20180816204506.GA21144@agluck-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816204506.GA21144@agluck-desk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 01:45:07PM -0700, Luck, Tony wrote:
> Bjorn,
> 
> Back in commit:
> 
>   0a70abb38062 ("PCI/ACPI: Support I/O resources when parsing host bridge resources")
> 
> we added acpi_pci_root_remap_iospace().  On ia64 this was a no-op because ia64
> didn't define PCI_IOBASE, so the entire body of the function was skipped.
> 
> But in the current merge window commit:
> 
>   0bbf47eab469 ("ia64: use asm-generic/io.h")
> 
> ended up defining PCI_IOBASE for us, and now we die horribly
> in early boot with:
> 
>   kernel BUG at lib/ioremap.c:72!
> 
> 
> Is PCI_IOBASE the right thing to check for to decide whether
> acpi_pci_root_remap_iospace() needs to do anything?
> 
> The ugly fix would be:
> 
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 7433035ded95..de06377de13b 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -741,7 +741,7 @@ static void acpi_pci_root_validate_resources(struct device *dev,
>  static void acpi_pci_root_remap_iospace(struct fwnode_handle *fwnode,
>  			struct resource_entry *entry)
>  {
> -#ifdef PCI_IOBASE
> +#if defined(PCI_IOBASE) && !defined(CONFIG_IA64)
>  	struct resource *res = entry->res;
>  	resource_size_t cpu_addr = res->start;
>  	resource_size_t pci_addr = cpu_addr - entry->offset;
> 
> or we can do some other juggling with defines to get the
> same outcome.
> 
> -Tony

If that gives too much trouble we could move
acpi_pci_root_remap_iospace() to arch/arm64 too (patch compile tested
below) given that at the moment it is generic in theory, just let me
know what's the best course of action.

Lorenzo

-- >8 --
diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 0e2ea1c78542..06e27879087b 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -98,13 +98,46 @@ int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
 	return 0;
 }
 
+static void acpi_pci_root_remap_iospace(struct fwnode_handle *fwnode,
+			struct resource_entry *entry)
+{
+	struct resource *res = entry->res;
+	resource_size_t cpu_addr = res->start;
+	resource_size_t pci_addr = cpu_addr - entry->offset;
+	resource_size_t length = resource_size(res);
+	unsigned long port;
+
+	if (pci_register_io_range(fwnode, cpu_addr, length))
+		goto err;
+
+	port = pci_address_to_pio(cpu_addr);
+	if (port == (unsigned long)-1)
+		goto err;
+
+	res->start = port;
+	res->end = port + length - 1;
+	entry->offset = port - pci_addr;
+
+	if (pci_remap_iospace(res, cpu_addr) < 0)
+		goto err;
+
+	pr_info("Remapped I/O %pa to %pR\n", &cpu_addr, res);
+	return;
+err:
+	res->flags |= IORESOURCE_DISABLED;
+}
+
 static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
 {
 	struct resource_entry *entry, *tmp;
+	struct acpi_device *device = ci->bridge;
 	int status;
 
 	status = acpi_pci_probe_root_resources(ci);
 	resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
+		if (entry->res->flags & IORESOURCE_IO)
+			acpi_pci_root_remap_iospace(&device->fwnode, entry);
+
 		if (!(entry->res->flags & IORESOURCE_WINDOW))
 			resource_list_destroy_entry(entry);
 	}
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 7433035ded95..0f9fb87b6e26 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -738,37 +738,6 @@ static void acpi_pci_root_validate_resources(struct device *dev,
 	}
 }
 
-static void acpi_pci_root_remap_iospace(struct fwnode_handle *fwnode,
-			struct resource_entry *entry)
-{
-#ifdef PCI_IOBASE
-	struct resource *res = entry->res;
-	resource_size_t cpu_addr = res->start;
-	resource_size_t pci_addr = cpu_addr - entry->offset;
-	resource_size_t length = resource_size(res);
-	unsigned long port;
-
-	if (pci_register_io_range(fwnode, cpu_addr, length))
-		goto err;
-
-	port = pci_address_to_pio(cpu_addr);
-	if (port == (unsigned long)-1)
-		goto err;
-
-	res->start = port;
-	res->end = port + length - 1;
-	entry->offset = port - pci_addr;
-
-	if (pci_remap_iospace(res, cpu_addr) < 0)
-		goto err;
-
-	pr_info("Remapped I/O %pa to %pR\n", &cpu_addr, res);
-	return;
-err:
-	res->flags |= IORESOURCE_DISABLED;
-#endif
-}
-
 int acpi_pci_probe_root_resources(struct acpi_pci_root_info *info)
 {
 	int ret;
@@ -789,10 +758,6 @@ int acpi_pci_probe_root_resources(struct acpi_pci_root_info *info)
 			"no IO and memory resources present in _CRS\n");
 	else {
 		resource_list_for_each_entry_safe(entry, tmp, list) {
-			if (entry->res->flags & IORESOURCE_IO)
-				acpi_pci_root_remap_iospace(&device->fwnode,
-						entry);
-
 			if (entry->res->flags & IORESOURCE_DISABLED)
 				resource_list_destroy_entry(entry);
 			else

