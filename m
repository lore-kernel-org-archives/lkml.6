Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5925C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FEC8208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:46:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FEC8208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbeH0Xe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:34:57 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:34837 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbeH0Xdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:33:46 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0M8hqV-1fi3bX47Bj-00wH5E; Mon, 27 Aug 2018 21:45:37 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     tglx@linutronix.de
Cc:     y2038@lists.linaro.org, linux-api@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, deepa.kernel@gmail.com,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 04/14] y2038: Remove newstat family from default syscall set
Date:   Mon, 27 Aug 2018 21:45:21 +0200
Message-Id: <20180827194531.3796559-5-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180827194531.3796559-1-arnd@arndb.de>
References: <20180827194531.3796559-1-arnd@arndb.de>
X-Provags-ID: V03:K1:1gDZLuElI0G1LKlTL6RoBPSZxFQDRriwbmpfMjfc1KIcskoHnj3
 DGnRdrV0TlSPFQNl7Hmma2IKjo5OwExBnFBBUChYG4uMaNs8j4j+DJd8N59T5dcAN1Ulp2X
 nG/TmYQVpadR1zp2uVitOL61GfR8d+OyReQ/4vfOW9wanJaI+4tEjQcNQJQ263/gwrqLXiT
 XdbYABIlj1feKUxJ2Qo9g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oWD6c3hCnlk=:XVxT1XYXy9Sat1zup0e8P+
 stT+Xf0gtJ/aQvym5PaelvLjftQItx5tw8sNJdkiVUiJXv1yn4sdD7INndk2VpaofeiLb4Hms
 AGBoIexeFsK00XQJPtj6CPOIMXcDkmiDse2X8hK48+I/DDvutEbS/5Lv12xDmGQPN/GBi1q8H
 +pMvah1veKruu8+Q7Jmf2LquanfH3IRRpW4eYwNXIF3lipQzuEMF8cUvFH8iDk49L6iYUXsj7
 o8dUBlzoAZR1xMveFhRAf5Riuq7I6zAJOgVVhDMd5mKc33KRHVw8AiuYFNvz12an7Btqcl04q
 aegPOYGghNgHgblhwpecUhwWX7mAjLAZ7NBmGYIxFRlRK1aSRTRa4ccgTOk2vlcedPzGFnHym
 gTuk0j3dHUqjLOSmEM0Y3Ihs47Ml92PvxQrS9j9cdOt2QifRIVHCyNeBrdRw/cp/1nJIU99I5
 8ESxYal34ofuzZUC0xOw4ZerwHdr1pXWC6Voh8GI1uCbsoZbQ2odVnVoQgEtIyIJRDVaVIcap
 TLBaJz5mLALvA3bihADQbR7ea9K+JLVDDnmiBaoeXpVcTLlv+0h1eQkdgdsPvlsEEB9krPmy+
 xXmemzuBkZihMPaP6dDyhQBppJm3Qhn0gvqZfcY718anRxe2lFJwvu1baeme6KzaWiyMW8FBL
 7oSsNRINgHe5Syx6upMbMl2RSMa77ek9JnkYJn+I6rtZ3Wbd6FTWxT8PM4Se3+eQTrr4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have four generations of stat() syscalls:
- the oldstat syscalls that are only used on the older architectures
- the newstat family that is used on all 64-bit architectures but
  lacked support for large files on 32-bit architectures.
- the stat64 family that is used mostly on 32-bit architectures to
  replace newstat
- statx() to replace all of the above, adding 64-bit timestamps among
  other things.

We already compile stat64 only on those architectures that need it,
but newstat is always built, including on those that don't reference
it. This adds a new __ARCH_WANT_NEW_STAT symbol along the lines of
__ARCH_WANT_OLD_STAT and __ARCH_WANT_STAT64 to control compilation of
newstat. All architectures that need it use an explict define, the
others now get a little bit smaller, and future architecture (including
64-bit targets) won't ever see it.

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/include/asm/unistd.h      | 1 +
 arch/arm/include/asm/unistd.h        | 1 +
 arch/arm64/include/uapi/asm/unistd.h | 1 +
 arch/ia64/include/asm/unistd.h       | 2 ++
 arch/m68k/include/asm/unistd.h       | 1 +
 arch/microblaze/include/asm/unistd.h | 1 +
 arch/mips/include/asm/unistd.h       | 1 +
 arch/parisc/include/asm/unistd.h     | 1 +
 arch/powerpc/include/asm/unistd.h    | 1 +
 arch/s390/include/asm/unistd.h       | 1 +
 arch/sh/include/asm/unistd.h         | 1 +
 arch/sparc/include/asm/unistd.h      | 1 +
 arch/x86/include/asm/unistd.h        | 1 +
 arch/xtensa/include/asm/unistd.h     | 1 +
 fs/stat.c                            | 3 +++
 15 files changed, 18 insertions(+)

diff --git a/arch/alpha/include/asm/unistd.h b/arch/alpha/include/asm/unistd.h
index d6e29a1de4cc..edc090470023 100644
--- a/arch/alpha/include/asm/unistd.h
+++ b/arch/alpha/include/asm/unistd.h
@@ -6,6 +6,7 @@
 
 #define NR_SYSCALLS			523
 
+#define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_GETHOSTNAME
diff --git a/arch/arm/include/asm/unistd.h b/arch/arm/include/asm/unistd.h
index 076090d2dbf5..07e58010d597 100644
--- a/arch/arm/include/asm/unistd.h
+++ b/arch/arm/include/asm/unistd.h
@@ -16,6 +16,7 @@
 #include <uapi/asm/unistd.h>
 #include <asm/unistd-nr.h>
 
+#define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_GETHOSTNAME
 #define __ARCH_WANT_SYS_PAUSE
diff --git a/arch/arm64/include/uapi/asm/unistd.h b/arch/arm64/include/uapi/asm/unistd.h
index 5072cbd15c82..dae1584cf017 100644
--- a/arch/arm64/include/uapi/asm/unistd.h
+++ b/arch/arm64/include/uapi/asm/unistd.h
@@ -16,5 +16,6 @@
  */
 
 #define __ARCH_WANT_RENAMEAT
+#define __ARCH_WANT_NEW_STAT
 
 #include <asm-generic/unistd.h>
diff --git a/arch/ia64/include/asm/unistd.h b/arch/ia64/include/asm/unistd.h
index ffb705dc9c13..c5b2620c4a4c 100644
--- a/arch/ia64/include/asm/unistd.h
+++ b/arch/ia64/include/asm/unistd.h
@@ -28,6 +28,8 @@
 #define __IGNORE_vfork		/* clone() */
 #define __IGNORE_umount2	/* umount() */
 
+#define __ARCH_WANT_NEW_STAT
+
 #if !defined(__ASSEMBLY__) && !defined(ASSEMBLER)
 
 #include <linux/types.h>
diff --git a/arch/m68k/include/asm/unistd.h b/arch/m68k/include/asm/unistd.h
index 30d0d3fbd4ef..db22cdadc38a 100644
--- a/arch/m68k/include/asm/unistd.h
+++ b/arch/m68k/include/asm/unistd.h
@@ -7,6 +7,7 @@
 
 #define NR_syscalls		380
 
+#define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_OLD_STAT
 #define __ARCH_WANT_STAT64
diff --git a/arch/microblaze/include/asm/unistd.h b/arch/microblaze/include/asm/unistd.h
index a62d09420a47..a28dc770c9b2 100644
--- a/arch/microblaze/include/asm/unistd.h
+++ b/arch/microblaze/include/asm/unistd.h
@@ -15,6 +15,7 @@
 
 /* #define __ARCH_WANT_OLD_READDIR */
 /* #define __ARCH_WANT_OLD_STAT */
+#define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_ALARM
 #define __ARCH_WANT_SYS_GETHOSTNAME
diff --git a/arch/mips/include/asm/unistd.h b/arch/mips/include/asm/unistd.h
index 3c09450908aa..d7878b3e16d8 100644
--- a/arch/mips/include/asm/unistd.h
+++ b/arch/mips/include/asm/unistd.h
@@ -24,6 +24,7 @@
 
 #ifndef __ASSEMBLY__
 
+#define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_SYS_ALARM
 #define __ARCH_WANT_SYS_GETHOSTNAME
diff --git a/arch/parisc/include/asm/unistd.h b/arch/parisc/include/asm/unistd.h
index 3d507d04eb4c..b36273bacca7 100644
--- a/arch/parisc/include/asm/unistd.h
+++ b/arch/parisc/include/asm/unistd.h
@@ -141,6 +141,7 @@ type name(type1 arg1, type2 arg2, type3 arg3, type4 arg4, type5 arg5)	\
     return K_INLINE_SYSCALL(name, 5, arg1, arg2, arg3, arg4, arg5);	\
 }
 
+#define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_ALARM
diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index c19379f0a32e..8b37e01817be 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -22,6 +22,7 @@
 #include <linux/compiler.h>
 #include <linux/linkage.h>
 
+#define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_ALARM
diff --git a/arch/s390/include/asm/unistd.h b/arch/s390/include/asm/unistd.h
index fd79c0d35dc4..1d181373288a 100644
--- a/arch/s390/include/asm/unistd.h
+++ b/arch/s390/include/asm/unistd.h
@@ -15,6 +15,7 @@
 #define __IGNORE_pkey_alloc
 #define __IGNORE_pkey_free
 
+#define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_SYS_ALARM
 #define __ARCH_WANT_SYS_GETHOSTNAME
diff --git a/arch/sh/include/asm/unistd.h b/arch/sh/include/asm/unistd.h
index b36200af9ce7..a845b57eac69 100644
--- a/arch/sh/include/asm/unistd.h
+++ b/arch/sh/include/asm/unistd.h
@@ -5,6 +5,7 @@
 #  include <asm/unistd_64.h>
 # endif
 
+# define __ARCH_WANT_NEW_STAT
 # define __ARCH_WANT_OLD_READDIR
 # define __ARCH_WANT_OLD_STAT
 # define __ARCH_WANT_STAT64
diff --git a/arch/sparc/include/asm/unistd.h b/arch/sparc/include/asm/unistd.h
index b2a6a955113e..3544244685e1 100644
--- a/arch/sparc/include/asm/unistd.h
+++ b/arch/sparc/include/asm/unistd.h
@@ -21,6 +21,7 @@
 #else
 #define __NR_time		231 /* Linux sparc32                               */
 #endif
+#define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_ALARM
diff --git a/arch/x86/include/asm/unistd.h b/arch/x86/include/asm/unistd.h
index 51c4eee00732..35b66bbf8028 100644
--- a/arch/x86/include/asm/unistd.h
+++ b/arch/x86/include/asm/unistd.h
@@ -31,6 +31,7 @@
 
 # endif
 
+# define __ARCH_WANT_NEW_STAT
 # define __ARCH_WANT_OLD_READDIR
 # define __ARCH_WANT_OLD_STAT
 # define __ARCH_WANT_SYS_ALARM
diff --git a/arch/xtensa/include/asm/unistd.h b/arch/xtensa/include/asm/unistd.h
index ed66db3bc9bb..0d532ab60b37 100644
--- a/arch/xtensa/include/asm/unistd.h
+++ b/arch/xtensa/include/asm/unistd.h
@@ -5,6 +5,7 @@
 #define __ARCH_WANT_SYS_CLONE
 #include <uapi/asm/unistd.h>
 
+#define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_UTIME
 #define __ARCH_WANT_SYS_LLSEEK
diff --git a/fs/stat.c b/fs/stat.c
index f8e6fb2c3657..adbfcd86c81b 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -280,6 +280,8 @@ SYSCALL_DEFINE2(fstat, unsigned int, fd, struct __old_kernel_stat __user *, stat
 
 #endif /* __ARCH_WANT_OLD_STAT */
 
+#ifdef __ARCH_WANT_NEW_STAT
+
 #if BITS_PER_LONG == 32
 #  define choose_32_64(a,b) a
 #else
@@ -378,6 +380,7 @@ SYSCALL_DEFINE2(newfstat, unsigned int, fd, struct stat __user *, statbuf)
 
 	return error;
 }
+#endif
 
 static int do_readlinkat(int dfd, const char __user *pathname,
 			 char __user *buf, int bufsiz)
-- 
2.18.0

