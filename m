Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751189AbeBJLir (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 06:38:47 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33884 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbeBJLiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 06:38:46 -0500
X-Google-Smtp-Source: AH8x224D0Li3N8fvRAardjJWFzRhAIl4H+09n1C4jOHPWOt0JpeaKJ6eLp4MsyMct5F/v5aJo0i++Q==
Date: Sat, 10 Feb 2018 12:38:42 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] x86/Kconfig: Further simplify the NR_CPUS config
Message-ID: <20180210113842.7j62u7rxp4jscei2@gmail.com>
References: <56d0376c-dc1f-334b-d392-a8c5cd85f4aa@infradead.org>
 <CA+55aFymknkNH2mP1vX5ZLEqQwA3BgxQhZF-SUbbJMwTDL6hAA@mail.gmail.com>
 <0b833246-ed4b-e451-c426-c4464725be92@infradead.org>
 <20180210113629.jcv6su3r4suuno63@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180210113629.jcv6su3r4suuno63@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> =========================>
> Subject: x86/Kconfig: Further simplify the NR_CPUS config
> From: Ingo Molnar <mingo@kernel.org>
> Date: Sat Feb 10 11:51:57 CET 2018
> 
> Clean up various aspects of the x86 CONFIG_NR_CPUS configuration switches:
> 
> - Rename the three CONFIG_NR_CPUS related variables to create a common
>   namespace for them:
> 
>     RANGE_BEGIN_CPUS => NR_CPUS_RANGE_BEGIN
>     RANGE_END_CPUS   => NR_CPUS_RANGE_END
>     DEF_CONFIG_CPUS  => NR_CPUS_DEFAULT
> 
> - Align them vertically, such as:
> 
>     config NR_CPUS_RANGE_END
>             int
>             depends on X86_64
>             default 8192 if  SMP && ( MAXSMP ||  CPUMASK_OFFSTACK)
>             default  512 if  SMP && (!MAXSMP && !CPUMASK_OFFSTACK)
>             default    1 if !SMP
> 
> - Update help text, add more comments.
> 
> Test results:
> 
>  # i386 allnoconfig:
>  CONFIG_NR_CPUS_RANGE_BEGIN=1
>  CONFIG_NR_CPUS_RANGE_END=1
>  CONFIG_NR_CPUS_DEFAULT=1
>  CONFIG_NR_CPUS=1
> 
>  # i386 defconfig:
>  CONFIG_NR_CPUS_RANGE_BEGIN=2
>  CONFIG_NR_CPUS_RANGE_END=8
>  CONFIG_NR_CPUS_DEFAULT=8
>  CONFIG_NR_CPUS=8
> 
>  # i386 allyesconfig:
>  CONFIG_NR_CPUS_RANGE_BEGIN=2
>  CONFIG_NR_CPUS_RANGE_END=64
>  CONFIG_NR_CPUS_DEFAULT=32
>  CONFIG_NR_CPUS=32
> 
>  # x86_64 allnoconfig:
>  CONFIG_NR_CPUS_RANGE_BEGIN=1
>  CONFIG_NR_CPUS_RANGE_END=1
>  CONFIG_NR_CPUS_DEFAULT=1
>  CONFIG_NR_CPUS=1
> 
>  # x86_64 defconfig:
>  CONFIG_NR_CPUS_RANGE_BEGIN=2
>  CONFIG_NR_CPUS_RANGE_END=512
>  CONFIG_NR_CPUS_DEFAULT=64
>  CONFIG_NR_CPUS=64
> 
>  # x86_64 allyesconfig:
>  CONFIG_NR_CPUS_RANGE_BEGIN=8192
>  CONFIG_NR_CPUS_RANGE_END=8192
>  CONFIG_NR_CPUS_DEFAULT=8192
>  CONFIG_NR_CPUS=8192
> 
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  arch/x86/Kconfig |   66 +++++++++++++++++++++++++++++++++----------------------
>  1 file changed, 40 insertions(+), 26 deletions(-)

Here is a full combo patch of your patch and mine, for easier review:

---
 arch/x86/Kconfig |   75 ++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 58 insertions(+), 17 deletions(-)

Index: tip/arch/x86/Kconfig
===================================================================
--- tip.orig/arch/x86/Kconfig
+++ tip/arch/x86/Kconfig
@@ -423,12 +423,6 @@ config X86_MPPARSE
 	  For old smp systems that do not have proper acpi support. Newer systems
 	  (esp with 64bit cpus) with acpi support, MADT and DSDT will override it
 
-config X86_BIGSMP
-	bool "Support for big SMP systems with more than 8 CPUs"
-	depends on X86_32 && SMP
-	---help---
-	  This option is needed for the systems that have more than 8 CPUs
-
 config GOLDFISH
        def_bool y
        depends on X86_GOLDFISH
@@ -460,6 +454,12 @@ config INTEL_RDT
 	  Say N if unsure.
 
 if X86_32
+config X86_BIGSMP
+	bool "Support for big SMP systems with more than 8 CPUs"
+	depends on SMP
+	---help---
+	  This option is needed for the systems that have more than 8 CPUs
+
 config X86_EXTENDED_PLATFORM
 	bool "Support for extended (non-PC) x86 platforms"
 	default y
@@ -949,25 +949,66 @@ config MAXSMP
 	  Enable maximum number of CPUS and NUMA Nodes for this architecture.
 	  If unsure, say N.
 
+#
+# The maximum number of CPUs supported:
+#
+# The main config value is NR_CPUS, which defaults to NR_CPUS_DEFAULT,
+# and which can be configured interactively in the
+# [NR_CPUS_RANGE_BEGIN ... NR_CPUS_RANGE_END] range.
+#
+# The ranges are different on 32-bit and 64-bit kernels, depending on
+# hardware capabilities and scalability features of the kernel.
+#
+# ( If MAXSMP is enabled we just use the highest possible value and disable
+#   interactive configuration. )
+#
+
+config NR_CPUS_RANGE_BEGIN
+	int
+	default NR_CPUS_RANGE_END if MAXSMP
+	default    1 if !SMP
+	default    2
+
+config NR_CPUS_RANGE_END
+	int
+	depends on X86_32
+	default   64 if  SMP &&  X86_BIGSMP
+	default    8 if  SMP && !X86_BIGSMP
+	default    1 if !SMP
+
+config NR_CPUS_RANGE_END
+	int
+	depends on X86_64
+	default 8192 if  SMP && ( MAXSMP ||  CPUMASK_OFFSTACK)
+	default  512 if  SMP && (!MAXSMP && !CPUMASK_OFFSTACK)
+	default    1 if !SMP
+
+config NR_CPUS_DEFAULT
+	int
+	depends on X86_32
+	default   32 if  X86_BIGSMP
+	default    8 if  SMP
+	default    1 if !SMP
+
+config NR_CPUS_DEFAULT
+	int
+	depends on X86_64
+	default 8192 if  MAXSMP
+	default   64 if  SMP
+	default    1 if !SMP
+
 config NR_CPUS
 	int "Maximum number of CPUs" if SMP && !MAXSMP
-	range 2 8 if SMP && X86_32 && !X86_BIGSMP
-	range 2 64 if SMP && X86_32 && X86_BIGSMP
-	range 2 512 if SMP && !MAXSMP && !CPUMASK_OFFSTACK && X86_64
-	range 2 8192 if SMP && !MAXSMP && CPUMASK_OFFSTACK && X86_64
-	default "1" if !SMP
-	default "8192" if MAXSMP
-	default "32" if SMP && X86_BIGSMP
-	default "8" if SMP && X86_32
-	default "64" if SMP
+	range NR_CPUS_RANGE_BEGIN NR_CPUS_RANGE_END
+	default NR_CPUS_DEFAULT
 	---help---
 	  This allows you to specify the maximum number of CPUs which this
 	  kernel will support.  If CPUMASK_OFFSTACK is enabled, the maximum
 	  supported value is 8192, otherwise the maximum value is 512.  The
 	  minimum value which makes sense is 2.
 
-	  This is purely to save memory - each supported CPU adds
-	  approximately eight kilobytes to the kernel image.
+	  This is purely to save memory: each supported CPU adds about 8KB
+	  to the kernel image.
 
 config SCHED_SMT
 	bool "SMT (Hyperthreading) scheduler support"
