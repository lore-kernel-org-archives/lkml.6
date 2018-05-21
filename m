Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr+cSrNw3Cd8GSNMSArx9JTclQwk7Jkby/5Bw517uB+LMvICwKZuvyzbXewsRiH8E1gi6YL
ARC-Seal: i=1; a=rsa-sha256; t=1526937442; cv=none;
        d=google.com; s=arc-20160816;
        b=QEEpc/BkSOucNfmM71TurgHGG/RuvWBSaMtmPk7MHcj1oUJ7xBTuXsEvV266yD29mv
         5lJbPzeahDo41SEpizYY+TycNyDGoBHrhGpMmtUw9Y6L8YIjHGs93LWUsfieQwtMsMnr
         wY2ZjKvPqEF7SmtF1NrpsWKlfHYE9SGUInHAitW0BMuwtypUs+lLLeSAPxe5yldOAhiu
         H/8ZXAq35B5+5Q8br1ZM7IgnrtRIA821Ayh5RiAr7phtvooYNVmKVXrDY4yTTYQNhEx6
         Y7/ZQPFzm6BMdex1IoLdZWfF2NBHsPVMk+7JQmquju7TpFbtUmw92at6afvDWWbjPo4N
         Uapg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=ToQrIKZm/BLRcPbrayANtql2Bo0CEx6+F62OB5gWdjg=;
        b=P9V0IvbVK3J6QLtwTml3Xolkiq8K9WRDcZBxnYn6yBj6tqANMBz9oLAeRzWEEv5tOo
         +hutGQTGHWeX0x3vI4n0SH8EAu84SfMNAlvJx5pNj96j2HnkupCg+FQYv7H8dCT0joIw
         p+3LmsMdpsxSzPGrSNJgBBkrQGSsc6LwgeqFnLknhwiUH31QGhpu+aL0qKY08gLMpp/i
         TnvzZkf4Oxtlh9TXQFMm6TOtpNfe2PaQVwRjMmwxEQllFfofhK8aWqZkMMriNLr01ZQ+
         PfngJ7gfVsap7jTK9KUjVssyHcG1UUkRNbXRAiOIjL4G6BGmkLMdXOCs+0eOMDUo6p8I
         /MLQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=bQHQU6mh;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=bQHQU6mh;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@suse.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 82/87] x86/bugs: Expose x86_spec_ctrl_base directly
Date: Mon, 21 May 2018 23:11:58 +0200
Message-Id: <20180521210427.008568976@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109955955970722?=
X-GMAIL-MSGID: =?utf-8?q?1601109955955970722?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit fa8ac4988249c38476f6ad678a4848a736373403 upstream

x86_spec_ctrl_base is the system wide default value for the SPEC_CTRL MSR.
x86_spec_ctrl_get_default() returns x86_spec_ctrl_base and was intended to
prevent modification to that variable. Though the variable is read only
after init and globaly visible already.

Remove the function and export the variable instead.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/nospec-branch.h |   16 +++++-----------
 arch/x86/include/asm/spec-ctrl.h     |    3 ---
 arch/x86/kernel/cpu/bugs.c           |   11 +----------
 3 files changed, 6 insertions(+), 24 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -217,16 +217,7 @@ enum spectre_v2_mitigation {
 	SPECTRE_V2_IBRS,
 };
 
-/*
- * The Intel specification for the SPEC_CTRL MSR requires that we
- * preserve any already set reserved bits at boot time (e.g. for
- * future additions that this kernel is not currently aware of).
- * We then set any additional mitigation bits that we want
- * ourselves and always use this as the base for SPEC_CTRL.
- * We also use this when handling guest entry/exit as below.
- */
 extern void x86_spec_ctrl_set(u64);
-extern u64 x86_spec_ctrl_get_default(void);
 
 /* The Speculative Store Bypass disable variants */
 enum ssb_mitigation {
@@ -278,6 +269,9 @@ static inline void indirect_branch_predi
 	alternative_msr_write(MSR_IA32_PRED_CMD, val, X86_FEATURE_USE_IBPB);
 }
 
+/* The Intel SPEC CTRL MSR base value cache */
+extern u64 x86_spec_ctrl_base;
+
 /*
  * With retpoline, we must use IBRS to restrict branch prediction
  * before calling into firmware.
@@ -286,7 +280,7 @@ static inline void indirect_branch_predi
  */
 #define firmware_restrict_branch_speculation_start()			\
 do {									\
-	u64 val = x86_spec_ctrl_get_default() | SPEC_CTRL_IBRS;		\
+	u64 val = x86_spec_ctrl_base | SPEC_CTRL_IBRS;			\
 									\
 	preempt_disable();						\
 	alternative_msr_write(MSR_IA32_SPEC_CTRL, val,			\
@@ -295,7 +289,7 @@ do {									\
 
 #define firmware_restrict_branch_speculation_end()			\
 do {									\
-	u64 val = x86_spec_ctrl_get_default();				\
+	u64 val = x86_spec_ctrl_base;					\
 									\
 	alternative_msr_write(MSR_IA32_SPEC_CTRL, val,			\
 			      X86_FEATURE_USE_IBRS_FW);			\
--- a/arch/x86/include/asm/spec-ctrl.h
+++ b/arch/x86/include/asm/spec-ctrl.h
@@ -47,9 +47,6 @@ void x86_spec_ctrl_restore_host(u64 gues
 extern u64 x86_amd_ls_cfg_base;
 extern u64 x86_amd_ls_cfg_ssbd_mask;
 
-/* The Intel SPEC CTRL MSR base value cache */
-extern u64 x86_spec_ctrl_base;
-
 static inline u64 ssbd_tif_to_spec_ctrl(u64 tifn)
 {
 	BUILD_BUG_ON(TIF_SSBD < SPEC_CTRL_SSBD_SHIFT);
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -35,6 +35,7 @@ static void __init ssb_select_mitigation
  * writes to SPEC_CTRL contain whatever reserved bits have been set.
  */
 u64 __ro_after_init x86_spec_ctrl_base;
+EXPORT_SYMBOL_GPL(x86_spec_ctrl_base);
 
 /*
  * The vendor and possibly platform specific bits which can be modified in
@@ -140,16 +141,6 @@ void x86_spec_ctrl_set(u64 val)
 }
 EXPORT_SYMBOL_GPL(x86_spec_ctrl_set);
 
-u64 x86_spec_ctrl_get_default(void)
-{
-	u64 msrval = x86_spec_ctrl_base;
-
-	if (static_cpu_has(X86_FEATURE_SPEC_CTRL))
-		msrval |= ssbd_tif_to_spec_ctrl(current_thread_info()->flags);
-	return msrval;
-}
-EXPORT_SYMBOL_GPL(x86_spec_ctrl_get_default);
-
 void
 x86_virt_spec_ctrl(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl, bool setguest)
 {
