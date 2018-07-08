Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF5FC3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 15:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6595B208A2
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 15:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mhygf2w7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6595B208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932924AbeGHPUM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 11:20:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52064 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932162AbeGHPUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 11:20:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BQegCPIKNWTTrIkjNmINFESlWGVD0/0alxuAxakNzPQ=; b=mhygf2w7DsAtrZyWNHQew/muA
        Rcnsp05bu0zbSlNEuBYTKLK838NI+Vyfc/Dy7VjtZWIsayLH371OQst2bMwPAAWsuONu9u03Ijzez
        uTrPS2S0CjecpNMwryNRGIi3kRRMNdRXAmqaygHICPGtn/gKd4wDDbXQQnNzvIzMmFwQ8txFTMk7R
        0lMbtq2ULdzoa9jWKgMFFOb9I2+c9u+RsqQuXoY03m+s7vyn0BmeoQAQr3FSOrVKN3jYR8rnOd15I
        MrHttRai9UqKSLPkt+tuStjkPjwNK0FBvbqSReU0b1bMQ9QavPR9hnAydsPsFG723HxO7qfhlIkOk
        LKBNfYz1Q==;
Received: from ip-64-134-140-74.public.wayport.net ([64.134.140.74] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcBTq-0002qn-93; Sun, 08 Jul 2018 15:20:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        linux-kbuild@vger.kernel.org, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] um: cleanup Kconfig files
Date:   Sun,  8 Jul 2018 08:19:57 -0700
Message-Id: <20180708152004.21679-3-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180708152004.21679-1-hch@lst.de>
References: <20180708152004.21679-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can handle all not architecture specific UM configuration directly in
the newly added arch/um/Kconfig.  Do so by merging the Kconfig.common,
Kconfig.rest and Kconfig.um files into arch/um/Kconfig, and move the main
UML menu as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/um/Kconfig        | 210 +++++++++++++++++++++++++++++++++++++++++
 arch/um/Kconfig.common |  60 ------------
 arch/um/Kconfig.rest   |  22 -----
 arch/um/Kconfig.um     | 124 ------------------------
 arch/x86/um/Kconfig    |  10 --
 5 files changed, 210 insertions(+), 216 deletions(-)
 delete mode 100644 arch/um/Kconfig.common
 delete mode 100644 arch/um/Kconfig.rest
 delete mode 100644 arch/um/Kconfig.um

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 24607af202dc..1f605a7281cc 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -1,3 +1,213 @@
 # SPDX-License-Identifier: GPL-2.0
 
+menu "UML-specific options"
+
+config UML
+	bool
+	default y
+	select ARCH_HAS_KCOV
+	select HAVE_ARCH_AUDITSYSCALL
+	select HAVE_ARCH_SECCOMP_FILTER
+	select HAVE_UID16
+	select HAVE_FUTEX_CMPXCHG if FUTEX
+	select HAVE_DEBUG_KMEMLEAK
+	select GENERIC_IRQ_SHOW
+	select GENERIC_CPU_DEVICES
+	select GENERIC_CLOCKEVENTS
+	select HAVE_GCC_PLUGINS
+	select TTY # Needed for line.c
+
+config MMU
+	bool
+	default y
+
+config NO_IOMEM
+	def_bool y
+
+config ISA
+	bool
+
+config SBUS
+	bool
+
+config PCI
+	bool
+
+config PCMCIA
+	bool
+
+config TRACE_IRQFLAGS_SUPPORT
+	bool
+	default y
+
+config LOCKDEP_SUPPORT
+	bool
+	default y
+
+config STACKTRACE_SUPPORT
+	bool
+	default y
+	select STACKTRACE
+
+config GENERIC_CALIBRATE_DELAY
+	bool
+	default y
+
+config HZ
+	int
+	default 100
+
+config NR_CPUS
+	int
+	range 1 1
+	default 1
+
 source "arch/$(SUBARCH)/um/Kconfig"
+
+config STATIC_LINK
+	bool "Force a static link"
+	default n
+	help
+	  This option gives you the ability to force a static link of UML.
+	  Normally, UML is linked as a shared binary.  This is inconvenient for
+	  use in a chroot jail.  So, if you intend to run UML inside a chroot,
+	  you probably want to say Y here.
+	  Additionally, this option enables using higher memory spaces (up to
+	  2.75G) for UML.
+
+source "mm/Kconfig"
+
+config LD_SCRIPT_STATIC
+	bool
+	default y
+	depends on STATIC_LINK
+
+config LD_SCRIPT_DYN
+	bool
+	default y
+	depends on !LD_SCRIPT_STATIC
+        select MODULE_REL_CRCS if MODVERSIONS
+
+source "fs/Kconfig.binfmt"
+
+config HOSTFS
+	tristate "Host filesystem"
+	help
+          While the User-Mode Linux port uses its own root file system for
+          booting and normal file access, this module lets the UML user
+          access files stored on the host.  It does not require any
+          network connection between the Host and UML.  An example use of
+          this might be:
+
+          mount none /tmp/fromhost -t hostfs -o /tmp/umlshare
+
+          where /tmp/fromhost is an empty directory inside UML and
+          /tmp/umlshare is a directory on the host with files the UML user
+          wishes to access.
+
+          For more information, see
+          <http://user-mode-linux.sourceforge.net/hostfs.html>.
+
+          If you'd like to be able to work with files stored on the host,
+          say Y or M here; otherwise say N.
+
+config MCONSOLE
+	bool "Management console"
+	depends on PROC_FS
+	default y
+	help
+          The user mode linux management console is a low-level interface to
+          the kernel, somewhat like the i386 SysRq interface.  Since there is
+          a full-blown operating system running under every user mode linux
+          instance, there is much greater flexibility possible than with the
+          SysRq mechanism.
+
+          If you answer 'Y' to this option, to use this feature, you need the
+          mconsole client (called uml_mconsole) which is present in CVS in
+          2.4.5-9um and later (path /tools/mconsole), and is also in the
+          distribution RPM package in 2.4.6 and later.
+
+          It is safe to say 'Y' here.
+
+config MAGIC_SYSRQ
+	bool "Magic SysRq key"
+	depends on MCONSOLE
+	help
+	  If you say Y here, you will have some control over the system even
+	  if the system crashes for example during kernel debugging (e.g., you
+	  will be able to flush the buffer cache to disk, reboot the system
+	  immediately or dump some status information). A key for each of the
+	  possible requests is provided.
+
+	  This is the feature normally accomplished by pressing a key
+	  while holding SysRq (Alt+PrintScreen).
+
+	  On UML, this is accomplished by sending a "sysrq" command with
+	  mconsole, followed by the letter for the requested command.
+
+	  The keys are documented in <file:Documentation/admin-guide/sysrq.rst>. Don't say Y
+	  unless you really know what this hack does.
+
+config KERNEL_STACK_ORDER
+	int "Kernel stack size order"
+	default 1 if 64BIT
+	range 1 10 if 64BIT
+	default 0 if !64BIT
+	help
+	  This option determines the size of UML kernel stacks.  They will
+	  be 1 << order pages.  The default is OK unless you're running Valgrind
+	  on UML, in which case, set this to 3.
+
+config MMAPPER
+	tristate "iomem emulation driver"
+	help
+	  This driver allows a host file to be used as emulated IO memory inside
+	  UML.
+
+config NO_DMA
+	def_bool y
+
+config PGTABLE_LEVELS
+	int
+	default 3 if 3_LEVEL_PGTABLES
+	default 2
+
+config SECCOMP
+	def_bool y
+	prompt "Enable seccomp to safely compute untrusted bytecode"
+	---help---
+	  This kernel feature is useful for number crunching applications
+	  that may need to compute untrusted bytecode during their
+	  execution. By using pipes or other transports made available to
+	  the process as file descriptors supporting the read/write
+	  syscalls, it's possible to isolate those applications in
+	  their own address space using seccomp. Once seccomp is
+	  enabled via prctl(PR_SET_SECCOMP), it cannot be disabled
+	  and the task is only allowed to execute a few safe syscalls
+	  defined by each seccomp mode.
+
+	  If unsure, say Y.
+
+endmenu
+
+source "init/Kconfig"
+
+source "kernel/Kconfig.freezer"
+
+source "arch/um/Kconfig.char"
+
+source "drivers/Kconfig"
+
+source "net/Kconfig"
+
+source "arch/um/Kconfig.net"
+
+source "fs/Kconfig"
+
+source "security/Kconfig"
+
+source "crypto/Kconfig"
+
+source "lib/Kconfig"
+
+source "arch/um/Kconfig.debug"
diff --git a/arch/um/Kconfig.common b/arch/um/Kconfig.common
deleted file mode 100644
index 07f84c842cc3..000000000000
--- a/arch/um/Kconfig.common
+++ /dev/null
@@ -1,60 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-config UML
-	bool
-	default y
-	select ARCH_HAS_KCOV
-	select HAVE_ARCH_AUDITSYSCALL
-	select HAVE_ARCH_SECCOMP_FILTER
-	select HAVE_UID16
-	select HAVE_FUTEX_CMPXCHG if FUTEX
-	select HAVE_DEBUG_KMEMLEAK
-	select GENERIC_IRQ_SHOW
-	select GENERIC_CPU_DEVICES
-	select GENERIC_CLOCKEVENTS
-	select HAVE_GCC_PLUGINS
-	select TTY # Needed for line.c
-
-config MMU
-	bool
-	default y
-
-config NO_IOMEM
-	def_bool y
-
-config ISA
-	bool
-
-config SBUS
-	bool
-
-config PCI
-	bool
-
-config PCMCIA
-	bool
-
-config TRACE_IRQFLAGS_SUPPORT
-	bool
-	default y
-
-config LOCKDEP_SUPPORT
-	bool
-	default y
-
-config STACKTRACE_SUPPORT
-	bool
-	default y
-	select STACKTRACE
-
-config GENERIC_CALIBRATE_DELAY
-	bool
-	default y
-
-config HZ
-	int
-	default 100
-
-config NR_CPUS
-	int
-	range 1 1
-	default 1
diff --git a/arch/um/Kconfig.rest b/arch/um/Kconfig.rest
deleted file mode 100644
index 08327b9c0cbe..000000000000
--- a/arch/um/Kconfig.rest
+++ /dev/null
@@ -1,22 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-source "init/Kconfig"
-
-source "kernel/Kconfig.freezer"
-
-source "arch/um/Kconfig.char"
-
-source "drivers/Kconfig"
-
-source "net/Kconfig"
-
-source "arch/um/Kconfig.net"
-
-source "fs/Kconfig"
-
-source "security/Kconfig"
-
-source "crypto/Kconfig"
-
-source "lib/Kconfig"
-
-source "arch/um/Kconfig.debug"
diff --git a/arch/um/Kconfig.um b/arch/um/Kconfig.um
deleted file mode 100644
index 20da5a8ca949..000000000000
--- a/arch/um/Kconfig.um
+++ /dev/null
@@ -1,124 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-config STATIC_LINK
-	bool "Force a static link"
-	default n
-	help
-	  This option gives you the ability to force a static link of UML.
-	  Normally, UML is linked as a shared binary.  This is inconvenient for
-	  use in a chroot jail.  So, if you intend to run UML inside a chroot,
-	  you probably want to say Y here.
-	  Additionally, this option enables using higher memory spaces (up to
-	  2.75G) for UML.
-
-source "mm/Kconfig"
-
-config LD_SCRIPT_STATIC
-	bool
-	default y
-	depends on STATIC_LINK
-
-config LD_SCRIPT_DYN
-	bool
-	default y
-	depends on !LD_SCRIPT_STATIC
-        select MODULE_REL_CRCS if MODVERSIONS
-
-source "fs/Kconfig.binfmt"
-
-config HOSTFS
-	tristate "Host filesystem"
-	help
-          While the User-Mode Linux port uses its own root file system for
-          booting and normal file access, this module lets the UML user
-          access files stored on the host.  It does not require any
-          network connection between the Host and UML.  An example use of
-          this might be:
-
-          mount none /tmp/fromhost -t hostfs -o /tmp/umlshare
-
-          where /tmp/fromhost is an empty directory inside UML and
-          /tmp/umlshare is a directory on the host with files the UML user
-          wishes to access.
-
-          For more information, see
-          <http://user-mode-linux.sourceforge.net/hostfs.html>.
-
-          If you'd like to be able to work with files stored on the host,
-          say Y or M here; otherwise say N.
-
-config MCONSOLE
-	bool "Management console"
-	depends on PROC_FS
-	default y
-	help
-          The user mode linux management console is a low-level interface to
-          the kernel, somewhat like the i386 SysRq interface.  Since there is
-          a full-blown operating system running under every user mode linux
-          instance, there is much greater flexibility possible than with the
-          SysRq mechanism.
-
-          If you answer 'Y' to this option, to use this feature, you need the
-          mconsole client (called uml_mconsole) which is present in CVS in
-          2.4.5-9um and later (path /tools/mconsole), and is also in the
-          distribution RPM package in 2.4.6 and later.
-
-          It is safe to say 'Y' here.
-
-config MAGIC_SYSRQ
-	bool "Magic SysRq key"
-	depends on MCONSOLE
-	help
-	  If you say Y here, you will have some control over the system even
-	  if the system crashes for example during kernel debugging (e.g., you
-	  will be able to flush the buffer cache to disk, reboot the system
-	  immediately or dump some status information). A key for each of the
-	  possible requests is provided.
-
-	  This is the feature normally accomplished by pressing a key
-	  while holding SysRq (Alt+PrintScreen).
-
-	  On UML, this is accomplished by sending a "sysrq" command with
-	  mconsole, followed by the letter for the requested command.
-
-	  The keys are documented in <file:Documentation/admin-guide/sysrq.rst>. Don't say Y
-	  unless you really know what this hack does.
-
-config KERNEL_STACK_ORDER
-	int "Kernel stack size order"
-	default 1 if 64BIT
-	range 1 10 if 64BIT
-	default 0 if !64BIT
-	help
-	  This option determines the size of UML kernel stacks.  They will
-	  be 1 << order pages.  The default is OK unless you're running Valgrind
-	  on UML, in which case, set this to 3.
-
-config MMAPPER
-	tristate "iomem emulation driver"
-	help
-	  This driver allows a host file to be used as emulated IO memory inside
-	  UML.
-
-config NO_DMA
-	def_bool y
-
-config PGTABLE_LEVELS
-	int
-	default 3 if 3_LEVEL_PGTABLES
-	default 2
-
-config SECCOMP
-	def_bool y
-	prompt "Enable seccomp to safely compute untrusted bytecode"
-	---help---
-	  This kernel feature is useful for number crunching applications
-	  that may need to compute untrusted bytecode during their
-	  execution. By using pipes or other transports made available to
-	  the process as file descriptors supporting the read/write
-	  syscalls, it's possible to isolate those applications in
-	  their own address space using seccomp. Once seccomp is
-	  enabled via prctl(PR_SET_SECCOMP), it cannot be disabled
-	  and the task is only allowed to execute a few safe syscalls
-	  defined by each seccomp mode.
-
-	  If unsure, say Y.
diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
index 7e509c83d80d..f518b4744ff8 100644
--- a/arch/x86/um/Kconfig
+++ b/arch/x86/um/Kconfig
@@ -1,9 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-source "arch/um/Kconfig.common"
-
-menu "UML-specific options"
-
 menu "Host processor type and features"
 
 source "arch/x86/Kconfig.cpu"
@@ -61,9 +57,3 @@ config ARCH_REUSE_HOST_VSYSCALL_AREA
 
 config GENERIC_HWEIGHT
 	def_bool y
-
-source "arch/um/Kconfig.um"
-
-endmenu
-
-source "arch/um/Kconfig.rest"
-- 
2.18.0

