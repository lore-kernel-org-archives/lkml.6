Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvr9HK5RaWo1G0lgCawpAU6FPmFg7Ai8VK2V+TTGabI9PLO81zI+NfbgJxnVQwIwsQAfZmq
ARC-Seal: i=1; a=rsa-sha256; t=1520451862; cv=none;
        d=google.com; s=arc-20160816;
        b=J3+qpzWlQzvKgralEIEIwRBJu/nieB45m2CyOBnDwp2/gammxRjCoZ/deEg0LFRwls
         HiKRVR6oiTRHoreI0kDRFmazEDhyD/+eJtIcC4CwL/Qq4fGADHNwUibOYlOQBNcFJnbI
         /7tXawrculvvYdbDlM9h8xx3b4Pk0LDuXBSor97Qg5OHtZFCL1pFxgVVzoyJ7OvNfB/X
         37SVXeMJKIVmHwRZMU0xZByUHwL1xWWS7YK7K3Q+eyFKNg5y7sHNI/dvrbp0v5Cv/mfq
         hVqSHaW/TlwHxk68wYYxNm4aDmvDbmLyA7BIFVuZMxhBQOZJkpt/UKw/O6cwLxy2k5mr
         YzmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NgBC+O/WBeS+7421uEz2plmcawh3FdsleheX76LG1Yc=;
        b=tWQ9ewYirDKxCz/PZtf98hATktl8nHC9GroAhBTQ+3dnjH9Lhg9u1RGlb7+jHSiqZ/
         GRqM4tn0+EY5A3IPfPTnC3tcPmv8A3Id+L3QNm79zVlvuDN5zL9Cg/Mu8w5tHcgA+LkT
         z3zQL69eAaqiwBaoZl8FKaUuUHJgwDSJS0nTmY0MMT+D0l0YiDancP7iHq3Aun7PxrcO
         4WlFRIxy70djsHZRbkd567iXlrreD+02lBzrya1YuQURtctJw4pEHkCXJCNxrCnwXaiT
         uZ0K2Px5LlJD03MVTqbPB7L3u0NtTpQAzHG0WjubkvVxChYceFOmST6rNVhGR4TfWuCp
         Y6xg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	KarimAllah Ahmed <karahmed@amazon.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	kvm@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.15 115/122] KVM/VMX: Optimize vmx_vcpu_run() and svm_vcpu_run() by marking the RDMSR path as unlikely()
Date: Wed,  7 Mar 2018 11:38:47 -0800
Message-Id: <20180307191746.319141902@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309331730557447?=
X-GMAIL-MSGID: =?utf-8?q?1594309331730557447?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Bonzini <pbonzini@redhat.com>

commit 946fbbc13dce68902f64515b610eeb2a6c3d7a64 upstream.

vmx_vcpu_run() and svm_vcpu_run() are large functions, and giving
branch hints to the compiler can actually make a substantial cycle
difference by keeping the fast path contiguous in memory.

With this optimization, the retpoline-guest/retpoline-host case is
about 50 cycles faster.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: KarimAllah Ahmed <karahmed@amazon.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kvm@vger.kernel.org
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/20180222154318.20361-3-pbonzini@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/svm.c |    2 +-
 arch/x86/kvm/vmx.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -5139,7 +5139,7 @@ static void svm_vcpu_run(struct kvm_vcpu
 	 * If the L02 MSR bitmap does not intercept the MSR, then we need to
 	 * save it.
 	 */
-	if (!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL))
+	if (unlikely(!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL)))
 		svm->spec_ctrl = native_read_msr(MSR_IA32_SPEC_CTRL);
 
 	if (svm->spec_ctrl)
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -9579,7 +9579,7 @@ static void __noclone vmx_vcpu_run(struc
 	 * If the L02 MSR bitmap does not intercept the MSR, then we need to
 	 * save it.
 	 */
-	if (!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL))
+	if (unlikely(!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL)))
 		vmx->spec_ctrl = native_read_msr(MSR_IA32_SPEC_CTRL);
 
 	if (vmx->spec_ctrl)
