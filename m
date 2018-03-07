Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsQd/FzCq6e8Od1Uf8NXd5dvYw8ku4dJu69gs8QtkA0BiLq8+T7clS5/fJr3nqvJTIuY8/S
ARC-Seal: i=1; a=rsa-sha256; t=1520451728; cv=none;
        d=google.com; s=arc-20160816;
        b=v2gWuWMW6PahtfJ2qZaLdTT4VkUEqywxhTE98rgxMc+Gdu0bCxYDVuTVRngmOVKLwo
         HfAmLEoNWQ+baskDHKsZpMT007REcWfHv0NY7bemLj5pmfi675qxFdHi8p4YYIKTWXpq
         CSAWI+t/y2rKbg5Uvxwz5T38/22H6wgP/rYbEPIYeP9ssAjN6VcZE1dSKqhWQk1Mq1qP
         tn+Q+grl58+50WBLUqSxdOgKRfTvIHP3GyaRVGu0NR8bVPNaU3a1StNEcvhsu8YbIwms
         RulJdikTW7URoTHTSr+Xu3KA/ARoS6xwUCJC/hJgQ6TUGnTSA2+51teQa/Ol13qhSVw2
         nBng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZmrzP02aFpb5tg4zDIZIFWp5eS1NqS/be3q3NgtF6FA=;
        b=pByZhkvaExF1zlchOk9SVPAMNsRNdUmy9nU1VCm2fs4tUgOT3Uu0Pbl7GwkyY6nEs4
         V2M7yMvC7sqFGQUWDdANAbJtHSado7jBowpGtSeDATQHgmwQC0Px/yLWEmfqmn9V4Jut
         9NRLUQOtmufXHGeEtejow3SG+c6Cy9VNTPDIM2+5d+6cZPFCBKxLaTA6DmJOoM/jYOiw
         cyvuz9+jtjr9xe3jbeMPLjH3X/oaLRWnf2jjhJTB/LepIa8/7B0ciczYJL9KIZcoPiu7
         Aq171rTx/9Fr/GSCUg8aIMcjffD3l4eK1Yv5QjeXsrieFNDhKl8eJjksZw2UocxRl9ts
         Gj5g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jan Beulich <jbeulich@suse.com>,
	xen-devel@lists.xenproject.org,
	boris.ostrovsky@oracle.com
Subject: [PATCH 4.15 036/122] x86/xen: Zero MSR_IA32_SPEC_CTRL before suspend
Date: Wed,  7 Mar 2018 11:37:28 -0800
Message-Id: <20180307191734.376131923@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309192061179507?=
X-GMAIL-MSGID: =?utf-8?q?1594309192061179507?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Juergen Gross <jgross@suse.com>

commit 71c208dd54ab971036d83ff6d9837bae4976e623 upstream.

Older Xen versions (4.5 and before) might have problems migrating pv
guests with MSR_IA32_SPEC_CTRL having a non-zero value. So before
suspending zero that MSR and restore it after being resumed.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jan Beulich <jbeulich@suse.com>
Cc: stable@vger.kernel.org
Cc: xen-devel@lists.xenproject.org
Cc: boris.ostrovsky@oracle.com
Link: https://lkml.kernel.org/r/20180226140818.4849-1-jgross@suse.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/xen/suspend.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/arch/x86/xen/suspend.c
+++ b/arch/x86/xen/suspend.c
@@ -1,12 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/types.h>
 #include <linux/tick.h>
+#include <linux/percpu-defs.h>
 
 #include <xen/xen.h>
 #include <xen/interface/xen.h>
 #include <xen/grant_table.h>
 #include <xen/events.h>
 
+#include <asm/cpufeatures.h>
+#include <asm/msr-index.h>
 #include <asm/xen/hypercall.h>
 #include <asm/xen/page.h>
 #include <asm/fixmap.h>
@@ -15,6 +18,8 @@
 #include "mmu.h"
 #include "pmu.h"
 
+static DEFINE_PER_CPU(u64, spec_ctrl);
+
 void xen_arch_pre_suspend(void)
 {
 	xen_save_time_memory_area();
@@ -35,6 +40,9 @@ void xen_arch_post_suspend(int cancelled
 
 static void xen_vcpu_notify_restore(void *data)
 {
+	if (xen_pv_domain() && boot_cpu_has(X86_FEATURE_SPEC_CTRL))
+		wrmsrl(MSR_IA32_SPEC_CTRL, this_cpu_read(spec_ctrl));
+
 	/* Boot processor notified via generic timekeeping_resume() */
 	if (smp_processor_id() == 0)
 		return;
@@ -44,7 +52,15 @@ static void xen_vcpu_notify_restore(void
 
 static void xen_vcpu_notify_suspend(void *data)
 {
+	u64 tmp;
+
 	tick_suspend_local();
+
+	if (xen_pv_domain() && boot_cpu_has(X86_FEATURE_SPEC_CTRL)) {
+		rdmsrl(MSR_IA32_SPEC_CTRL, tmp);
+		this_cpu_write(spec_ctrl, tmp);
+		wrmsrl(MSR_IA32_SPEC_CTRL, 0);
+	}
 }
 
 void xen_arch_resume(void)
