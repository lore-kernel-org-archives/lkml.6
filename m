Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZorhClTZBzKOtOWZ+FWv7XqshOSoFrbwiJiN8ezF/h1khutDMPXF0OhM9oa0peS5mzztnrD
ARC-Seal: i=1; a=rsa-sha256; t=1526937595; cv=none;
        d=google.com; s=arc-20160816;
        b=wgxFrP/gCSerzyX3K5DBGvhLbpnbk9kzyTj2mL9VBpQn9LHGXsmG7sBvbjNAIktLj+
         XXBv1mCOkiHDM/6YY/K1aA2QOixGeooSnF35qX03aVHO8RfsbEoQxtOBegFYKY9oWUrq
         LWEZSHdH68vja+lBf/5qvJQ3g512dwTos+wqxGyCFmRH+6RcYoorffy2MMx30dXF6Go+
         Uh0OJjPvzQEdbAxLpeBENGrsATxzdz2v1DErtgi4vT8qbUyDKmHh5cAeQ0fqQxU7+OJD
         JxGi1/lTUDbZhsmHdN+vOmNs20plg3OlZiF+ZlWsIFwDXpF+Vz9Ii8cbvgyf0VL39FN2
         N7Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=tXh5raY/tC+4TVat06cL2G7tOv59NgVrF39/u/IfoDM=;
        b=MEH7KHHdlsfl0QIZfVQSMH4FvxhiFkqG/nerAtY+2y5RQdyRwhk5+4XGVjS9jsIGhr
         bGV111gkR6JxTPxSBkrOjvqTtUzE0EYuQaYCbG24yhnfWEfaSf3LeINLnHedzzxSWtkf
         m5WeGeTgT0qxRDzedsvf7TXkzjf3aEoNL+COThTPL5o27UPqSmIYuRoLavMldA19hIUK
         HgGMWZGhoupeMGGGKQT7jFrjVQB03OzXWn59xR9VPRxihaTNqnEFnRj2QsDN6aq48Nb7
         UMgn0efKTax1wRF/DBZZ4Ny2vOoc40CVH9VoNsPir/nTXylETaWwjrjhNoGZE5FcbCst
         Vaiw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=P2KdjAOq;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=P2KdjAOq;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jon Masters <jcm@redhat.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@suse.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 51/95] x86/bugs: Read SPEC_CTRL MSR during boot and re-use reserved bits
Date: Mon, 21 May 2018 23:11:41 +0200
Message-Id: <20180521210457.953818429@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109829596787230?=
X-GMAIL-MSGID: =?utf-8?q?1601110116036888632?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit 1b86883ccb8d5d9506529d42dbe1a5257cb30b18 upstream

The 336996-Speculative-Execution-Side-Channel-Mitigations.pdf refers to all
the other bits as reserved. The Intel SDM glossary defines reserved as
implementation specific - aka unknown.

As such at bootup this must be taken it into account and proper masking for
the bits in use applied.

A copy of this document is available at
https://bugzilla.kernel.org/show_bug.cgi?id=199511

[ tglx: Made x86_spec_ctrl_base __ro_after_init ]

Suggested-by: Jon Masters <jcm@redhat.com>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/nospec-branch.h |   24 ++++++++++++++++++++----
 arch/x86/kernel/cpu/bugs.c           |   28 ++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -217,6 +217,17 @@ enum spectre_v2_mitigation {
 	SPECTRE_V2_IBRS,
 };
 
+/*
+ * The Intel specification for the SPEC_CTRL MSR requires that we
+ * preserve any already set reserved bits at boot time (e.g. for
+ * future additions that this kernel is not currently aware of).
+ * We then set any additional mitigation bits that we want
+ * ourselves and always use this as the base for SPEC_CTRL.
+ * We also use this when handling guest entry/exit as below.
+ */
+extern void x86_spec_ctrl_set(u64);
+extern u64 x86_spec_ctrl_get_default(void);
+
 extern char __indirect_thunk_start[];
 extern char __indirect_thunk_end[];
 
@@ -254,8 +265,9 @@ void alternative_msr_write(unsigned int
 
 static inline void indirect_branch_prediction_barrier(void)
 {
-	alternative_msr_write(MSR_IA32_PRED_CMD, PRED_CMD_IBPB,
-			      X86_FEATURE_USE_IBPB);
+	u64 val = PRED_CMD_IBPB;
+
+	alternative_msr_write(MSR_IA32_PRED_CMD, val, X86_FEATURE_USE_IBPB);
 }
 
 /*
@@ -266,14 +278,18 @@ static inline void indirect_branch_predi
  */
 #define firmware_restrict_branch_speculation_start()			\
 do {									\
+	u64 val = x86_spec_ctrl_get_default() | SPEC_CTRL_IBRS;		\
+									\
 	preempt_disable();						\
-	alternative_msr_write(MSR_IA32_SPEC_CTRL, SPEC_CTRL_IBRS,	\
+	alternative_msr_write(MSR_IA32_SPEC_CTRL, val,			\
 			      X86_FEATURE_USE_IBRS_FW);			\
 } while (0)
 
 #define firmware_restrict_branch_speculation_end()			\
 do {									\
-	alternative_msr_write(MSR_IA32_SPEC_CTRL, 0,			\
+	u64 val = x86_spec_ctrl_get_default();				\
+									\
+	alternative_msr_write(MSR_IA32_SPEC_CTRL, val,			\
 			      X86_FEATURE_USE_IBRS_FW);			\
 	preempt_enable();						\
 } while (0)
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -28,6 +28,12 @@
 
 static void __init spectre_v2_select_mitigation(void);
 
+/*
+ * Our boot-time value of the SPEC_CTRL MSR. We read it once so that any
+ * writes to SPEC_CTRL contain whatever reserved bits have been set.
+ */
+static u64 __ro_after_init x86_spec_ctrl_base;
+
 void __init check_bugs(void)
 {
 	identify_boot_cpu();
@@ -37,6 +43,13 @@ void __init check_bugs(void)
 		print_cpu_info(&boot_cpu_data);
 	}
 
+	/*
+	 * Read the SPEC_CTRL MSR to account for reserved bits which may
+	 * have unknown values.
+	 */
+	if (boot_cpu_has(X86_FEATURE_IBRS))
+		rdmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
+
 	/* Select the proper spectre mitigation before patching alternatives */
 	spectre_v2_select_mitigation();
 
@@ -95,6 +108,21 @@ static const char *spectre_v2_strings[]
 
 static enum spectre_v2_mitigation spectre_v2_enabled = SPECTRE_V2_NONE;
 
+void x86_spec_ctrl_set(u64 val)
+{
+	if (val & ~SPEC_CTRL_IBRS)
+		WARN_ONCE(1, "SPEC_CTRL MSR value 0x%16llx is unknown.\n", val);
+	else
+		wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base | val);
+}
+EXPORT_SYMBOL_GPL(x86_spec_ctrl_set);
+
+u64 x86_spec_ctrl_get_default(void)
+{
+	return x86_spec_ctrl_base;
+}
+EXPORT_SYMBOL_GPL(x86_spec_ctrl_get_default);
+
 #ifdef RETPOLINE
 static bool spectre_v2_bad_module;
 
