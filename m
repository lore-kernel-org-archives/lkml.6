Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751338AbeBTWAW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 17:00:22 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:59783 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750998AbeBTWAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 17:00:19 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Nicolas Pitre <nico@linaro.org>
Cc: Andi Kleen <ak@linux.intel.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4/7] ARM: io-acorn: fix LTO linking without CONFIG_PRINTK
Date: Tue, 20 Feb 2018 22:59:51 +0100
Message-Id: <20180220215954.4092811-5-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180220215954.4092811-1-arnd@arndb.de>
References: <20180220215954.4092811-1-arnd@arndb.de>
X-Provags-ID: V03:K0:VK74VWQafS8rBr+c73a7bMHPRD+K+N8l6MVxQy43ZaVr0X2zlpp
 dfoLBNc6r66TvFAIBmxZWh7yAxShcxXdxFYkEy7Ts2nbXH6w+/HEqOfwbXSzHLygsnwUbvS
 avD5Cazvb6i75IYc43RZt63T1T3Xr3wjvnqgLGebRxeYMIn4Fl24iCNEyHUBeGpu3kt4cw+
 FuXqDUtdBpsj4p/gtAGcA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sPxTnOdUPr4=:FOBnhRX7YAOaJ4JmekCDuO
 lydEFyBTYbqKqcM1kFzfQmAC0FUx03pqpapAr+KozWxx4fm4D0nsgWTNtqVEZBI0n9o3BSorO
 rKtG9ErzwWb4jtmHIrKj0w7i9GJX1RWys0cGB8xWE409c998wXXAmOKdTyIfucW102htjcCoO
 /m20IVoDBvBKDrTi8ZKCk3x91MuhZLAMPgMCKhw3D0o2KWWFvlQ7BttYq9WXbglL8Vxt0297p
 BRPh66KvTqXkurGUvnoFvma9mhSr5msb8051c6vuaHQ/1WlsJ7fUdR/bhGKb+91j/W/ppB+1h
 eHDJMFgyV6hFGF9nHaE4102mYNFbxk9R/Tyz6iOjIx+wBr0J/2r/Ak2UPE0zExyAru1gsYEph
 qmMIA3bdqzsKTxqwnDln2TYQYB4U9rS2NgscR99Qwbm9ISILZUgmIU+MJJR1reXSF5DA9ZgKy
 5rI1Edq0QmZy+0y78fFhke31yLGd/xCeD9RcLLxdAgw9Fkwu1NKYprCjMz81ApvI/yN+0HJ9I
 rnQBXeDdAPNMfJ14YoBwl0Cx//dbcyueQsoSW2jsjhlHCaALVDcVSOJELIVVYziO9VJ8R6tfe
 VU+04D97PErdEhhEXybCSMJ3V8Tj/AVp4F6iLroxNYXplL5Db0Zez/iXOIksk4iEJsYwAN6x4
 Sq0BPS5yJYsq2JQ+Ef7wE0gKCzGKmjh5JQf0fIjrha5073CcP5w/C48ApmaBMAIfIcaQXEhT1
 qGUoyg+ZM4bBlKlBXOcTpqGz62BEpY1SUKtRUpA9FObz0iZrbMIopDzg5AtpQtj+ltY1New3M
 DtIN8JH9JvVlVY8br5LaJlklcphEYpRje6m8oIjz920AMqbe0rlTm1iCVH3lFEIp+qJvv9wA2
 aj3l3Tz9JY5ea3Fad+dnPfqBKcer+ZjMij2C9DtsOZS2FdtJVITcxKAsvkbZk9
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_LTO is enabled, we get a link error for this file
that contains a reference to printk():

arch/arm/lib/io-acorn.o: In function `outsl':
(.text+0x38): undefined reference to `printk'

Normally the file is simply dropped, but that doesn't happen
with LTO. Making the reference conditional helps, but perhaps
a better fix would be to make sure the LTO linker drops the
entire file in the same way that we normally do.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/lib/io-acorn.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/lib/io-acorn.S b/arch/arm/lib/io-acorn.S
index 69719bad674d..3522a899460b 100644
--- a/arch/arm/lib/io-acorn.S
+++ b/arch/arm/lib/io-acorn.S
@@ -27,6 +27,10 @@
  */
 ENTRY(insl)
 ENTRY(outsl)
+#ifdef CONFIG_PRINTK
 		adr	r0, .Liosl_warning
 		mov	r1, lr
 		b	printk
+#else
+		ret	lr
+#endif
-- 
2.9.0
