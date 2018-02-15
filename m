Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224JevRCVTpmKZ2Y9zCrHelRkslsmHyAtoCRbnio1top0yLENiS+8iizDW1JNA9uBalThLNC
ARC-Seal: i=1; a=rsa-sha256; t=1518708469; cv=none;
        d=google.com; s=arc-20160816;
        b=o6G/uMUTQo4iPi72Z14KL3UZm4ZHR+3HV+KSFmW+rVE+MMQBEDb2one39LOrDeTFpQ
         N0sf4ZBywxhNI7sMs+PScvQi6HR78gcnOmQNhWaVzg/5tuVZRrxgINgiweFgWjVWpJIa
         zmL+VmEW3eU3IVJGTDlP2IThplUTjpkMNQVNNBomU12/aVl3SywkEMpK3pKzofUVFW9K
         pGJOul6M2NbS9OgS1rDzYPbtDWOZqDsg3pGFhVdUdn80Cg0OlNjGyNIpZ49oTRZOHBx7
         sUcivHAWcoXCQat6iw1NCVbFCNODQEXH2yVph7zCcOJBn1cyP58AKKmidqhIR4bNdV8p
         4IRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=s6beJ4xeh2iBsQ1xvKqFoFPZa2CqKJWu6YiWF/gecUU=;
        b=Hc1qGLI0dvoMp4T3d/F4SYTDImpfnwMDBiXouDp2PO9FRIjZuuMFTWtyYUQJLpEvN1
         3PhKJ4dTryCaL/WTMx3oUmza1Zxw4Nir3FoxHNSd+TpUql0Vt8GNHUJI5VjRjdbIQv/Z
         7Jl8v6VStaZzCfbEYKn/ABh6DrmrLsVLId+1n/bdr5BweaQlUsFR17IGtKEfMhk3WrSC
         sWkfK7eNntUNqPG9u3bdTjkldItxxaG2npg4lWdCk3msvaPs9B7to1J7KNkSDNXvh987
         OqChCQ+JnldaUI15LaqTtVTe/psixU70KRPBIrwIDECX+p+NOjQVvhAnry8p9Thja2Pq
         MyvQ==
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
Subject: [PATCH 4.9 52/88] arm: KVM: Fix SMCCC handling of unimplemented SMC/HVC calls
Date: Thu, 15 Feb 2018 16:17:19 +0100
Message-Id: <20180215151229.925317169@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480746848288808?=
X-GMAIL-MSGID: =?utf-8?q?1592481251722021766?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 
 	ret = kvm_psci_call(vcpu);
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
 
