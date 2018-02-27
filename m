Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751658AbeB0Squ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 13:46:50 -0500
Received: from namei.org ([65.99.196.166]:50822 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750952AbeB0Sqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 13:46:48 -0500
Date: Wed, 28 Feb 2018 05:46:44 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [GIT PULL] seccomp fix for v4.16-rc4
Message-ID: <alpine.LRH.2.21.1802280544300.23878@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull, from Kees: "This disables the seccomp samples when cross 
compiling. We're seen too many build issues here, so it's best to just 
disable it, especially since they're just the samples."


The following changes since commit 3be23274755ee85771270a23af7691dc9b3a95db:

  tpm: fix potential buffer overruns caused by bit glitches on the bus (2018-02-26 15:43:46 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git fixes-v4.16-rc4

for you to fetch changes up to 757744eb5f47c4492dfc04155c2c2c325fbcb4fc:

  Merge tag 'seccomp-v4.16-rc4' of https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux into fixes-v4.16-rc4 (2018-02-27 10:39:29 -0800)

----------------------------------------------------------------
James Morris (1):
      Merge tag 'seccomp-v4.16-rc4' of https://git.kernel.org/.../kees/linux into fixes-v4.16-rc4

Michal Hocko (1):
      samples/seccomp: do not compile when cross compiled

 samples/seccomp/Makefile | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/samples/seccomp/Makefile b/samples/seccomp/Makefile
index 0e349b8..ba942e3 100644
--- a/samples/seccomp/Makefile
+++ b/samples/seccomp/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+ifndef CROSS_COMPILE
 hostprogs-$(CONFIG_SAMPLE_SECCOMP) := bpf-fancy dropper bpf-direct
 
 HOSTCFLAGS_bpf-fancy.o += -I$(objtree)/usr/include
@@ -16,7 +17,6 @@ HOSTCFLAGS_bpf-direct.o += -idirafter $(objtree)/include
 bpf-direct-objs := bpf-direct.o
 
 # Try to match the kernel target.
-ifndef CROSS_COMPILE
 ifndef CONFIG_64BIT
 
 # s390 has -m31 flag to build 31 bit binaries
@@ -35,12 +35,4 @@ HOSTLOADLIBES_bpf-fancy += $(MFLAG)
 HOSTLOADLIBES_dropper += $(MFLAG)
 endif
 always := $(hostprogs-m)
-else
-# MIPS system calls are defined based on the -mabi that is passed
-# to the toolchain which may or may not be a valid option
-# for the host toolchain. So disable tests if target architecture
-# is MIPS but the host isn't.
-ifndef CONFIG_MIPS
-always := $(hostprogs-m)
-endif
 endif
