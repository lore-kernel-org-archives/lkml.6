Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtDyRz18mRb8Jx7/7gLnfF1uxq+SmuxnXDwY9UVXWz6PPRUN6N6Tve1GXotcJRLHeAIJ084
ARC-Seal: i=1; a=rsa-sha256; t=1520641270; cv=none;
        d=google.com; s=arc-20160816;
        b=ytCZiHrM9lUIkOYASqTOVDPa9TLbBznaHHbxUKal1/wqBpkYR6YocMDGaB/fx2dBp/
         1dJIuQv92awj/CTqJruQDZ3S5jRWuXjA5LIWIGx79sOjQu2oVxCYs8r2SYQpfYZwNF04
         BrA9xmwP/B3uNS8IaXZ/BYdTF6FVU/sDG7EVXRbZlC1wPetG1y+MPFRnPK1ZyN5jySAh
         YiaC8egZkA3jZmV7k3TxQD5O8Z/dcYlbl0u+A8SLD0ZpjgvAvJqZixQkCoEzQwtdCtoz
         ER8/9NMzRzHV375FFj2DQjP4UwmJce3axlr+UxPb8cS0SqvP2xe8i59MB1Ezd92NBcYj
         YtlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1JW0mQw+MgHTV9BFiYz0/oPT/ONbyZ+NA9exJwiwTxU=;
        b=0+JKolPx1YOEbWcBpnVIScxMskdhaqXGLQpueNXGITZdwHBjJoQvG5VfECCxAQ9vGI
         NpD8gdT3VAl9OYLIu+h4aGKgW9B9Xp7Uexr/3c0Okn07cZxBtSi0PVFgXnWzJ7v+fglG
         cVr3PY7Dh/8/lULfWMfafCGM6a7R0wYFzgq2kXV45SfE6rt4rFBP65XO/bMShyJ/LAMx
         0ED3KeSyE75meqdzdb0A0KCKb6VdfHCbkBt6HisXCXOqUW8+KE/QRImBj+mVB835+TpJ
         p+vKJBUccCv7W9xaKpYJ7PXXVXOY0nG3Exago2hUt1p1Q/Sik8XMXlnPt+bfjC73Am8L
         gF1w==
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
Subject: [PATCH 4.9 15/65] x86/xen: Zero MSR_IA32_SPEC_CTRL before suspend
Date: Fri,  9 Mar 2018 16:18:15 -0800
Message-Id: <20180310001826.213960392@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507940091175389?=
X-GMAIL-MSGID: =?utf-8?q?1594507940091175389?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1,11 +1,14 @@
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
@@ -68,6 +71,8 @@ static void xen_pv_post_suspend(int susp
 	xen_mm_unpin_all();
 }
 
+static DEFINE_PER_CPU(u64, spec_ctrl);
+
 void xen_arch_pre_suspend(void)
 {
 	if (xen_pv_domain())
@@ -84,6 +89,9 @@ void xen_arch_post_suspend(int cancelled
 
 static void xen_vcpu_notify_restore(void *data)
 {
+	if (xen_pv_domain() && boot_cpu_has(X86_FEATURE_SPEC_CTRL))
+		wrmsrl(MSR_IA32_SPEC_CTRL, this_cpu_read(spec_ctrl));
+
 	/* Boot processor notified via generic timekeeping_resume() */
 	if (smp_processor_id() == 0)
 		return;
@@ -93,7 +101,15 @@ static void xen_vcpu_notify_restore(void
 
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
