Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752284AbeBZJ1N (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 04:27:13 -0500
Received: from smtp-4.orcon.net.nz ([60.234.4.59]:51858 "EHLO
        smtp-4.orcon.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752027AbeBZJ1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 04:27:09 -0500
From: Michael Cree <mcree@orcon.net.nz>
To: linux-alpha@vger.kernel.org
Cc: Matt Turner <mattst88@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org,
        Michael Cree <mcree@orcon.net.nz>
Subject: [PATCH] alpha: Implement CPU vulnerabilities sysfs functions.
Date: Mon, 26 Feb 2018 22:02:12 +1300
Message-Id: <20180226090212.23871-1-mcree@orcon.net.nz>
X-Mailer: git-send-email 2.11.0
X-GeoIP: NZ
X-Spam_score: -2.9
X-Spam_score_int: -28
X-Spam_bar: --
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the CPU vulnerabilty show functions for meltdown, spectre_v1
and spectre_v2 on Alpha.

Tests on XP1000 (EV67/667MHz) and ES45 (EV68CB/1.25GHz) show them
to be vulnerable to Meltdown and Spectre V1.  In the case of
Meltdown I saw a 1 to 2% success rate in reading bytes on the
XP1000 and 50 to 60% success rate on the ES45. (This compares to
99.97% success reported for Intel CPUs.)  Report EV6 and later
CPUs as vulnerable.

Tests on PWS600au (EV56/600MHz) for Spectre V1 attack were
unsuccessful (though I did not try particularly hard) so mark EV4
through to EV56 as not vulnerable.

Signed-off-by: Michael Cree <mcree@orcon.net.nz>
---
 arch/alpha/Kconfig         |  1 +
 arch/alpha/kernel/Makefile |  2 +-
 arch/alpha/kernel/bugs.c   | 45 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 1 deletion(-)
 create mode 100644 arch/alpha/kernel/bugs.c

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index e96adcbcab41..b2022885ced8 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -18,6 +18,7 @@ config ALPHA
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select AUDIT_ARCH
 	select GENERIC_CLOCKEVENTS
+	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_STRNCPY_FROM_USER
 	select GENERIC_STRNLEN_USER
diff --git a/arch/alpha/kernel/Makefile b/arch/alpha/kernel/Makefile
index bf7b41fa7b01..5a74581bf0ee 100644
--- a/arch/alpha/kernel/Makefile
+++ b/arch/alpha/kernel/Makefile
@@ -9,7 +9,7 @@ ccflags-y	:= -Wno-sign-compare
 
 obj-y    := entry.o traps.o process.o osf_sys.o irq.o \
 	    irq_alpha.o signal.o setup.o ptrace.o time.o \
-	    systbls.o err_common.o io.o
+	    systbls.o err_common.o io.o bugs.o
 
 obj-$(CONFIG_VGA_HOSE)	+= console.o
 obj-$(CONFIG_SMP)	+= smp.o
diff --git a/arch/alpha/kernel/bugs.c b/arch/alpha/kernel/bugs.c
new file mode 100644
index 000000000000..08cc10d7fa17
--- /dev/null
+++ b/arch/alpha/kernel/bugs.c
@@ -0,0 +1,45 @@
+
+#include <asm/hwrpb.h>
+#include <linux/device.h>
+
+
+#ifdef CONFIG_SYSFS
+
+static int cpu_is_ev6_or_later(void)
+{
+	struct percpu_struct *cpu;
+        unsigned long cputype;
+
+        cpu = (struct percpu_struct *)((char *)hwrpb + hwrpb->processor_offset);
+        cputype = cpu->type & 0xffffffff;
+        /* Include all of EV6, EV67, EV68, EV7, EV79 and EV69. */
+        return (cputype == EV6_CPU) || ((cputype >= EV67_CPU) && (cputype <= EV69_CPU));
+}
+
+ssize_t cpu_show_meltdown(struct device *dev,
+			  struct device_attribute *attr, char *buf)
+{
+	if (cpu_is_ev6_or_later())
+		return sprintf(buf, "Vulnerable\n");
+	else
+		return sprintf(buf, "Not affected\n");
+}
+
+ssize_t cpu_show_spectre_v1(struct device *dev,
+                            struct device_attribute *attr, char *buf)
+{
+	if (cpu_is_ev6_or_later())
+		return sprintf(buf, "Vulnerable\n");
+	else
+		return sprintf(buf, "Not affected\n");
+}
+
+ssize_t cpu_show_spectre_v2(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	if (cpu_is_ev6_or_later())
+		return sprintf(buf, "Vulnerable\n");
+	else
+		return sprintf(buf, "Not affected\n");
+}
+#endif
-- 
2.11.0
