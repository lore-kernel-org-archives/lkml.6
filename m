Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsiIsrspdwMpjZzMNpLsdW4QxjPLO1NHLCAyuUDkoRFn5qrceoy8CigJWUNF9NLL9fRc9Zm
ARC-Seal: i=1; a=rsa-sha256; t=1520641304; cv=none;
        d=google.com; s=arc-20160816;
        b=iVCEtuUS1vnzYLo6zo/AwdeZvtcsa5EAKfcsGL5ZVYBtPI0fYD4gx0kIzF/YHCcY4i
         O8K/6rGmC4mOngw0nFpAt5Qhq0Zl3bfw7uSt+5xtmYmXAA/rIXvw9RqWmBW+dMePmYSK
         zTr50NUDb4u7quut/XhatAoylB/WG42EE8VxfL7lfoPosmWCqJ22iy7ShazvqrmgTG6M
         FYOtGQHx3pRgSMlarL4gjMNJo6/+WmQfLiHMDLuKvu7DKdyAVschQJVHZHFp3iMMmQKb
         ningBab8w7myOtBTDa+5IxvVsmTABTjLIO4haM6yy4Y/C/7sZhIXl6/M+ab8XrWE4wo3
         BjAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fNTi0Sxz9pPDiuYJ/JsVR8QV0PxgQW6+c5fVND01zqI=;
        b=JnXqwd8iDn3HbTk76+Qz2xaXS92hunzwQb0zicNYJ0NExGzgAvqGZOWLbg2Hvbh2MC
         1k2KLNJCVK5WdD5Si0Qgq/zVj7t8YdDQlssAU1mcpwO4auc8Pv3b1iaREZN+Snkss6P3
         o+kzO0JxLYAosqVcqNOGT/aZpMYOKjyzhas1vU/Fw9EjMp/IcYsjcs30BzI2h346k+xB
         ap6nnEZ2Kx+jt6elPcr7fWPEKIXyaU64enBcLMeDIuDTcVv4au1QSVN7BpMWIKqBWeZg
         wTheBoewKDq2U5XuTNGnyGmWw/Zp0uQquNXgFaaAE7x11EW5l3je6FNvoKnDL6Lk+Xug
         frrw==
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
Subject: [PATCH 4.9 23/65] KVM/VMX: Optimize vmx_vcpu_run() and svm_vcpu_run() by marking the RDMSR path as unlikely()
Date: Fri,  9 Mar 2018 16:18:23 -0800
Message-Id: <20180310001826.784593752@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507976662296743?=
X-GMAIL-MSGID: =?utf-8?q?1594507976662296743?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5029,7 +5029,7 @@ static void svm_vcpu_run(struct kvm_vcpu
 	 * If the L02 MSR bitmap does not intercept the MSR, then we need to
 	 * save it.
 	 */
-	if (!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL))
+	if (unlikely(!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL)))
 		svm->spec_ctrl = native_read_msr(MSR_IA32_SPEC_CTRL);
 
 	if (svm->spec_ctrl)
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -9042,7 +9042,7 @@ static void __noclone vmx_vcpu_run(struc
 	 * If the L02 MSR bitmap does not intercept the MSR, then we need to
 	 * save it.
 	 */
-	if (!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL))
+	if (unlikely(!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL)))
 		vmx->spec_ctrl = native_read_msr(MSR_IA32_SPEC_CTRL);
 
 	if (vmx->spec_ctrl)
