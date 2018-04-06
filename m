Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751887AbeDFSC4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 14:02:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50722 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751773AbeDFSCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 14:02:52 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 745AA601C4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: arnd@arndb.de, timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] io: change readX_relaxed() to remove barriers
Date: Fri,  6 Apr 2018 14:02:45 -0400
Message-Id: <1523037766-14518-1-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we hardened readX() API in asm-generic version, readX_relaxed()
API is violating the rules when readX_relaxed() == readX() in the default
implementation.

The relaxed API shouldn't have any barriers in it and it doesn't provide
any ordering with respect to the memory transactions. The only requirement
is for reads to be ordered with respect to each other. This is achieved
by the volatile in the __raw_readX() API.

Open code the relaxed API and remove any barriers in it.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 include/asm-generic/io.h | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 578b688..fa0975d 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -252,19 +252,35 @@ static inline void writeq(u64 value, volatile void __iomem *addr)
  * accesses.
  */
 #ifndef readb_relaxed
-#define readb_relaxed readb
+#define readb_relaxed readb_relaxed
+static inline u8 readb_relaxed(const volatile void __iomem *addr)
+{
+	return __raw_readb(addr);
+}
 #endif
 
 #ifndef readw_relaxed
-#define readw_relaxed readw
+#define readw_relaxed readw_relaxed
+static inline u16 readw_relaxed(const volatile void __iomem *addr)
+{
+	return __le16_to_cpu(__raw_readw(addr));
+}
 #endif
 
 #ifndef readl_relaxed
-#define readl_relaxed readl
+#define readl_relaxed readl_relaxed
+static inline u32 readl_relaxed(const volatile void __iomem *addr)
+{
+	return __le32_to_cpu(__raw_readl(addr));
+}
 #endif
 
 #if defined(readq) && !defined(readq_relaxed)
-#define readq_relaxed readq
+#define readq_relaxed readq_relaxed
+static inline u64 readq_relaxed(const volatile void __iomem *addr)
+{
+	return __le64_to_cpu(__raw_readq(addr));
+}
 #endif
 
 #ifndef writeb_relaxed
-- 
2.7.4
