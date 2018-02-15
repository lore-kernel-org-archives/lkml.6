Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225412dy/tY1Hye+Qg9CZv12i2ll6rKdT1A4z0ScrEjbef5GZNKvXEBacj6jEnEKTjJTXrJC
ARC-Seal: i=1; a=rsa-sha256; t=1518708914; cv=none;
        d=google.com; s=arc-20160816;
        b=Av5yIoiq6/SLUqP2PlVUgAZv5D/w7pJvConIa57IpRA1VQLzS77AaJxWfiQ5zEAMUq
         LjjC8V05TTuA9CBWDzaRlrUeM5b9nVC3Xt3C0by38lCnVWDPulaZDLMBWioOXS5CIx+q
         rzlZQGy82sPn+eB7WkKlQycmlQ/xjrrcXBr/YFdXEAMJbTuYKvsmQASQIT4wlMMZXull
         64qC/NU0EMvq6zWBl5rgpqMjvxZVnjWrh3+hKwLgaqhSI4/AQoYC/LPOceuuY+ax+TKG
         pxZtOIb72K3+Sw10BtxCfh16zAdG1/Y75wz14gbZpGIFCQZCnn6pRBlExVRhhQ6oJ28C
         UT8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rQ4AzFIoNA6JpuW4Dkf1eVsSSg+iucjUagmA7tEU3Ic=;
        b=M3TCrbJqC43hFVzJvcNcoRyp1pqgw2hpB95ggIRlxxK6CEPYpG/9/yuVaZTufdjdFD
         Opfl8po1ArJH10+F8S4QWfqud8cmlUD56jykC73a55+jmQArE5yec7xBTu6v2tTJs/oT
         iyIdG7RLsThsb5cGJ8FPaovXSWyBwEld/xH12+gd6PdUkzQJqP9Kovf3KYSC3HozAcuf
         MpoeKgZH0VI827Q4tvA5aND7B60kUrLnUEXbJ2aroJEKhW61fL/sn11Taftrv4W9FcCV
         LKCIxIb2FavIuGwv+f+CddYY+NsdwoWv8D0rBZXmO20poY+1i01wLB9MQU3fuUQLYEKD
         J0Zw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.14 093/195] [Variant 2/Spectre-v2] arm64: Add ARM_SMCCC_ARCH_WORKAROUND_1 BP hardening support
Date: Thu, 15 Feb 2018 16:16:24 +0100
Message-Id: <20180215151710.355165471@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481718217103195?=
X-GMAIL-MSGID: =?utf-8?q?1592481718217103195?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>


Commit b092201e0020 upstream.

Add the detection and runtime code for ARM_SMCCC_ARCH_WORKAROUND_1.
It is lovely. Really.

Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/bpi.S        |   20 ++++++++++++
 arch/arm64/kernel/cpu_errata.c |   68 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 87 insertions(+), 1 deletion(-)

--- a/arch/arm64/kernel/bpi.S
+++ b/arch/arm64/kernel/bpi.S
@@ -17,6 +17,7 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/arm-smccc.h>
 
 .macro ventry target
 	.rept 31
@@ -85,3 +86,22 @@ ENTRY(__qcom_hyp_sanitize_link_stack_sta
 	.endr
 	ldp	x29, x30, [sp], #16
 ENTRY(__qcom_hyp_sanitize_link_stack_end)
+
+.macro smccc_workaround_1 inst
+	sub	sp, sp, #(8 * 4)
+	stp	x2, x3, [sp, #(8 * 0)]
+	stp	x0, x1, [sp, #(8 * 2)]
+	mov	w0, #ARM_SMCCC_ARCH_WORKAROUND_1
+	\inst	#0
+	ldp	x2, x3, [sp, #(8 * 0)]
+	ldp	x0, x1, [sp, #(8 * 2)]
+	add	sp, sp, #(8 * 4)
+.endm
+
+ENTRY(__smccc_workaround_1_smc_start)
+	smccc_workaround_1	smc
+ENTRY(__smccc_workaround_1_smc_end)
+
+ENTRY(__smccc_workaround_1_hvc_start)
+	smccc_workaround_1	hvc
+ENTRY(__smccc_workaround_1_hvc_end)
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -70,6 +70,10 @@ DEFINE_PER_CPU_READ_MOSTLY(struct bp_har
 extern char __psci_hyp_bp_inval_start[], __psci_hyp_bp_inval_end[];
 extern char __qcom_hyp_sanitize_link_stack_start[];
 extern char __qcom_hyp_sanitize_link_stack_end[];
+extern char __smccc_workaround_1_smc_start[];
+extern char __smccc_workaround_1_smc_end[];
+extern char __smccc_workaround_1_hvc_start[];
+extern char __smccc_workaround_1_hvc_end[];
 
 static void __copy_hyp_vect_bpi(int slot, const char *hyp_vecs_start,
 				const char *hyp_vecs_end)
@@ -116,6 +120,10 @@ static void __install_bp_hardening_cb(bp
 #define __psci_hyp_bp_inval_end			NULL
 #define __qcom_hyp_sanitize_link_stack_start	NULL
 #define __qcom_hyp_sanitize_link_stack_end	NULL
+#define __smccc_workaround_1_smc_start		NULL
+#define __smccc_workaround_1_smc_end		NULL
+#define __smccc_workaround_1_hvc_start		NULL
+#define __smccc_workaround_1_hvc_end		NULL
 
 static void __install_bp_hardening_cb(bp_hardening_cb_t fn,
 				      const char *hyp_vecs_start,
@@ -142,17 +150,75 @@ static void  install_bp_hardening_cb(con
 	__install_bp_hardening_cb(fn, hyp_vecs_start, hyp_vecs_end);
 }
 
+#include <uapi/linux/psci.h>
+#include <linux/arm-smccc.h>
 #include <linux/psci.h>
 
+static void call_smc_arch_workaround_1(void)
+{
+	arm_smccc_1_1_smc(ARM_SMCCC_ARCH_WORKAROUND_1, NULL);
+}
+
+static void call_hvc_arch_workaround_1(void)
+{
+	arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_WORKAROUND_1, NULL);
+}
+
+static bool check_smccc_arch_workaround_1(const struct arm64_cpu_capabilities *entry)
+{
+	bp_hardening_cb_t cb;
+	void *smccc_start, *smccc_end;
+	struct arm_smccc_res res;
+
+	if (!entry->matches(entry, SCOPE_LOCAL_CPU))
+		return false;
+
+	if (psci_ops.smccc_version == SMCCC_VERSION_1_0)
+		return false;
+
+	switch (psci_ops.conduit) {
+	case PSCI_CONDUIT_HVC:
+		arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
+				  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
+		if (res.a0)
+			return false;
+		cb = call_hvc_arch_workaround_1;
+		smccc_start = __smccc_workaround_1_hvc_start;
+		smccc_end = __smccc_workaround_1_hvc_end;
+		break;
+
+	case PSCI_CONDUIT_SMC:
+		arm_smccc_1_1_smc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
+				  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
+		if (res.a0)
+			return false;
+		cb = call_smc_arch_workaround_1;
+		smccc_start = __smccc_workaround_1_smc_start;
+		smccc_end = __smccc_workaround_1_smc_end;
+		break;
+
+	default:
+		return false;
+	}
+
+	install_bp_hardening_cb(entry, cb, smccc_start, smccc_end);
+
+	return true;
+}
+
 static int enable_psci_bp_hardening(void *data)
 {
 	const struct arm64_cpu_capabilities *entry = data;
 
-	if (psci_ops.get_version)
+	if (psci_ops.get_version) {
+		if (check_smccc_arch_workaround_1(entry))
+			return 0;
+
 		install_bp_hardening_cb(entry,
 				       (bp_hardening_cb_t)psci_ops.get_version,
 				       __psci_hyp_bp_inval_start,
 				       __psci_hyp_bp_inval_end);
+	}
 
 	return 0;
 }
