Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoQSz+oZlwDTML4V0snNqPh8WBq+xpWIS5nB2VbgIoMYAA0X0zcSU15ErtfK7W2K5zGjqeF
ARC-Seal: i=1; a=rsa-sha256; t=1526938030; cv=none;
        d=google.com; s=arc-20160816;
        b=csL2MAXXA1Ck4twwTbtR08opJU67IivxfsMcdc8fa3abhvYtUGMmO5+wJcZ3YgjRQg
         YDxzw4ighIgBoD5JAZo9sQUu5hgKu3dq/FrjfrWSDLvgYfPHfR0V+x9/IClwf1nrOsv6
         k2eI/DUE5QAkAolTnvSMuByRrfOQFC/H8vb/vnEiQ/s7mNZ0rfUMKd35TKg4zquqZ+7I
         rP7cIjiTXhDnvVTQRIP0qKPPM6OmIfI6cDgwsXblpDB3NF2uPehHmo9c8YS9okQFXhyA
         HwC5pHswBkdZUBhwGXVZvE5Qfkv5C+PGb8FYRUVc/tNd3/fI+HPSIvSG9plSHmJL6VgH
         aH2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=JHMfMTGoG7hoTLudQjxJit92H37cyTuPs8khbnuWKEQ=;
        b=MdmZAdD9krE2ubz9ytXu3IoXi55qYFrP6+KNQcd6v1cYnJ042WN4aSstuAZb/HTb7b
         CqxpUQvpfmWvfZUy3qaFrNdZfCELD7PAY9Qy/m/1TpdepDLOd7Ac4wTkcg4g4pDecvpi
         1W5lNp6vh2lukYg2EaKtWUhfryLHaAQmnO/cu7CnYaSZJD2Et9KSntjd35cwGG8P4mWq
         gbaqNJSGg8HJHC1hFXXx4WV+Jg5H1k6+pkbdRg/4Ktc0C0Htl7Uc/6/2Sbw/Dn4plXlR
         YQKdFdV6zz6fzLgqqzQFCKWau5uMo4+Gu4Sde2gsKGUer764EvqKtiXXbXEZDSLmFAE1
         9HAg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=GjeU2t5Q;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=GjeU2t5Q;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Borislav Petkov <bp@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 4.16 103/110] x86/bugs: Unify x86_spec_ctrl_{set_guest,restore_host}
Date: Mon, 21 May 2018 23:12:40 +0200
Message-Id: <20180521210514.771111887@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109949692245896?=
X-GMAIL-MSGID: =?utf-8?q?1601110571850254762?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

commit cc69b34989210f067b2c51d5539b5f96ebcc3a01 upstream

Function bodies are very similar and are going to grow more almost
identical code. Add a bool arg to determine whether SPEC_CTRL is being set
for the guest or restored to the host.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/spec-ctrl.h |   33 ++++++++++++++++++---
 arch/x86/kernel/cpu/bugs.c       |   60 +++++++++------------------------------
 2 files changed, 44 insertions(+), 49 deletions(-)

--- a/arch/x86/include/asm/spec-ctrl.h
+++ b/arch/x86/include/asm/spec-ctrl.h
@@ -13,10 +13,35 @@
  * Takes the guest view of SPEC_CTRL MSR as a parameter and also
  * the guest's version of VIRT_SPEC_CTRL, if emulated.
  */
-extern void x86_spec_ctrl_set_guest(u64 guest_spec_ctrl,
-				    u64 guest_virt_spec_ctrl);
-extern void x86_spec_ctrl_restore_host(u64 guest_spec_ctrl,
-				       u64 guest_virt_spec_ctrl);
+extern void x86_virt_spec_ctrl(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl, bool guest);
+
+/**
+ * x86_spec_ctrl_set_guest - Set speculation control registers for the guest
+ * @guest_spec_ctrl:		The guest content of MSR_SPEC_CTRL
+ * @guest_virt_spec_ctrl:	The guest controlled bits of MSR_VIRT_SPEC_CTRL
+ *				(may get translated to MSR_AMD64_LS_CFG bits)
+ *
+ * Avoids writing to the MSR if the content/bits are the same
+ */
+static inline
+void x86_spec_ctrl_set_guest(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl)
+{
+	x86_virt_spec_ctrl(guest_spec_ctrl, guest_virt_spec_ctrl, true);
+}
+
+/**
+ * x86_spec_ctrl_restore_host - Restore host speculation control registers
+ * @guest_spec_ctrl:		The guest content of MSR_SPEC_CTRL
+ * @guest_virt_spec_ctrl:	The guest controlled bits of MSR_VIRT_SPEC_CTRL
+ *				(may get translated to MSR_AMD64_LS_CFG bits)
+ *
+ * Avoids writing to the MSR if the content/bits are the same
+ */
+static inline
+void x86_spec_ctrl_restore_host(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl)
+{
+	x86_virt_spec_ctrl(guest_spec_ctrl, guest_virt_spec_ctrl, false);
+}
 
 /* AMD specific Speculative Store Bypass MSR data */
 extern u64 x86_amd_ls_cfg_base;
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -151,55 +151,25 @@ u64 x86_spec_ctrl_get_default(void)
 }
 EXPORT_SYMBOL_GPL(x86_spec_ctrl_get_default);
 
-/**
- * x86_spec_ctrl_set_guest - Set speculation control registers for the guest
- * @guest_spec_ctrl:		The guest content of MSR_SPEC_CTRL
- * @guest_virt_spec_ctrl:	The guest controlled bits of MSR_VIRT_SPEC_CTRL
- *				(may get translated to MSR_AMD64_LS_CFG bits)
- *
- * Avoids writing to the MSR if the content/bits are the same
- */
-void x86_spec_ctrl_set_guest(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl)
+void
+x86_virt_spec_ctrl(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl, bool setguest)
 {
-	u64 host = x86_spec_ctrl_base;
+	struct thread_info *ti = current_thread_info();
+	u64 msr, host = x86_spec_ctrl_base;
 
 	/* Is MSR_SPEC_CTRL implemented ? */
-	if (!static_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
-		return;
-
-	/* SSBD controlled in MSR_SPEC_CTRL */
-	if (static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD))
-		host |= ssbd_tif_to_spec_ctrl(current_thread_info()->flags);
-
-	if (host != guest_spec_ctrl)
-		wrmsrl(MSR_IA32_SPEC_CTRL, guest_spec_ctrl);
-}
-EXPORT_SYMBOL_GPL(x86_spec_ctrl_set_guest);
-
-/**
- * x86_spec_ctrl_restore_host - Restore host speculation control registers
- * @guest_spec_ctrl:		The guest content of MSR_SPEC_CTRL
- * @guest_virt_spec_ctrl:	The guest controlled bits of MSR_VIRT_SPEC_CTRL
- *				(may get translated to MSR_AMD64_LS_CFG bits)
- *
- * Avoids writing to the MSR if the content/bits are the same
- */
-void x86_spec_ctrl_restore_host(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl)
-{
-	u64 host = x86_spec_ctrl_base;
-
-	/* Is MSR_SPEC_CTRL implemented ? */
-	if (!static_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
-		return;
-
-	/* SSBD controlled in MSR_SPEC_CTRL */
-	if (static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD))
-		host |= ssbd_tif_to_spec_ctrl(current_thread_info()->flags);
-
-	if (host != guest_spec_ctrl)
-		wrmsrl(MSR_IA32_SPEC_CTRL, host);
+	if (static_cpu_has(X86_FEATURE_MSR_SPEC_CTRL)) {
+		/* SSBD controlled in MSR_SPEC_CTRL */
+		if (static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD))
+			host |= ssbd_tif_to_spec_ctrl(ti->flags);
+
+		if (host != guest_spec_ctrl) {
+			msr = setguest ? guest_spec_ctrl : host;
+			wrmsrl(MSR_IA32_SPEC_CTRL, msr);
+		}
+	}
 }
-EXPORT_SYMBOL_GPL(x86_spec_ctrl_restore_host);
+EXPORT_SYMBOL_GPL(x86_virt_spec_ctrl);
 
 static void x86_amd_ssb_disable(void)
 {
