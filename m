Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752946AbeEGVjm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 17:39:42 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38789 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752524AbeEGVjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 17:39:41 -0400
X-Google-Smtp-Source: AB8JxZrtp/OFEJ6P1OYDnVr0VvNMtW5vB7bB8QRYGS3wkUpN5KhofQF1qGaLHrkOO8+038YqXDzUag==
Date: Tue, 8 May 2018 00:39:37 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH] x86_64: use immediate constants in __clear_user()
Message-ID: <20180507213937.GB32406@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Save 2 registers. Adding constants should be just as fast as adding
registers.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/x86/lib/usercopy_64.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/arch/x86/lib/usercopy_64.c
+++ b/arch/x86/lib/usercopy_64.c
@@ -23,13 +23,13 @@ unsigned long __clear_user(void __user *addr, unsigned long size)
 	asm volatile(
 		"	testq  %[size8],%[size8]\n"
 		"	jz     4f\n"
-		"0:	movq %[zero],(%[dst])\n"
-		"	addq   %[eight],%[dst]\n"
+		"0:	movq $0,(%[dst])\n"
+		"	addq   $8,%[dst]\n"
 		"	decl %%ecx ; jnz   0b\n"
 		"4:	movq  %[size1],%%rcx\n"
 		"	testl %%ecx,%%ecx\n"
 		"	jz     2f\n"
-		"1:	movb   %b[zero],(%[dst])\n"
+		"1:	movb   $0,(%[dst])\n"
 		"	incq   %[dst]\n"
 		"	decl %%ecx ; jnz  1b\n"
 		"2:\n"
@@ -40,8 +40,7 @@ unsigned long __clear_user(void __user *addr, unsigned long size)
 		_ASM_EXTABLE(0b,3b)
 		_ASM_EXTABLE(1b,2b)
 		: [size8] "=&c"(size), [dst] "=&D" (__d0)
-		: [size1] "r"(size & 7), "[size8]" (size / 8), "[dst]"(addr),
-		  [zero] "r" (0UL), [eight] "r" (8UL));
+		: [size1] "r"(size & 7), "[size8]" (size / 8), "[dst]"(addr));
 	clac();
 	return size;
 }
