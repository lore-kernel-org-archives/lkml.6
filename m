Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752683AbeFDMVi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 08:21:38 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54277 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752543AbeFDMVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 08:21:36 -0400
X-Google-Smtp-Source: ADUXVKLqb0X826UAhiDcJGosDI9ddMwP6FzeRa8gVEhKQg0nsWezyskRFtFQPNFf/vDR39oCRSiA9Q==
Date: Mon, 4 Jun 2018 14:21:32 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/asm changes for v4.18
Message-ID: <20180604122132.GA3337@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-asm-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-asm-for-linus

   # HEAD: 6469a0ee0a06b2ea1f5afbb1d5a3feed017d4c7a x86/io: Define readq()/writeq() to use 64-bit type

Two smaller changes:

 - better support (non-atomic) 64-bit readq()/writeq() variants (Andy Shevchenko)

 - __clear_user() micro-optimization (Alexey Dobriyan)

 Thanks,

	Ingo

------------------>
Alexey Dobriyan (1):
      x86/asm/64: Micro-optimize __clear_user() - Use immediate constants

Andy Shevchenko (1):
      x86/io: Define readq()/writeq() to use 64-bit type


 arch/x86/include/asm/io.h  | 8 ++++----
 arch/x86/lib/usercopy_64.c | 9 ++++-----
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index f6e5b9375d8c..6de64840dd22 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -94,10 +94,10 @@ build_mmio_write(__writel, "l", unsigned int, "r", )
 
 #ifdef CONFIG_X86_64
 
-build_mmio_read(readq, "q", unsigned long, "=r", :"memory")
-build_mmio_read(__readq, "q", unsigned long, "=r", )
-build_mmio_write(writeq, "q", unsigned long, "r", :"memory")
-build_mmio_write(__writeq, "q", unsigned long, "r", )
+build_mmio_read(readq, "q", u64, "=r", :"memory")
+build_mmio_read(__readq, "q", u64, "=r", )
+build_mmio_write(writeq, "q", u64, "r", :"memory")
+build_mmio_write(__writeq, "q", u64, "r", )
 
 #define readq_relaxed(a)	__readq(a)
 #define writeq_relaxed(v, a)	__writeq(v, a)
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
