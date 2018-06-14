Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 08AB3C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D1F1208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FL9XBiEw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D1F1208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936055AbeFNMAt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 08:00:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60464 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935958AbeFNMAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 08:00:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8RVxlN9C30nTdtPwdgzpj7PT3Us6PdwPZ2fxxbIZOAo=; b=FL9XBiEwN6sQD8pBJoMpdjxOl
        ZancsySrGawGWH0Bhd3IkG/idnLImaqcRyNoCJUkRovz3z+ecP5mWJ/7NrcTy0Hagi2HRtyiAqNGb
        fJO1lO96vQgEa6ZXfHUhFlOqJCmy/H1Yd15KJ2qpFQ53eFj3JqEkqY+wKPEC4keTXthXKVmFEfboa
        PNpNNPtFEcsgope9LQZpd6+36yL66tfafEAdmRSgEKly1U5D4vJwLPuueCe8VRd9QTHZ/GuX5gfur
        zhgBYgccVCcnM/GScFnRmZQnGxZY0icG4OSJJgLlxlBdpeWB6R1VOfWUdZd0qtQyt4TkNXyTN1Vep
        FT3XCHC/g==;
Received: from 80-109-164-210.cable.dynamic.surfer.at ([80.109.164.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTQvd-00031Y-2d; Thu, 14 Jun 2018 12:00:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dma-mapping: move all DMA mapping code to kernel/dma
Date:   Thu, 14 Jun 2018 14:00:29 +0200
Message-Id: <20180614120029.27315-3-hch@lst.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614120029.27315-1-hch@lst.de>
References: <20180614120029.27315-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the code is split over various files with dma- prefixes in the
lib/ and drives/base directories, and the number of files keeps growing.
Move them into a single directory to keep the code together and remove
the file name prefixes.  To match the irq infrastructure this directory
is placed under the kernel/ directory.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/driver-api/infrastructure.rst   |  4 +-
 MAINTAINERS                                   |  9 +---
 drivers/base/Makefile                         |  3 --
 include/linux/dma-contiguous.h                |  2 +-
 init/Kconfig                                  |  4 --
 kernel/Makefile                               |  1 +
 kernel/dma/Kconfig                            | 50 +++++++++++++++++++
 kernel/dma/Makefile                           | 11 ++++
 .../dma-coherent.c => kernel/dma/coherent.c   |  0
 .../dma/contiguous.c                          |  0
 lib/dma-debug.c => kernel/dma/debug.c         |  0
 lib/dma-direct.c => kernel/dma/direct.c       |  0
 .../dma-mapping.c => kernel/dma/mapping.c     |  2 +-
 .../dma/noncoherent.c                         |  0
 {lib => kernel/dma}/swiotlb.c                 |  0
 lib/dma-virt.c => kernel/dma/virt.c           |  2 -
 lib/Kconfig                                   | 47 +----------------
 lib/Makefile                                  |  6 ---
 18 files changed, 69 insertions(+), 72 deletions(-)
 create mode 100644 kernel/dma/Kconfig
 create mode 100644 kernel/dma/Makefile
 rename drivers/base/dma-coherent.c => kernel/dma/coherent.c (100%)
 rename drivers/base/dma-contiguous.c => kernel/dma/contiguous.c (100%)
 rename lib/dma-debug.c => kernel/dma/debug.c (100%)
 rename lib/dma-direct.c => kernel/dma/direct.c (100%)
 rename drivers/base/dma-mapping.c => kernel/dma/mapping.c (99%)
 rename lib/dma-noncoherent.c => kernel/dma/noncoherent.c (100%)
 rename {lib => kernel/dma}/swiotlb.c (100%)
 rename lib/dma-virt.c => kernel/dma/virt.c (98%)

diff --git a/Documentation/driver-api/infrastructure.rst b/Documentation/driver-api/infrastructure.rst
index bee1b9a1702f..6172f3cc3d0b 100644
--- a/Documentation/driver-api/infrastructure.rst
+++ b/Documentation/driver-api/infrastructure.rst
@@ -49,10 +49,10 @@ Device Drivers Base
 Device Drivers DMA Management
 -----------------------------
 
-.. kernel-doc:: drivers/base/dma-coherent.c
+.. kernel-doc:: kernel/dma/coherent.c
    :export:
 
-.. kernel-doc:: drivers/base/dma-mapping.c
+.. kernel-doc:: kernel/dma/mapping.c
    :export:
 
 Device drivers PnP support
diff --git a/MAINTAINERS b/MAINTAINERS
index c13b9fb3be0b..a6844a9e2f64 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4359,12 +4359,7 @@ L:	iommu@lists.linux-foundation.org
 T:	git git://git.infradead.org/users/hch/dma-mapping.git
 W:	http://git.infradead.org/users/hch/dma-mapping.git
 S:	Supported
-F:	lib/dma-debug.c
-F:	lib/dma-direct.c
-F:	lib/dma-noncoherent.c
-F:	lib/dma-virt.c
-F:	drivers/base/dma-mapping.c
-F:	drivers/base/dma-coherent.c
+F:	kernel/dma/
 F:	include/asm-generic/dma-mapping.h
 F:	include/linux/dma-direct.h
 F:	include/linux/dma-mapping.h
@@ -13642,7 +13637,7 @@ M:	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
 L:	iommu@lists.linux-foundation.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git
 S:	Supported
-F:	lib/swiotlb.c
+F:	kernel/dma/swiotlb.c
 F:	arch/*/kernel/pci-swiotlb.c
 F:	include/linux/swiotlb.h
 
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index b074f242a435..704f44295810 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -8,10 +8,7 @@ obj-y			:= component.o core.o bus.o dd.o syscore.o \
 			   topology.o container.o property.o cacheinfo.o \
 			   devcon.o
 obj-$(CONFIG_DEVTMPFS)	+= devtmpfs.o
-obj-$(CONFIG_DMA_CMA) += dma-contiguous.o
 obj-y			+= power/
-obj-$(CONFIG_HAS_DMA)	+= dma-mapping.o
-obj-$(CONFIG_HAVE_GENERIC_DMA_COHERENT) += dma-coherent.o
 obj-$(CONFIG_ISA_BUS_API)	+= isa.o
 obj-y				+= firmware_loader/
 obj-$(CONFIG_NUMA)	+= node.o
diff --git a/include/linux/dma-contiguous.h b/include/linux/dma-contiguous.h
index b67bf6ac907d..3c5a4cb3eb95 100644
--- a/include/linux/dma-contiguous.h
+++ b/include/linux/dma-contiguous.h
@@ -48,7 +48,7 @@
  *   CMA should not be used by the device drivers directly. It is
  *   only a helper framework for dma-mapping subsystem.
  *
- *   For more information, see kernel-docs in drivers/base/dma-contiguous.c
+ *   For more information, see kernel-docs in kernel/dma/contiguous.c
  */
 
 #ifdef __KERNEL__
diff --git a/init/Kconfig b/init/Kconfig
index 5a52f07259a2..fde3d09e8b27 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1719,10 +1719,6 @@ source "arch/Kconfig"
 
 endmenu		# General setup
 
-config HAVE_GENERIC_DMA_COHERENT
-	bool
-	default n
-
 config RT_MUTEXES
 	bool
 
diff --git a/kernel/Makefile b/kernel/Makefile
index d2001624fe7a..04bc07c2b42a 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -41,6 +41,7 @@ obj-y += printk/
 obj-y += irq/
 obj-y += rcu/
 obj-y += livepatch/
+obj-y += dma/
 
 obj-$(CONFIG_CHECKPOINT_RESTORE) += kcmp.o
 obj-$(CONFIG_FREEZER) += freezer.o
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
new file mode 100644
index 000000000000..9bd54304446f
--- /dev/null
+++ b/kernel/dma/Kconfig
@@ -0,0 +1,50 @@
+
+config HAS_DMA
+	bool
+	depends on !NO_DMA
+	default y
+
+config NEED_SG_DMA_LENGTH
+	bool
+
+config NEED_DMA_MAP_STATE
+	bool
+
+config ARCH_DMA_ADDR_T_64BIT
+	def_bool 64BIT || PHYS_ADDR_T_64BIT
+
+config HAVE_GENERIC_DMA_COHERENT
+	bool
+
+config ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	bool
+
+config ARCH_HAS_SYNC_DMA_FOR_CPU
+	bool
+	select NEED_DMA_MAP_STATE
+
+config DMA_DIRECT_OPS
+	bool
+	depends on HAS_DMA
+
+config DMA_NONCOHERENT_OPS
+	bool
+	depends on HAS_DMA
+	select DMA_DIRECT_OPS
+
+config DMA_NONCOHERENT_MMAP
+	bool
+	depends on DMA_NONCOHERENT_OPS
+
+config DMA_NONCOHERENT_CACHE_SYNC
+	bool
+	depends on DMA_NONCOHERENT_OPS
+
+config DMA_VIRT_OPS
+	bool
+	depends on HAS_DMA
+
+config SWIOTLB
+	bool
+	select DMA_DIRECT_OPS
+	select NEED_DMA_MAP_STATE
diff --git a/kernel/dma/Makefile b/kernel/dma/Makefile
new file mode 100644
index 000000000000..6de44e4eb454
--- /dev/null
+++ b/kernel/dma/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_HAS_DMA)			+= mapping.o
+obj-$(CONFIG_DMA_CMA)			+= contiguous.o
+obj-$(CONFIG_HAVE_GENERIC_DMA_COHERENT) += coherent.o
+obj-$(CONFIG_DMA_DIRECT_OPS)		+= direct.o
+obj-$(CONFIG_DMA_NONCOHERENT_OPS)	+= noncoherent.o
+obj-$(CONFIG_DMA_VIRT_OPS)		+= virt.o
+obj-$(CONFIG_DMA_API_DEBUG)		+= debug.o
+obj-$(CONFIG_SWIOTLB)			+= swiotlb.o
+
diff --git a/drivers/base/dma-coherent.c b/kernel/dma/coherent.c
similarity index 100%
rename from drivers/base/dma-coherent.c
rename to kernel/dma/coherent.c
diff --git a/drivers/base/dma-contiguous.c b/kernel/dma/contiguous.c
similarity index 100%
rename from drivers/base/dma-contiguous.c
rename to kernel/dma/contiguous.c
diff --git a/lib/dma-debug.c b/kernel/dma/debug.c
similarity index 100%
rename from lib/dma-debug.c
rename to kernel/dma/debug.c
diff --git a/lib/dma-direct.c b/kernel/dma/direct.c
similarity index 100%
rename from lib/dma-direct.c
rename to kernel/dma/direct.c
diff --git a/drivers/base/dma-mapping.c b/kernel/dma/mapping.c
similarity index 99%
rename from drivers/base/dma-mapping.c
rename to kernel/dma/mapping.c
index f831a582209c..d2a92ddaac4d 100644
--- a/drivers/base/dma-mapping.c
+++ b/kernel/dma/mapping.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * drivers/base/dma-mapping.c - arch-independent dma-mapping routines
+ * arch-independent dma-mapping routines
  *
  * Copyright (c) 2006  SUSE Linux Products GmbH
  * Copyright (c) 2006  Tejun Heo <teheo@suse.de>
diff --git a/lib/dma-noncoherent.c b/kernel/dma/noncoherent.c
similarity index 100%
rename from lib/dma-noncoherent.c
rename to kernel/dma/noncoherent.c
diff --git a/lib/swiotlb.c b/kernel/dma/swiotlb.c
similarity index 100%
rename from lib/swiotlb.c
rename to kernel/dma/swiotlb.c
diff --git a/lib/dma-virt.c b/kernel/dma/virt.c
similarity index 98%
rename from lib/dma-virt.c
rename to kernel/dma/virt.c
index 8e61a02ef9ca..631ddec4b60a 100644
--- a/lib/dma-virt.c
+++ b/kernel/dma/virt.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *	lib/dma-virt.c
- *
  * DMA operations that map to virtual addresses without flushing memory.
  */
 #include <linux/export.h>
diff --git a/lib/Kconfig b/lib/Kconfig
index 809fdd155739..803fcbced729 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -420,60 +420,15 @@ config HAS_IOPORT_MAP
 	depends on HAS_IOMEM && !NO_IOPORT_MAP
 	default y
 
-config HAS_DMA
-	bool
-	depends on !NO_DMA
-	default y
+source "kernel/dma/Kconfig"
 
 config SGL_ALLOC
 	bool
 	default n
 
-config NEED_SG_DMA_LENGTH
-	bool
-
-config NEED_DMA_MAP_STATE
-	bool
-
-config ARCH_DMA_ADDR_T_64BIT
-	def_bool 64BIT || PHYS_ADDR_T_64BIT
-
 config IOMMU_HELPER
 	bool
 
-config ARCH_HAS_SYNC_DMA_FOR_DEVICE
-	bool
-
-config ARCH_HAS_SYNC_DMA_FOR_CPU
-	bool
-	select NEED_DMA_MAP_STATE
-
-config DMA_DIRECT_OPS
-	bool
-	depends on HAS_DMA
-
-config DMA_NONCOHERENT_OPS
-	bool
-	depends on HAS_DMA
-	select DMA_DIRECT_OPS
-
-config DMA_NONCOHERENT_MMAP
-	bool
-	depends on DMA_NONCOHERENT_OPS
-
-config DMA_NONCOHERENT_CACHE_SYNC
-	bool
-	depends on DMA_NONCOHERENT_OPS
-
-config DMA_VIRT_OPS
-	bool
-	depends on HAS_DMA
-
-config SWIOTLB
-	bool
-	select DMA_DIRECT_OPS
-	select NEED_DMA_MAP_STATE
-
 config CHECK_SIGNATURE
 	bool
 
diff --git a/lib/Makefile b/lib/Makefile
index 5e0e160c9242..8153fdab287f 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -29,9 +29,6 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
 lib-$(CONFIG_PRINTK) += dump_stack.o
 lib-$(CONFIG_MMU) += ioremap.o
 lib-$(CONFIG_SMP) += cpumask.o
-obj-$(CONFIG_DMA_DIRECT_OPS) += dma-direct.o
-obj-$(CONFIG_DMA_NONCOHERENT_OPS) += dma-noncoherent.o
-obj-$(CONFIG_DMA_VIRT_OPS) += dma-virt.o
 
 lib-y	+= kobject.o klist.o
 obj-y	+= lockref.o
@@ -148,7 +145,6 @@ obj-$(CONFIG_SMP) += percpu_counter.o
 obj-$(CONFIG_AUDIT_GENERIC) += audit.o
 obj-$(CONFIG_AUDIT_COMPAT_GENERIC) += compat_audit.o
 
-obj-$(CONFIG_SWIOTLB) += swiotlb.o
 obj-$(CONFIG_IOMMU_HELPER) += iommu-helper.o
 obj-$(CONFIG_FAULT_INJECTION) += fault-inject.o
 obj-$(CONFIG_NOTIFIER_ERROR_INJECTION) += notifier-error-inject.o
@@ -169,8 +165,6 @@ obj-$(CONFIG_NLATTR) += nlattr.o
 
 obj-$(CONFIG_LRU_CACHE) += lru_cache.o
 
-obj-$(CONFIG_DMA_API_DEBUG) += dma-debug.o
-
 obj-$(CONFIG_GENERIC_CSUM) += checksum.o
 
 obj-$(CONFIG_GENERIC_ATOMIC64) += atomic64.o
-- 
2.17.1

