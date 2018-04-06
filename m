Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751946AbeDFSDM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 14:03:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50748 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751779AbeDFSCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 14:02:53 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 13861601C4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: arnd@arndb.de, timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] io: change writeX_relaxed() to remove barriers
Date: Fri,  6 Apr 2018 14:02:46 -0400
Message-Id: <1523037766-14518-2-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523037766-14518-1-git-send-email-okaya@codeaurora.org>
References: <1523037766-14518-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we hardened writeX() API in asm-generic version, writeX_relaxed()
API is violating the rules when writeX_relaxed() == writeX() in the default
implementation.

The relaxed API shouldn't have any barriers in it and it doesn't provide
any ordering with respect to the memory transactions. The only requirement
is for writes to be ordered with respect to each other. This is achieved
by the volatile in the __raw_writeX() API.

Open code the relaxed API and remove any barriers in it.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 include/asm-generic/io.h | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index fa0975d..f4a1494 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -284,19 +284,35 @@ static inline u64 readq_relaxed(const volatile void __iomem *addr)
 #endif
 
 #ifndef writeb_relaxed
-#define writeb_relaxed writeb
+#define writeb_relaxed writeb_relaxed
+static inline void writeb_relaxed(u8 value, volatile void __iomem *addr)
+{
+	__raw_writeb(value, addr);
+}
 #endif
 
 #ifndef writew_relaxed
-#define writew_relaxed writew
+#define writew_relaxed writew_relaxed
+static inline void writew_relaxed(u16 value, volatile void __iomem *addr)
+{
+	__raw_writew(cpu_to_le16(value), addr);
+}
 #endif
 
 #ifndef writel_relaxed
-#define writel_relaxed writel
+#define writel_relaxed writel_relaxed
+static inline void writel_relaxed(u32 value, volatile void __iomem *addr)
+{
+	__raw_writel(__cpu_to_le32(value), addr);
+}
 #endif
 
 #if defined(writeq) && !defined(writeq_relaxed)
-#define writeq_relaxed writeq
+#define writeq_relaxed writeq_relaxed
+static inline void writeq_relaxed(u64 value, volatile void __iomem *addr)
+{
+	__raw_writeq(__cpu_to_le64(value), addr);
+}
 #endif
 
 /*
-- 
2.7.4
