Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932527AbeBLBr2 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 20:47:28 -0500
Received: from [198.137.202.136] ([198.137.202.136]:58079 "EHLO
        terminus.zytor.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S932299AbeBLBrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 20:47:25 -0500
Date: Sun, 11 Feb 2018 04:11:42 -0800
From: tip-bot for Randy Dunlap <tipbot@zytor.com>
Message-ID: <tip-a0d0bb4deba831085d3eeb32d39fe73713ce6eb2@git.kernel.org>
Cc: hpa@zytor.com, torvalds@linux-foundation.org, peterz@infradead.org,
        rdunlap@infradead.org, torvalds@linuxfoundation.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
        rdunlap@infradead.org, peterz@infradead.org, mingo@kernel.org,
        torvalds@linuxfoundation.org, torvalds@linux-foundation.org
In-Reply-To: <0b833246-ed4b-e451-c426-c4464725be92@infradead.org>
References: <0b833246-ed4b-e451-c426-c4464725be92@infradead.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/Kconfig: Simplify NR_CPUS config
Git-Commit-ID: a0d0bb4deba831085d3eeb32d39fe73713ce6eb2
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

Commit-ID:  a0d0bb4deba831085d3eeb32d39fe73713ce6eb2
Gitweb:     https://git.kernel.org/tip/a0d0bb4deba831085d3eeb32d39fe73713ce6eb2
Author:     Randy Dunlap <rdunlap@infradead.org>
AuthorDate: Fri, 9 Feb 2018 16:51:03 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 11 Feb 2018 11:51:33 +0100

x86/Kconfig: Simplify NR_CPUS config

Clean up and simplify the X86 NR_CPUS Kconfig symbol/option by
introducing RANGE_BEGIN_CPUS, RANGE_END_CPUS, and DEF_CONFIG_CPUS.
Then combine some default values when their conditionals can be
reduced.

Also move the X86_BIGSMP kconfig option inside an "if X86_32"/"endif"
config block and drop its explicit "depends on X86_32".

Combine the max. 8192 cases of RANGE_END_CPUS (X86_64 only).
Split RANGE_END_CPUS and DEF_CONFIG_CPUS into separate cases for
X86_32 and X86_64.

Suggested-by: Linus Torvalds <torvalds@linuxfoundation.org>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/0b833246-ed4b-e451-c426-c4464725be92@infradead.org
Link: lkml.kernel.org/r/CA+55aFzOd3j6ZUSkEwTdk85qtt1JywOtm3ZAb-qAvt8_hJ6D4A@mail.gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/Kconfig | 57 +++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 42 insertions(+), 15 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 63bf349..9d921b7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
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
@@ -949,17 +949,44 @@ config MAXSMP
 	  Enable maximum number of CPUS and NUMA Nodes for this architecture.
 	  If unsure, say N.
 
+config RANGE_END_CPUS
+	int
+	depends on X86_32
+	default 8 if SMP && !X86_BIGSMP
+	default 64 if SMP && X86_BIGSMP
+	default 1 if !SMP
+
+config RANGE_END_CPUS
+	int
+	depends on X86_64
+	default 512 if SMP && !MAXSMP && !CPUMASK_OFFSTACK
+	default 8192 if SMP && (MAXSMP || CPUMASK_OFFSTACK)
+	default 1 if !SMP
+
+config RANGE_BEGIN_CPUS
+	int
+	default 1 if !SMP
+	default RANGE_END_CPUS if MAXSMP
+	default 2
+
+config DEF_CONFIG_CPUS
+	int
+	depends on X86_32
+	default 1 if !SMP
+	default 32 if X86_BIGSMP
+	default 8 if SMP
+
+config DEF_CONFIG_CPUS
+	int
+	depends on X86_64
+	default 1 if !SMP
+	default 8192 if MAXSMP
+	default 64 if SMP
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
+	range RANGE_BEGIN_CPUS RANGE_END_CPUS
+	default DEF_CONFIG_CPUS
 	---help---
 	  This allows you to specify the maximum number of CPUs which this
 	  kernel will support.  If CPUMASK_OFFSTACK is enabled, the maximum
