Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226TX1/D/mn7BWE1bE6lJIQKl8jC3AS4JwtIaC+Zs592VAYTX38YyLVnmY4dUmbcHj50r6xE
ARC-Seal: i=1; a=rsa-sha256; t=1518707987; cv=none;
        d=google.com; s=arc-20160816;
        b=Y9gYPereUDC31Pkf/kGj5llnxxpFqOMWXxRwzGNzK1+sOCmeMx3hNdf/hXI6rOCaS3
         16ONUbfAIMnJT/x8JXn+yNa+pgwyymP5dDI0R7HBQg2xJ/vxSl0OJzMp8XmVE/a/4013
         N2gWPhacNz5YMbRakrmFxPo6+TjJCtIZ7jkayYHpLuU499fApGw0+sLjFwQdP8zJRUOC
         wUGeZ+36sF7yeEgb9+hsD4hgGaxYpWFd9OE5cm04o6YccXNZ/MElZHCgbgLqw6U2j96B
         0NRaRCmOBJEBSxkgTc/lF4Qt/1bGXZDBAFf9CFzedvXmFdiKh8hooY+JK+w9+eUusIwD
         x1MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yNf7Ki32lEcpo5VD6jK36y7l8ydi+53aJrNAzF/+yRU=;
        b=UIJbqR2Ru+Ra8G8f2r9pOYg8TotK1qqGD9A7f6sLQ+WrEKcvQ1dtTxqB62bcCAXi9T
         6j10n5l3Tt0Y/dheNaUQJzeaascagNqt9gzTqudaYmqcLsCVn7pWOKZCsFZ2VV9YXZit
         c/49QYzjT5yQYkuzG73IFU1WH9YtasWGRyRPfR3nkhYGNhCj5DQrmmjayfuV22lLAwWt
         8Nh60sLiswgiGQJhP9LdwBtZmxfAaPtCRQj4iS8UzK0PKQB0WzlkX7BtHNJhsLrClDUa
         6CbviZs05eWnr65AfTX0p/QQ4JYvOwlOMx9GjEVPin0YWjkPLFwEXe5EMIGRAF2WNgfq
         Lhhw==
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
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 3.18 34/45] arm: KVM: Fix SMCCC handling of unimplemented SMC/HVC calls
Date: Thu, 15 Feb 2018 16:17:25 +0100
Message-Id: <20180215144123.189399417@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215144115.863307741@linuxfoundation.org>
References: <20180215144115.863307741@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480746848288808?=
X-GMAIL-MSGID: =?utf-8?q?1592480746848288808?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>

commit 20e8175d246e9f9deb377f2784b3e7dfb2ad3e86 upstream.

KVM doesn't follow the SMCCC when it comes to unimplemented calls,
and inject an UNDEF instead of returning an error. Since firmware
calls are now used for security mitigation, they are becoming more
common, and the undef is counter productive.

Instead, let's follow the SMCCC which states that -1 must be returned
to the caller when getting an unknown function number.

Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/kvm/handle_exit.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/arch/arm/kvm/handle_exit.c
+++ b/arch/arm/kvm/handle_exit.c
@@ -45,7 +45,7 @@ static int handle_hvc(struct kvm_vcpu *v
 
 	ret = kvm_psci_call(vcpu);
 	if (ret < 0) {
-		kvm_inject_undefined(vcpu);
+		vcpu_set_reg(vcpu, 0, ~0UL);
 		return 1;
 	}
 
@@ -54,7 +54,16 @@ static int handle_hvc(struct kvm_vcpu *v
 
 static int handle_smc(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
-	kvm_inject_undefined(vcpu);
+	/*
+	 * "If an SMC instruction executed at Non-secure EL1 is
+	 * trapped to EL2 because HCR_EL2.TSC is 1, the exception is a
+	 * Trap exception, not a Secure Monitor Call exception [...]"
+	 *
+	 * We need to advance the PC after the trap, as it would
+	 * otherwise return to the same address...
+	 */
+	vcpu_set_reg(vcpu, 0, ~0UL);
+	kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
 	return 1;
 }
 
