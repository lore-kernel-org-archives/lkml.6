Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5576BC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A5CC2084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A5CC2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731882AbeGSPwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:52:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59958 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731567AbeGSPwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:52:04 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B93741090;
        Thu, 19 Jul 2018 15:08:27 +0000 (UTC)
Date:   Thu, 19 Jul 2018 17:08:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Re: Linux 4.4.142
Message-ID: <20180719150825.GB28841@kroah.com>
References: <20180719150819.GA28841@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719150819.GA28841@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 3fc39e41dbde..75d6176c8786 100644
--- a/Makefile
+++ b/Makefile
@@ -1,6 +1,6 @@
 VERSION = 4
 PATCHLEVEL = 4
-SUBLEVEL = 141
+SUBLEVEL = 142
 EXTRAVERSION =
 NAME = Blurry Fish Butt
 
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 814276d0eed1..736e2843139b 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -686,13 +686,14 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 		c->x86_capability[CPUID_1_EDX] = edx;
 	}
 
+	/* Thermal and Power Management Leaf: level 0x00000006 (eax) */
+	if (c->cpuid_level >= 0x00000006)
+		c->x86_capability[CPUID_6_EAX] = cpuid_eax(0x00000006);
+
 	/* Additional Intel-defined flags: level 0x00000007 */
 	if (c->cpuid_level >= 0x00000007) {
 		cpuid_count(0x00000007, 0, &eax, &ebx, &ecx, &edx);
-
 		c->x86_capability[CPUID_7_0_EBX] = ebx;
-
-		c->x86_capability[CPUID_6_EAX] = cpuid_eax(0x00000006);
 		c->x86_capability[CPUID_7_ECX] = ecx;
 	}
 
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 1db6d73c8dd2..31a981d6229d 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -7,6 +7,7 @@ quote   := "
 squote  := '
 empty   :=
 space   := $(empty) $(empty)
+pound   := \#
 
 ###
 # Name of target with a '.' as filename prefix. foo/bar.o => foo/.bar.o
@@ -236,11 +237,11 @@ endif
 
 # Replace >$< with >$$< to preserve $ when reloading the .cmd file
 # (needed for make)
-# Replace >#< with >\#< to avoid starting a comment in the .cmd file
+# Replace >#< with >$(pound)< to avoid starting a comment in the .cmd file
 # (needed for make)
 # Replace >'< with >'\''< to be able to enclose the whole string in '...'
 # (needed for the shell)
-make-cmd = $(call escsq,$(subst \#,\\\#,$(subst $$,$$$$,$(cmd_$(1)))))
+make-cmd = $(call escsq,$(subst $(pound),$$(pound),$(subst $$,$$$$,$(cmd_$(1)))))
 
 # Find any prerequisites that is newer than target or that does not exist.
 # PHONY targets skipped in both cases.
diff --git a/tools/arch/x86/include/asm/unistd_32.h b/tools/arch/x86/include/asm/unistd_32.h
new file mode 100644
index 000000000000..cf33ab09273d
--- /dev/null
+++ b/tools/arch/x86/include/asm/unistd_32.h
@@ -0,0 +1,9 @@
+#ifndef __NR_perf_event_open
+# define __NR_perf_event_open 336
+#endif
+#ifndef __NR_futex
+# define __NR_futex 240
+#endif
+#ifndef __NR_gettid
+# define __NR_gettid 224
+#endif
diff --git a/tools/arch/x86/include/asm/unistd_64.h b/tools/arch/x86/include/asm/unistd_64.h
new file mode 100644
index 000000000000..2c9835695b56
--- /dev/null
+++ b/tools/arch/x86/include/asm/unistd_64.h
@@ -0,0 +1,9 @@
+#ifndef __NR_perf_event_open
+# define __NR_perf_event_open 298
+#endif
+#ifndef __NR_futex
+# define __NR_futex 202
+#endif
+#ifndef __NR_gettid
+# define __NR_gettid 186
+#endif
diff --git a/tools/build/Build.include b/tools/build/Build.include
index 1c570528baf7..0340d8a51dab 100644
--- a/tools/build/Build.include
+++ b/tools/build/Build.include
@@ -12,6 +12,7 @@
 # Convenient variables
 comma   := ,
 squote  := '
+pound   := \#
 
 ###
 # Name of target with a '.' as filename prefix. foo/bar.o => foo/.bar.o
@@ -43,11 +44,11 @@ echo-cmd = $(if $($(quiet)cmd_$(1)),\
 ###
 # Replace >$< with >$$< to preserve $ when reloading the .cmd file
 # (needed for make)
-# Replace >#< with >\#< to avoid starting a comment in the .cmd file
+# Replace >#< with >$(pound)< to avoid starting a comment in the .cmd file
 # (needed for make)
 # Replace >'< with >'\''< to be able to enclose the whole string in '...'
 # (needed for the shell)
-make-cmd = $(call escsq,$(subst \#,\\\#,$(subst $$,$$$$,$(cmd_$(1)))))
+make-cmd = $(call escsq,$(subst $(pound),$$(pound),$(subst $$,$$$$,$(cmd_$(1)))))
 
 ###
 # Find any prerequisites that is newer than target or that does not exist.
diff --git a/tools/perf/config/Makefile b/tools/perf/config/Makefile
index de89ec574361..b92c952b01ef 100644
--- a/tools/perf/config/Makefile
+++ b/tools/perf/config/Makefile
@@ -200,6 +200,7 @@ CFLAGS += -I$(src-perf)/arch/$(ARCH)/include
 CFLAGS += -I$(srctree)/tools/include/
 CFLAGS += -I$(srctree)/arch/$(ARCH)/include/uapi
 CFLAGS += -I$(srctree)/arch/$(ARCH)/include
+CFLAGS += -I$(srctree)/tools/arch/$(ARCH)/include
 CFLAGS += -I$(srctree)/include/uapi
 CFLAGS += -I$(srctree)/include
 
diff --git a/tools/perf/perf-sys.h b/tools/perf/perf-sys.h
index 83a25cef82fd..5cee8a3d0455 100644
--- a/tools/perf/perf-sys.h
+++ b/tools/perf/perf-sys.h
@@ -11,29 +11,11 @@
 #if defined(__i386__)
 #define cpu_relax()	asm volatile("rep; nop" ::: "memory");
 #define CPUINFO_PROC	{"model name"}
-#ifndef __NR_perf_event_open
-# define __NR_perf_event_open 336
-#endif
-#ifndef __NR_futex
-# define __NR_futex 240
-#endif
-#ifndef __NR_gettid
-# define __NR_gettid 224
-#endif
 #endif
 
 #if defined(__x86_64__)
 #define cpu_relax()	asm volatile("rep; nop" ::: "memory");
 #define CPUINFO_PROC	{"model name"}
-#ifndef __NR_perf_event_open
-# define __NR_perf_event_open 298
-#endif
-#ifndef __NR_futex
-# define __NR_futex 202
-#endif
-#ifndef __NR_gettid
-# define __NR_gettid 186
-#endif
 #endif
 
 #ifdef __powerpc__
diff --git a/tools/perf/util/include/asm/unistd_32.h b/tools/perf/util/include/asm/unistd_32.h
deleted file mode 100644
index 8b137891791f..000000000000
--- a/tools/perf/util/include/asm/unistd_32.h
+++ /dev/null
@@ -1 +0,0 @@
-
diff --git a/tools/perf/util/include/asm/unistd_64.h b/tools/perf/util/include/asm/unistd_64.h
deleted file mode 100644
index 8b137891791f..000000000000
--- a/tools/perf/util/include/asm/unistd_64.h
+++ /dev/null
@@ -1 +0,0 @@
-
diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index 19edc1a7a232..7ea4438b801d 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -92,3 +92,5 @@ ifneq ($(silent),1)
 	QUIET_INSTALL  = @printf '  INSTALL  %s\n' $1;
   endif
 endif
+
+pound := \#
