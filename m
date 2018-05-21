Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqTSFlMO07jLjx7xE5AzX+Wjq3ADZpzl8BZvuLLx04IrUo1bCgUODj5z98PRHVjH3zexLRp
ARC-Seal: i=1; a=rsa-sha256; t=1526937379; cv=none;
        d=google.com; s=arc-20160816;
        b=pzTqzwNBanydTf47IZxyOzPdxDkjVanqRKpRmOIboa1M7siiWazy1GEs8fUD21T8X/
         tA3dGQ8cAOdSschcQ+C3MMyZbX/vVXFg8vpBdPsj0PgZx+8QCMGRU8oGOcSa498R0Ur4
         xBLMSBvWaxKWZ2JsT2+ADglMX91ZNOM/kGPo7mqWqjBDB5EDWANnygVi+Bp9KztiwH91
         mDhI/lEhMopkIY6eMaal+wb7BRfOTwTwZtG+BXY0nFH6kaqIe4OVRjst2C8ug/pZe530
         730ctzeAkqONw4jM3feXtOk8xe5UmRz5twk6PgJAhlb8IdrW6J3OpQ1hfc8akrU2G6bz
         Fa7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=+AonksaAErkBEDhVT8ByAbxLuWehOSriEv9CUGVzYmM=;
        b=WtASljR10cVze5u+mO10x/P+HLMHJgWA7BXG5XqoZhYyYtq3eUOhF54mpg+NsRD09M
         6dBM4T17QIVyzqZVaQ05ZuWJjc+U7v0AnBZh05K8WjfT9tQ7nSG9utJmJoj2uArcDXs+
         lrlCoVONWIiP8bbPFkf4sX0HlbstbhekwOt3+aJMjv7I7P2/gY7FKhSu5A+BBzOFvVLX
         HKfPz4gCGnZTVDq2Z8DlXxrVvcBS/Z594xplDkMs8IUIOZI9ZVjffB8z/nE1dehZ3yaT
         FZUcQtHZOqgK2phgrC/DjQ0zc96aFYGBqbss/nKiq8tntHNRqLT1EiWZ9m+MzJviT2gL
         2ZOg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=YDR08vrm;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=YDR08vrm;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 53/87] x86/process: Allow runtime control of Speculative Store Bypass
Date: Mon, 21 May 2018 23:11:29 +0200
Message-Id: <20180521210425.088094184@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109889140728203?=
X-GMAIL-MSGID: =?utf-8?q?1601109889140728203?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 885f82bfbc6fefb6664ea27965c3ab9ac4194b8c upstream

The Speculative Store Bypass vulnerability can be mitigated with the
Reduced Data Speculation (RDS) feature. To allow finer grained control of
this eventually expensive mitigation a per task mitigation control is
required.

Add a new TIF_RDS flag and put it into the group of TIF flags which are
evaluated for mismatch in switch_to(). If these bits differ in the previous
and the next task, then the slow path function __switch_to_xtra() is
invoked. Implement the TIF_RDS dependent mitigation control in the slow
path.

If the prctl for controlling Speculative Store Bypass is disabled or no
task uses the prctl then there is no overhead in the switch_to() fast
path.

Update the KVM related speculation control functions to take TID_RDS into
account as well.

Based on a patch from Tim Chen. Completely rewritten.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/msr-index.h   |    3 ++-
 arch/x86/include/asm/spec-ctrl.h   |   17 +++++++++++++++++
 arch/x86/include/asm/thread_info.h |    6 ++++--
 arch/x86/kernel/cpu/bugs.c         |   26 +++++++++++++++++++++-----
 arch/x86/kernel/process.c          |   22 ++++++++++++++++++++++
 5 files changed, 66 insertions(+), 8 deletions(-)

--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -40,7 +40,8 @@
 #define MSR_IA32_SPEC_CTRL		0x00000048 /* Speculation Control */
 #define SPEC_CTRL_IBRS			(1 << 0)   /* Indirect Branch Restricted Speculation */
 #define SPEC_CTRL_STIBP			(1 << 1)   /* Single Thread Indirect Branch Predictors */
-#define SPEC_CTRL_RDS			(1 << 2)   /* Reduced Data Speculation */
+#define SPEC_CTRL_RDS_SHIFT		2	   /* Reduced Data Speculation bit */
+#define SPEC_CTRL_RDS			(1 << SPEC_CTRL_RDS_SHIFT)   /* Reduced Data Speculation */
 
 #define MSR_IA32_PRED_CMD		0x00000049 /* Prediction Command */
 #define PRED_CMD_IBPB			(1 << 0)   /* Indirect Branch Prediction Barrier */
--- a/arch/x86/include/asm/spec-ctrl.h
+++ b/arch/x86/include/asm/spec-ctrl.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_X86_SPECCTRL_H_
 #define _ASM_X86_SPECCTRL_H_
 
+#include <linux/thread_info.h>
 #include <asm/nospec-branch.h>
 
 /*
@@ -18,4 +19,20 @@ extern void x86_spec_ctrl_restore_host(u
 extern u64 x86_amd_ls_cfg_base;
 extern u64 x86_amd_ls_cfg_rds_mask;
 
+/* The Intel SPEC CTRL MSR base value cache */
+extern u64 x86_spec_ctrl_base;
+
+static inline u64 rds_tif_to_spec_ctrl(u64 tifn)
+{
+	BUILD_BUG_ON(TIF_RDS < SPEC_CTRL_RDS_SHIFT);
+	return (tifn & _TIF_RDS) >> (TIF_RDS - SPEC_CTRL_RDS_SHIFT);
+}
+
+static inline u64 rds_tif_to_amd_ls_cfg(u64 tifn)
+{
+	return (tifn & _TIF_RDS) ? x86_amd_ls_cfg_rds_mask : 0ULL;
+}
+
+extern void speculative_store_bypass_update(void);
+
 #endif
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -83,6 +83,7 @@ struct thread_info {
 #define TIF_SIGPENDING		2	/* signal pending */
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_SINGLESTEP		4	/* reenable singlestep on user return*/
+#define TIF_RDS			5	/* Reduced data speculation */
 #define TIF_SYSCALL_EMU		6	/* syscall emulation active */
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
 #define TIF_SECCOMP		8	/* secure computing */
@@ -104,8 +105,9 @@ struct thread_info {
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
-#define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
+#define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
+#define _TIF_RDS		(1 << TIF_RDS)
 #define _TIF_SYSCALL_EMU	(1 << TIF_SYSCALL_EMU)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
@@ -139,7 +141,7 @@ struct thread_info {
 
 /* flags to check in __switch_to() */
 #define _TIF_WORK_CTXSW							\
-	(_TIF_IO_BITMAP|_TIF_NOTSC|_TIF_BLOCKSTEP)
+	(_TIF_IO_BITMAP|_TIF_NOTSC|_TIF_BLOCKSTEP|_TIF_RDS)
 
 #define _TIF_WORK_CTXSW_PREV (_TIF_WORK_CTXSW|_TIF_USER_RETURN_NOTIFY)
 #define _TIF_WORK_CTXSW_NEXT (_TIF_WORK_CTXSW)
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -32,7 +32,7 @@ static void __init ssb_select_mitigation
  * Our boot-time value of the SPEC_CTRL MSR. We read it once so that any
  * writes to SPEC_CTRL contain whatever reserved bits have been set.
  */
-static u64 __ro_after_init x86_spec_ctrl_base;
+u64 __ro_after_init x86_spec_ctrl_base;
 
 /*
  * The vendor and possibly platform specific bits which can be modified in
@@ -139,25 +139,41 @@ EXPORT_SYMBOL_GPL(x86_spec_ctrl_set);
 
 u64 x86_spec_ctrl_get_default(void)
 {
-	return x86_spec_ctrl_base;
+	u64 msrval = x86_spec_ctrl_base;
+
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+		msrval |= rds_tif_to_spec_ctrl(current_thread_info()->flags);
+	return msrval;
 }
 EXPORT_SYMBOL_GPL(x86_spec_ctrl_get_default);
 
 void x86_spec_ctrl_set_guest(u64 guest_spec_ctrl)
 {
+	u64 host = x86_spec_ctrl_base;
+
 	if (!boot_cpu_has(X86_FEATURE_IBRS))
 		return;
-	if (x86_spec_ctrl_base != guest_spec_ctrl)
+
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+		host |= rds_tif_to_spec_ctrl(current_thread_info()->flags);
+
+	if (host != guest_spec_ctrl)
 		wrmsrl(MSR_IA32_SPEC_CTRL, guest_spec_ctrl);
 }
 EXPORT_SYMBOL_GPL(x86_spec_ctrl_set_guest);
 
 void x86_spec_ctrl_restore_host(u64 guest_spec_ctrl)
 {
+	u64 host = x86_spec_ctrl_base;
+
 	if (!boot_cpu_has(X86_FEATURE_IBRS))
 		return;
-	if (x86_spec_ctrl_base != guest_spec_ctrl)
-		wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
+
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+		host |= rds_tif_to_spec_ctrl(current_thread_info()->flags);
+
+	if (host != guest_spec_ctrl)
+		wrmsrl(MSR_IA32_SPEC_CTRL, host);
 }
 EXPORT_SYMBOL_GPL(x86_spec_ctrl_restore_host);
 
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -33,6 +33,7 @@
 #include <asm/mce.h>
 #include <asm/vm86.h>
 #include <asm/switch_to.h>
+#include <asm/spec-ctrl.h>
 
 /*
  * per-CPU TSS segments. Threads are completely 'soft' on Linux,
@@ -202,6 +203,24 @@ static inline void switch_to_bitmap(stru
 	}
 }
 
+static __always_inline void __speculative_store_bypass_update(unsigned long tifn)
+{
+	u64 msr;
+
+	if (static_cpu_has(X86_FEATURE_AMD_RDS)) {
+		msr = x86_amd_ls_cfg_base | rds_tif_to_amd_ls_cfg(tifn);
+		wrmsrl(MSR_AMD64_LS_CFG, msr);
+	} else {
+		msr = x86_spec_ctrl_base | rds_tif_to_spec_ctrl(tifn);
+		wrmsrl(MSR_IA32_SPEC_CTRL, msr);
+	}
+}
+
+void speculative_store_bypass_update(void)
+{
+	__speculative_store_bypass_update(current_thread_info()->flags);
+}
+
 void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p,
 		      struct tss_struct *tss)
 {
@@ -230,6 +249,9 @@ void __switch_to_xtra(struct task_struct
 
 	if ((tifp ^ tifn) & _TIF_NOTSC)
 		cr4_toggle_bits(X86_CR4_TSD);
+
+	if ((tifp ^ tifn) & _TIF_RDS)
+		__speculative_store_bypass_update(tifn);
 }
 
 /*
