Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZroSJn3a0Ihl2CwKOz8/NfDbUbvqsnWUZLdsuJOZyCurpixgErvCWMP66ss4Y9Rd2+MMwuJ
ARC-Seal: i=1; a=rsa-sha256; t=1526937916; cv=none;
        d=google.com; s=arc-20160816;
        b=SvW/IXansScvFLESC6QEwxCD56FHf+SduhpH8NAsMJWW2A18bjHIIg5OG5PVcmdoDJ
         wm7l3GWFg0vtKaWzQBv84tZDCRaAHNqkU1nR2ek0EZRVxzplVRqONkb7XF6ILnhyb/Wc
         7AKZV+vp/xBqghtr0NkdCjZC2IgXxXgKaD03ItHoChgdBxczCr4By9DnwR6SAomZA4mY
         yhQLXKfVQPr/1doHPcQTrsdR9A+RTzChoBoZTTDiw4gW5+cBVt9eVO+uBgbxEbK9H9iw
         NVuUf33UIWiZNZ6YwKEPbL4p+ksgmrJChjCiAXXzANrANcnjhhg8RpNlOqw0BDHELcIT
         DkAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=rGacbnJKxVsvY6/D3TNFoXh4hood7vQ2wdKrSpDlMJg=;
        b=hzrnJRxJUa0NkVq86mSwvEeMLDb7Zi3G3anCiZl/ETh0poo1k4vT9e/LKv1KWnq0DG
         rwxxbbgI5nnEBJnPoaMnSd0mRL7wb8HE6w4UZYc5Ko+z1wc2J4QNmlOZhIqwafMGYz8v
         nQLlkI++gG/x+npb4D7wTxMHRk+s+jH1Dcu6W4zSx3FCrLdaJFcOo/CAmh/dh1XsFZHJ
         +UpcHEG2pQa4i+PuzNdtAVynvK8h16kDb0d5MwZcXK0H6OD+fhZMf8rw5WLDC6PwPUU/
         RMc3G4nXQWJdzOx+0pQTJH3CNhuzGrc16FC/VyWR5qTAr8AaTmM0P50OMqWFPHYjBjWP
         3tbg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=At1lOX8+;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=At1lOX8+;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.16 073/110] x86/KVM/VMX: Expose SPEC_CTRL Bit(2) to the guest
Date: Mon, 21 May 2018 23:12:10 +0200
Message-Id: <20180521210512.632685068@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109855664030596?=
X-GMAIL-MSGID: =?utf-8?q?1601110452440858441?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -402,7 +402,7 @@ static inline int __do_cpuid_ent(struct
 
 	/* cpuid 7.0.edx*/
 	const u32 kvm_cpuid_7_0_edx_x86_features =
-		F(AVX512_4VNNIW) | F(AVX512_4FMAPS) | F(SPEC_CTRL) |
+		F(AVX512_4VNNIW) | F(AVX512_4FMAPS) | F(SPEC_CTRL) | F(RDS) |
 		F(ARCH_CAPABILITIES);
 
 	/* all calls to cpuid_count() should be made on the same cpu */
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -3276,7 +3276,8 @@ static int vmx_get_msr(struct kvm_vcpu *
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr_info->host_initiated &&
 		    !guest_cpuid_has(vcpu, X86_FEATURE_IBRS) &&
-		    !guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL))
+		    !guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL) &&
+		    !guest_cpuid_has(vcpu, X86_FEATURE_RDS))
 			return 1;
 
 		msr_info->data = to_vmx(vcpu)->spec_ctrl;
@@ -3397,11 +3398,12 @@ static int vmx_set_msr(struct kvm_vcpu *
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
