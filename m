Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226AbR1D7w7xc5Ra59Psf3v0FozqRFqDejaYupiQ691typfvJoKl5biPxZ7jLZvCHO1jERWb
ARC-Seal: i=1; a=rsa-sha256; t=1518708804; cv=none;
        d=google.com; s=arc-20160816;
        b=Qf9OnVCejgdIzop641XdoJtkCb2lEajGEy23aaHThM5Qpi2gWDio38miXY8DqYS1CZ
         pmoadCk/awgNnMR9v2wBzmesumNmv4Y3YWlal/hRJhZwbbOZ01FaBWSgkwr4jbTn8hvB
         pFLVB+mpQvkRmPizjCOn29gFSdV5RbsIcAliNrLEK7N4+JeRziOM/oeVYkQpVRp7VJcf
         KCeBsBgXbkZL4JqfRt/yZ5v32JETZdGUF7zRLqZ9tY7lyfNVNf8XEHv0HQYhZJUDeHvw
         vUPoMtLB05uGB9Ab6L1eKqmCIk5g6K/AD+WBVQ0NFsaIH0Nw4ygCpQljgTVP6XaRIExo
         upQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=adhXuVbzqJL6JSSmsz9r2dz4X/bMorp917Lls/zxCnc=;
        b=p49LVUO3wsJB5nGAj23Z60zkr+kqfW6XWEElCNVUlt7D9GSOlJxWoDX/lpxPd/Xjou
         vkXjjqJhOY8B3Mv4JuxXR4zSGXlvvCXhueuYH/ekwoGBdfyOv9mIJP2iZ6KbcmzLwMHR
         ld9Gs7bijFYjuHL7LiHHiN8lfXn+cZcFB1eiaPwfUmdk2xXe+70zpXPvqHgy8kObndjV
         NJ+ftv4vJuQ/8GONHhQuFUHE/p8DeY5yU9Qh0qffd+L/FK0qQtZ/0e+9+5nN071mLB9w
         5G3co1ZwxfKosQGfZEOYEaPjvfylkLp8GbN6cMptVHgVgwYXkCmOAak6G6q8h7zLUa2F
         yPtw==
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
	Catalin Marinas <catalin.marinas@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.14 085/195] [Variant 2/Spectre-v2] arm64: KVM: Make PSCI_VERSION a fast path
Date: Thu, 15 Feb 2018 16:16:16 +0100
Message-Id: <20180215151709.958840909@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481604029553131?=
X-GMAIL-MSGID: =?utf-8?q?1592481604029553131?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>


Commit 90348689d500 upstream.

For those CPUs that require PSCI to perform a BP invalidation,
going all the way to the PSCI code for not much is a waste of
precious cycles. Let's terminate that call as early as possible.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
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
@@ -322,6 +323,18 @@ again:
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
