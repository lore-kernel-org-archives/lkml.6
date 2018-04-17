Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/Wk4C0vZN4ct5Idaj55W5YUxoqi4nYCtansNaZGGFb2MRVxpYdgM/ScxI3LCUpPFmVV5sz
ARC-Seal: i=1; a=rsa-sha256; t=1523981455; cv=none;
        d=google.com; s=arc-20160816;
        b=qogm+JEeN7wDL4MHFPfl0HwUA/JnEKhVmO67XaFZDjLNon6AqhzX/ijjXafO5t92il
         BtjDRVfSGZvoVaiygSGrJUw+MuwhUKaopoT7HuotqDhiWLDgExvH75QOraKsb9g0q4OB
         UCZ8qLk6qQ8tmahL7xc2JAwGZeV8wfm0C6k9I4OcSJnrPBd7Zl0Oc2MtMUMbogp0yf+I
         IK8vT6O2V1M8GSMw5Tvm1kPqIjwoKUZUloX+oyWb/fZGsxtqnnQ3uTMifmQiH8QFlE1P
         ViAmmw7pDI2px4GPOyeCSxl9r/vEuiCLpvyseuxL8mYvOVfOq0PUFSiJDosyc7mYVMD8
         5B5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=MJwLEdunmvtdW2UYhOHrrzQumAxVn104jvmAxgfUyMM=;
        b=ExlJN0uCZrjYPANBWte3GXT+iNwTEgvCqX7A+jIbElWhhGL20R3cl2GJxlmMNbFEeT
         bwh0hrI2ETlpb7uw92cp40tBYLxN0q39XZZkWJBTSYrcUt+qW1mFeAg3r+eKD+9cBlGT
         XLoHpmemewh/snclgLUQta1JZYhcOh8BiPdJ5HdmfmBbfACBPmBCGCLjR0YbXMobcGgm
         fSCuWInQ5DEHAHaKACO95m+P0h04vevjrPTCv4Q9XQvPgAvMIxgqE+T60InY8f2SFcLA
         kl0N2Rlvuin6DB2cKnhkrC2Hb8caO6+5XHPsotNaLDTBsZx0DCK35ofxC5q75B1nWgbA
         DQKw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoffer Dall <christoffer.dall@linaro.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Greg Hackmann <ghackmann@google.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 4.9 35/66] arm64: KVM: Increment PC after handling an SMC trap
Date: Tue, 17 Apr 2018 17:59:08 +0200
Message-Id: <20180417155647.391743183@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
References: <20180417155645.868055442@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598010378012758243?=
X-GMAIL-MSGID: =?utf-8?q?1598010378012758243?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>


From: Marc Zyngier <marc.zyngier@arm.com>

commit f5115e8869e1dfafac0e414b4f1664f3a84a4683 upstream.

When handling an SMC trap, the "preferred return address" is set
to that of the SMC, and not the next PC (which is a departure from
the behaviour of an SMC that isn't trapped).

Increment PC in the handler, as the guest is otherwise forever
stuck...

Cc: stable@vger.kernel.org
Fixes: acfb3b883f6d ("arm64: KVM: Fix SMCCC handling of unimplemented SMC/HVC calls")
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kvm/handle_exit.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -53,7 +53,16 @@ static int handle_hvc(struct kvm_vcpu *v
 
 static int handle_smc(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
+	/*
+	 * "If an SMC instruction executed at Non-secure EL1 is
+	 * trapped to EL2 because HCR_EL2.TSC is 1, the exception is a
+	 * Trap exception, not a Secure Monitor Call exception [...]"
+	 *
+	 * We need to advance the PC after the trap, as it would
+	 * otherwise return to the same address...
+	 */
 	vcpu_set_reg(vcpu, 0, ~0UL);
+	kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
 	return 1;
 }
 
