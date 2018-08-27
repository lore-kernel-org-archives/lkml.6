Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34BAC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD43A208D8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JoYpMQeD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD43A208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbeH0OtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 10:49:17 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46508 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbeH0OtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 10:49:16 -0400
Received: by mail-ed1-f67.google.com with SMTP id k14-v6so3775493edr.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 04:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RBWagJrS8izqpWfSj/uAIGFEJFmec204/M/NCMHphvQ=;
        b=JoYpMQeDGKZ1zPIb0BMTotGaKg0SeZ72J+k3jcjwarBgImQcQVqOO6lafaAInE26Jb
         K3luZE7h/FLn/GR8AopVaDIhhpcGxZUvQRhxg6UR/95nwjim2/Ll8c9PGqeQz54smymW
         2+v2iqer31zdShwwuAKCTtkmD7B45t1uZowzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RBWagJrS8izqpWfSj/uAIGFEJFmec204/M/NCMHphvQ=;
        b=Rj/U9jjWxqLJpHUOqH5ifLClFU/5srORysz4dphlwnfM5/XHowPl4/oyC8BMde0rW6
         6ETQY/yD/C2LcGC345jH1G4glqeashjjdFLYneRpbenpGtQzs5dI6U/rcYuA2bDOb4ly
         VmBn31bFS1yATtX2lfKFsWSQ4OYHFEp+bb4jpdQEgbAvTPt5+Kilvrg2540LHSVawk26
         UghQ+7hlAbd4L6zONgkRPKrhlmSWPR/mKObmg+9LokiO5kMKcwNURQW98QoLZ8DGhriK
         MouXuIY83Dtprq1kBMgHWLkkDGe/7DrQXjHMtB7e79VBqTjkxphNOTZfMs+nekuu01P3
         19Bw==
X-Gm-Message-State: APzg51AC177Uqldw0Jj09Z7sQQSL6yXo0PxLsmoIyaJs68w59wPp3hU4
        Z8jSnA+r4hftVTAghNuwxYmoWQ==
X-Google-Smtp-Source: ANB0VdZ8biaPTWv8M/yLq9HTb+Wu9LRY8RkOyG+W4lu040cGjccHqpmmNhIbm67C2hefIOD82IrTxQ==
X-Received: by 2002:a50:8386:: with SMTP id 6-v6mr16195527edi.170.1535367783703;
        Mon, 27 Aug 2018 04:03:03 -0700 (PDT)
Received: from rev02.home ([2a02:a212:9283:9800:24b9:e2d6:9acc:50dd])
        by smtp.gmail.com with ESMTPSA id r2-v6sm3114344eda.89.2018.08.27.04.03.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 04:03:02 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org
Cc:     will.deacon@arm.com, catalin.marinas@arm.com,
        herbert@gondor.apana.org.au, ebiggers@google.com,
        suzuki.poulose@arm.com, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 3/4] arm64/lib: add accelerated crc32 routines
Date:   Mon, 27 Aug 2018 13:02:44 +0200
Message-Id: <20180827110245.14812-4-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180827110245.14812-1-ard.biesheuvel@linaro.org>
References: <20180827110245.14812-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike crc32c(), which is wired up to the crypto API internally so the
optimal driver is selected based on the platform's capabilities,
crc32_le() is implemented as a library function using a slice-by-8 table
based C implementation. Even though few of the call sites may be
bottlenecks, calling a time variant implementation with a non-negligible
D-cache footprint is a bit of a waste, given that ARMv8.1 and up mandates
support for the CRC32 instructions that were optional in ARMv8.0, but are
already widely available, even on the Cortex-A53 based Raspberry Pi.

So implement routines that use these instructions if available, and fall
back to the existing generic routines otherwise. The selection is based
on alternatives patching.

Note that this unconditionally selects CONFIG_CRC32 as a builtin. Since
CRC32 is relied upon by core functionality such as CONFIG_OF_FLATTREE,
this just codifies the status quo.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/Kconfig      |  1 +
 arch/arm64/lib/Makefile |  2 +
 arch/arm64/lib/crc32.S  | 60 ++++++++++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 29e75b47becd..0625355f12fa 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -75,6 +75,7 @@ config ARM64
 	select CLONE_BACKWARDS
 	select COMMON_CLK
 	select CPU_PM if (SUSPEND || CPU_IDLE)
+	select CRC32
 	select DCACHE_WORD_ACCESS
 	select DMA_DIRECT_OPS
 	select EDAC_SUPPORT
diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index 68755fd70dcf..f28f91fd96a2 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -25,3 +25,5 @@ KCOV_INSTRUMENT_atomic_ll_sc.o	:= n
 UBSAN_SANITIZE_atomic_ll_sc.o	:= n
 
 lib-$(CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE) += uaccess_flushcache.o
+
+obj-$(CONFIG_CRC32) += crc32.o
diff --git a/arch/arm64/lib/crc32.S b/arch/arm64/lib/crc32.S
new file mode 100644
index 000000000000..5bc1e85b4e1c
--- /dev/null
+++ b/arch/arm64/lib/crc32.S
@@ -0,0 +1,60 @@
+/*
+ * Accelerated CRC32(C) using AArch64 CRC instructions
+ *
+ * Copyright (C) 2016 - 2018 Linaro Ltd <ard.biesheuvel@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/linkage.h>
+#include <asm/alternative.h>
+#include <asm/assembler.h>
+
+	.cpu		generic+crc
+
+	.macro		__crc32, c
+0:	subs		x2, x2, #16
+	b.mi		8f
+	ldp		x3, x4, [x1], #16
+CPU_BE(	rev		x3, x3		)
+CPU_BE(	rev		x4, x4		)
+	crc32\c\()x	w0, w0, x3
+	crc32\c\()x	w0, w0, x4
+	b.ne		0b
+	ret
+
+8:	tbz		x2, #3, 4f
+	ldr		x3, [x1], #8
+CPU_BE(	rev		x3, x3		)
+	crc32\c\()x	w0, w0, x3
+4:	tbz		x2, #2, 2f
+	ldr		w3, [x1], #4
+CPU_BE(	rev		w3, w3		)
+	crc32\c\()w	w0, w0, w3
+2:	tbz		x2, #1, 1f
+	ldrh		w3, [x1], #2
+CPU_BE(	rev16		w3, w3		)
+	crc32\c\()h	w0, w0, w3
+1:	tbz		x2, #0, 0f
+	ldrb		w3, [x1]
+	crc32\c\()b	w0, w0, w3
+0:	ret
+	.endm
+
+	.align		5
+ENTRY(crc32_le)
+alternative_if_not ARM64_HAS_CRC32
+	b		crc32_le_base
+alternative_else_nop_endif
+	__crc32
+ENDPROC(crc32_le)
+
+	.align		5
+ENTRY(__crc32c_le)
+alternative_if_not ARM64_HAS_CRC32
+	b		__crc32c_le_base
+alternative_else_nop_endif
+	__crc32		c
+ENDPROC(__crc32c_le)
-- 
2.18.0

