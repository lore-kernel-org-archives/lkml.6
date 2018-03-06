Return-Path: <john.garry@huawei.com>
X-Google-Smtp-Source: AG47ELtBjDYiP0YBdSMJOz19lNt1FVO5DF0ZWE5LRQN8qT7r3a5zER9MR/Y0ngbxSZaHIuRx75zS
ARC-Seal: i=1; a=rsa-sha256; t=1520333308; cv=none;
        d=google.com; s=arc-20160816;
        b=XMI2qt6d6Oh9OZgniQKbZgjKKLTyN61eyRbAaAn5Au1OglBdX5IXR3wH0Q6PK+8iCa
         j6Xehm3Lz9Fq2QkgGfTjyNVnnOpQHuNC70YgUaZ59kbDqkTMHbszvF9fmGcN6BZS0CDE
         AUCJrseydBsRgKl7tK5NqeAkB4i+gOnefJqzEDrzD8F4ZeDiZmjkNYSPej5sYb3DQk9j
         otWNr1gtVOoht7LENzxDig0tgNkxHFJFFGdVy/FgGUqIb3L+aJYlO06ti7xgjAE8VnSl
         jMorMlPnX/19jZuQ2FGFdb1lqvGnYLwSNvGpIgDQYt75qIO0W06h3PxrKEIfzOyzidqc
         nSSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=OA7cjhpliCNDOhxGQb5JT1Tyzni2iDNL/x3EBcw9IO4=;
        b=w+tzusUgM+vWxUgH/h/yA6irJYiqfLkqS4qFYlssjR9t+n4vxtG+2G0X2F8qPDwNJ/
         mBtTqTvLVyMn9glS9RqUC/M22gac568ayckixiqcu0+DMP1BksODksYbC1K498myE5Ok
         3h4xeCO8sTW4oM/hdi4VW0jwAu5Q7S6o4pvKNwUfeM1cfCnmJ8BVCNFAcKt/wQowwqJu
         eB1kDQQJP7CKja44S4byF/nozTsmtnFgmCsQxyKDt6KUUbuqoPe34es7Vi2Ekbczl6OO
         Zpo5rk2HF6m47mNR4UxDHqInDskVeeuKDLFMxq7UtjVW94SZdTTCEAdX/TVrg/I/IzoQ
         yobA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of john.garry@huawei.com designates 45.249.212.190 as permitted sender) smtp.mailfrom=john.garry@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of john.garry@huawei.com designates 45.249.212.190 as permitted sender) smtp.mailfrom=john.garry@huawei.com
From: John Garry <john.garry@huawei.com>
To: <mika.westerberg@linux.intel.com>, <rafael@kernel.org>,
	<lorenzo.pieralisi@arm.com>, <rjw@rjwysocki.net>, <hanjun.guo@linaro.org>,
	<robh+dt@kernel.org>, <bhelgaas@google.com>, <arnd@arndb.de>,
	<mark.rutland@arm.com>, <olof@lixom.net>, <dann.frazier@canonical.com>,
	<andy.shevchenko@gmail.com>, <robh@kernel.org>,
	<andriy.shevchenko@linux.intel.com>
CC: <joe@perches.com>, <benh@kernel.crashing.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linuxarm@huawei.com>, <minyard@acm.org>,
	<devicetree@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<rdunlap@infradead.org>, <gregkh@linuxfoundation.org>,
	<akpm@linux-foundation.org>, <frowand.list@gmail.com>, <agraf@suse.de>
Subject: [PATCH v16 3/9] PCI: Add fwnode handler as input param of pci_register_io_range()
Date: Tue, 6 Mar 2018 18:47:42 +0800
Message-ID: <1520333268-82754-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520333268-82754-1-git-send-email-john.garry@huawei.com>
References: <1520333268-82754-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594185019418376311?=
X-GMAIL-MSGID: =?utf-8?q?1594185019418376311?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Gabriele Paoloni <gabriele.paoloni@huawei.com>

In preparation for having the PCI MMIO helpers to use the new generic
I/O space management(logical PIO) we need to add the fwnode handler as
extra input parameter.
This patch changes the signature of pci_register_io_range() and of
its callers as needed.

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Tested-by: dann frazier <dann.frazier@canonical.com>
---
 drivers/acpi/pci_root.c | 8 +++++---
 drivers/of/address.c    | 4 +++-
 drivers/pci/pci.c       | 3 ++-
 include/linux/pci.h     | 3 ++-
 4 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 6fc204a..1213479 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -729,7 +729,8 @@ static void acpi_pci_root_validate_resources(struct device *dev,
 	}
 }
 
-static void acpi_pci_root_remap_iospace(struct resource_entry *entry)
+static void acpi_pci_root_remap_iospace(struct fwnode_handle *fwnode,
+			struct resource_entry *entry)
 {
 #ifdef PCI_IOBASE
 	struct resource *res = entry->res;
@@ -738,7 +739,7 @@ static void acpi_pci_root_remap_iospace(struct resource_entry *entry)
 	resource_size_t length = resource_size(res);
 	unsigned long port;
 
-	if (pci_register_io_range(cpu_addr, length))
+	if (pci_register_io_range(fwnode, cpu_addr, length))
 		goto err;
 
 	port = pci_address_to_pio(cpu_addr);
@@ -780,7 +781,8 @@ int acpi_pci_probe_root_resources(struct acpi_pci_root_info *info)
 	else {
 		resource_list_for_each_entry_safe(entry, tmp, list) {
 			if (entry->res->flags & IORESOURCE_IO)
-				acpi_pci_root_remap_iospace(entry);
+				acpi_pci_root_remap_iospace(&device->fwnode,
+						entry);
 
 			if (entry->res->flags & IORESOURCE_DISABLED)
 				resource_list_destroy_entry(entry);
diff --git a/drivers/of/address.c b/drivers/of/address.c
index ce4d3d8..cdf047b 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -2,6 +2,7 @@
 #define pr_fmt(fmt)	"OF: " fmt
 
 #include <linux/device.h>
+#include <linux/fwnode.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
@@ -333,7 +334,8 @@ int of_pci_range_to_resource(struct of_pci_range *range,
 
 	if (res->flags & IORESOURCE_IO) {
 		unsigned long port;
-		err = pci_register_io_range(range->cpu_addr, range->size);
+		err = pci_register_io_range(&np->fwnode, range->cpu_addr,
+				range->size);
 		if (err)
 			goto invalid_range;
 		port = pci_address_to_pio(range->cpu_addr);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ff41a64..3f30b7d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3451,7 +3451,8 @@ struct io_range {
  * Record the PCI IO range (expressed as CPU physical address + size).
  * Return a negative value if an error has occured, zero otherwise
  */
-int pci_register_io_range(phys_addr_t addr, resource_size_t size)
+int pci_register_io_range(struct fwnode_handle *fwnode, phys_addr_t addr,
+			resource_size_t	size)
 {
 	int err = 0;
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 25b7a35..17cc998 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1221,7 +1221,8 @@ int __must_check pci_bus_alloc_resource(struct pci_bus *bus,
 			void *alignf_data);
 
 
-int pci_register_io_range(phys_addr_t addr, resource_size_t size);
+int pci_register_io_range(struct fwnode_handle *fwnode, phys_addr_t addr,
+			resource_size_t size);
 unsigned long pci_address_to_pio(phys_addr_t addr);
 phys_addr_t pci_pio_to_address(unsigned long pio);
 int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr);
-- 
1.9.1
