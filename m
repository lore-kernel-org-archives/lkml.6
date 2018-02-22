Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753741AbeBVLS6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 06:18:58 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:54940 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753531AbeBVLS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 06:18:56 -0500
X-Google-Smtp-Source: AH8x2253FfIrqeuGyYsrLX4Nup3BCTD+EJJz++OlwwcpdCJK6OtFifMbz9/nZDwar6Kfwodp3aXHEA==
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: catalin.marinas@arm.com, will.deacon@arm.com,
        bauerman@linux.vnet.ibm.com, dhowells@redhat.com, vgoyal@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        akpm@linux-foundation.org, mpe@ellerman.id.au, dyoung@redhat.com,
        bhe@redhat.com, arnd@arndb.de, ard.biesheuvel@linaro.org,
        julien.thierry@arm.com
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v8 01/13] resource: add walk_system_ram_res_rev()
Date: Thu, 22 Feb 2018 20:17:20 +0900
Message-Id: <20180222111732.23051-2-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180222111732.23051-1-takahiro.akashi@linaro.org>
References: <20180222111732.23051-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function, being a variant of walk_system_ram_res() introduced in
commit 8c86e70acead ("resource: provide new functions to walk through
resources"), walks through a list of all the resources of System RAM
in reversed order, i.e., from higher to lower.

It will be used in kexec_file implementation on arm64.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 include/linux/ioport.h |  3 +++
 kernel/resource.c      | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index da0ebaec25f0..f12d95fe038b 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -277,6 +277,9 @@ extern int
 walk_system_ram_res(u64 start, u64 end, void *arg,
 		    int (*func)(struct resource *, void *));
 extern int
+walk_system_ram_res_rev(u64 start, u64 end, void *arg,
+			int (*func)(struct resource *, void *));
+extern int
 walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start, u64 end,
 		    void *arg, int (*func)(struct resource *, void *));
 
diff --git a/kernel/resource.c b/kernel/resource.c
index e270b5048988..bdaa93407f4c 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -23,6 +23,8 @@
 #include <linux/pfn.h>
 #include <linux/mm.h>
 #include <linux/resource_ext.h>
+#include <linux/string.h>
+#include <linux/vmalloc.h>
 #include <asm/io.h>
 
 
@@ -486,6 +488,61 @@ int walk_mem_res(u64 start, u64 end, void *arg,
 				     arg, func);
 }
 
+int walk_system_ram_res_rev(u64 start, u64 end, void *arg,
+				int (*func)(struct resource *, void *))
+{
+	struct resource res, *rams;
+	int rams_size = 16, i;
+	int ret = -1;
+
+	/* create a list */
+	rams = vmalloc(sizeof(struct resource) * rams_size);
+	if (!rams)
+		return ret;
+
+	res.start = start;
+	res.end = end;
+	res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
+	i = 0;
+	while ((res.start < res.end) &&
+		(!find_next_iomem_res(&res, IORES_DESC_NONE, true))) {
+		if (i >= rams_size) {
+			/* re-alloc */
+			struct resource *rams_new;
+			int rams_new_size;
+
+			rams_new_size = rams_size + 16;
+			rams_new = vmalloc(sizeof(struct resource)
+							* rams_new_size);
+			if (!rams_new)
+				goto out;
+
+			memcpy(rams_new, rams,
+					sizeof(struct resource) * rams_size);
+			vfree(rams);
+			rams = rams_new;
+			rams_size = rams_new_size;
+		}
+
+		rams[i].start = res.start;
+		rams[i++].end = res.end;
+
+		res.start = res.end + 1;
+		res.end = end;
+	}
+
+	/* go reverse */
+	for (i--; i >= 0; i--) {
+		ret = (*func)(&rams[i], arg);
+		if (ret)
+			break;
+	}
+
+out:
+	vfree(rams);
+	return ret;
+}
+
 #if !defined(CONFIG_ARCH_HAS_WALK_MEMORY)
 
 /*
-- 
2.16.2
