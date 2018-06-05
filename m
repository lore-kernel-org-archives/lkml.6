Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752980AbeFERE3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:04:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:33318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752961AbeFERE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:04:26 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anatoly Pugachev <matorola@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.4 36/37] sparc64: Dont clibber fixed registers in __multi4.
Date: Tue,  5 Jun 2018 19:01:41 +0200
Message-Id: <20180605170111.001955813@linuxfoundation.org>
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

commit 79db795833bf5c3e798bcd7a5aeeee3fb0505927 upstream.

%g4 and %g5 are fixed registers used by the kernel for the thread
pointer and the per-cpu offset.  Use %o4 and %g7 instead.

Diagnosis by Anthony Yznaga.

Fixes: 1b4af13ff2cc ("sparc64: Add __multi3 for gcc 7.x and later.")
Reported-by: Anatoly Pugachev <matorola@gmail.com>
Tested-by: Anatoly Pugachev <matorola@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/sparc/lib/multi3.S |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- a/arch/sparc/lib/multi3.S
+++ b/arch/sparc/lib/multi3.S
@@ -5,26 +5,26 @@
 	.align	4
 ENTRY(__multi3) /* %o0 = u, %o1 = v */
 	mov	%o1, %g1
-	srl	%o3, 0, %g4
-	mulx	%g4, %g1, %o1
+	srl	%o3, 0, %o4
+	mulx	%o4, %g1, %o1
 	srlx	%g1, 0x20, %g3
-	mulx	%g3, %g4, %g5
-	sllx	%g5, 0x20, %o5
-	srl	%g1, 0, %g4
+	mulx	%g3, %o4, %g7
+	sllx	%g7, 0x20, %o5
+	srl	%g1, 0, %o4
 	sub	%o1, %o5, %o5
 	srlx	%o5, 0x20, %o5
-	addcc	%g5, %o5, %g5
+	addcc	%g7, %o5, %g7
 	srlx	%o3, 0x20, %o5
-	mulx	%g4, %o5, %g4
+	mulx	%o4, %o5, %o4
 	mulx	%g3, %o5, %o5
 	sethi	%hi(0x80000000), %g3
-	addcc	%g5, %g4, %g5
-	srlx	%g5, 0x20, %g5
+	addcc	%g7, %o4, %g7
+	srlx	%g7, 0x20, %g7
 	add	%g3, %g3, %g3
 	movcc	%xcc, %g0, %g3
-	addcc	%o5, %g5, %o5
-	sllx	%g4, 0x20, %g4
-	add	%o1, %g4, %o1
+	addcc	%o5, %g7, %o5
+	sllx	%o4, 0x20, %o4
+	add	%o1, %o4, %o1
 	add	%o5, %g3, %g2
 	mulx	%g1, %o2, %g1
 	add	%g1, %g2, %g1
