Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrbLAVWYQ63hB6CbzHm3A7SJXdZ3B5wCHeXqkF+uEhYwLCpX8Ro564F1FZ/H9eaO4isuouH
ARC-Seal: i=1; a=rsa-sha256; t=1526937618; cv=none;
        d=google.com; s=arc-20160816;
        b=tpoOR/b3HVapEcBygLZOjgMSEJjJTeiGGyKZlDjFbZBfVAveheQNfWiJCGaiD7G7+c
         xJBou6sU+jUMDKGMYs4km++IllP/st7wNTluBg4Bp5CYuA6W1AvaUbhzc/EegiePcGLE
         mIuJFa4E4n+lWgkl9Q7bDmCRBv7I5yWbGIMhUQzGzeVyogc12ju+JRft2KUi0fzTUtZ/
         FwqazzPGkIIBTRNsRJr5o3RSP0DwAugx6+VxPXjVFcFmmnLZBuDBCgLFv8ukMUmAqDs+
         Ojjx9woCjBbOpMroitXgT8Uyc7nr1SvsTTX79cLish7TY3meBscf8igyT0tXMp4dg+sF
         0Jqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=m70Lsvyz2zj2yguq4syBaSXTiVTUwtUs9PMWTx4cwxI=;
        b=fcjrw7RFLB1FfbR+4jQQ9/7PNiqbcCvkrSnHc0lL2fRoF8dBlLQTZyoRgK2stFUJ7q
         UACrXzY9G2mhfwUrM0FTexub335kk8a3O8Tc3+pAHM/3VEIunbX4NLZ289/ulVXE6Aet
         a/iu8fH2+XeQsUMcrNZ9QGnOxsZr9K2CSc6ccP/98PHnYSaovEyDyGBb8hdu6NevXFto
         rNSUDHTV2VT46T2IW8jGSYS61fbdjVKY4q+BbAL0Ba6GI/d+k2PsEd9Te9UoYReoPT1N
         dTDCGFXZtlcAnU5LbuvGuLOf+9Jp1VH1SCrkjq5jqRSlb3CTeV2AUm2jV7xexltMA5Fg
         HMsA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=hA+HXYsX;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=hA+HXYsX;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 59/95] x86/KVM/VMX: Expose SPEC_CTRL Bit(2) to the guest
Date: Mon, 21 May 2018 23:11:49 +0200
Message-Id: <20180521210458.766532912@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109855664030596?=
X-GMAIL-MSGID: =?utf-8?q?1601110139749295245?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/cpuid.c |    2 +-
 arch/x86/kvm/vmx.c   |    8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -394,7 +394,7 @@ static inline int __do_cpuid_ent(struct
 
 	/* cpuid 7.0.edx*/
 	const u32 kvm_cpuid_7_0_edx_x86_features =
-		F(AVX512_4VNNIW) | F(AVX512_4FMAPS) | F(SPEC_CTRL) |
+		F(AVX512_4VNNIW) | F(AVX512_4FMAPS) | F(SPEC_CTRL) | F(RDS) |
 		F(ARCH_CAPABILITIES);
 
 	/* all calls to cpuid_count() should be made on the same cpu */
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -3294,7 +3294,8 @@ static int vmx_get_msr(struct kvm_vcpu *
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr_info->host_initiated &&
 		    !guest_cpuid_has(vcpu, X86_FEATURE_IBRS) &&
-		    !guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL))
+		    !guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL) &&
+		    !guest_cpuid_has(vcpu, X86_FEATURE_RDS))
 			return 1;
 
 		msr_info->data = to_vmx(vcpu)->spec_ctrl;
@@ -3415,11 +3416,12 @@ static int vmx_set_msr(struct kvm_vcpu *
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr_info->host_initiated &&
 		    !guest_cpuid_has(vcpu, X86_FEATURE_IBRS) &&
-		    !guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL))
+		    !guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL) &&
+		    !guest_cpuid_has(vcpu, X86_FEATURE_RDS))
 			return 1;
 
 		/* The STIBP bit doesn't fault even if it's not advertised */
-		if (data & ~(SPEC_CTRL_IBRS | SPEC_CTRL_STIBP))
+		if (data & ~(SPEC_CTRL_IBRS | SPEC_CTRL_STIBP | SPEC_CTRL_RDS))
 			return 1;
 
 		vmx->spec_ctrl = data;
