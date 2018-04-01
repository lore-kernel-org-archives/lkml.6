Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754079AbeDAUkt (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 16:40:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43034 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753999AbeDAUkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 16:40:46 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 05/45] C++: Set compilation as C++ for .c files
From: David Howells <dhowells@redhat.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Apr 2018 21:40:45 +0100
Message-ID: <152261524532.30503.16094079179209557382.stgit@warthog.procyon.org.uk>
In-Reply-To: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


---

 Makefile                      |   13 ++++---------
 arch/x86/Makefile             |    2 +-
 arch/x86/purgatory/Makefile   |    2 +-
 include/linux/types.h         |    4 ++++
 scripts/checksyscalls.sh      |    2 +-
 tools/power/cpupower/Makefile |    1 -
 tools/virtio/Makefile         |    2 +-
 7 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/Makefile b/Makefile
index e02d092bc2d6..76e2ca8bf0fe 100644
--- a/Makefile
+++ b/Makefile
@@ -370,7 +370,7 @@ HOST_LOADLIBES := $(HOST_LFS_LIBS)
 # Make variables (CC, etc...)
 AS		= $(CROSS_COMPILE)as
 LD		= $(CROSS_COMPILE)ld
-CC		= $(CROSS_COMPILE)gcc
+CC		= $(CROSS_COMPILE)g++
 CPP		= $(CC) -E
 AR		= $(CROSS_COMPILE)ar
 NM		= $(CROSS_COMPILE)nm
@@ -415,11 +415,12 @@ LINUXINCLUDE    := \
 		$(USERINCLUDE)
 
 KBUILD_AFLAGS   := -D__ASSEMBLY__
-KBUILD_CFLAGS   := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
+KBUILD_CFLAGS   := -Wall -Wundef -Wno-trigraphs \
 		   -fno-strict-aliasing -fno-common -fshort-wchar \
 		   -Werror-implicit-function-declaration \
 		   -Wno-format-security \
-		   -std=gnu89
+		   -std=gnu89 -Wno-pointer-arith \
+		   -fno-rtti -fno-exceptions -fpermissive
 KBUILD_CPPFLAGS := -D__KERNEL__
 KBUILD_AFLAGS_KERNEL :=
 KBUILD_CFLAGS_KERNEL :=
@@ -817,12 +818,6 @@ endif
 NOSTDINC_FLAGS += -nostdinc -isystem $(call shell-cached,$(CC) -print-file-name=include)
 CHECKFLAGS     += $(NOSTDINC_FLAGS)
 
-# warn about C99 declaration after statement
-KBUILD_CFLAGS += $(call cc-option,-Wdeclaration-after-statement,)
-
-# disable pointer signed / unsigned warnings in gcc 4.0
-KBUILD_CFLAGS += $(call cc-disable-warning, pointer-sign)
-
 # disable invalid "can't wrap" optimizations for signed / pointers
 KBUILD_CFLAGS	+= $(call cc-option,-fno-strict-overflow)
 
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 498c1b812300..9933a5f2e628 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -33,7 +33,7 @@ M16_CFLAGS	 := $(call cc-option, -m16, $(CODE16GCC_CFLAGS))
 
 REALMODE_CFLAGS	:= $(M16_CFLAGS) -g -Os -D__KERNEL__ \
 		   -DDISABLE_BRANCH_PROFILING \
-		   -Wall -Wstrict-prototypes -march=i386 -mregparm=3 \
+		   -Wall -march=i386 -mregparm=3 \
 		   -fno-strict-aliasing -fomit-frame-pointer -fno-pic \
 		   -mno-mmx -mno-sse
 
diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 2f15a2ac4209..3911b8b1b140 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -16,7 +16,7 @@ KCOV_INSTRUMENT := n
 # in turn leaves some undefined symbols like __fentry__ in purgatory and not
 # sure how to relocate those. Like kexec-tools, use custom flags.
 
-KBUILD_CFLAGS := -fno-strict-aliasing -Wall -Wstrict-prototypes -fno-zero-initialized-in-bss -fno-builtin -ffreestanding -c -MD -Os -mcmodel=large
+KBUILD_CFLAGS := -fno-strict-aliasing -Wall -Wstrict-prototypes -fno-zero-initialized-in-bss -fno-builtin -ffreestanding -c -MD -Os -mcmodel=large  -x c++ -Wno-pointer-arith
 KBUILD_CFLAGS += -m$(BITS)
 KBUILD_CFLAGS += $(call cc-option,-fno-PIE)
 
diff --git a/include/linux/types.h b/include/linux/types.h
index c94d59ef96cc..31e8258ac048 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -2,6 +2,10 @@
 #ifndef _LINUX_TYPES_H
 #define _LINUX_TYPES_H
 
+#ifndef __cplusplus
+#error not c++
+#endif
+
 #define __EXPORTED_HEADERS__
 #include <uapi/linux/types.h>
 
diff --git a/scripts/checksyscalls.sh b/scripts/checksyscalls.sh
index ee3dfb5be6cd..2f9aa09602e7 100755
--- a/scripts/checksyscalls.sh
+++ b/scripts/checksyscalls.sh
@@ -212,4 +212,4 @@ syscall_list() {
 }
 
 (ignore_list && syscall_list $(dirname $0)/../arch/x86/entry/syscalls/syscall_32.tbl) | \
-$* -E -x c - > /dev/null
+$* -E -x c++ - > /dev/null
diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index 1dd5f4fcffd5..68d2e199b402 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -125,7 +125,6 @@ cc-supports = ${shell if $(CC) ${1} -S -o /dev/null -x c /dev/null > /dev/null 2
 OPTIMIZATION := $(call cc-supports,-Os,-O2)
 
 WARNINGS := -Wall -Wchar-subscripts -Wpointer-arith -Wsign-compare
-WARNINGS += $(call cc-supports,-Wno-pointer-sign)
 WARNINGS += $(call cc-supports,-Wdeclaration-after-statement)
 WARNINGS += -Wshadow
 
diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile
index 8e2a908115c2..fde1fccb019d 100644
--- a/tools/virtio/Makefile
+++ b/tools/virtio/Makefile
@@ -4,7 +4,7 @@ test: virtio_test vringh_test
 virtio_test: virtio_ring.o virtio_test.o
 vringh_test: vringh_test.o vringh.o virtio_ring.o
 
-CFLAGS += -g -O2 -Werror -Wall -I. -I../include/ -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE
+CFLAGS += -g -O2 -Werror -Wall -I. -I../include/ -I ../../usr/include/ -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE
 vpath %.c ../../drivers/virtio ../../drivers/vhost
 mod:
 	${MAKE} -C `pwd`/../.. M=`pwd`/vhost_test V=${V}
