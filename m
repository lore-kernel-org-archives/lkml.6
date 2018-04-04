Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752495AbeDDX7S (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 19:59:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35512 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752484AbeDDX62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 19:58:28 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3D2D660F5F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: arnd@arndb.de, timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] io: define stronger ordering for the default readX() implementation
Date: Wed,  4 Apr 2018 19:58:17 -0400
Message-Id: <1522886301-25955-2-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522886301-25955-1-git-send-email-okaya@codeaurora.org>
References: <1522886301-25955-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default implementation of mapping readX() to __raw_readX() is wrong.
readX() has stronger ordering semantics. Compiler is allowed to reorder
__raw_readX() against the memory accesses following register read.

Use the previously defined __io_ar() and __io_br() macros to harden
code generation according to architecture support.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 include/asm-generic/io.h | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index a3d349e..fc554af 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -153,7 +153,12 @@ static inline void __raw_writeq(u64 value, volatile void __iomem *addr)
 #define readb readb
 static inline u8 readb(const volatile void __iomem *addr)
 {
-	return __raw_readb(addr);
+	u8 val;
+
+	__io_br();
+	val = __raw_readb(addr);
+	__io_ar();
+	return val;
 }
 #endif
 
@@ -161,7 +166,12 @@ static inline u8 readb(const volatile void __iomem *addr)
 #define readw readw
 static inline u16 readw(const volatile void __iomem *addr)
 {
-	return __le16_to_cpu(__raw_readw(addr));
+	u16 val;
+
+	__io_br();
+	val = __le16_to_cpu(__raw_readw(addr));
+	__io_ar();
+	return val;
 }
 #endif
 
@@ -169,7 +179,12 @@ static inline u16 readw(const volatile void __iomem *addr)
 #define readl readl
 static inline u32 readl(const volatile void __iomem *addr)
 {
-	return __le32_to_cpu(__raw_readl(addr));
+	u32 val;
+
+	__io_br();
+	val = __le32_to_cpu(__raw_readl(addr));
+	__io_ar();
+	return val;
 }
 #endif
 
@@ -178,7 +193,12 @@ static inline u32 readl(const volatile void __iomem *addr)
 #define readq readq
 static inline u64 readq(const volatile void __iomem *addr)
 {
-	return __le64_to_cpu(__raw_readq(addr));
+	u64 val;
+
+	__io_br();
+	val = __le64_to_cpu(__raw_readq(addr));
+	__io_ar();
+	return val;
 }
 #endif
 #endif /* CONFIG_64BIT */
-- 
2.7.4
