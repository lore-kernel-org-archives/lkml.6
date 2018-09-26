Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA21C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A24E208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ry/ASTip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A24E208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbeIZSZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 14:25:01 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:48395 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727187AbeIZSY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 14:24:59 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180926121215euoutp01150564d3f82a7f6e404d9946937762a0~X8g0SH7db3037430374euoutp01c;
        Wed, 26 Sep 2018 12:12:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180926121215euoutp01150564d3f82a7f6e404d9946937762a0~X8g0SH7db3037430374euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1537963935;
        bh=19Gado/ajBeMIphbJK43vQ5JfG1n8s+zfVYD9irz2JY=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=ry/ASTippaKZwSLAnRRfFTW/T9bifp6tBQ+JswlC5iUITsdIXDj7biK9G6gvJzFWx
         OB1i8R51pTCnRt+GUIwSzXeaBXB5/ZLSRRSD5QUYnqWVDb5/rV2eAii0H+dN6QEOX+
         AAFRI5tOgsdWoBoWaXy8rUq9KzFJME7GY2k8Xp1k=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180926121214eucas1p276126f4243906d3da41d5d20ec1fc49c~X8gzir8AA2051920519eucas1p2s;
        Wed, 26 Sep 2018 12:12:14 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id EF.21.04294.E977BAB5; Wed, 26
        Sep 2018 13:12:14 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180926121214eucas1p2b262936ddd96980b7b4369f16b52c6ce~X8gyxToX31327013270eucas1p26;
        Wed, 26 Sep 2018 12:12:14 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-79-5bab779e584b
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D1.7D.04284.E977BAB5; Wed, 26
        Sep 2018 13:12:14 +0100 (BST)
Received: from AMDC3482.DIGITAL.local ([106.120.51.30]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PFN0028YWK7Q120@eusync4.samsung.com>;
        Wed, 26 Sep 2018 13:12:14 +0100 (BST)
From:   Maciej Slodczyk <m.slodczyk2@partner.samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux@armlinux.org.uk, oleg@redhat.com, catalin.marinas@arm.com,
        will.deacon@arm.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, k.lewandowsk@samsung.com,
        m.slodczyk2@partner.samsung.com
Subject: [PATCH v2 1/7] arm64: move arm uprobes code to be reused by arm64
Date:   Wed, 26 Sep 2018 14:11:59 +0200
Message-id: <1537963925-25313-2-git-send-email-m.slodczyk2@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1537963925-25313-1-git-send-email-m.slodczyk2@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsWy7djPc7rzyldHGzy9qWLRdW8Hm0XHppms
        FhtnrGe1eL+sh9Hi6Nm/TBaNn+YyW2x6fI3V4vKuOWwWh6buZbTY07+azWLtkbvsFpcOLGCy
        aFq2lcVi6/5WRovjvQeYLF5+PMHiIOCxZt4aRo/L1y4ye2xeoeWxaVUnm8e8k4Eem5fUexx8
        t4fJ4/2+q2wefVtWMXp83iQXwBXFZZOSmpNZllqkb5fAlTHr6lS2goWuFYcv3WVtYLxi2cXI
        ySEhYCLxofECUxcjF4eQwApGiX/TfrNAOJ8ZJe5sesYMU/V44hNWiMQyRonmIysZQRJCAv8Z
        JXoaAkFsNgFzie1HW1hAbBEBN4kbjR1gY5kFLjNJXD7RzQSSEBbwknh4YQqQzcHBIqAqcaZT
        HSTMK+AvcfvQHRaIZXISN891gi3mFAiQODR9BTPIHAmB52wSZ/ufQl3kInH2zDwoW1ji1fEt
        7BC2jERnx0EmCLtcYveJm+wQzS2MElMbD0AlrCX+rJrIBmIzC/BJTNo2nRnkIAkBXomONiGI
        Eg+Jb/s3sEA8uZhRYsNplQmMkgsYGVYxiqeWFuempxYb5aWW6xUn5haX5qXrJefnbmIEJoHT
        /45/2cG460/SIUYBDkYlHl4O21XRQqyJZcWVuYcYJTiYlUR4uctWRwvxpiRWVqUW5ccXleak
        Fh9ilOZgURLn5dNKixYSSE8sSc1OTS1ILYLJMnFwSjUwGuawRZasKwi9cOh0gZxHXKVmKq9T
        WPaegP03jky6cW/ugfsnOOIfOwd6T98qt25pUsu1a/oPLI6Hvm8WCJB6tli3n19Hs+gy6/LX
        SpYuG08mf+a712/f++fjulXflNXnC/PcOBfG9exFROytjt9PnDK+BRY1n+ONeddeu41ttr6h
        4I72K4/vKLEUZyQaajEXFScCAOXk3EX+AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsVy+t/xa7rzyldHG3x/wWzRdW8Hm0XHppms
        FhtnrGe1eL+sh9Hi6Nm/TBaNn+YyW2x6fI3V4vKuOWwWh6buZbTY07+azWLtkbvsFpcOLGCy
        aFq2lcVi6/5WRovjvQeYLF5+PMHiIOCxZt4aRo/L1y4ye2xeoeWxaVUnm8e8k4Eem5fUexx8
        t4fJ4/2+q2wefVtWMXp83iQXwBXFZZOSmpNZllqkb5fAlTHr6lS2goWuFYcv3WVtYLxi2cXI
        ySEhYCLxeOITVhBbSGAJo8Tf3/ZdjFxAdiOTxPSuBrAEm4C5xPajLSwgtoiAm8SNxg4mkCJm
        gctMEp8X7AUrEhbwknh4YQpQgoODRUBV4kynOkiYV8Bf4vahOywQy+Qkbp7rZAaxOQUCJA5N
        X8EMsdhf4srJmSwTGHkWMDKsYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECAzgbcd+bt7BeGlj
        8CFGAQ5GJR5eDttV0UKsiWXFlbmHGCU4mJVEeLnLVkcL8aYkVlalFuXHF5XmpBYfYpTmYFES
        5z1vUBklJJCeWJKanZpakFoEk2Xi4JRqYGTIvZ5fzJvgnXaTP88oaxbnsrjjDT1/3AS8xMKc
        d0i1VGXz7+V4uzf3UWzswU3LbvEfzHk972ZJxJ3yUz1+Z4QcHYsr33rymYQwdpWdkC64nPtl
        Ubv0EVMN3r8HlNZrm38Trebjv3Uw8OfslE2Bhse65zg9WWm6bDbXZ9XbP3tkdrft7srPUGIp
        zkg01GIuKk4EAHIUfiJcAgAA
X-CMS-MailID: 20180926121214eucas1p2b262936ddd96980b7b4369f16b52c6ce
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180926121214eucas1p2b262936ddd96980b7b4369f16b52c6ce
References: <1537963925-25313-1-git-send-email-m.slodczyk2@partner.samsung.com>
        <CGME20180926121214eucas1p2b262936ddd96980b7b4369f16b52c6ce@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move ARM32 uprobes code from arch/arm/probes/ to a more common location -
lib/probes/arm/. This code will be used by ARM64 code when uprobing 32-bit
applications.

Signed-off-by: Maciej Slodczyk <m.slodczyk2@partner.samsung.com>
---
 arch/arm/probes/Makefile                                  | 8 ++++----
 arch/arm/probes/kprobes/actions-arm.c                     | 2 +-
 arch/arm/probes/kprobes/checkers-arm.c                    | 4 ++--
 arch/arm/probes/kprobes/checkers-common.c                 | 4 ++--
 arch/arm/probes/kprobes/checkers-thumb.c                  | 2 +-
 arch/arm/probes/kprobes/checkers.h                        | 2 +-
 arch/arm/probes/kprobes/core.c                            | 2 +-
 arch/arm/probes/kprobes/core.h                            | 2 +-
 arch/arm/probes/kprobes/test-core.c                       | 2 +-
 arch/arm/probes/uprobes/Makefile                          | 2 +-
 arch/arm/probes/uprobes/core.c                            | 4 ++--
 lib/Makefile                                              | 2 ++
 lib/probes/Makefile                                       | 1 +
 lib/probes/arm/Makefile                                   | 6 ++++++
 {arch/arm/probes/uprobes => lib/probes/arm}/actions-arm.c | 4 ++--
 {arch/arm/probes => lib/probes/arm}/decode-arm.c          | 0
 {arch/arm/probes => lib/probes/arm}/decode-arm.h          | 0
 {arch/arm/probes => lib/probes/arm}/decode.c              | 0
 {arch/arm/probes => lib/probes/arm}/decode.h              | 0
 19 files changed, 28 insertions(+), 19 deletions(-)
 create mode 100644 lib/probes/Makefile
 create mode 100644 lib/probes/arm/Makefile
 rename {arch/arm/probes/uprobes => lib/probes/arm}/actions-arm.c (99%)
 rename {arch/arm/probes => lib/probes/arm}/decode-arm.c (100%)
 rename {arch/arm/probes => lib/probes/arm}/decode-arm.h (100%)
 rename {arch/arm/probes => lib/probes/arm}/decode.c (100%)
 rename {arch/arm/probes => lib/probes/arm}/decode.h (100%)

diff --git a/arch/arm/probes/Makefile b/arch/arm/probes/Makefile
index 8b0ea5a..9e22de6 100644
--- a/arch/arm/probes/Makefile
+++ b/arch/arm/probes/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_UPROBES)		+= decode.o decode-arm.o uprobes/
-obj-$(CONFIG_KPROBES)		+= decode.o kprobes/
+subdir-ccflags-y := -I$(srctree)/lib/probes/arm/
+
+obj-$(CONFIG_UPROBES)		+= uprobes/
+obj-$(CONFIG_KPROBES)		+= kprobes/
 ifdef CONFIG_THUMB2_KERNEL
 obj-$(CONFIG_KPROBES)		+= decode-thumb.o
-else
-obj-$(CONFIG_KPROBES)		+= decode-arm.o
 endif
diff --git a/arch/arm/probes/kprobes/actions-arm.c b/arch/arm/probes/kprobes/actions-arm.c
index b9056d6..fb1179e 100644
--- a/arch/arm/probes/kprobes/actions-arm.c
+++ b/arch/arm/probes/kprobes/actions-arm.c
@@ -62,7 +62,7 @@
 #include <linux/kprobes.h>
 #include <linux/ptrace.h>
 
-#include "../decode-arm.h"
+#include "decode-arm.h"
 #include "core.h"
 #include "checkers.h"
 
diff --git a/arch/arm/probes/kprobes/checkers-arm.c b/arch/arm/probes/kprobes/checkers-arm.c
index 7b98173..29520a2 100644
--- a/arch/arm/probes/kprobes/checkers-arm.c
+++ b/arch/arm/probes/kprobes/checkers-arm.c
@@ -14,8 +14,8 @@
  */
 
 #include <linux/kernel.h>
-#include "../decode.h"
-#include "../decode-arm.h"
+#include "decode.h"
+#include "decode-arm.h"
 #include "checkers.h"
 
 static enum probes_insn __kprobes arm_check_stack(probes_opcode_t insn,
diff --git a/arch/arm/probes/kprobes/checkers-common.c b/arch/arm/probes/kprobes/checkers-common.c
index 971119c..afc3a38 100644
--- a/arch/arm/probes/kprobes/checkers-common.c
+++ b/arch/arm/probes/kprobes/checkers-common.c
@@ -14,8 +14,8 @@
  */
 
 #include <linux/kernel.h>
-#include "../decode.h"
-#include "../decode-arm.h"
+#include "decode.h"
+#include "decode-arm.h"
 #include "checkers.h"
 
 enum probes_insn checker_stack_use_none(probes_opcode_t insn,
diff --git a/arch/arm/probes/kprobes/checkers-thumb.c b/arch/arm/probes/kprobes/checkers-thumb.c
index d608e3b..847f1ee 100644
--- a/arch/arm/probes/kprobes/checkers-thumb.c
+++ b/arch/arm/probes/kprobes/checkers-thumb.c
@@ -14,7 +14,7 @@
  */
 
 #include <linux/kernel.h>
-#include "../decode.h"
+#include "decode.h"
 #include "../decode-thumb.h"
 #include "checkers.h"
 
diff --git a/arch/arm/probes/kprobes/checkers.h b/arch/arm/probes/kprobes/checkers.h
index cf6c9e7..9bbab0d 100644
--- a/arch/arm/probes/kprobes/checkers.h
+++ b/arch/arm/probes/kprobes/checkers.h
@@ -17,7 +17,7 @@
 
 #include <linux/kernel.h>
 #include <linux/types.h>
-#include "../decode.h"
+#include "decode.h"
 
 extern probes_check_t checker_stack_use_none;
 extern probes_check_t checker_stack_use_unknown;
diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
index f8bd523..de5e854 100644
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -34,7 +34,7 @@
 #include <asm/patch.h>
 #include <asm/sections.h>
 
-#include "../decode-arm.h"
+#include "decode-arm.h"
 #include "../decode-thumb.h"
 #include "core.h"
 
diff --git a/arch/arm/probes/kprobes/core.h b/arch/arm/probes/kprobes/core.h
index ec5d1f2..4da60f0 100644
--- a/arch/arm/probes/kprobes/core.h
+++ b/arch/arm/probes/kprobes/core.h
@@ -20,7 +20,7 @@
 #define _ARM_KERNEL_KPROBES_H
 
 #include <asm/kprobes.h>
-#include "../decode.h"
+#include "decode.h"
 
 /*
  * These undefined instructions must be unique and
diff --git a/arch/arm/probes/kprobes/test-core.c b/arch/arm/probes/kprobes/test-core.c
index cc237fa..c19df9f 100644
--- a/arch/arm/probes/kprobes/test-core.c
+++ b/arch/arm/probes/kprobes/test-core.c
@@ -212,7 +212,7 @@
 
 #include "core.h"
 #include "test-core.h"
-#include "../decode-arm.h"
+#include "decode-arm.h"
 #include "../decode-thumb.h"
 
 
diff --git a/arch/arm/probes/uprobes/Makefile b/arch/arm/probes/uprobes/Makefile
index e1dc3d0..0d05ba9 100644
--- a/arch/arm/probes/uprobes/Makefile
+++ b/arch/arm/probes/uprobes/Makefile
@@ -1 +1 @@
-obj-$(CONFIG_UPROBES)		+= core.o actions-arm.o
+obj-$(CONFIG_UPROBES)		+= core.o
diff --git a/arch/arm/probes/uprobes/core.c b/arch/arm/probes/uprobes/core.c
index bf99226..90d0954 100644
--- a/arch/arm/probes/uprobes/core.c
+++ b/arch/arm/probes/uprobes/core.c
@@ -17,8 +17,8 @@
 #include <asm/opcodes.h>
 #include <asm/traps.h>
 
-#include "../decode.h"
-#include "../decode-arm.h"
+#include "decode.h"
+#include "decode-arm.h"
 #include "core.h"
 
 #define UPROBE_TRAP_NR	UINT_MAX
diff --git a/lib/Makefile b/lib/Makefile
index ca3f7eb..cf2c5d6 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -129,6 +129,8 @@ obj-$(CONFIG_ZSTD_COMPRESS) += zstd/
 obj-$(CONFIG_ZSTD_DECOMPRESS) += zstd/
 obj-$(CONFIG_XZ_DEC) += xz/
 obj-$(CONFIG_RAID6_PQ) += raid6/
+obj-$(CONFIG_UPROBES) += probes/
+obj-$(CONFIG_KPROBES) += probes/
 
 lib-$(CONFIG_DECOMPRESS_GZIP) += decompress_inflate.o
 lib-$(CONFIG_DECOMPRESS_BZIP2) += decompress_bunzip2.o
diff --git a/lib/probes/Makefile b/lib/probes/Makefile
new file mode 100644
index 0000000..534a2b7
--- /dev/null
+++ b/lib/probes/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_ARM)		+= arm/
diff --git a/lib/probes/arm/Makefile b/lib/probes/arm/Makefile
new file mode 100644
index 0000000..1c97b8f
--- /dev/null
+++ b/lib/probes/arm/Makefile
@@ -0,0 +1,6 @@
+ccflags-y += -I$(srctree)/arch/arm/probes/uprobes/
+obj-$(CONFIG_UPROBES)		+= decode.o decode-arm.o actions-arm.o
+obj-$(CONFIG_KPROBES)		+= decode.o
+ifndef CONFIG_THUMB2_KERNEL
+obj-$(CONFIG_KPROBES)		+= decode-arm.o
+endif
diff --git a/arch/arm/probes/uprobes/actions-arm.c b/lib/probes/arm/actions-arm.c
similarity index 99%
rename from arch/arm/probes/uprobes/actions-arm.c
rename to lib/probes/arm/actions-arm.c
index 76eb449..a25795a 100644
--- a/arch/arm/probes/uprobes/actions-arm.c
+++ b/lib/probes/arm/actions-arm.c
@@ -13,8 +13,8 @@
 #include <linux/uprobes.h>
 #include <linux/module.h>
 
-#include "../decode.h"
-#include "../decode-arm.h"
+#include "decode.h"
+#include "decode-arm.h"
 #include "core.h"
 
 static int uprobes_substitute_pc(unsigned long *pinsn, u32 oregs)
diff --git a/arch/arm/probes/decode-arm.c b/lib/probes/arm/decode-arm.c
similarity index 100%
rename from arch/arm/probes/decode-arm.c
rename to lib/probes/arm/decode-arm.c
diff --git a/arch/arm/probes/decode-arm.h b/lib/probes/arm/decode-arm.h
similarity index 100%
rename from arch/arm/probes/decode-arm.h
rename to lib/probes/arm/decode-arm.h
diff --git a/arch/arm/probes/decode.c b/lib/probes/arm/decode.c
similarity index 100%
rename from arch/arm/probes/decode.c
rename to lib/probes/arm/decode.c
diff --git a/arch/arm/probes/decode.h b/lib/probes/arm/decode.h
similarity index 100%
rename from arch/arm/probes/decode.h
rename to lib/probes/arm/decode.h
-- 
2.7.4

