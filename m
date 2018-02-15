Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2256xntsdgJRJXka0oenLjZ2qv6abDfFTazE65sg1Rq5SkTyVsHPrZ4i35z260A4xbvhpGow
ARC-Seal: i=1; a=rsa-sha256; t=1518708943; cv=none;
        d=google.com; s=arc-20160816;
        b=RPma3bBvf2XilT/XD+6CydDDvMLO1zFyRBi5DTXqzP5XgT3dqcHjooAqD0QjmSF+da
         tSaQyOewKvIRfSsVrIv4dizpXDzbpsqTGZtSgJuTNxCFckQalZviFDtwd2CG59CfNbuC
         lmzOo4n/A7Bv3NwxBB8v7tlz/13MoTOc7Sl1O8BO+XtdVq/HL6Pn+S/jjOKSqKURLGDV
         QpPGFkkx72cioYG8Kx5fRRbaY94OUZebFBXTghLihGM8W8Cnv1oOmoXtMogBZ1Mu5Dbg
         s63KWQAVwx/QiZA8OHCf6NMwKA88ZGPaD4qPn0GK+Hj/2ZVZopR7ULf1KjT/FoBSBiQf
         tumg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FKXSJvDgKWVYWZIyD+ULJP65wrLZSRJMC2DYORRldNg=;
        b=IY+0qLDHOMWE0icAnGR90X7DQ4fK0RXVO+4X+hXFxr00ERj0tfZb4vR36jDNtNH1bN
         0cGtYtmtVuFNTw2/2WV5HVrq5fJ8kHXOAMJqoAV119HuXKoOSTmKJVZiV0M+mnq4QHGP
         dINWexHWaujNDLUiW1jYnQdVGS6AX1V749gDJZ/IBJWpQD3CpQa3oz7rK7csj6WFxWI+
         tz42teDc5LoCl8vRXoCHipP6Cjgdm7HLWz70rmQbKz50jRiLdXbEB2/gyo46coKmutml
         s4sOK4o+hBYmoj4xL5SMdnek7kqXvQzDVht+ohDVR3LKavNLOKgtZoJ+ZkItf5UmFWwC
         C+5Q==
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
Subject: [PATCH 4.14 136/195] arm: KVM: Fix SMCCC handling of unimplemented SMC/HVC calls
Date: Thu, 15 Feb 2018 16:17:07 +0100
Message-Id: <20180215151712.591016767@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480746848288808?=
X-GMAIL-MSGID: =?utf-8?q?1592481748974856458?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -38,7 +38,7 @@ static int handle_hvc(struct kvm_vcpu *v
 
 	ret = kvm_hvc_call_handler(vcpu);
 	if (ret < 0) {
-		kvm_inject_undefined(vcpu);
+		vcpu_set_reg(vcpu, 0, ~0UL);
 		return 1;
 	}
 
@@ -47,7 +47,16 @@ static int handle_hvc(struct kvm_vcpu *v
 
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
 
