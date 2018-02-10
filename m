Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753369AbeBJAvH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 19:51:07 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:36877 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753300AbeBJAvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 19:51:06 -0500
Subject: [PATCH v2] x86: simplify NR_CPUS config
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <56d0376c-dc1f-334b-d392-a8c5cd85f4aa@infradead.org>
 <CA+55aFymknkNH2mP1vX5ZLEqQwA3BgxQhZF-SUbbJMwTDL6hAA@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0b833246-ed4b-e451-c426-c4464725be92@infradead.org>
Date: Fri, 9 Feb 2018 16:51:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFymknkNH2mP1vX5ZLEqQwA3BgxQhZF-SUbbJMwTDL6hAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

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
Link: lkml.kernel.org/r/CA+55aFzOd3j6ZUSkEwTdk85qtt1JywOtm3ZAb-qAvt8_hJ6D4A@mail.gmail.com
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: x86@kernel.org
---
 arch/x86/Kconfig |   57 +++++++++++++++++++++++++++++++++------------
 1 file changed, 42 insertions(+), 15 deletions(-)

v2: more simplification as suggested by Linus; also separate the
    X86_32 and X86_64 configs.

--- linux-next-20180209.orig/arch/x86/Kconfig
+++ linux-next-20180209/arch/x86/Kconfig
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
