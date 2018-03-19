Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELspfRshe+BVUE3dsRBUuw1P9IqJT6uLgNiVKHDvrjJVAcNcGlXg2nPru3X7glUtiaq0hPJG
ARC-Seal: i=1; a=rsa-sha256; t=1521483529; cv=none;
        d=google.com; s=arc-20160816;
        b=HOM06wV8UiNXfrL4jCpNLycwoB4JM7NecN8KQeAQ5glVgGlN0DJqq43EElctLaYyPb
         T8JxIqdGTbz+qZ/k4DOI1RAfHBtvpMPlHu/XlIFYFq+7SxmNUsemCz1wcSQ64rMB8eKY
         chl2F1wn93vt/r2T3oIYXt8RMqnmXWFZ0rWAJ4icntPEvVfee4h/e1w/beBDDUwirx3n
         Ky9MIMdkKqQhQbMyQzZTeBftCsmFIcQ0jqO/kYocJMhwT3FQOeZfjk9W6l4EH+gIWicK
         UxpqZJ4T3Ki+SUdyjk2crhjUcsWB9IbcS1Toy+iefMGOexrJ8KPH7vq/s90Bfj4gIBCZ
         GeUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6FDiO2tkTNNisq0vYo3Mk2A/QqklwA8M+72LH9b5CyQ=;
        b=O65PlazzRaIXCVR+vfQaLuWpU6RrVM+oyFQoyRqD7Ns702sUR+iUAqR7/xY4PCEwg3
         K04VNK7OiPJ1AJ5B92lCWtf9kfWI0kGpVPkxgneNEQK3Dgg5jtTcbdgtzjwyNaiFD+hm
         VlLEt6AtRJ6LDVSXvNHjoCWHecuCx8vq91wkM3k8XOWeMXmkchPhAowmsaIU3pxAlBY/
         ihMB3Ylq40YwWvoUAIvC5a1M+Yhf7lQnHC0ckYk/+PRJ5+OHwYoHH7injyrDbnHp4Jvd
         JWJwQavv69hIPf2LUeiL/4o2wegQBr4PTzboo1hWCD/KV37zNA0oCxc94Sl8D6PJJwpb
         cRsg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Xunlei Pang <xlpang@redhat.com>,
	Borislav Petkov <bp@suse.de>,
	Tony Luck <tony.luck@intel.com>,
	Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
	kexec@lists.infradead.org,
	linux-edac <linux-edac@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 022/241] x86/mce: Handle broadcasted MCE gracefully with kexec
Date: Mon, 19 Mar 2018 19:04:47 +0100
Message-Id: <20180319180752.087801059@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391113151628350?=
X-GMAIL-MSGID: =?utf-8?q?1595391113151628350?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xunlei Pang <xlpang@redhat.com>


[ Upstream commit 5bc329503e8191c91c4c40836f062ef771d8ba83 ]

When we are about to kexec a crash kernel and right then and there a
broadcasted MCE fires while we're still in the first kernel and while
the other CPUs remain in a holding pattern, the #MC handler of the
first kernel will timeout and then panic due to never completing MCE
synchronization.

Handle this in a similar way as to when the CPUs are offlined when that
broadcasted MCE happens.

[ Boris: rewrote commit message and comments. ]

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Xunlei Pang <xlpang@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Tony Luck <tony.luck@intel.com>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: kexec@lists.infradead.org
Cc: linux-edac <linux-edac@vger.kernel.org>
Link: http://lkml.kernel.org/r/1487857012-9059-1-git-send-email-xlpang@redhat.com
Link: http://lkml.kernel.org/r/20170313095019.19351-1-bp@alien8.de
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/reboot.h    |    1 +
 arch/x86/kernel/cpu/mcheck/mce.c |   18 ++++++++++++++++--
 arch/x86/kernel/reboot.c         |    5 +++--
 3 files changed, 20 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/reboot.h
+++ b/arch/x86/include/asm/reboot.h
@@ -15,6 +15,7 @@ struct machine_ops {
 };
 
 extern struct machine_ops machine_ops;
+extern int crashing_cpu;
 
 void native_machine_crash_shutdown(struct pt_regs *regs);
 void native_machine_shutdown(void);
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -48,6 +48,7 @@
 #include <asm/tlbflush.h>
 #include <asm/mce.h>
 #include <asm/msr.h>
+#include <asm/reboot.h>
 
 #include "mce-internal.h"
 
@@ -1081,9 +1082,22 @@ void do_machine_check(struct pt_regs *re
 	 * on Intel.
 	 */
 	int lmce = 1;
+	int cpu = smp_processor_id();
 
-	/* If this CPU is offline, just bail out. */
-	if (cpu_is_offline(smp_processor_id())) {
+	/*
+	 * Cases where we avoid rendezvous handler timeout:
+	 * 1) If this CPU is offline.
+	 *
+	 * 2) If crashing_cpu was set, e.g. we're entering kdump and we need to
+	 *  skip those CPUs which remain looping in the 1st kernel - see
+	 *  crash_nmi_callback().
+	 *
+	 * Note: there still is a small window between kexec-ing and the new,
+	 * kdump kernel establishing a new #MC handler where a broadcasted MCE
+	 * might not get handled properly.
+	 */
+	if (cpu_is_offline(cpu) ||
+	    (crashing_cpu != -1 && crashing_cpu != cpu)) {
 		u64 mcgstatus;
 
 		mcgstatus = mce_rdmsrl(MSR_IA32_MCG_STATUS);
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -769,10 +769,11 @@ void machine_crash_shutdown(struct pt_re
 #endif
 
 
+/* This is the CPU performing the emergency shutdown work. */
+int crashing_cpu = -1;
+
 #if defined(CONFIG_SMP)
 
-/* This keeps a track of which one is crashing cpu. */
-static int crashing_cpu;
 static nmi_shootdown_cb shootdown_callback;
 
 static atomic_t waiting_for_crash_ipi;
