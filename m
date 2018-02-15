Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227FrvGpoFLZYD0CifXo6QiTCnICBE8ilhPUzvcSY9kycF5UG6orWvIh/ECayMmCIKVE8sxG
ARC-Seal: i=1; a=rsa-sha256; t=1518709303; cv=none;
        d=google.com; s=arc-20160816;
        b=vC+9xSX98M8kBgG7xkVA4iWsx/GOTKzaGtxnEOp546+yjMMOXQlnl5gJIf9KH1SNgV
         WwsNRTtiLlT0okIvlIVc83G0VNPdXeLrIL/NrpcvN/hVh0YNq4KCd98GFrt9DyTbC1zd
         JvbpRSfxxGrlbBNSwVYI7rHqxgrxFujygUXS8Os0dg8DqTeYsgkdvFuOAA3ICzK5j3K+
         O2qjaFuXGOoWrAzxqzNENhXUyBmc1wKqZudcRTkVa400uVOjfg7vVXCIFQcwXEdrRcZS
         0RwZxBC/IbuP1rguaTwq9eXzn4tPTPlmb+a+XNF3//lPC3J5ODGnExGB75uJcBpBWt3m
         5HDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Kf4SsNLaWy7/hDN3Fb6r3jNdkRIljdFBIaxMOi/HEE0=;
        b=T+DIgKurAW/kmZ7ET/4KExKSK2yPzUJTdfiVjSBt3XKhFmZBJEE3Isv1WWAbYrOTuC
         bhdVrHWMK8TMeTKodmkj3aRVLdOgDq2bP3ins6JeYXBeVz6iUDOcrBPWX2BR+4HIOrcn
         oR1X9GjThKjMTsAwRtSABzB1D8S6y4x+dycbrWTd2hVNctpeU0YND9XnXEhYvrAsnFWC
         X6r9r+Yk4kq17Kv76kJudtdos202NeRXPuNGM97gpbRZGo3icyOfr5BLr40tvPekzxdB
         7HhEQi3SRdWoCkyVaqoH90RlGC/swk4ae1FLw7ZWK2RGEdydmSSGU92x7DHKc4zAR2th
         DyXQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.15 069/202] [Variant 2/Spectre-v2] arm64: Implement branch predictor hardening for affected Cortex-A CPUs
Date: Thu, 15 Feb 2018 16:16:09 +0100
Message-Id: <20180215151717.104338798@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481574166304658?=
X-GMAIL-MSGID: =?utf-8?q?1592482126891228497?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit aa6acde65e03 upstream.

Cortex-A57, A72, A73 and A75 are susceptible to branch predictor aliasing
and can theoretically be attacked by malicious code.

This patch implements a PSCI-based mitigation for these CPUs when available.
The call into firmware will invalidate the branch predictor state, preventing
any malicious entries from affecting other victim contexts.

Co-developed-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/bpi.S        |   24 +++++++++++++++++++++++
 arch/arm64/kernel/cpu_errata.c |   42 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

--- a/arch/arm64/kernel/bpi.S
+++ b/arch/arm64/kernel/bpi.S
@@ -53,3 +53,27 @@ ENTRY(__bp_harden_hyp_vecs_start)
 	vectors __kvm_hyp_vector
 	.endr
 ENTRY(__bp_harden_hyp_vecs_end)
+ENTRY(__psci_hyp_bp_inval_start)
+	sub	sp, sp, #(8 * 18)
+	stp	x16, x17, [sp, #(16 * 0)]
+	stp	x14, x15, [sp, #(16 * 1)]
+	stp	x12, x13, [sp, #(16 * 2)]
+	stp	x10, x11, [sp, #(16 * 3)]
+	stp	x8, x9, [sp, #(16 * 4)]
+	stp	x6, x7, [sp, #(16 * 5)]
+	stp	x4, x5, [sp, #(16 * 6)]
+	stp	x2, x3, [sp, #(16 * 7)]
+	stp	x0, x1, [sp, #(16 * 8)]
+	mov	x0, #0x84000000
+	smc	#0
+	ldp	x16, x17, [sp, #(16 * 0)]
+	ldp	x14, x15, [sp, #(16 * 1)]
+	ldp	x12, x13, [sp, #(16 * 2)]
+	ldp	x10, x11, [sp, #(16 * 3)]
+	ldp	x8, x9, [sp, #(16 * 4)]
+	ldp	x6, x7, [sp, #(16 * 5)]
+	ldp	x4, x5, [sp, #(16 * 6)]
+	ldp	x2, x3, [sp, #(16 * 7)]
+	ldp	x0, x1, [sp, #(16 * 8)]
+	add	sp, sp, #(8 * 18)
+ENTRY(__psci_hyp_bp_inval_end)
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -67,6 +67,8 @@ static int cpu_enable_trap_ctr_access(vo
 DEFINE_PER_CPU_READ_MOSTLY(struct bp_hardening_data, bp_hardening_data);
 
 #ifdef CONFIG_KVM
+extern char __psci_hyp_bp_inval_start[], __psci_hyp_bp_inval_end[];
+
 static void __copy_hyp_vect_bpi(int slot, const char *hyp_vecs_start,
 				const char *hyp_vecs_end)
 {
@@ -108,6 +110,9 @@ static void __install_bp_hardening_cb(bp
 	spin_unlock(&bp_lock);
 }
 #else
+#define __psci_hyp_bp_inval_start	NULL
+#define __psci_hyp_bp_inval_end		NULL
+
 static void __install_bp_hardening_cb(bp_hardening_cb_t fn,
 				      const char *hyp_vecs_start,
 				      const char *hyp_vecs_end)
@@ -132,6 +137,21 @@ static void  install_bp_hardening_cb(con
 
 	__install_bp_hardening_cb(fn, hyp_vecs_start, hyp_vecs_end);
 }
+
+#include <linux/psci.h>
+
+static int enable_psci_bp_hardening(void *data)
+{
+	const struct arm64_cpu_capabilities *entry = data;
+
+	if (psci_ops.get_version)
+		install_bp_hardening_cb(entry,
+				       (bp_hardening_cb_t)psci_ops.get_version,
+				       __psci_hyp_bp_inval_start,
+				       __psci_hyp_bp_inval_end);
+
+	return 0;
+}
 #endif	/* CONFIG_HARDEN_BRANCH_PREDICTOR */
 
 #define MIDR_RANGE(model, min, max) \
@@ -282,6 +302,28 @@ const struct arm64_cpu_capabilities arm6
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
 	},
 #endif
+#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
+	{
+		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
+		.enable = enable_psci_bp_hardening,
+	},
+	{
+		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
+		.enable = enable_psci_bp_hardening,
+	},
+	{
+		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
+		.enable = enable_psci_bp_hardening,
+	},
+	{
+		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A75),
+		.enable = enable_psci_bp_hardening,
+	},
+#endif
 	{
 	}
 };
