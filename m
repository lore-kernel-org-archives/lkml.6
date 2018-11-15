Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCB5C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 05:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5934B2080C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 05:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fmHs7jD2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5934B2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbeKOP65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 10:58:57 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:44249 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728645AbeKOP64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 10:58:56 -0500
Received: by mail-yb1-f196.google.com with SMTP id p144-v6so7893621yba.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 21:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vuW0vIeG+fBL43JD346Yj35MDPMUrs8BFpP/g2qIAkI=;
        b=fmHs7jD24UHXdOuV/RkXNE33quq7FklmXfYHhzdXD54yuqcW05dBiwZbw9bjD6QJi1
         04In6CXtz+DS4CTg8ukwS6Y2JN/kyYfarrl7ZKGCclurAduh8t7ooBJ2qMqIrWNyE7wp
         C9mfdCln8YmApMBPPd6S/bh0RyRPFLGUtIXWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vuW0vIeG+fBL43JD346Yj35MDPMUrs8BFpP/g2qIAkI=;
        b=ZYNWDFvBcUSvkx8seWVtMLm4UeR+dNwxdrn5tuE69FhqoKUdfaYsSfKL0LCapxS+S0
         I3NOTj95DOpDkGibew8/zOSI1vCBdqHDAz1OLZszGAh7MhRI889GFlpzZI0ThcybP5Hx
         NKkqZFDOdG6+6Ung7w/c+TIFz/qfrCwmpqulUgIkil9QRHV1iUhoHTum3Q17v6NxBCeX
         J4kfeHtFNLI6DRkY0KHnoJJBmKrpB/erB8G6OsrluQMWRkZQSxaz7GTU396tVk23VUxf
         +OYmPniZPiB0zH6s5Qi053/QDHasrXnoXSVnyAU9/hT1+g9ycLMe2XU5S23CemoESk+v
         w9pA==
X-Gm-Message-State: AGRZ1gLfPJ1RYM992TJSOhY03PQb9HeCD4IkGq85vhjRr3mHGrKC7wT0
        32m1bgheR0YzHMoOTcp5NWSPsA==
X-Google-Smtp-Source: AJdET5cSKJSln6HGf2ZJpmsq8nkU9sQMtJCL2cEfX/SXq35ZLGNxWkhAiW8/FTpQTLfMVo/f26hT/g==
X-Received: by 2002:a25:b213:: with SMTP id i19-v6mr4461442ybj.414.1542261150950;
        Wed, 14 Nov 2018 21:52:30 -0800 (PST)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id w70sm603729yww.76.2018.11.14.21.52.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 21:52:30 -0800 (PST)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc:     prudo@linux.ibm.com, ard.biesheuvel@linaro.org,
        james.morse@arm.com, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH v16 04/16] powerpc, kexec_file: factor out memblock-based arch_kexec_walk_mem()
Date:   Thu, 15 Nov 2018 14:52:43 +0900
Message-Id: <20181115055254.2812-5-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181115055254.2812-1-takahiro.akashi@linaro.org>
References: <20181115055254.2812-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memblock list is another source for usable system memory layout.
So move powerpc's arch_kexec_walk_mem() to common code so that other
memblock-based architectures, particularly arm64, can also utilise it.
A moved function is now renamed to kexec_walk_memblock() and integrated
into kexec_locate_mem_hole(), which will now be usable for all
architectures with no need for overriding arch_kexec_walk_mem().

With this change, arch_kexec_walk_mem() need no longer be a weak function,
and was now renamed to kexec_walk_resources().

Since powerpc doesn't support kdump in its kexec_file_load(), the current
kexec_walk_memblock() won't work for kdump either in this form, this will
be fixed in the next patch.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Acked-by: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Acked-by: James Morse <james.morse@arm.com>
---
 arch/powerpc/kernel/machine_kexec_file_64.c | 54 ------------------
 include/linux/kexec.h                       |  2 -
 kernel/kexec_file.c                         | 61 +++++++++++++++++++--
 3 files changed, 57 insertions(+), 60 deletions(-)

diff --git a/arch/powerpc/kernel/machine_kexec_file_64.c b/arch/powerpc/kernel/machine_kexec_file_64.c
index c77e95e9b384..0d20c7ad40fa 100644
--- a/arch/powerpc/kernel/machine_kexec_file_64.c
+++ b/arch/powerpc/kernel/machine_kexec_file_64.c
@@ -24,7 +24,6 @@
 
 #include <linux/slab.h>
 #include <linux/kexec.h>
-#include <linux/memblock.h>
 #include <linux/of_fdt.h>
 #include <linux/libfdt.h>
 #include <asm/ima.h>
@@ -46,59 +45,6 @@ int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
 	return kexec_image_probe_default(image, buf, buf_len);
 }
 
-/**
- * arch_kexec_walk_mem - call func(data) for each unreserved memory block
- * @kbuf:	Context info for the search. Also passed to @func.
- * @func:	Function to call for each memory block.
- *
- * This function is used by kexec_add_buffer and kexec_locate_mem_hole
- * to find unreserved memory to load kexec segments into.
- *
- * Return: The memory walk will stop when func returns a non-zero value
- * and that value will be returned. If all free regions are visited without
- * func returning non-zero, then zero will be returned.
- */
-int arch_kexec_walk_mem(struct kexec_buf *kbuf,
-			int (*func)(struct resource *, void *))
-{
-	int ret = 0;
-	u64 i;
-	phys_addr_t mstart, mend;
-	struct resource res = { };
-
-	if (kbuf->top_down) {
-		for_each_free_mem_range_reverse(i, NUMA_NO_NODE, 0,
-						&mstart, &mend, NULL) {
-			/*
-			 * In memblock, end points to the first byte after the
-			 * range while in kexec, end points to the last byte
-			 * in the range.
-			 */
-			res.start = mstart;
-			res.end = mend - 1;
-			ret = func(&res, kbuf);
-			if (ret)
-				break;
-		}
-	} else {
-		for_each_free_mem_range(i, NUMA_NO_NODE, 0, &mstart, &mend,
-					NULL) {
-			/*
-			 * In memblock, end points to the first byte after the
-			 * range while in kexec, end points to the last byte
-			 * in the range.
-			 */
-			res.start = mstart;
-			res.end = mend - 1;
-			ret = func(&res, kbuf);
-			if (ret)
-				break;
-		}
-	}
-
-	return ret;
-}
-
 /**
  * setup_purgatory - initialize the purgatory's global variables
  * @image:		kexec image.
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index f378cb786f1b..d58d1f2fab10 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -192,8 +192,6 @@ int __weak arch_kexec_apply_relocations(struct purgatory_info *pi,
 					const Elf_Shdr *relsec,
 					const Elf_Shdr *symtab);
 
-int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
-			       int (*func)(struct resource *, void *));
 extern int kexec_add_buffer(struct kexec_buf *kbuf);
 int kexec_locate_mem_hole(struct kexec_buf *kbuf);
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 9e6529da12ed..d03195a8cb6e 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -16,6 +16,7 @@
 #include <linux/file.h>
 #include <linux/slab.h>
 #include <linux/kexec.h>
+#include <linux/memblock.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
 #include <linux/fs.h>
@@ -499,8 +500,57 @@ static int locate_mem_hole_callback(struct resource *res, void *arg)
 	return locate_mem_hole_bottom_up(start, end, kbuf);
 }
 
+#ifdef CONFIG_ARCH_DISCARD_MEMBLOCK
+static int kexec_walk_memblock(struct kexec_buf *kbuf,
+			       int (*func)(struct resource *, void *))
+{
+	return 0;
+}
+#else
+static int kexec_walk_memblock(struct kexec_buf *kbuf,
+			       int (*func)(struct resource *, void *))
+{
+	int ret = 0;
+	u64 i;
+	phys_addr_t mstart, mend;
+	struct resource res = { };
+
+	if (kbuf->top_down) {
+		for_each_free_mem_range_reverse(i, NUMA_NO_NODE, 0,
+						&mstart, &mend, NULL) {
+			/*
+			 * In memblock, end points to the first byte after the
+			 * range while in kexec, end points to the last byte
+			 * in the range.
+			 */
+			res.start = mstart;
+			res.end = mend - 1;
+			ret = func(&res, kbuf);
+			if (ret)
+				break;
+		}
+	} else {
+		for_each_free_mem_range(i, NUMA_NO_NODE, 0, &mstart, &mend,
+					NULL) {
+			/*
+			 * In memblock, end points to the first byte after the
+			 * range while in kexec, end points to the last byte
+			 * in the range.
+			 */
+			res.start = mstart;
+			res.end = mend - 1;
+			ret = func(&res, kbuf);
+			if (ret)
+				break;
+		}
+	}
+
+	return ret;
+}
+#endif
+
 /**
- * arch_kexec_walk_mem - call func(data) on free memory regions
+ * kexec_walk_resources - call func(data) on free memory regions
  * @kbuf:	Context info for the search. Also passed to @func.
  * @func:	Function to call for each memory region.
  *
@@ -508,8 +558,8 @@ static int locate_mem_hole_callback(struct resource *res, void *arg)
  * and that value will be returned. If all free regions are visited without
  * func returning non-zero, then zero will be returned.
  */
-int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
-			       int (*func)(struct resource *, void *))
+static int kexec_walk_resources(struct kexec_buf *kbuf,
+				int (*func)(struct resource *, void *))
 {
 	if (kbuf->image->type == KEXEC_TYPE_CRASH)
 		return walk_iomem_res_desc(crashk_res.desc,
@@ -536,7 +586,10 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
 	if (kbuf->mem != KEXEC_BUF_MEM_UNKNOWN)
 		return 0;
 
-	ret = arch_kexec_walk_mem(kbuf, locate_mem_hole_callback);
+	if (IS_ENABLED(CONFIG_ARCH_DISCARD_MEMBLOCK))
+		ret = kexec_walk_resources(kbuf, locate_mem_hole_callback);
+	else
+		ret = kexec_walk_memblock(kbuf, locate_mem_hole_callback);
 
 	return ret == 1 ? 0 : -EADDRNOTAVAIL;
 }
-- 
2.19.0

