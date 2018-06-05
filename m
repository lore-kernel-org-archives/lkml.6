Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753154AbeFERXD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:23:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:33274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752938AbeFEREX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:04:23 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Waldemar Brodkorb <wbx@openadk.org>,
        "David S. Miller" <davem@davemloft.net>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.4 35/37] sparc64: Add __multi3 for gcc 7.x and later.
Date: Tue,  5 Jun 2018 19:01:40 +0200
Message-Id: <20180605170110.952281382@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180605170108.884872354@linuxfoundation.org>
References: <20180605170108.884872354@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David S. Miller <davem@davemloft.net>

commit 1b4af13ff2cc6897557bb0b8d9e2fad4fa4d67aa upstream.

Reported-by: Waldemar Brodkorb <wbx@openadk.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/sparc/lib/Makefile |    1 +
 arch/sparc/lib/multi3.S |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

--- a/arch/sparc/lib/Makefile
+++ b/arch/sparc/lib/Makefile
@@ -15,6 +15,7 @@ lib-$(CONFIG_SPARC32) += copy_user.o loc
 lib-$(CONFIG_SPARC64) += atomic_64.o
 lib-$(CONFIG_SPARC32) += lshrdi3.o ashldi3.o
 lib-$(CONFIG_SPARC32) += muldi3.o bitext.o cmpdi2.o
+lib-$(CONFIG_SPARC64) += multi3.o
 
 lib-$(CONFIG_SPARC64) += copy_page.o clear_page.o bzero.o
 lib-$(CONFIG_SPARC64) += csum_copy.o csum_copy_from_user.o csum_copy_to_user.o
--- /dev/null
+++ b/arch/sparc/lib/multi3.S
@@ -0,0 +1,35 @@
+#include <linux/linkage.h>
+#include <asm/export.h>
+
+	.text
+	.align	4
+ENTRY(__multi3) /* %o0 = u, %o1 = v */
+	mov	%o1, %g1
+	srl	%o3, 0, %g4
+	mulx	%g4, %g1, %o1
+	srlx	%g1, 0x20, %g3
+	mulx	%g3, %g4, %g5
+	sllx	%g5, 0x20, %o5
+	srl	%g1, 0, %g4
+	sub	%o1, %o5, %o5
+	srlx	%o5, 0x20, %o5
+	addcc	%g5, %o5, %g5
+	srlx	%o3, 0x20, %o5
+	mulx	%g4, %o5, %g4
+	mulx	%g3, %o5, %o5
+	sethi	%hi(0x80000000), %g3
+	addcc	%g5, %g4, %g5
+	srlx	%g5, 0x20, %g5
+	add	%g3, %g3, %g3
+	movcc	%xcc, %g0, %g3
+	addcc	%o5, %g5, %o5
+	sllx	%g4, 0x20, %g4
+	add	%o1, %g4, %o1
+	add	%o5, %g3, %g2
+	mulx	%g1, %o2, %g1
+	add	%g1, %g2, %g1
+	mulx	%o0, %o3, %o0
+	retl
+	 add	%g1, %o0, %o0
+ENDPROC(__multi3)
+EXPORT_SYMBOL(__multi3)
