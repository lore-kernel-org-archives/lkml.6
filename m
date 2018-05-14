Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753629AbeENMxP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:53:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57279 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752142AbeENMxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:53:13 -0400
Date: Mon, 14 May 2018 05:52:50 -0700
From: tip-bot for Alexey Dobriyan <tipbot@zytor.com>
Message-ID: <tip-1153933703d927b3d4874c0bc801de32b1b58be9@git.kernel.org>
Cc: tglx@linutronix.de, mingo@kernel.org, torvalds@linux-foundation.org,
        hpa@zytor.com, adobriyan@gmail.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, peterz@infradead.org,
        adobriyan@gmail.com, hpa@zytor.com, torvalds@linux-foundation.org,
        mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <20180507213937.GB32406@avx2>
References: <20180507213937.GB32406@avx2>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/asm] x86/asm/64: Micro-optimize __clear_user() - Use
 immediate constants
Git-Commit-ID: 1153933703d927b3d4874c0bc801de32b1b58be9
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  1153933703d927b3d4874c0bc801de32b1b58be9
Gitweb:     https://git.kernel.org/tip/1153933703d927b3d4874c0bc801de32b1b58be9
Author:     Alexey Dobriyan <adobriyan@gmail.com>
AuthorDate: Tue, 8 May 2018 00:39:37 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 14 May 2018 11:38:51 +0200

x86/asm/64: Micro-optimize __clear_user() - Use immediate constants

Save two registers. Adding constants should be just as fast as adding registers.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180507213937.GB32406@avx2
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/lib/usercopy_64.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
index 75d3776123cc..a624dcc4de10 100644
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
