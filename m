Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751874AbeDENKF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 09:10:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38356 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751418AbeDENJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 09:09:22 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BEE746076C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: arnd@arndb.de, timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] io: define stronger ordering for the default writeX() implementation
Date: Thu,  5 Apr 2018 09:09:11 -0400
Message-Id: <1522933753-19589-3-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522933753-19589-1-git-send-email-okaya@codeaurora.org>
References: <1522933753-19589-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default implementation of mapping writeX() to __raw_writeX() is wrong.
writeX() has stronger ordering semantics. Compiler is allowed to reorder
memory writes against __raw_writeX().

Use the previously defined __io_aw() and __io_bw() macros to harden
code generation according to architecture support.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 include/asm-generic/io.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index d27e8af..964725e 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -208,7 +208,9 @@ static inline u64 readq(const volatile void __iomem *addr)
 #define writeb writeb
 static inline void writeb(u8 value, volatile void __iomem *addr)
 {
+	__io_bw();
 	__raw_writeb(value, addr);
+	__io_aw();
 }
 #endif
 
@@ -216,7 +218,9 @@ static inline void writeb(u8 value, volatile void __iomem *addr)
 #define writew writew
 static inline void writew(u16 value, volatile void __iomem *addr)
 {
+	__io_bw();
 	__raw_writew(cpu_to_le16(value), addr);
+	__io_aw();
 }
 #endif
 
@@ -224,7 +228,9 @@ static inline void writew(u16 value, volatile void __iomem *addr)
 #define writel writel
 static inline void writel(u32 value, volatile void __iomem *addr)
 {
+	__io_bw();
 	__raw_writel(__cpu_to_le32(value), addr);
+	__io_aw();
 }
 #endif
 
@@ -233,7 +239,9 @@ static inline void writel(u32 value, volatile void __iomem *addr)
 #define writeq writeq
 static inline void writeq(u64 value, volatile void __iomem *addr)
 {
+	__io_bw();
 	__raw_writeq(__cpu_to_le64(value), addr);
+	__io_aw();
 }
 #endif
 #endif /* CONFIG_64BIT */
-- 
2.7.4
