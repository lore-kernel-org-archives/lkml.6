Return-Path: <kernel-hardening-return-13020-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+K2YfTx023I6KACnU72WG+vyQOgmDPI3MQKNtGyMlWknj6rMz5OXsWFcrqxcglxBU4Yos/
ARC-Seal: i=1; a=rsa-sha256; t=1523990339; cv=none;
        d=google.com; s=arc-20160816;
        b=k3OoyGqvzr2VaVpbqosO0tZTvACXErWNAK9oXeA6QwyGrsUURwGg5yEhmbu5yZ9ZV7
         HIpCiixxjxZ/9hRSGVS4r8f41By+n6FJFlCfj41mGmkbqOsbU/31sAjBk0MdnZYBwy8/
         rpRSUuQ4qCvhPdLIsDGaqPY0mrSj69pBQBh+5ZzoRkKPmDNxrGaljOOkSlecdVZSnA+p
         WC0XpJCrO8gBT7xgH6oIvqb4n0VGczZ0KyenhG3ry1k5/gBviocME+hypy1Rzh70UQgg
         YDHpJ4RUuojo3sbQNXbGMXLwWn1V1R9cDiUVS/rfgjRrX4G2WG9tJZyTKBu5XeKoUGXE
         F2nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=11Y/EXDvdfE23Qa+nugO8bDiHjjD5M9j94ICNBI+C/Y=;
        b=uRd1Vnpz7Hz2FealmLI/tJdJluKoJq8YvzJgCsT+lNc7pwsiQQnulfjp5s/ZF2ra91
         NoS8RrOxlOTg46ou0noOCydW1qT/A+QyAKe2T636u7lk6Sb1z/h51OrmH2Q21BLO8vzb
         k084gMWBXKA+2G0lxFScpBDtakUSrkmzeKFPkuEDmmcwlVqKdSPAoo/xQ8Jkld1rmYVE
         46wNPuVb/qwK9o17vUr1MHxJG1SQhpmuiTslXblKDGpAFxiylpv5K5kUSrbPgoSgsvgl
         fQBXO9DeK23qmI5wht7Y22mfi+E2XseIE5Kwt8pjvbnOJJ/ZaWgegKko6Qog027hRQsQ
         mZZA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13020-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13020-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13020-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13020-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: arnd@arndb.de,
	catalin.marinas@arm.com,
	cdall@kernel.org,
	drjones@redhat.com,
	kvmarm@lists.cs.columbia.edu,
	linux-arch@vger.kernel.org,
	marc.zyngier@arm.com,
	mark.rutland@arm.com,
	ramana.radhakrishnan@arm.com,
	suzuki.poulose@arm.com,
	will.deacon@arm.com,
	linux-kernel@vger.kernel.org,
	awallis@codeaurora.org,
	kernel-hardening@lists.openwall.com
Subject: [PATCHv3 03/11] arm64/kvm: hide ptrauth from guests
Date: Tue, 17 Apr 2018 19:37:27 +0100
Message-Id: <20180417183735.56985-4-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180417183735.56985-1-mark.rutland@arm.com>
References: <20180417183735.56985-1-mark.rutland@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598019694139875288?=
X-GMAIL-MSGID: =?utf-8?q?1598019694139875288?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In subsequent patches we're going to expose ptrauth to the host kernel
and userspace, but things are a bit trickier for guest kernels. For the
time being, let's hide ptrauth from KVM guests.

Regardless of how well-behaved the guest kernel is, guest userspace
could attempt to use ptrauth instructions, triggering a trap to EL2,
resulting in noise from kvm_handle_unknown_ec(). So let's write up a
handler for the PAC trap, which silently injects an UNDEF into the
guest, as if the feature were really missing.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Christoffer Dall <cdall@kernel.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: kvmarm@lists.cs.columbia.edu
---
 arch/arm64/kvm/handle_exit.c | 18 ++++++++++++++++++
 arch/arm64/kvm/sys_regs.c    |  9 +++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index e5e741bfffe1..5114ad691eae 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -173,6 +173,23 @@ static int handle_sve(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	return 1;
 }
 
+/*
+ * Guest usage of a ptrauth instruction (which the guest EL1 did not turn into
+ * a NOP), or guest EL1 access to a ptrauth register.
+ */
+static int kvm_handle_ptrauth(struct kvm_vcpu *vcpu, struct kvm_run *run)
+{
+	/*
+	 * We don't currently suport ptrauth in a guest, and we mask the ID
+	 * registers to prevent well-behaved guests from trying to make use of
+	 * it.
+	 *
+	 * Inject an UNDEF, as if the feature really isn't present.
+	 */
+	kvm_inject_undefined(vcpu);
+	return 1;
+}
+
 static exit_handle_fn arm_exit_handlers[] = {
 	[0 ... ESR_ELx_EC_MAX]	= kvm_handle_unknown_ec,
 	[ESR_ELx_EC_WFx]	= kvm_handle_wfx,
@@ -195,6 +212,7 @@ static exit_handle_fn arm_exit_handlers[] = {
 	[ESR_ELx_EC_BKPT32]	= kvm_handle_guest_debug,
 	[ESR_ELx_EC_BRK64]	= kvm_handle_guest_debug,
 	[ESR_ELx_EC_FP_ASIMD]	= handle_no_fpsimd,
+	[ESR_ELx_EC_PAC]	= kvm_handle_ptrauth,
 };
 
 static exit_handle_fn kvm_get_exit_handler(struct kvm_vcpu *vcpu)
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 806b0b126a64..eee399c35e84 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1000,6 +1000,15 @@ static u64 read_id_reg(struct sys_reg_desc const *r, bool raz)
 				    task_pid_nr(current));
 
 		val &= ~(0xfUL << ID_AA64PFR0_SVE_SHIFT);
+	} else if (id == SYS_ID_AA64ISAR1_EL1) {
+		const u64 ptrauth_mask = (0xfUL << ID_AA64ISAR1_APA_SHIFT) |
+					 (0xfUL << ID_AA64ISAR1_API_SHIFT) |
+					 (0xfUL << ID_AA64ISAR1_GPA_SHIFT) |
+					 (0xfUL << ID_AA64ISAR1_GPI_SHIFT);
+		if (val & ptrauth_mask)
+			pr_err_once("kvm [%i]: ptrauth unsupported for guests, suppressing\n",
+					task_pid_nr(current));
+		val &= ~ptrauth_mask;
 	} else if (id == SYS_ID_AA64MMFR1_EL1) {
 		if (val & (0xfUL << ID_AA64MMFR1_LOR_SHIFT))
 			pr_err_once("kvm [%i]: LORegions unsupported for guests, suppressing\n",
-- 
2.11.0
