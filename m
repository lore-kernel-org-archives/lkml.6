Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225RxbUZdnJBo37C8JQqrlEso0fJrNiW5wV94tj2YDgY2jrDw9qg9uRh+LWZJpU7QN3Qz4zt
ARC-Seal: i=1; a=rsa-sha256; t=1518708776; cv=none;
        d=google.com; s=arc-20160816;
        b=O/g9nhwLqOTwcYc4idTS/Z0zKNdD5jo2fnEfdiu08FE3wp6MW0U6Yg8fmm/KORyQtq
         P1Bl23dZcGLtb3nW8m8AgtrtUhiKdwLD6JK7LVUzMc2LkQ7DMrLrQKpoO+FNFYtq1l0Z
         Gv/Orke4tg2Ak6ItHLGZkhLqPRyZHEo1Uz4b665dyefjBJq3lzzAVEjGhKpbYupe5DW2
         wlVtXTribHIs1WCpdX1z7Pum+Rfrw8c7hUCnwQIKu9mls39C/EhrytGX9F0nGddpCT+f
         6Upf7EnGh9lYHp93te2tPHye71Aa85yhttcBPdyk+d/YqqGTrMTSwlfkTvju+GoPQdpN
         DSLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6qPVvhovoP//eJ0l3VH8uJTj3qcyYrCJn3FATASZGTY=;
        b=YdJry9npNW4BOJOlZpd7NnDLIssxr/S9pkrvWn/mun3bFyfW7Pvx71/1tDLhv11zVM
         CcCgX2nxuW3mGzGNz2wP0CjqYjCftcFelkaQyhWafEiymmAipqBXX+tdwWtZNUXsgbmV
         5txGUT4zRArNl9VjWvIYobaI4rUxVZie0hmkRZpaO0ee6uoZYO/1l1osxwm9W1cDkATQ
         IsGuH1Tg/EQJr4qOmYR00jnGnH6fM4Py42vzR9j6WYU1Q/ExPHjVdpiRmaaTBCh7uOh+
         SIi826b/OZXYc6KZaZHFO/wPnyJlVn7GA6yN1AuGRuLjzWkJNqmnMYAvf7afWmS643S8
         pPuw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.14 076/195] [Variant 2/Spectre-v2] arm64: Implement branch predictor hardening for affected Cortex-A CPUs
Date: Thu, 15 Feb 2018 16:16:07 +0100
Message-Id: <20180215151709.496120848@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481574166304658?=
X-GMAIL-MSGID: =?utf-8?q?1592481574166304658?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
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
