Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrJFcnHNGAaEmUnH5OVwGQM9Eh1jsPJPAOnOSStVDWylJ+Bc/oYscpQSJm9Xk9deRPElkME
ARC-Seal: i=1; a=rsa-sha256; t=1526937702; cv=none;
        d=google.com; s=arc-20160816;
        b=VRD3IboGXD3FYeTzpkYqMh4PnXkFRrtD617hMWniQevJHgANML4scAQH1tObSb0ZSa
         DzFMev35/qnSx41We2DrI5ZP65+q5aBK2z1lorJcLYBCz46a1+UCxWP3SLSdBY/TmWee
         nv+iSqhii3GXhuDYlKSsMN8tUzZphOc99L7ZY0/g6lyytxNntQZoRO5/zP8qvhCkO06/
         juzD9aTCoASYi8U4JsNSIKprJyxKY9vwCgGBTOeA7eDXOaY1UcRe/a+Jg/Rj3xqFgiv+
         onnqI11IgeRK2Ie+USGC+W8xFf18vgTODNzN5QrdENYru6Z0E/4uwNVLap1/ffwaICfe
         UgXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=XUcny4tn/K9Whkgac6vQpOT9wFGdfMSj+Hwm+ZtR5vs=;
        b=nQf2vSK3sNrGYPvdFUEs9xAPLy1B+pZz3MgV5vDwA152qBz/8GH3gsuztWXsPhG4oZ
         MZDFnWHQflB57e29Zml/pw9r1yEsZy6zZarJapeu4IqhwZ0hvvAI2SxBsGIxWIY7Dupt
         79lhneoRkEg5uI6py2i98LijkDDk6glovm0SWCk2j1aAnjebbZK+8ry3FL6qXmrzMORM
         kEzf0tIgAhVh7x3apMiz1BJJGAr2QVDnfQHxK95tMTmoVyPwBiEOM4hEVcm9cKj28Y72
         /CiLVhnaRekdqzrmzI2LXXBqT3WbK2rE9kegQqIkhmgMYVEia2EyxM2IC0qjIgRNwuWp
         7mDg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=l3cnTKWo;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=l3cnTKWo;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@suse.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 4.14 90/95] x86/bugs: Expose x86_spec_ctrl_base directly
Date: Mon, 21 May 2018 23:12:20 +0200
Message-Id: <20180521210503.139626357@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109955955970722?=
X-GMAIL-MSGID: =?utf-8?q?1601110228353535743?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -36,6 +36,7 @@ static void __init ssb_select_mitigation
  * writes to SPEC_CTRL contain whatever reserved bits have been set.
  */
 u64 __ro_after_init x86_spec_ctrl_base;
+EXPORT_SYMBOL_GPL(x86_spec_ctrl_base);
 
 /*
  * The vendor and possibly platform specific bits which can be modified in
@@ -141,16 +142,6 @@ void x86_spec_ctrl_set(u64 val)
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
