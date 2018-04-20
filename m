Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754679AbeDTKri (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 06:47:38 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:39880 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754549AbeDTKre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 06:47:34 -0400
X-IronPort-AV: E=Sophos;i="5.49,301,1520899200";
   d="scan'208";a="607906209"
Subject: [PATCH 1/3] xen: add generic fault injection facility
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
Date: Fri, 20 Apr 2018 10:47:26 +0000
Message-ID: <20180420104726.17823.40147.stgit@dev-dsk-staskins-1a-ca5afbf2.eu-west-1.amazon.com>
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3KAlkvG016958

The overall idea of this patch is to add a generic fault injection facility
to Xen, which later can be used in various places by different Xen parts.

Core implementation ideas:

- The facility build is controlled by boolean config
  CONFIG_XEN_FAULT_INJECTION option ("N" by default).

- All fault injection logic is located in an optionally compiled separated
  file.

- Fault injection attribute and control directory creation and destruction
  are wrapped with helpers, producing and accepting a pointer to an opaque
  object thus making all the rest of code independent on fault injection
  engine.

When enabled Xen root fault injection directory appears:

- /sys/kernel/debug/xen/fault_inject/

The falicity provides the following helpers (exported to be accessible in
modules):

- xen_fi_add(name) - adds fault injection control directory "name" to Xen
  root fault injection directory

- xen_fi_dir_create(name) - allows to create a subdirectory "name" in Xen
  root fault injection directory.

- xen_fi_dir_add(dir, name) - adds fault injection control directory "name"
  to directory "dir"

- xen_should_fail(fi) - check whether fi hav to fail.

Signed-off-by: Stanislav Kinsburskii <staskins@amazon.com>
CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>
CC: Juergen Gross <jgross@suse.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: x86@kernel.org
CC: xen-devel@lists.xenproject.org
CC: linux-kernel@vger.kernel.org
CC: Stanislav Kinsburskii <staskins@amazon.com>
CC: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/xen/Kconfig        |    7 +++
 arch/x86/xen/Makefile       |    1 
 arch/x86/xen/fault_inject.c |  109 +++++++++++++++++++++++++++++++++++++++++++
 include/xen/fault_inject.h  |   45 ++++++++++++++++++
 4 files changed, 162 insertions(+)
 create mode 100644 arch/x86/xen/fault_inject.c
 create mode 100644 include/xen/fault_inject.h

diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
index c1f98f3..483fc16 100644
--- a/arch/x86/xen/Kconfig
+++ b/arch/x86/xen/Kconfig
@@ -77,3 +77,10 @@ config XEN_PVH
 	bool "Support for running as a PVH guest"
 	depends on XEN && XEN_PVHVM && ACPI
 	def_bool n
+
+config XEN_FAULT_INJECTION
+	bool "Enable Xen fault injection"
+	depends on FAULT_INJECTION_DEBUG_FS
+	default n
+	help
+	  Enable Xen fault injection facility
diff --git a/arch/x86/xen/Makefile b/arch/x86/xen/Makefile
index d83cb54..3158fe1 100644
--- a/arch/x86/xen/Makefile
+++ b/arch/x86/xen/Makefile
@@ -34,3 +34,4 @@ obj-$(CONFIG_XEN_DOM0)		+= vga.o
 obj-$(CONFIG_SWIOTLB_XEN)	+= pci-swiotlb-xen.o
 obj-$(CONFIG_XEN_EFI)		+= efi.o
 obj-$(CONFIG_XEN_PVH)	 	+= xen-pvh.o
+obj-$(CONFIG_XEN_FAULT_INJECTION)	+= fault_inject.o
diff --git a/arch/x86/xen/fault_inject.c b/arch/x86/xen/fault_inject.c
new file mode 100644
index 0000000..ecf0f7c
--- /dev/null
+++ b/arch/x86/xen/fault_inject.c
@@ -0,0 +1,109 @@
+/*
+ * Fauit injection interface for Xen virtual block devices
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
+#include <linux/fault-inject.h>
+
+#include <xen/fault_inject.h>
+
+#include "debugfs.h"
+
+static struct dentry *d_fi_debug;
+
+static DECLARE_FAULT_ATTR(template_attr);
+
+struct xen_fi {
+	struct dentry		*dir;
+	struct fault_attr	attr;
+};
+
+struct xen_fi *xen_fi_dir_add(struct dentry *parent, const char *name)
+{
+	struct xen_fi *fi;
+	struct dentry *dir;
+
+	fi = kzalloc(sizeof(*fi), GFP_KERNEL);
+	if (!fi)
+		return ERR_PTR(-ENOMEM);
+
+	memcpy(&fi->attr, &template_attr, sizeof(template_attr));
+
+	dir = fault_create_debugfs_attr(name, parent, &fi->attr);
+	if (IS_ERR(dir)) {
+		kfree(fi);
+		return (struct xen_fi *)dir;
+	}
+
+	fi->dir = dir;
+
+	return fi;
+}
+EXPORT_SYMBOL(xen_fi_dir_add);
+
+struct xen_fi *xen_fi_add(const char *name)
+{
+	return xen_fi_dir_add(d_fi_debug, name);
+}
+
+void xen_fi_del(struct xen_fi *fi)
+{
+	debugfs_remove_recursive(fi->dir);
+	kfree(fi);
+}
+EXPORT_SYMBOL(xen_fi_del);
+
+bool xen_should_fail(struct xen_fi *fi)
+{
+	return should_fail(&fi->attr, 0);
+}
+EXPORT_SYMBOL(xen_should_fail);
+
+struct dentry *xen_fi_dir_create(const char *name)
+{
+	return debugfs_create_dir(name, d_fi_debug);
+}
+EXPORT_SYMBOL(xen_fi_dir_create);
+
+static int __init xen_fi_init(void)
+{
+	struct dentry *d_xen;
+
+	d_xen = xen_init_debugfs();
+	if (!d_xen)
+		return -ENOMEM;
+
+	d_fi_debug = debugfs_create_dir("fault_inject", d_xen);
+	if (d_fi_debug == NULL)
+		return -ENOMEM;
+
+	return 0;
+}
+
+fs_initcall(xen_fi_init);
diff --git a/include/xen/fault_inject.h b/include/xen/fault_inject.h
new file mode 100644
index 0000000..e2bf14a
--- /dev/null
+++ b/include/xen/fault_inject.h
@@ -0,0 +1,45 @@
+#ifndef _XEN_FAULT_INJECT_H
+#define _XEN_FAULT_INJECT_H
+
+struct dentry;
+struct xen_fi;
+
+#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
+
+struct dentry *xen_fi_dir_create(const char *name);
+
+struct xen_fi *xen_fi_dir_add(struct dentry *parent, const char *name);
+struct xen_fi *xen_fi_add(const char *name);
+void xen_fi_del(struct xen_fi *fi);
+
+bool xen_should_fail(struct xen_fi *fi);
+
+#else
+
+static inline struct dentry *xen_fi_dir_create(const char *name)
+{
+	return NULL;
+}
+
+static inline struct xen_fi *xen_fi_dir_add(struct dentry *parent, const char *name)
+{
+	return NULL;
+}
+
+static inline struct xen_fi *xen_fi_add(const char *name)
+{
+	return NULL;
+}
+
+static inline void xen_fi_del(struct xen_fi *fi) { }
+
+static inline bool xen_should_fail(struct xen_fi *fi)
+{
+	return false;
+}
+
+#endif /* CONFIG_FAULT_INJECTION_DEBUG_FS */
+
+#endif /* _XEN_FAULT_INJECT_H */
+
+

Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
