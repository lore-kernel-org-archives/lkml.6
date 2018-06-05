Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752256AbeFERYs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:24:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:32776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751923AbeFERD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:03:56 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.4 04/37] sh: New gcc support
Date: Tue,  5 Jun 2018 19:01:09 +0200
Message-Id: <20180605170109.155041777@linuxfoundation.org>
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

From: Yoshinori Sato <ysato@users.sourceforge.jp>

commit 940d4113f3306e07a1f86541489b686d1a979d54 upstream.

New gcc (4.8 or later) used new shift helper functions.
So we need added new helper to private libgcc.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Rich Felker <dalias@libc.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/sh/kernel/sh_ksyms_32.c |    3 +++
 arch/sh/lib/ashlsi3.S        |   35 ++++++++++++++++++++++++++---------
 arch/sh/lib/ashrsi3.S        |   33 ++++++++++++++++++++++++---------
 arch/sh/lib/lshrsi3.S        |   34 +++++++++++++++++++++++++---------
 4 files changed, 78 insertions(+), 27 deletions(-)

--- a/arch/sh/kernel/sh_ksyms_32.c
+++ b/arch/sh/kernel/sh_ksyms_32.c
@@ -34,6 +34,9 @@ DECLARE_EXPORT(__sdivsi3);
 DECLARE_EXPORT(__lshrsi3);
 DECLARE_EXPORT(__ashrsi3);
 DECLARE_EXPORT(__ashlsi3);
+DECLARE_EXPORT(__lshrsi3_r0);
+DECLARE_EXPORT(__ashrsi3_r0);
+DECLARE_EXPORT(__ashlsi3_r0);
 DECLARE_EXPORT(__ashiftrt_r4_6);
 DECLARE_EXPORT(__ashiftrt_r4_7);
 DECLARE_EXPORT(__ashiftrt_r4_8);
--- a/arch/sh/lib/ashlsi3.S
+++ b/arch/sh/lib/ashlsi3.S
@@ -54,21 +54,38 @@ Boston, MA 02110-1301, USA.  */
 !
 ! (none)
 !
+! __ashlsi3_r0
+!
+! Entry:
+!
+! r4: Value to shift
+! r0: Shifts
+!
+! Exit:
+!
+! r0: Result
+!
+! Destroys:
+!
+! (none)
+
+
 	.global	__ashlsi3
+	.global	__ashlsi3_r0
 	
 	.align	2
 __ashlsi3:
-	mov	#31,r0
-	and	r0,r5
+	mov	r5,r0
+	.align	2
+__ashlsi3_r0:
+	and	#31,r0
+	mov.l	r4,@-r15
+	mov	r0,r4
 	mova	ashlsi3_table,r0
-	mov.b	@(r0,r5),r5
-#ifdef __sh1__
-	add	r5,r0
+	mov.b	@(r0,r4),r4
+	add	r4,r0
 	jmp	@r0
-#else
-	braf	r5
-#endif
-	mov	r4,r0
+	mov.l	@r15+,r0
 
 	.align	2
 ashlsi3_table:
--- a/arch/sh/lib/ashrsi3.S
+++ b/arch/sh/lib/ashrsi3.S
@@ -54,22 +54,37 @@ Boston, MA 02110-1301, USA.  */
 !
 ! (none)
 !
+! __ashrsi3_r0
+!
+! Entry:
+!
+! r4: Value to shift
+! r0: Shifts
+!
+! Exit:
+!
+! r0: Result
+!
+! Destroys:
+!
+! (none)
 
 	.global	__ashrsi3
+	.global	__ashrsi3_r0
 	
 	.align	2
 __ashrsi3:
-	mov	#31,r0
-	and	r0,r5
+	mov	r5,r0
+	.align	2
+__ashrsi3_r0:
+	and	#31,r0
+	mov.l	r4,@-r15
+	mov	r0,r4
 	mova	ashrsi3_table,r0
-	mov.b	@(r0,r5),r5
-#ifdef __sh1__
-	add	r5,r0
+	mov.b	@(r0,r4),r4
+	add	r4,r0
 	jmp	@r0
-#else
-	braf	r5
-#endif
-	mov	r4,r0
+	mov.l	@r15+,r0
 
 	.align	2
 ashrsi3_table:
--- a/arch/sh/lib/lshrsi3.S
+++ b/arch/sh/lib/lshrsi3.S
@@ -54,21 +54,37 @@ Boston, MA 02110-1301, USA.  */
 !
 ! (none)
 !
+! __lshrsi3_r0
+!
+! Entry:
+!
+! r0: Value to shift
+! r5: Shifts
+!
+! Exit:
+!
+! r0: Result
+!
+! Destroys:
+!
+! (none)
+!
 	.global	__lshrsi3
+	.global	__lshrsi3_r0
 	
 	.align	2
 __lshrsi3:
-	mov	#31,r0
-	and	r0,r5
+	mov	r5,r0
+	.align	2
+__lshrsi3_r0:
+	and	#31,r0
+	mov.l	r4,@-r15
+	mov	r0,r4
 	mova	lshrsi3_table,r0
-	mov.b	@(r0,r5),r5
-#ifdef __sh1__
-	add	r5,r0
+	mov.b	@(r0,r4),r4
+	add	r4,r0
 	jmp	@r0
-#else
-	braf	r5
-#endif
-	mov	r4,r0
+	mov.l	@r15+,r0
 
 	.align	2
 lshrsi3_table:
