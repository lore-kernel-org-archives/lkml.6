Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752799AbeDDX7R (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 19:59:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35598 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752630AbeDDX6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 19:58:30 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C0C4760F6B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: arnd@arndb.de, timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] io: change outX() to have their own IO barrier overrides
Date: Wed,  4 Apr 2018 19:58:19 -0400
Message-Id: <1522886301-25955-4-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522886301-25955-1-git-send-email-okaya@codeaurora.org>
References: <1522886301-25955-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Open code writeX() inside outX() so that outX() variants have their own
overrideable Port IO barrier combinations as __io_pbw() and __io_paw() for
actions to be taken before port IO and after port IO write.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 include/asm-generic/io.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index ca268d9..38a96d1 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -456,7 +456,9 @@ static inline u32 inl(unsigned long addr)
 #define outb outb
 static inline void outb(u8 value, unsigned long addr)
 {
-	writeb(value, PCI_IOBASE + addr);
+	__io_pbw();
+	__raw_writeb(value, PCI_IOBASE + addr);
+	__io_paw();
 }
 #endif
 
@@ -464,7 +466,9 @@ static inline void outb(u8 value, unsigned long addr)
 #define outw outw
 static inline void outw(u16 value, unsigned long addr)
 {
-	writew(value, PCI_IOBASE + addr);
+	__io_pbw();
+	__raw_writew(cpu_to_le16(value), PCI_IOBASE + addr);
+	__io_paw();
 }
 #endif
 
@@ -472,7 +476,9 @@ static inline void outw(u16 value, unsigned long addr)
 #define outl outl
 static inline void outl(u32 value, unsigned long addr)
 {
-	writel(value, PCI_IOBASE + addr);
+	__io_pbw();
+	__raw_writel(cpu_to_le32(value), PCI_IOBASE + addr);
+	__io_paw();
 }
 #endif
 
-- 
2.7.4
