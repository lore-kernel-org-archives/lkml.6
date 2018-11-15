Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5C4C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 05:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ADB72087E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 05:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WxwDcLSF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ADB72087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbeKOP7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 10:59:08 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:32989 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbeKOP7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 10:59:07 -0500
Received: by mail-yb1-f196.google.com with SMTP id i78-v6so7939967ybg.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 21:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BhVPs0/6RkCK6rd2OYDrSNPF0bSzTb9H/aaLYLX1Jv0=;
        b=WxwDcLSFuqY21hY7SAVmE9m6wvTPTpkujhMeYjGRCOsM8vBVn7VNbQhMOv/QDzYTtl
         F+Bwmu9H+GHc6kw9TrduFZrE2xvJSovmSS6M5wRhMgARpNzJ63q4ktuq2QT2RCVJfa9b
         q/RXBcooI4IvUtNJAV0WNKl7o9lo4kDsyCQSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BhVPs0/6RkCK6rd2OYDrSNPF0bSzTb9H/aaLYLX1Jv0=;
        b=S6+egHTAbeZ/m57rdjzkS/7ILdUAFrSJvdQf0C8s1L1VuzJZhTGLHzgEjE0xWn4iMi
         7mh4Aru1t4b3f9Zq+Sr2QEMPHiTf5VeIetAjuC68gN4UxF+XNOiRDx3n3izbRw5wBise
         cY9dEl6OI28g/GpDU+iiKCQalwTImqZvJZzsyIA2JgMxTQosVc+gQZzocGI0G7imtcEQ
         vXK3qbsnNtYrebDs1Z82uMUC6ok9weFvjGAelHYMZUitSFN9fBGs5pvtCW8b31VPOYEz
         nSNk871yEhCYJj/G00KaYJ5mfjeo8q7JFoNh7NM7e3EFhLYOXzNIAVyKbUi5pnDe2S7T
         pssA==
X-Gm-Message-State: AGRZ1gJnUicqGnn7x3rK9T0iLjlz5guRmLTLyfuEE0iE8g5BDAiQwwij
        HnaaFvYKAPGUp3FsITX/Civ9dg==
X-Google-Smtp-Source: AJdET5deiDqOxZe4N/79xPi6cOjAlTm6UK+usVXvOGy9hhV6IwkpdH+U1g5XKUAcgLVN2n2bt4iyKg==
X-Received: by 2002:a25:cf04:: with SMTP id f4-v6mr4496008ybg.261.1542261161782;
        Wed, 14 Nov 2018 21:52:41 -0800 (PST)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id 1-v6sm6680791ywm.3.2018.11.14.21.52.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 21:52:41 -0800 (PST)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc:     prudo@linux.ibm.com, ard.biesheuvel@linaro.org,
        james.morse@arm.com, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v16 07/16] arm64: add image head flag definitions
Date:   Thu, 15 Nov 2018 14:52:46 +0900
Message-Id: <20181115055254.2812-8-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181115055254.2812-1-takahiro.akashi@linaro.org>
References: <20181115055254.2812-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those image head's flags will be used later by kexec_file loader.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Acked-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/image.h | 59 ++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/head.S       |  3 +-
 arch/arm64/kernel/image.h      | 21 +++++++-----
 3 files changed, 74 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm64/include/asm/image.h

diff --git a/arch/arm64/include/asm/image.h b/arch/arm64/include/asm/image.h
new file mode 100644
index 000000000000..e2c27a2278e9
--- /dev/null
+++ b/arch/arm64/include/asm/image.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_IMAGE_H
+#define __ASM_IMAGE_H
+
+#define ARM64_IMAGE_MAGIC	"ARM\x64"
+
+#define ARM64_IMAGE_FLAG_BE_SHIFT		0
+#define ARM64_IMAGE_FLAG_PAGE_SIZE_SHIFT	(ARM64_IMAGE_FLAG_BE_SHIFT + 1)
+#define ARM64_IMAGE_FLAG_PHYS_BASE_SHIFT \
+					(ARM64_IMAGE_FLAG_PAGE_SIZE_SHIFT + 2)
+#define ARM64_IMAGE_FLAG_BE_MASK		0x1
+#define ARM64_IMAGE_FLAG_PAGE_SIZE_MASK		0x3
+#define ARM64_IMAGE_FLAG_PHYS_BASE_MASK		0x1
+
+#define ARM64_IMAGE_FLAG_LE			0
+#define ARM64_IMAGE_FLAG_BE			1
+#define ARM64_IMAGE_FLAG_PAGE_SIZE_4K		1
+#define ARM64_IMAGE_FLAG_PAGE_SIZE_16K		2
+#define ARM64_IMAGE_FLAG_PAGE_SIZE_64K		3
+#define ARM64_IMAGE_FLAG_PHYS_BASE		1
+
+#ifndef __ASSEMBLY__
+
+#define arm64_image_flag_field(flags, field) \
+				(((flags) >> field##_SHIFT) & field##_MASK)
+
+/*
+ * struct arm64_image_header - arm64 kernel image header
+ * See Documentation/arm64/booting.txt for details
+ *
+ * @code0:		Executable code, or
+ *   @mz_header		  alternatively used for part of MZ header
+ * @code1:		Executable code
+ * @text_offset:	Image load offset
+ * @image_size:		Effective Image size
+ * @flags:		kernel flags
+ * @reserved:		reserved
+ * @magic:		Magic number
+ * @reserved5:		reserved, or
+ *   @pe_header:	  alternatively used for PE COFF offset
+ */
+
+struct arm64_image_header {
+	__le32 code0;
+	__le32 code1;
+	__le64 text_offset;
+	__le64 image_size;
+	__le64 flags;
+	__le64 res2;
+	__le64 res3;
+	__le64 res4;
+	__le32 magic;
+	__le32 res5;
+};
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __ASM_IMAGE_H */
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 4471f570a295..4d0b78c95c34 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -31,6 +31,7 @@
 #include <asm/cache.h>
 #include <asm/cputype.h>
 #include <asm/elf.h>
+#include <asm/image.h>
 #include <asm/kernel-pgtable.h>
 #include <asm/kvm_arm.h>
 #include <asm/memory.h>
@@ -91,7 +92,7 @@ _head:
 	.quad	0				// reserved
 	.quad	0				// reserved
 	.quad	0				// reserved
-	.ascii	"ARM\x64"			// Magic number
+	.ascii	ARM64_IMAGE_MAGIC		// Magic number
 #ifdef CONFIG_EFI
 	.long	pe_header - _head		// Offset to the PE header.
 
diff --git a/arch/arm64/kernel/image.h b/arch/arm64/kernel/image.h
index a820ed07fb80..d843f9cbcd92 100644
--- a/arch/arm64/kernel/image.h
+++ b/arch/arm64/kernel/image.h
@@ -15,13 +15,15 @@
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
-#ifndef __ASM_IMAGE_H
-#define __ASM_IMAGE_H
+#ifndef __ARM64_KERNEL_IMAGE_H
+#define __ARM64_KERNEL_IMAGE_H
 
 #ifndef LINKER_SCRIPT
 #error This file should only be included in vmlinux.lds.S
 #endif
 
+#include <asm/image.h>
+
 /*
  * There aren't any ELF relocations we can use to endian-swap values known only
  * at link time (e.g. the subtraction of two symbol addresses), so we must get
@@ -47,19 +49,22 @@
 	sym##_lo32 = DATA_LE32((data) & 0xffffffff);		\
 	sym##_hi32 = DATA_LE32((data) >> 32)
 
+#define __HEAD_FLAG(field)	(__HEAD_FLAG_##field << \
+					ARM64_IMAGE_FLAG_##field##_SHIFT)
+
 #ifdef CONFIG_CPU_BIG_ENDIAN
-#define __HEAD_FLAG_BE		1
+#define __HEAD_FLAG_BE		ARM64_IMAGE_FLAG_BE
 #else
-#define __HEAD_FLAG_BE		0
+#define __HEAD_FLAG_BE		ARM64_IMAGE_FLAG_LE
 #endif
 
 #define __HEAD_FLAG_PAGE_SIZE	((PAGE_SHIFT - 10) / 2)
 
 #define __HEAD_FLAG_PHYS_BASE	1
 
-#define __HEAD_FLAGS		((__HEAD_FLAG_BE << 0) |	\
-				 (__HEAD_FLAG_PAGE_SIZE << 1) |	\
-				 (__HEAD_FLAG_PHYS_BASE << 3))
+#define __HEAD_FLAGS		(__HEAD_FLAG(BE)	| \
+				 __HEAD_FLAG(PAGE_SIZE) | \
+				 __HEAD_FLAG(PHYS_BASE))
 
 /*
  * These will output as part of the Image header, which should be little-endian
@@ -119,4 +124,4 @@ __efistub_screen_info		= KALLSYMS_HIDE(screen_info);
 
 #endif
 
-#endif /* __ASM_IMAGE_H */
+#endif /* __ARM64_KERNEL_IMAGE_H */
-- 
2.19.0

