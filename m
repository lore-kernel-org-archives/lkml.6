Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932418AbeBLBVT (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 20:21:19 -0500
Received: from [198.137.202.136] ([198.137.202.136]:45687 "EHLO mail.zytor.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S932311AbeBLBVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 20:21:17 -0500
Date: Sun, 11 Feb 2018 04:12:08 -0800
From: tip-bot for Ingo Molnar <tipbot@zytor.com>
Message-ID: <tip-aec6487e994d2f625197970a56a4aac40c2c7547@git.kernel.org>
Cc: rdunlap@infradead.org, mingo@kernel.org, torvalds@linux-foundation.org,
        a.p.zijlstra@chello.nl, tglx@linutronix.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org
Reply-To: mingo@kernel.org, rdunlap@infradead.org, a.p.zijlstra@chello.nl,
        torvalds@linux-foundation.org, hpa@zytor.com, tglx@linutronix.de,
        peterz@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20180210113629.jcv6su3r4suuno63@gmail.com>
References: <20180210113629.jcv6su3r4suuno63@gmail.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/Kconfig: Further simplify the NR_CPUS config
Git-Commit-ID: aec6487e994d2f625197970a56a4aac40c2c7547
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

Commit-ID:  aec6487e994d2f625197970a56a4aac40c2c7547
Gitweb:     https://git.kernel.org/tip/aec6487e994d2f625197970a56a4aac40c2c7547
Author:     Ingo Molnar <mingo@kernel.org>
AuthorDate: Sat, 10 Feb 2018 12:36:29 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 11 Feb 2018 11:51:34 +0100

x86/Kconfig: Further simplify the NR_CPUS config

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

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180210113629.jcv6su3r4suuno63@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/Kconfig | 66 ++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 26 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9d921b7..a528c14 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
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
