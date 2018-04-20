Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754721AbeDTKr5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 06:47:57 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:43906 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754639AbeDTKry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 06:47:54 -0400
X-IronPort-AV: E=Sophos;i="5.49,301,1520899200";
   d="scan'208";a="607906235"
Subject: [PATCH 3/3] xen blkback: add fault injection facility
From: Stanislav Kinsburskii <staskins@amazon.com>
CC: <jakub.kicinski@netronome.com>, <hpa@zytor.com>, <mcroce@redhat.com>,
        <staskins@amazon.com>, <tglx@linutronix.de>, <ggarcia@abra.uab.cat>,
        <daniel@iogearbox.net>, <x86@kernel.org>, <mingo@redhat.com>,
        <xen-devel@lists.xenproject.org>, <axboe@kernel.dk>,
        <konrad.wilk@oracle.com>, <amir.jer.levy@intel.com>,
        <paul.durrant@citrix.com>, <stefanha@redhat.com>,
        <dsa@cumulusnetworks.com>, <boris.ostrovsky@oracle.com>,
        <jgross@suse.com>, <linux-block@vger.kernel.org>,
        <wei.liu2@citrix.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <davem@davemloft.net>,
        <dwmw@amazon.co.uk>, <roger.pau@citrix.com>
Date: Fri, 20 Apr 2018 10:47:36 +0000
Message-ID: <20180420104736.17823.42983.stgit@dev-dsk-staskins-1a-ca5afbf2.eu-west-1.amazon.com>
In-Reply-To: <20180420104603.17823.31095.stgit@dev-dsk-staskins-1a-ca5afbf2.eu-west-1.amazon.com>
References: <20180420104603.17823.31095.stgit@dev-dsk-staskins-1a-ca5afbf2.eu-west-1.amazon.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3KAm4Qk016970

This patch adds wrapper helpers around generic Xen fault inject
facility.
The major reason is to keep all the module fault injection directories
in a dedicated subdirectory instead of Xen fault inject root.

IOW, when using these helpers, per-device and named by device name
fault injection control directories will appear under the following
directory:
- /sys/kernel/debug/xen/fault_inject/xen-blkback/
instead of:
- /sys/kernel/debug/xen/fault_inject/

Signed-off-by: Stanislav Kinsburskii <staskins@amazon.com>
CC: Jens Axboe <axboe@kernel.dk>
CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
CC: "Roger Pau Monné" <roger.pau@citrix.com>
CC: linux-kernel@vger.kernel.org
CC: linux-block@vger.kernel.org
CC: xen-devel@lists.xenproject.org
CC: Stanislav Kinsburskii <staskins@amazon.com>
CC: David Woodhouse <dwmw@amazon.co.uk>
---
 drivers/block/Kconfig                  |    7 ++
 drivers/block/xen-blkback/Makefile     |    1 
 drivers/block/xen-blkback/blkback.c    |    9 ++
 drivers/block/xen-blkback/blkback_fi.c |  116 ++++++++++++++++++++++++++++++++
 drivers/block/xen-blkback/blkback_fi.h |   37 ++++++++++
 drivers/block/xen-blkback/common.h     |    3 +
 drivers/block/xen-blkback/xenbus.c     |    5 +
 7 files changed, 178 insertions(+)
 create mode 100644 drivers/block/xen-blkback/blkback_fi.c
 create mode 100644 drivers/block/xen-blkback/blkback_fi.h

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index ad9b687..0ce05fe 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -436,6 +436,13 @@ config XEN_BLKDEV_BACKEND
 	  compile this driver as a module, chose M here: the module
 	  will be called xen-blkback.
 
+config XEN_BLKDEV_BACKEND_FAULT_INJECTION
+	  bool "Xen block-device backend driver fault injection"
+	  depends on XEN_BLKDEV_BACKEND
+	  depends on XEN_FAULT_INJECTION
+	  default n
+	  help
+	    Allow to inject errors to Xen backend block driver
 
 config VIRTIO_BLK
 	tristate "Virtio block driver"
diff --git a/drivers/block/xen-blkback/Makefile b/drivers/block/xen-blkback/Makefile
index e491c1b..035d134 100644
--- a/drivers/block/xen-blkback/Makefile
+++ b/drivers/block/xen-blkback/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_XEN_BLKDEV_BACKEND) := xen-blkback.o
 
 xen-blkback-y	:= blkback.o xenbus.o
+xen-blkback-$(CONFIG_XEN_BLKDEV_BACKEND_FAULT_INJECTION) += blkback_fi.o
diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index 987d665..2933bec 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -51,6 +51,7 @@
 #include <xen/balloon.h>
 #include <xen/grant_table.h>
 #include "common.h"
+#include "blkback_fi.h"
 
 /*
  * Maximum number of unused free pages to keep in the internal buffer.
@@ -1491,11 +1492,19 @@ static int __init xen_blkif_init(void)
 	if (rc)
 		goto failed_init;
 
+	(void) xen_blkbk_fi_init();
  failed_init:
 	return rc;
 }
 
 module_init(xen_blkif_init);
 
+static void __exit xen_blkif_fini(void)
+{
+	xen_blkbk_fi_fini();
+}
+
+module_exit(xen_blkif_fini);
+
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_ALIAS("xen-backend:vbd");
diff --git a/drivers/block/xen-blkback/blkback_fi.c b/drivers/block/xen-blkback/blkback_fi.c
new file mode 100644
index 0000000..b7abaea
--- /dev/null
+++ b/drivers/block/xen-blkback/blkback_fi.c
@@ -0,0 +1,116 @@
+/*
+ * Fault injection interface for Xen virtual block devices
+ *
+ * Copyright 2018 Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foundation; or, when distributed
+ * separately from the Linux kernel or incorporated into other
+ * software packages, subject to the following license:
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this source file (the "Software"), to deal in the Software without
+ * restriction, including without limitation the rights to use, copy, modify,
+ * merge, publish, distribute, sublicense, and/or sell copies of the Software,
+ * and to permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
+ * IN THE SOFTWARE.
+ */
+
+#include <linux/slab.h>
+#include <linux/debugfs.h>
+
+#include <xen/fault_inject.h>
+
+#include "blkback_fi.h"
+#include "common.h"
+
+static struct dentry *blkif_fi_dir;
+
+static const char *xen_blkif_fi_names[XENBLKIF_FI_MAX] = {
+};
+
+struct xen_blkif_fi {
+	struct dentry *dir;
+	struct xen_fi *faults[XENBLKIF_FI_MAX];
+};
+
+int xen_blkbk_fi_init(void)
+{
+	blkif_fi_dir = xen_fi_dir_create("xen-blkback");
+	if (!blkif_fi_dir)
+		return -ENOMEM;
+	return 0;
+}
+
+void xen_blkbk_fi_fini(void)
+{
+	debugfs_remove_recursive(blkif_fi_dir);
+}
+
+void xen_blkif_fi_fini(struct xen_blkif *blkif)
+{
+	struct xen_blkif_fi *bfi = blkif->fi_info;
+	int fi;
+
+	if (!blkif->fi_info)
+		return;
+
+	blkif->fi_info = NULL;
+
+	for (fi = 0; fi < XENBLKIF_FI_MAX; fi++)
+		xen_fi_del(bfi->faults[fi]);
+	debugfs_remove_recursive(bfi->dir);
+	kfree(bfi);
+}
+
+int xen_blkif_fi_init(struct xen_blkif *blkif)
+{
+	struct xen_blkif_fi *bfi;
+	int fi, err = -ENOMEM;
+
+	bfi = kmalloc(sizeof(*bfi), GFP_KERNEL);
+	if (!bfi)
+		return -ENOMEM;
+
+	bfi->dir = debugfs_create_dir(dev_name(&blkif->be->dev->dev),
+				      blkif_fi_dir);
+	if (!bfi->dir)
+		goto err_dir;
+
+	for (fi = 0; fi < XENBLKIF_FI_MAX; fi++) {
+		bfi->faults[fi] = xen_fi_dir_add(bfi->dir,
+						 xen_blkif_fi_names[fi]);
+		if (!bfi->faults[fi])
+			goto err_fault;
+	}
+
+	blkif->fi_info = bfi;
+	return 0;
+
+err_fault:
+	for (; fi > 0; fi--)
+		xen_fi_del(bfi->faults[fi]);
+	debugfs_remove_recursive(bfi->dir);
+err_dir:
+	kfree(bfi);
+	return err;
+}
+
+bool xenblkif_should_fail(struct xen_blkif *blkif, xen_blkbk_fi_t type)
+{
+	struct xen_blkif_fi *bfi = blkif->fi_info;
+
+	return xen_should_fail(bfi->faults[type]);
+}
diff --git a/drivers/block/xen-blkback/blkback_fi.h b/drivers/block/xen-blkback/blkback_fi.h
new file mode 100644
index 0000000..4e29850
--- /dev/null
+++ b/drivers/block/xen-blkback/blkback_fi.h
@@ -0,0 +1,37 @@
+#ifndef _XEN_BLKBACK_FI_H
+#define _XEN_BLKBACK_FI_H
+
+struct xen_fi;
+struct xen_blkif;
+
+typedef enum {
+	XENBLKIF_FI_MAX
+} xen_blkbk_fi_t;
+
+#ifdef CONFIG_XEN_BLKDEV_BACKEND_FAULT_INJECTION
+
+void xen_blkbk_fi_fini(void);
+int xen_blkbk_fi_init(void);
+
+void xen_blkif_fi_fini(struct xen_blkif *blkif);
+int xen_blkif_fi_init(struct xen_blkif *blkif);
+
+bool xenblkif_should_fail(struct xen_blkif *blkif, xen_blkbk_fi_t type);
+
+#else
+
+static inline void xen_blkbk_fi_fini(void) { }
+static inline int xen_blkbk_fi_init(void) { return 0; }
+
+static inline void xen_blkif_fi_fini(struct xen_blkif *blkif) { }
+static inline int xen_blkif_fi_init(struct xen_blkif *blkif) { return 0; }
+
+static inline bool xenblkif_should_fail(struct xen_blkif *blkif, xen_blkbk_fi_t type)
+{
+	return false;
+}
+
+#endif /* CONFIG_XEN_BLKDEV_BACKEND_FAULT_INJECTION */
+
+#endif /* _XEN_BLKBACK_FI_H */
+
diff --git a/drivers/block/xen-blkback/common.h b/drivers/block/xen-blkback/common.h
index ecb35fe..6d12d4d 100644
--- a/drivers/block/xen-blkback/common.h
+++ b/drivers/block/xen-blkback/common.h
@@ -329,6 +329,9 @@ struct xen_blkif {
 	/* All rings for this device. */
 	struct xen_blkif_ring	*rings;
 	unsigned int		nr_rings;
+#ifdef CONFIG_XEN_BLKDEV_BACKEND_FAULT_INJECTION
+	void			*fi_info;
+#endif
 };
 
 struct seg_buf {
diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index 21c1be1..9931fc8 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -22,6 +22,7 @@
 #include <xen/events.h>
 #include <xen/grant_table.h>
 #include "common.h"
+#include "blkback_fi.h"
 
 /* On the XenBus the max length of 'ring-ref%u'. */
 #define RINGREF_NAME_LEN (20)
@@ -246,6 +247,8 @@ static int xen_blkif_disconnect(struct xen_blkif *blkif)
 	unsigned int j, r;
 	bool busy = false;
 
+	xen_blkif_fi_fini(blkif);
+
 	for (r = 0; r < blkif->nr_rings; r++) {
 		struct xen_blkif_ring *ring = &blkif->rings[r];
 		unsigned int i = 0;
@@ -998,6 +1001,8 @@ static int read_per_ring_refs(struct xen_blkif_ring *ring, const char *dir)
 		return err;
 	}
 
+	(void) xen_blkif_fi_init(blkif);
+
 	return 0;
 
 fail:

Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
