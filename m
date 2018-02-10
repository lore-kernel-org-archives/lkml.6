Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751317AbeBJLgf (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 06:36:35 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44431 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbeBJLge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 06:36:34 -0500
X-Google-Smtp-Source: AH8x225Czev0nGAklyx9STf1vkmN9sUYrnrtliEdicMZYpN3KIFHXzjct/3fOSM9gliWsUYbN0tADw==
Date: Sat, 10 Feb 2018 12:36:29 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH] x86/Kconfig: Further simplify the NR_CPUS config
Message-ID: <20180210113629.jcv6su3r4suuno63@gmail.com>
References: <56d0376c-dc1f-334b-d392-a8c5cd85f4aa@infradead.org>
 <CA+55aFymknkNH2mP1vX5ZLEqQwA3BgxQhZF-SUbbJMwTDL6hAA@mail.gmail.com>
 <0b833246-ed4b-e451-c426-c4464725be92@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b833246-ed4b-e451-c426-c4464725be92@infradead.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Randy Dunlap <rdunlap@infradead.org> wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Clean up and simplify the X86 NR_CPUS Kconfig symbol/option by
> introducing RANGE_BEGIN_CPUS, RANGE_END_CPUS, and DEF_CONFIG_CPUS.
> Then combine some default values when their conditionals can be
> reduced.
> 
> Also move the X86_BIGSMP kconfig option inside an "if X86_32"/"endif"
> config block and drop its explicit "depends on X86_32".
> 
> Combine the max. 8192 cases of RANGE_END_CPUS (X86_64 only).
> Split RANGE_END_CPUS and DEF_CONFIG_CPUS into separate cases for
> X86_32 and X86_64.
> 
> Suggested-by: Linus Torvalds <torvalds@linuxfoundation.org>
> Link: lkml.kernel.org/r/CA+55aFzOd3j6ZUSkEwTdk85qtt1JywOtm3ZAb-qAvt8_hJ6D4A@mail.gmail.com
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: x86@kernel.org
> ---
>  arch/x86/Kconfig |   57 +++++++++++++++++++++++++++++++++------------
>  1 file changed, 42 insertions(+), 15 deletions(-)

Looks mostly good to me in principle - there's a few style nits:

> 
> v2: more simplification as suggested by Linus; also separate the
>     X86_32 and X86_64 configs.
> 
> --- linux-next-20180209.orig/arch/x86/Kconfig
> +++ linux-next-20180209/arch/x86/Kconfig
> @@ -423,12 +423,6 @@ config X86_MPPARSE
>  	  For old smp systems that do not have proper acpi support. Newer systems
>  	  (esp with 64bit cpus) with acpi support, MADT and DSDT will override it
>  
> -config X86_BIGSMP
> -	bool "Support for big SMP systems with more than 8 CPUs"
> -	depends on X86_32 && SMP
> -	---help---
> -	  This option is needed for the systems that have more than 8 CPUs
> -
>  config GOLDFISH
>         def_bool y
>         depends on X86_GOLDFISH
> @@ -460,6 +454,12 @@ config INTEL_RDT
>  	  Say N if unsure.
>  
>  if X86_32
> +config X86_BIGSMP
> +	bool "Support for big SMP systems with more than 8 CPUs"
> +	depends on SMP
> +	---help---
> +	  This option is needed for the systems that have more than 8 CPUs
> +
>  config X86_EXTENDED_PLATFORM
>  	bool "Support for extended (non-PC) x86 platforms"
>  	default y
> @@ -949,17 +949,44 @@ config MAXSMP
>  	  Enable maximum number of CPUS and NUMA Nodes for this architecture.
>  	  If unsure, say N.
>  
> +config RANGE_END_CPUS
> +	int
> +	depends on X86_32
> +	default 8 if SMP && !X86_BIGSMP
> +	default 64 if SMP && X86_BIGSMP
> +	default 1 if !SMP
> +
> +config RANGE_END_CPUS
> +	int
> +	depends on X86_64
> +	default 512 if SMP && !MAXSMP && !CPUMASK_OFFSTACK
> +	default 8192 if SMP && (MAXSMP || CPUMASK_OFFSTACK)
> +	default 1 if !SMP
> +
> +config RANGE_BEGIN_CPUS
> +	int
> +	default 1 if !SMP
> +	default RANGE_END_CPUS if MAXSMP
> +	default 2

I'd suggest a more natural naming order, which also lines up with how we name the 
main parameter in the end (CONFIG_NR_CPUS):

	NR_CPUS_RANGE_BEGIN
	NR_CPUS_RANGE_END

> +config DEF_CONFIG_CPUS
> +	int
> +	depends on X86_32
> +	default 1 if !SMP
> +	default 32 if X86_BIGSMP
> +	default 8 if SMP
> +
> +config DEF_CONFIG_CPUS
> +	int
> +	depends on X86_64
> +	default 1 if !SMP
> +	default 8192 if MAXSMP
> +	default 64 if SMP

This too needs to match the target namespace, i.e.:

       NR_CPUS_DEFAULT

I.e. instead of the random, idiosynchratic naming this patch introduces:

	CONFIG_RANGE_BEGIN_CPUS
	CONFIG_RANGE_END_CPUS
	CONFIG_DEF_CONFIG_CPUS
	CONFIG_NR_CPUS

We'll get:

	CONFIG_NR_CPUS_RANGE_BEGIN
	CONFIG_NR_CPUS_RANGE_END
	CONFIG_NR_CPUS_DEFAULT
	CONFIG_NR_CPUS

See how much more structured and organized it all is, both in the source and in 
the resulting .config file? Also, a side effect is that a simple NR_CPUS grep:

  triton:~/tip> grep NR_CPUS .config
  CONFIG_NR_CPUS_RANGE_BEGIN=2
  CONFIG_NR_CPUS_RANGE_END=512
  CONFIG_NR_CPUS_DEFAULT=64
  CONFIG_NR_CPUS=64

  grep NR_CPUS .config

... will tell the full story about how the NR_CPUS Kconfig setup on a particular 
system looks like.

There's no such grep command for the patch you sent, because for example the 
pattern 'CPUS' is too generic as it matches 'CPUSET' and 'PTLOCK_CPUS' as well.

Furthermore, these blocks should be vertically aligned:

> +	default 1 if !SMP
> +	default 8192 if MAXSMP
> +	default 64 if SMP

To:

	default    1 if !SMP
	default 8192 if MAXSMP
	default   64 if SMP

Also note that the moment we have aligned this block vertically, it becomes clear 
at a glance that the internal ordering of the lines should be numeric (in 
decreasing order, to arrive at the highest possible value):

	default 8192 if MAXSMP
	default   64 if SMP
	default    1 if !SMP

We should do the same for all the other entries as well.

A third general problem is the somewhat random ordering of the Kconfig blocks 
themselves:

 +config NR_CPUS_RANGE_END
 +config NR_CPUS_RANGE_BEGIN
 +config NR_CPUS_DEFAULT

The more natural ordering is _RANGE_BEGIN, _RANGE_END, _DEFAULT. (The Kconfig 
language allows forward references, so the fact that _BEGIN in a narrow case 
depends on _END isn't a problem.)

... below is the a patch on top of yours that fixes all this and a few other 
details - see the changelog.

Thanks,

	Ingo

=========================>
Subject: x86/Kconfig: Further simplify the NR_CPUS config
From: Ingo Molnar <mingo@kernel.org>
Date: Sat Feb 10 11:51:57 CET 2018

Clean up various aspects of the x86 CONFIG_NR_CPUS configuration switches:

- Rename the three CONFIG_NR_CPUS related variables to create a common
  namespace for them:

    RANGE_BEGIN_CPUS => NR_CPUS_RANGE_BEGIN
    RANGE_END_CPUS   => NR_CPUS_RANGE_END
    DEF_CONFIG_CPUS  => NR_CPUS_DEFAULT

- Align them vertically, such as:

    config NR_CPUS_RANGE_END
            int
            depends on X86_64
            default 8192 if  SMP && ( MAXSMP ||  CPUMASK_OFFSTACK)
            default  512 if  SMP && (!MAXSMP && !CPUMASK_OFFSTACK)
            default    1 if !SMP

- Update help text, add more comments.

Test results:

 # i386 allnoconfig:
 CONFIG_NR_CPUS_RANGE_BEGIN=1
 CONFIG_NR_CPUS_RANGE_END=1
 CONFIG_NR_CPUS_DEFAULT=1
 CONFIG_NR_CPUS=1

 # i386 defconfig:
 CONFIG_NR_CPUS_RANGE_BEGIN=2
 CONFIG_NR_CPUS_RANGE_END=8
 CONFIG_NR_CPUS_DEFAULT=8
 CONFIG_NR_CPUS=8

 # i386 allyesconfig:
 CONFIG_NR_CPUS_RANGE_BEGIN=2
 CONFIG_NR_CPUS_RANGE_END=64
 CONFIG_NR_CPUS_DEFAULT=32
 CONFIG_NR_CPUS=32

 # x86_64 allnoconfig:
 CONFIG_NR_CPUS_RANGE_BEGIN=1
 CONFIG_NR_CPUS_RANGE_END=1
 CONFIG_NR_CPUS_DEFAULT=1
 CONFIG_NR_CPUS=1

 # x86_64 defconfig:
 CONFIG_NR_CPUS_RANGE_BEGIN=2
 CONFIG_NR_CPUS_RANGE_END=512
 CONFIG_NR_CPUS_DEFAULT=64
 CONFIG_NR_CPUS=64

 # x86_64 allyesconfig:
 CONFIG_NR_CPUS_RANGE_BEGIN=8192
 CONFIG_NR_CPUS_RANGE_END=8192
 CONFIG_NR_CPUS_DEFAULT=8192
 CONFIG_NR_CPUS=8192

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/Kconfig |   66 +++++++++++++++++++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 26 deletions(-)

Index: tip/arch/x86/Kconfig
===================================================================
--- tip.orig/arch/x86/Kconfig
+++ tip/arch/x86/Kconfig
@@ -949,52 +949,66 @@ config MAXSMP
 	  Enable maximum number of CPUS and NUMA Nodes for this architecture.
 	  If unsure, say N.
 
-config RANGE_END_CPUS
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
 	int
-	depends on X86_32
-	default 8 if SMP && !X86_BIGSMP
-	default 64 if SMP && X86_BIGSMP
-	default 1 if !SMP
+	default NR_CPUS_RANGE_END if MAXSMP
+	default    1 if !SMP
+	default    2
 
-config RANGE_END_CPUS
+config NR_CPUS_RANGE_END
 	int
-	depends on X86_64
-	default 512 if SMP && !MAXSMP && !CPUMASK_OFFSTACK
-	default 8192 if SMP && (MAXSMP || CPUMASK_OFFSTACK)
-	default 1 if !SMP
+	depends on X86_32
+	default   64 if  SMP &&  X86_BIGSMP
+	default    8 if  SMP && !X86_BIGSMP
+	default    1 if !SMP
 
-config RANGE_BEGIN_CPUS
+config NR_CPUS_RANGE_END
 	int
-	default 1 if !SMP
-	default RANGE_END_CPUS if MAXSMP
-	default 2
+	depends on X86_64
+	default 8192 if  SMP && ( MAXSMP ||  CPUMASK_OFFSTACK)
+	default  512 if  SMP && (!MAXSMP && !CPUMASK_OFFSTACK)
+	default    1 if !SMP
 
-config DEF_CONFIG_CPUS
+config NR_CPUS_DEFAULT
 	int
 	depends on X86_32
-	default 1 if !SMP
-	default 32 if X86_BIGSMP
-	default 8 if SMP
+	default   32 if  X86_BIGSMP
+	default    8 if  SMP
+	default    1 if !SMP
 
-config DEF_CONFIG_CPUS
+config NR_CPUS_DEFAULT
 	int
 	depends on X86_64
-	default 1 if !SMP
-	default 8192 if MAXSMP
-	default 64 if SMP
+	default 8192 if  MAXSMP
+	default   64 if  SMP
+	default    1 if !SMP
 
 config NR_CPUS
 	int "Maximum number of CPUs" if SMP && !MAXSMP
-	range RANGE_BEGIN_CPUS RANGE_END_CPUS
-	default DEF_CONFIG_CPUS
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
