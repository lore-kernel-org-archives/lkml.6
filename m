Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753254AbeDMCaz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 22:30:55 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48936 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752584AbeDMCax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 22:30:53 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 10B7960F8D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-mips@linux-mips.org, arnd@arndb.de, timur@codeaurora.org,
        sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, Paul Burton <paul.burton@mips.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] MIPS: io: prevent compiler reordering on the default writeX() implementation
Date: Thu, 12 Apr 2018 22:30:43 -0400
Message-Id: <1523586646-19630-1-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

writeX() has a strong ordering semantics with respect to memory updates.
In the abscence of a write barrier or a compiler barrier, commpiler can
reorder register and memory update instructions. This breaks the writeX()
API.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 arch/mips/include/asm/io.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 0cbf3af..fd00ddaf 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -307,7 +307,7 @@ static inline void iounmap(const volatile void __iomem *addr)
 #if defined(CONFIG_CPU_CAVIUM_OCTEON) || defined(CONFIG_LOONGSON3_ENHANCEMENT)
 #define war_io_reorder_wmb()		wmb()
 #else
-#define war_io_reorder_wmb()		do { } while (0)
+#define war_io_reorder_wmb()		barrier()
 #endif
 
 #define __BUILD_MEMORY_SINGLE(pfx, bwlq, type, irq)			\
-- 
2.7.4
