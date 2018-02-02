Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752419AbeBBUim (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 15:38:42 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:45663 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751557AbeBBUig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 15:38:36 -0500
X-Google-Smtp-Source: AH8x224HmxbnKiGKq8zZv/qtG7G3UIW2pxUC5fb8FnyAfILxkiFvlavDknUxrfCZpa8McFTkL4sZGg==
Date: Fri, 2 Feb 2018 15:38:34 -0500 (EST)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
cc: Andi Kleen <ak@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH 7/7] Kbuild: lto: pass -m32/-m64 to to LDFINAL
In-Reply-To: <CAK8P3a3dgFjXP3wub+J5-_67MS2Mm_twktD=cyoY2pPro+AWzQ@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.76.1802021523390.1842@knanqh.ubzr>
References: <20180202161550.2106846-1-arnd@arndb.de> <20180202162104.2300532-7-arnd@arndb.de> <nycvar.YSQ.7.76.1802021336090.1842@knanqh.ubzr> <CAK8P3a3dgFjXP3wub+J5-_67MS2Mm_twktD=cyoY2pPro+AWzQ@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Feb 2018, Arnd Bergmann wrote:

> Do you have a git tree with other changes for LTO on ARM? I'd
> like to try that as well.

I currently have only 2 other patches.

You need commit 75fea300d73a that just hit mainline (you may cherry-pick 
it easily if necessary).

Then the following:

----- >8
Subject: [PATCH] HACK: enable LTO on ARM

Without the ${KBUILD_VMLINUX_LIBS} move the build fails with missing
memcpy all over the place. Didn't figure it out yet.

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4382315005..84450843ed 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -17,6 +17,7 @@ config ARM
 	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT if CPU_V7
 	select ARCH_SUPPORTS_ATOMIC_RMW
+	select ARCH_SUPPORTS_LTO
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select ARCH_WANT_IPC_PARSE_VERSION
@@ -101,6 +102,7 @@ config ARM
 	select PERF_USE_VMALLOC
 	select RTC_LIB
 	select SYS_SUPPORTS_APM_EMULATION
+	select THIN_ARCHIVES if LTO
 	# Above selects are sorted alphabetically; please add new ones
 	# according to that.  Thanks.
 	help
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 45a6b9b7af..39ac0a9639 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -97,7 +97,7 @@ targets       := vmlinux vmlinux.lds piggy_data piggy.o \
 clean-files += piggy_data lib1funcs.S ashldi3.S bswapsdi2.S \
 		$(libfdt) $(libfdt_hdrs) hyp-stub.S
 
-KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
+KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING $(DISABLE_LTO)
 
 ifeq ($(CONFIG_FUNCTION_TRACER),y)
 ORIG_CFLAGS := $(KBUILD_CFLAGS)
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 964b2ee855..0774a87788 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -99,9 +99,9 @@ vmlinux_link()
 		if [ -n "${CONFIG_THIN_ARCHIVES}" ]; then
 			objects="--whole-archive			\
 				built-in.o				\
+				${KBUILD_VMLINUX_LIBS}			\
 				--no-whole-archive			\
 				--start-group				\
-				${KBUILD_VMLINUX_LIBS}			\
 				--end-group				\
 				${1}"
 		else






> 
>        Arnd
> 
