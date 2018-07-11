Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16186C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D2E120854
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D0IWLzid"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D2E120854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbeGKHoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 03:44:39 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44411 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbeGKHoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 03:44:39 -0400
Received: by mail-pg1-f196.google.com with SMTP id r1-v6so2686765pgp.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 00:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hcyD5bzBlMQbAFyjVm5uzlDDpIhRGR7j0yPAOy1/9Is=;
        b=D0IWLzidIP460MwlrQAG6aeF2+wQJfsdDVp4sxz2rV6CBYykEPx9kJafLWl8/24Izp
         aBJMYleQySH+AEvDxpml4JhRLirMDCdI0nyFbiR1OSvWAEfj7RRTITx5GkIFI1GZomOC
         mjB1OxQ7nC/1WvViv/ENHY915vprkVR7BhIno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hcyD5bzBlMQbAFyjVm5uzlDDpIhRGR7j0yPAOy1/9Is=;
        b=XtFD+pQp5QM8onw8iGgqcuMhcPGJKxr0YOfs7i1YDMJ5ZboAm4XgcGHZhpVzxemKev
         XikVEpoct5CTZTGyciGrIeIoqnqV8Ij1kbHqm8zf4apSGRnjZIfrL/GY+Ydu3GHeDZ+8
         g+EmTtAjDLMwDa3Rd+531oOUmDHRTfUFg4bO5R7uh6L2WsGHXcAnSo3gxw7wdt39zQR+
         vJR9dXw1p8UhwPXstKouzmAGZrs6x7dLY29FI+UIc97qOrVdThTaBocnwO69TrKxwnOI
         ChdSoFOsID+g5hlQ9C9CmirEWNeHVCas/+ZCzVn/WWd6ppPOCRxjyBh53IGg0f60wUAz
         iUaw==
X-Gm-Message-State: APt69E02uTmdb89OXDUEa9ujOsMq2mi6QnGEqGV6P+cYjXLvBwwkpg0S
        FW1Ih6dN6jhZft/ZXjhXwW5jew==
X-Google-Smtp-Source: AAOMgpebTrlVF+m3XLxJMgHPeW2CZiKSWaEOIEFAeDo5FrDXaVn3AirHeaZSVepOErMm0J8l+VrNvQ==
X-Received: by 2002:a65:40cd:: with SMTP id u13-v6mr26126916pgp.334.1531294902996;
        Wed, 11 Jul 2018 00:41:42 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id s144-v6sm4342192pfs.123.2018.07.11.00.41.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 00:41:42 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de
Cc:     ard.biesheuvel@linaro.org, james.morse@arm.com,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH v11 03/15] powerpc, kexec_file: factor out memblock-based arch_kexec_walk_mem()
Date:   Wed, 11 Jul 2018 16:41:51 +0900
Message-Id: <20180711074203.3019-4-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180711074203.3019-1-takahiro.akashi@linaro.org>
References: <20180711074203.3019-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memblock list is another source for usable system memory layout.
So powerpc's arch_kexec_walk_mem() is moved to kexec_file.c so that
other memblock-based architectures, particularly arm64, can also utilise
it. A moved function is now renamed to kexec_walk_memblock() and merged
into the existing arch_kexec_walk_mem() for general use, either resource
list or memblock list.

A consequent function will not work for kdump with memblock list, but
this will be fixed in the next patch.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Acked-by: James Morse <james.morse@arm.com>
---
 arch/powerpc/kernel/machine_kexec_file_64.c | 54 ---------------------
 kernel/kexec_file.c                         | 54 +++++++++++++++++++++
 2 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/arch/powerpc/kernel/machine_kexec_file_64.c b/arch/powerpc/kernel/machine_kexec_file_64.c
index 0bd23dc789a4..5357b09902c5 100644
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
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 63c7ce1c0c3e..b088324fb3ad 100644
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
@@ -501,6 +502,55 @@ static int locate_mem_hole_callback(struct resource *res, void *arg)
 	return locate_mem_hole_bottom_up(start, end, kbuf);
 }
 
+#if defined(CONFIG_HAVE_MEMBLOCK) && !defined(CONFIG_ARCH_DISCARD_MEMBLOCK)
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
+#else
+static int kexec_walk_memblock(struct kexec_buf *kbuf,
+			       int (*func)(struct resource *, void *))
+{
+	return 0;
+}
+#endif
+
 /**
  * arch_kexec_walk_mem - call func(data) on free memory regions
  * @kbuf:	Context info for the search. Also passed to @func.
@@ -513,6 +563,10 @@ static int locate_mem_hole_callback(struct resource *res, void *arg)
 int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
 			       int (*func)(struct resource *, void *))
 {
+	if (IS_ENABLED(CONFIG_HAVE_MEMBLOCK) &&
+			!IS_ENABLED(CONFIG_ARCH_DISCARD_MEMBLOCK))
+		return kexec_walk_memblock(kbuf, func);
+
 	if (kbuf->image->type == KEXEC_TYPE_CRASH)
 		return walk_iomem_res_desc(crashk_res.desc,
 					   IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
-- 
2.17.0

