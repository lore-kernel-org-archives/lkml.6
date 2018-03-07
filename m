Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsJjKVDU4uR4PJHl6lgleUYtZrB9FxaJZPHrvQrYOIcn6emJHsGS1E3di3aFMJv5yZcxyBO
ARC-Seal: i=1; a=rsa-sha256; t=1520451923; cv=none;
        d=google.com; s=arc-20160816;
        b=In2MXApqkoU+8BPMLKTTNiIHA4PaZs/zFeBVARdM6R1w7cQfhACOptI5HvzB9UpUwU
         Cw07yWoJ+cFrZKOac8jnZIqJMq2vY4nJix1t914+k7p2U/8s6gLSOAqh5/vYIzNs8+zL
         OPNNJJFyv8hfowNIxX3+/ORYiGiJLz1/LbkV54X+iUfqw008FeZfpqB836B878coBLrf
         AgPW98mELWltKxS/cvo+XFi0ydHCRE72hX7pga/Pfpj3urnAY1zLqYiLWki1H/uVRONh
         3KSpkfdPkMCgz3Nzdx3dpnJ7YamwG3KY4WckMm3z517UAdWjXXIKQyiOCzbIGIPTQw4q
         yd9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=iItEXLRYWbbPwINr0Wn8mNT5o9YjqLPzRFVXLepUtiE=;
        b=bKmhMOUXFQwdfRTrl9ZA2Omrs02qDcG5vOX2+0t1Oq/iKiHjJcrfU7OIGzNnRugGpq
         dqOfXTVFPn9rxAfsKFuOgGFF2NNQgp1awtsMsIybISA4uoG4g3uSwvNX3v2mrHf/AWL8
         RycyemaCYPq9P+cYTXJ93CRiyDh5S3JunAe7aQgwnJboMWSnfB8tXGCSwUavXLjTfqbX
         u0L0LvwMH1PcxIhBz5BaGw76OUFsc/LaSlwbPUnCTK4RuoUH0GUE8Ouown+61h3PsJE2
         aIFJEG2GNq2GZEpwUUV5kBHrmLCVpOw1Nb3mAS7TBc7puGjBOVbd/X3KGCyVaa5pAgES
         2Ulg==
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
Subject: [PATCH 4.14 031/110] x86/xen: Zero MSR_IA32_SPEC_CTRL before suspend
Date: Wed,  7 Mar 2018 11:38:14 -0800
Message-Id: <20180307191043.718826919@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309192061179507?=
X-GMAIL-MSGID: =?utf-8?q?1594309395727710907?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 	if (xen_pv_domain())
@@ -31,6 +36,9 @@ void xen_arch_post_suspend(int cancelled
 
 static void xen_vcpu_notify_restore(void *data)
 {
+	if (xen_pv_domain() && boot_cpu_has(X86_FEATURE_SPEC_CTRL))
+		wrmsrl(MSR_IA32_SPEC_CTRL, this_cpu_read(spec_ctrl));
+
 	/* Boot processor notified via generic timekeeping_resume() */
 	if (smp_processor_id() == 0)
 		return;
@@ -40,7 +48,15 @@ static void xen_vcpu_notify_restore(void
 
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
