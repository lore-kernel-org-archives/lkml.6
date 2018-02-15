Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2279mSXmT08oULvycGCvhft2iyYaW/IAATzutPxaGS+REySumsmnjwqb5tiyWzCjC0jMlcIg
ARC-Seal: i=1; a=rsa-sha256; t=1518709330; cv=none;
        d=google.com; s=arc-20160816;
        b=uCMkQtyADkOBj+l0dtKrvvV9qv2yMyl0N9qBrYX3ZCGmg/jUymX4AcGzckWWvvSZPZ
         91ZO0qyc4MGPPlCD1RMKG+64lMa3udc9N+klQ+JQZAv5rHHucMlEjG+zcS+Sk7WWrEP9
         otBwLMVyyYHweUwJ1uf8yXxkiMkSQzjMlg/Od97xbQ3ltH6aI4YTdi//Fa0xx/ZmpqQo
         2AMpdLD1k4pHDA03XgTipQSgZ6H2Y54xMCXnEeLqDeOSgdJfhbYCYvS+aB1PC4lz5Xtg
         GhM19dIJrKtDktFBqUGsM6nQTb9NarxN1mtFN2qofq6GT+mvkI/AyosFREVK82GiQ9V5
         nkkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=mQN6V+A4XXYNjJZvWL8RSablvP8hYvIZS+YiHhXGzl4=;
        b=CLpzMA+icz4o7eiFtW4cqHVDmBbYu9o/k+SfqCZuBI1M9swOR3nCwmrVuzMXgCY7Ao
         4lctWfCjwKe5l0l2ud7eOv8l2qCBXLuJFz1PWiQsauVXlKGgidEKPACyMBuoPzp3bPWm
         6vw2vqfuBUtqZ+CQTYygRXWuKDkw70LmISO4oV4HK3VhNhbVXcU278AtRJh/zNgM19FA
         6SBnmWNN82Cs+JTrhRzGw33e07q85t32ge4XMeiyqHeI3N++oWIdPFhgiKv/fLzMS+ua
         1aIkodDWHeBEFMmCleiaGmmiFub/Ta4GtUI+gZnUAOvB2n3VMO/l6H6eyrrSe2V4cmeS
         VoFA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Marc Zyngier <marc.zyngier@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.15 078/202] [Variant 2/Spectre-v2] arm64: KVM: Make PSCI_VERSION a fast path
Date: Thu, 15 Feb 2018 16:16:18 +0100
Message-Id: <20180215151717.559429005@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481604029553131?=
X-GMAIL-MSGID: =?utf-8?q?1592482154350050210?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>


Commit 90348689d500 upstream.

For those CPUs that require PSCI to perform a BP invalidation,
going all the way to the PSCI code for not much is a waste of
precious cycles. Let's terminate that call as early as possible.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kvm/hyp/switch.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -17,6 +17,7 @@
 
 #include <linux/types.h>
 #include <linux/jump_label.h>
+#include <uapi/linux/psci.h>
 
 #include <asm/kvm_asm.h>
 #include <asm/kvm_emulate.h>
@@ -341,6 +342,18 @@ again:
 	if (exit_code == ARM_EXCEPTION_TRAP && !__populate_fault_info(vcpu))
 		goto again;
 
+	if (exit_code == ARM_EXCEPTION_TRAP &&
+	    (kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_HVC64 ||
+	     kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_HVC32) &&
+	    vcpu_get_reg(vcpu, 0) == PSCI_0_2_FN_PSCI_VERSION) {
+		u64 val = PSCI_RET_NOT_SUPPORTED;
+		if (test_bit(KVM_ARM_VCPU_PSCI_0_2, vcpu->arch.features))
+			val = 2;
+
+		vcpu_set_reg(vcpu, 0, val);
+		goto again;
+	}
+
 	if (static_branch_unlikely(&vgic_v2_cpuif_trap) &&
 	    exit_code == ARM_EXCEPTION_TRAP) {
 		bool valid;
