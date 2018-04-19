Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753197AbeDSATX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 20:19:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37228 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753065AbeDSATW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 20:19:22 -0400
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        robh+dt@kernel.org, dan.j.williams@intel.com, nicolas.pitre@linaro.org,
        josh@joshtriplett.org
Cc: Baoquan He <bhe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Borislav Petkov <bp@suse.de>, Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH v3 2/3] resource: add walk_system_ram_res_rev()
Date: Thu, 19 Apr 2018 08:18:47 +0800
Message-Id: <20180419001848.3041-3-bhe@redhat.com>
In-Reply-To: <20180419001848.3041-1-bhe@redhat.com>
References: <20180419001848.3041-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function, being a variant of walk_system_ram_res() introduced in
commit 8c86e70acead ("resource: provide new functions to walk through
resources"), walks through a list of all the resources of System RAM
in reversed order, i.e., from higher to lower.

It will be used in kexec_file code.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Wei Yang <richard.weiyang@gmail.com>
---
 include/linux/ioport.h |  3 +++
 kernel/resource.c      | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 225d13d3500a..5f2cfb460a14 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -278,6 +278,9 @@ extern int
 walk_system_ram_res(u64 start, u64 end, void *arg,
 		    int (*func)(struct resource *, void *));
 extern int
+walk_system_ram_res_rev(u64 start, u64 end, void *arg,
+			int (*func)(struct resource *, void *));
+extern int
 walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start, u64 end,
 		    void *arg, int (*func)(struct resource *, void *));
 
diff --git a/kernel/resource.c b/kernel/resource.c
index 4f560991c130..6c519b06e3d6 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -23,6 +23,8 @@
 #include <linux/pfn.h>
 #include <linux/mm.h>
 #include <linux/resource_ext.h>
+#include <linux/string.h>
+#include <linux/vmalloc.h>
 #include <asm/io.h>
 
 
@@ -475,6 +477,44 @@ int walk_system_ram_res(u64 start, u64 end, void *arg,
 }
 
 /*
+ * This function, being a variant of walk_system_ram_res(), calls the @func
+ * callback against all memory ranges of type System RAM which are marked as
+ * IORESOURCE_SYSTEM_RAM and IORESOUCE_BUSY in reversed order, i.e., from
+ * higher to lower.
+ */
+int walk_system_ram_res_rev(u64 start, u64 end, void *arg,
+				int (*func)(struct resource *, void *))
+{
+	unsigned long flags;
+	struct resource *res;
+	int ret = -1;
+
+	flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
+
+	read_lock(&resource_lock);
+	list_for_each_entry_reverse(res, &iomem_resource.child, sibling) {
+		if (start >= end)
+			break;
+		if ((res->flags & flags) != flags)
+			continue;
+		if (res->desc != IORES_DESC_NONE)
+			continue;
+		if (res->end < start)
+			break;
+
+		if ((res->end >= start) && (res->start < end)) {
+			ret = (*func)(res, arg);
+			if (ret)
+				break;
+		}
+		end = res->start - 1;
+
+	}
+	read_unlock(&resource_lock);
+	return ret;
+}
+
+/*
  * This function calls the @func callback against all memory ranges, which
  * are ranges marked as IORESOURCE_MEM and IORESOUCE_BUSY.
  */
-- 
2.13.6
