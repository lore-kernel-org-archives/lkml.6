Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753362AbeDBSKt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 14:10:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48990 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753030AbeDBSKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 14:10:47 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 11AED60591
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-mips@vger.kernel.org, timur@codeaurora.org,
        sulrich@codeaurora.org
Cc: arnd@arndb.de, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, Paul Burton <paul.burton@mips.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: io: add a barrier after readX()
Date: Mon,  2 Apr 2018 14:10:32 -0400
Message-Id: <1522692633-24304-1-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While a barrier is present in writeX() function before the register write,
a similar barrier is missing in the readX() function after the register
read. This could allow register accesses following readX() to observe
stale data.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Reported-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/include/asm/io.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 0cbf3af..7f9068d 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -377,6 +377,7 @@ static inline type pfx##read##bwlq(const volatile void __iomem *mem)	\
 		BUG();							\
 	}								\
 									\
+	war_io_reorder_wmb();						\
 	return pfx##ioswab##bwlq(__mem, __val);				\
 }
 
-- 
2.7.4
