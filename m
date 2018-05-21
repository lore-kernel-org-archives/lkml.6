Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo21nE6SSW9QU+h3DFMiqYD699DOsn+3S0ZEPPBGCHAfKvaaFZZoc3zAfWzrqzc5cnt3pc8
ARC-Seal: i=1; a=rsa-sha256; t=1526937347; cv=none;
        d=google.com; s=arc-20160816;
        b=gTkeFvgUG7sDHpV0bRV1YGKrojUM6741zee33Clu0RhghSjFZLFFsCO51P48QP19GV
         lqb6okiS/hzNPyKmwCn07aVE9e9zF9xn72fj0tl/w3hN7Gt8q6efpI802OVN1F8tzAKx
         wVSCVcVSQfjLs5uLmZdBBWTtxGOjzdMUetGeYeTTVZQhPHRte79g9iCa22CemQzhHwFo
         Os1fHAEHqtr1Ld6v/icigrOFI4VZ9ELqI2SamO6zRTax22EkCpZ5j4iU5PjDQyiW5GYf
         NHPHX2kzC6+/sTqlMkYBJyRbnzej3+FmZJQu5Jor43snql0owyaGtFXydgrJV3m3/fqY
         aKGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=AovtAgAuBhpy7DpZdmV1ZZ3d1HwsdhZe2BVAlm5MjFg=;
        b=u20KuZxCXBI8u/SippvsHbXizreSZ/P+AOU0Gf/W73P9Vttg6cDTVUEHaxhowK2DAW
         BeImiHBFnbCLI/OrqO4Sg7JxNXWwscCEXgE8aOHhFZx5+R9eTlR+olR9rqm/Sufo+DAE
         DPMrOo0oflAm1NexIDzcbFuCH0GVYIhksAh0tOYv+Gu8t+sezGTXopL3ReTbp4mckvjH
         QCwSjrHkvRNOEUtBfol080ApRqKL71OVIgu2ylISCA8egxaaz483LPDRY8khsO+vP+bQ
         avzjgubFgMeAnKJb5faSTecdLLx3ZPcKj2iEczpgQnHVg7WubT+y/yMv5QT8R9vUiAg3
         uXBw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=C9/IgVOO;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=C9/IgVOO;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 47/87] x86/KVM/VMX: Expose SPEC_CTRL Bit(2) to the guest
Date: Mon, 21 May 2018 23:11:23 +0200
Message-Id: <20180521210424.749861931@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109855664030596?=
X-GMAIL-MSGID: =?utf-8?q?1601109855664030596?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit da39556f66f5cfe8f9c989206974f1cb16ca5d7c upstream

Expose the CPUID.7.EDX[31] bit to the guest, and also guard against various
combinations of SPEC_CTRL MSR values.

The handling of the MSR (to take into account the host value of SPEC_CTRL
Bit(2)) is taken care of in patch:

  KVM/SVM/VMX/x86/spectre_v2: Support the combination of guest and host IBRS

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>

[dwmw2: Handle 4.9 guest CPUID differences, rename
        guest_cpu_has_ibrs() → guest_cpu_has_spec_ctrl()]
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/cpuid.c |    2 +-
 arch/x86/kvm/cpuid.h |    4 ++--
 arch/x86/kvm/svm.c   |    4 ++--
 arch/x86/kvm/vmx.c   |    6 +++---
 4 files changed, 8 insertions(+), 8 deletions(-)

--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -382,7 +382,7 @@ static inline int __do_cpuid_ent(struct
 
 	/* cpuid 7.0.edx*/
 	const u32 kvm_cpuid_7_0_edx_x86_features =
-		F(SPEC_CTRL) | F(ARCH_CAPABILITIES);
+		F(SPEC_CTRL) | F(RDS) | F(ARCH_CAPABILITIES);
 
 	/* all calls to cpuid_count() should be made on the same cpu */
 	get_cpu();
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -171,7 +171,7 @@ static inline bool guest_cpuid_has_ibpb(
 	return best && (best->edx & bit(X86_FEATURE_SPEC_CTRL));
 }
 
-static inline bool guest_cpuid_has_ibrs(struct kvm_vcpu *vcpu)
+static inline bool guest_cpuid_has_spec_ctrl(struct kvm_vcpu *vcpu)
 {
 	struct kvm_cpuid_entry2 *best;
 
@@ -179,7 +179,7 @@ static inline bool guest_cpuid_has_ibrs(
 	if (best && (best->ebx & bit(X86_FEATURE_IBRS)))
 		return true;
 	best = kvm_find_cpuid_entry(vcpu, 7, 0);
-	return best && (best->edx & bit(X86_FEATURE_SPEC_CTRL));
+	return best && (best->edx & (bit(X86_FEATURE_SPEC_CTRL) | bit(X86_FEATURE_RDS)));
 }
 
 static inline bool guest_cpuid_has_arch_capabilities(struct kvm_vcpu *vcpu)
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -3545,7 +3545,7 @@ static int svm_get_msr(struct kvm_vcpu *
 		break;
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr_info->host_initiated &&
-		    !guest_cpuid_has_ibrs(vcpu))
+		    !guest_cpuid_has_spec_ctrl(vcpu))
 			return 1;
 
 		msr_info->data = svm->spec_ctrl;
@@ -3643,7 +3643,7 @@ static int svm_set_msr(struct kvm_vcpu *
 		break;
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr->host_initiated &&
-		    !guest_cpuid_has_ibrs(vcpu))
+		    !guest_cpuid_has_spec_ctrl(vcpu))
 			return 1;
 
 		/* The STIBP bit doesn't fault even if it's not advertised */
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -3020,7 +3020,7 @@ static int vmx_get_msr(struct kvm_vcpu *
 		break;
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr_info->host_initiated &&
-		    !guest_cpuid_has_ibrs(vcpu))
+		    !guest_cpuid_has_spec_ctrl(vcpu))
 			return 1;
 
 		msr_info->data = to_vmx(vcpu)->spec_ctrl;
@@ -3137,11 +3137,11 @@ static int vmx_set_msr(struct kvm_vcpu *
 		break;
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr_info->host_initiated &&
-		    !guest_cpuid_has_ibrs(vcpu))
+		    !guest_cpuid_has_spec_ctrl(vcpu))
 			return 1;
 
 		/* The STIBP bit doesn't fault even if it's not advertised */
-		if (data & ~(SPEC_CTRL_IBRS | SPEC_CTRL_STIBP))
+		if (data & ~(SPEC_CTRL_IBRS | SPEC_CTRL_STIBP | SPEC_CTRL_RDS))
 			return 1;
 
 		vmx->spec_ctrl = data;
