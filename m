Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389EAC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0869220661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:23:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0869220661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbeLIWXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:23:03 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35146 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726322AbeLIVzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:20 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72k-0002ib-7g; Sun, 09 Dec 2018 21:55:18 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72h-0003Yw-Je; Sun, 09 Dec 2018 21:55:15 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Thomas Gleixner" <tglx@linutronix.de>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Ingo Molnar" <mingo@kernel.org>, "Borislav Petkov" <bp@alien8.de>,
        "Peter Zijlstra" <peterz@infradead.org>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.248538111@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 232/328] x86/boot: Move EISA setup to a separate file
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit f7eaf6e00fd581043bb540dfe865f1d81769b189 upstream.

EISA has absolutely nothing to do with traps, so move it out of traps.c
into its own eisa.c file.

Furthermore, the EISA bus detection does not need to run during
very early boot, it's good enough to run it before the EISA bus
and drivers are initialized.

I.e. instead of calling it from the very early trap_init() code,
make it a subsys_initcall().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Link: http://lkml.kernel.org/r/20170828064956.515322409@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/Makefile |  1 +
 arch/x86/kernel/eisa.c   | 18 ++++++++++++++++++
 arch/x86/kernel/traps.c  | 13 -------------
 3 files changed, 19 insertions(+), 13 deletions(-)
 create mode 100644 arch/x86/kernel/eisa.c

--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -92,6 +92,7 @@ obj-$(CONFIG_PARAVIRT)		+= paravirt.o pa
 obj-$(CONFIG_PARAVIRT_SPINLOCKS)+= paravirt-spinlocks.o
 obj-$(CONFIG_PARAVIRT_CLOCK)	+= pvclock.o
 
+obj-$(CONFIG_EISA)		+= eisa.o
 obj-$(CONFIG_PCSPKR_PLATFORM)	+= pcspeaker.o
 
 obj-$(CONFIG_X86_CHECK_BIOS_CORRUPTION) += check.o
--- /dev/null
+++ b/arch/x86/kernel/eisa.c
@@ -0,0 +1,18 @@
+/*
+ * EISA specific code
+ *
+ * This file is licensed under the GPL V2
+ */
+#include <linux/ioport.h>
+#include <linux/eisa.h>
+
+static __init int eisa_bus_probe(void)
+{
+	void __iomem *p = ioremap(0x0FFFD9, 4);
+
+	if (readl(p) == 'E' + ('I'<<8) + ('S'<<16) + ('A'<<24))
+		EISA_bus = 1;
+	iounmap(p);
+	return 0;
+}
+subsys_initcall(eisa_bus_probe);
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -37,11 +37,6 @@
 #include <linux/smp.h>
 #include <linux/io.h>
 
-#ifdef CONFIG_EISA
-#include <linux/ioport.h>
-#include <linux/eisa.h>
-#endif
-
 #if defined(CONFIG_EDAC)
 #include <linux/edac.h>
 #endif
@@ -796,14 +791,6 @@ void __init trap_init(void)
 {
 	int i;
 
-#ifdef CONFIG_EISA
-	void __iomem *p = early_ioremap(0x0FFFD9, 4);
-
-	if (readl(p) == 'E' + ('I'<<8) + ('S'<<16) + ('A'<<24))
-		EISA_bus = 1;
-	early_iounmap(p, 4);
-#endif
-
 	set_intr_gate(X86_TRAP_DE, divide_error);
 	set_intr_gate_ist(X86_TRAP_NMI, &nmi, NMI_STACK);
 	/* int4 can be called from all */

