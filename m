Return-Path: <john.garry@huawei.com>
X-Google-Smtp-Source: AG47ELtJRmZRUaPbF6hECqL+NaY29KNwcGvdtdlUH801o3dzvthpYohxHm+NolH2RmtSZpkc6FNp
ARC-Seal: i=1; a=rsa-sha256; t=1520333308; cv=none;
        d=google.com; s=arc-20160816;
        b=hd+vDfxIX6XCHVeGsvCWMmuVr39P1RciIOkdazg93872pnnZW7ukmk2ZQisFMrLwgz
         CneKbIOY5yyaFH6QF+TEBCxr/zYtuFsvclmhLBLWYkAZyy7blfpQMhvMWu2qI4qvvxnK
         zFx+B9Sz7Ifh6cDKycRI1IMnpYMWfKL817neyN6wp0B7f7K+mJV+3l1gMYba4hAP086x
         WwxYSRqWqBq1czmTrIZQQPGFrUHHtMu3vfacFkdIIJPH1mIC7OiZP8ff2kmM4/9vvj+m
         SpFAwihapY5PDnonGHomMikAMRoG2g+mrip2Imjg16MJisoymE3TrSSk0EfVEBmd0wgq
         G6qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=YY5/xfa6Q6jO3B9AmF91X3fG8bvtn1Lz1KUNcgUPL3E=;
        b=NsSziO9ecbE/p9GcoZYnd6mVUH1NrXwLyE3fXVzf4kG//4GJP2oDgKql6fO+a901FO
         YoMfQa48kFk+vxgyhjCG6iRShvyO+61HW+Fi+mGy81OyvZz4u2q69YBudubW8j2bqZlf
         Z5StXoVpbylnpNV8AxvgfwsHxoMf7BEzbvOQXbnO1d6rUrQRh6nptcQ1TAZzckOx6Ejf
         LFYIsoTRsbUNfYG7h/j3jaIPsCmkx1KcO9hHz3D5kSSMXRJtn/2vuZr2b1ljT3+b/sHl
         khQP0c/cXRfW2NKVt0bvXxrfMNfw1xufnptiitWgC/T6xuLU6dUtD0J7gAOjziIz9xA7
         B4ug==
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
Subject: [PATCH v16 4/9] PCI: Apply the new generic I/O management on PCI IO hosts
Date: Tue, 6 Mar 2018 18:47:43 +0800
Message-ID: <1520333268-82754-5-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520333268-82754-1-git-send-email-john.garry@huawei.com>
References: <1520333268-82754-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594185018743470182?=
X-GMAIL-MSGID: =?utf-8?q?1594185018743470182?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Zhichang Yuan <yuanzhichang@hisilicon.com>

After introducing the new generic I/O space management(Logical PIO), the
original PCI MMIO relevant helpers need to be updated based on the new
interfaces defined in logical PIO.
This patch adapts the corresponding code to match the changes introduced
by logical PIO.

Signed-off-by: Zhichang Yuan <yuanzhichang@hisilicon.com>
Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>        #earlier draft
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Tested-by: dann frazier <dann.frazier@canonical.com>
---
 drivers/pci/pci.c        | 92 +++++++++---------------------------------------
 include/asm-generic/io.h |  2 +-
 2 files changed, 18 insertions(+), 76 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 3f30b7d..09c2490 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -22,6 +22,7 @@
 #include <linux/spinlock.h>
 #include <linux/string.h>
 #include <linux/log2.h>
+#include <linux/logic_pio.h>
 #include <linux/pci-aspm.h>
 #include <linux/pm_wakeup.h>
 #include <linux/interrupt.h>
@@ -3436,17 +3437,6 @@ int pci_request_regions_exclusive(struct pci_dev *pdev, const char *res_name)
 }
 EXPORT_SYMBOL(pci_request_regions_exclusive);
 
-#ifdef PCI_IOBASE
-struct io_range {
-	struct list_head list;
-	phys_addr_t start;
-	resource_size_t size;
-};
-
-static LIST_HEAD(io_range_list);
-static DEFINE_SPINLOCK(io_range_lock);
-#endif
-
 /*
  * Record the PCI IO range (expressed as CPU physical address + size).
  * Return a negative value if an error has occured, zero otherwise
@@ -3454,51 +3444,28 @@ struct io_range {
 int pci_register_io_range(struct fwnode_handle *fwnode, phys_addr_t addr,
 			resource_size_t	size)
 {
-	int err = 0;
-
+	int ret = 0;
 #ifdef PCI_IOBASE
-	struct io_range *range;
-	resource_size_t allocated_size = 0;
-
-	/* check if the range hasn't been previously recorded */
-	spin_lock(&io_range_lock);
-	list_for_each_entry(range, &io_range_list, list) {
-		if (addr >= range->start && addr + size <= range->start + size) {
-			/* range already registered, bail out */
-			goto end_register;
-		}
-		allocated_size += range->size;
-	}
+	struct logic_pio_hwaddr *range;
 
-	/* range not registed yet, check for available space */
-	if (allocated_size + size - 1 > IO_SPACE_LIMIT) {
-		/* if it's too big check if 64K space can be reserved */
-		if (allocated_size + SZ_64K - 1 > IO_SPACE_LIMIT) {
-			err = -E2BIG;
-			goto end_register;
-		}
-
-		size = SZ_64K;
-		pr_warn("Requested IO range too big, new size set to 64K\n");
-	}
+	if (!size || addr + size < addr)
+		return -EINVAL;
 
-	/* add the range to the list */
 	range = kzalloc(sizeof(*range), GFP_ATOMIC);
-	if (!range) {
-		err = -ENOMEM;
-		goto end_register;
-	}
+	if (!range)
+		return -ENOMEM;
 
-	range->start = addr;
+	range->fwnode = fwnode;
 	range->size = size;
+	range->hw_start = addr;
+	range->flags = LOGIC_PIO_CPU_MMIO;
 
-	list_add_tail(&range->list, &io_range_list);
-
-end_register:
-	spin_unlock(&io_range_lock);
+	ret = logic_pio_register_range(range);
+	if (ret)
+		kfree(range);
 #endif
 
-	return err;
+	return ret;
 }
 
 phys_addr_t pci_pio_to_address(unsigned long pio)
@@ -3506,21 +3473,10 @@ phys_addr_t pci_pio_to_address(unsigned long pio)
 	phys_addr_t address = (phys_addr_t)OF_BAD_ADDR;
 
 #ifdef PCI_IOBASE
-	struct io_range *range;
-	resource_size_t allocated_size = 0;
-
-	if (pio > IO_SPACE_LIMIT)
+	if (pio >= MMIO_UPPER_LIMIT)
 		return address;
 
-	spin_lock(&io_range_lock);
-	list_for_each_entry(range, &io_range_list, list) {
-		if (pio >= allocated_size && pio < allocated_size + range->size) {
-			address = range->start + pio - allocated_size;
-			break;
-		}
-		allocated_size += range->size;
-	}
-	spin_unlock(&io_range_lock);
+	address = logic_pio_to_hwaddr(pio);
 #endif
 
 	return address;
@@ -3529,21 +3485,7 @@ phys_addr_t pci_pio_to_address(unsigned long pio)
 unsigned long __weak pci_address_to_pio(phys_addr_t address)
 {
 #ifdef PCI_IOBASE
-	struct io_range *res;
-	resource_size_t offset = 0;
-	unsigned long addr = -1;
-
-	spin_lock(&io_range_lock);
-	list_for_each_entry(res, &io_range_list, list) {
-		if (address >= res->start && address < res->start + res->size) {
-			addr = address - res->start + offset;
-			break;
-		}
-		offset += res->size;
-	}
-	spin_unlock(&io_range_lock);
-
-	return addr;
+	return logic_pio_trans_cpuaddr(address);
 #else
 	if (address > IO_SPACE_LIMIT)
 		return (unsigned long)-1;
diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index f76fbd6..0016413 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -901,7 +901,7 @@ static inline void __iomem *ioremap_wt(phys_addr_t offset, size_t size)
 #define ioport_map ioport_map
 static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
 {
-	return PCI_IOBASE + (port & IO_SPACE_LIMIT);
+	return PCI_IOBASE + (port & MMIO_UPPER_LIMIT);
 }
 #endif
 
-- 
1.9.1
