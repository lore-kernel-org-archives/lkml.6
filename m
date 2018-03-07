Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsAg8cdHezrkUMtU0Yw79rtNm1HlZxGz2oUQseTZukK+pOqUX0vxftNK92/OakCWR7j7xi0
ARC-Seal: i=1; a=rsa-sha256; t=1520452078; cv=none;
        d=google.com; s=arc-20160816;
        b=lh9/MN8kJQRQu1pY6rl/z90BN91oafNfR0tnA+i/oFczZic85huNGZd43pbtxb49yv
         ZnONIOylq9pXVobfjrEFRyoN+StfTvwMrlKVoR5n/pkRe0Kld3WF3Zu8twcqTXP4Hu8M
         VXYyYuADB6ryJEVpEKRf0rvhxJ93El8Z6poCMwVv1FTqisz9vY5iTLSa3TMaikiE5Ymh
         l6jQOXj4fqsiNzE9u2L2Quf9dD913ByDQ5YBxzonQceV8q/y1GPcUsacyG1YDb6CZZbg
         5IxhMLMOQkqyE+locaAo2KPYTEBOb2ysxcob1BhxcSHIW5TtU83oR/RFlVrgE7WJ1OXE
         iLNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=m9vdCi+ZExKUZk2lvj+2NI9BJbc8L7goeHUlpaXN6wg=;
        b=hySTScq0BEZCQmCp2nMiz1AMBRIqJ75DLoxNdwieluE3Q+YBsuyK/YdahuTzWVem3c
         TEQrcfE/vnENdI6rtfOn03nOYoHLjlWggJm3ETx199ZR8i94AHNxF96/SGCltieN3tBQ
         MwPlIgVUr6TBKcH70CyZohvuk43XzNN5vypUVqVcmfuk7TOdUEYcd9pGHS/xasqoIYxe
         8Se4uPc/radaH6aIDw5Zj9T6Du9kdie/Y/uqt0OOKM/cKu8742FgYFlwId8Y/QbbEpua
         xZ9BW0QbqWU4Ajh+E0RC+KtzP31Hxqs+lJu9WDCzGTcQtVja9K2UIJEQTLlokW+z1oy1
         YMVQ==
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
Subject: [PATCH 4.14 101/110] KVM/VMX: Optimize vmx_vcpu_run() and svm_vcpu_run() by marking the RDMSR path as unlikely()
Date: Wed,  7 Mar 2018 11:39:24 -0800
Message-Id: <20180307191052.793934234@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309331730557447?=
X-GMAIL-MSGID: =?utf-8?q?1594309558420259486?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5125,7 +5125,7 @@ static void svm_vcpu_run(struct kvm_vcpu
 	 * If the L02 MSR bitmap does not intercept the MSR, then we need to
 	 * save it.
 	 */
-	if (!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL))
+	if (unlikely(!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL)))
 		svm->spec_ctrl = native_read_msr(MSR_IA32_SPEC_CTRL);
 
 	if (svm->spec_ctrl)
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -9567,7 +9567,7 @@ static void __noclone vmx_vcpu_run(struc
 	 * If the L02 MSR bitmap does not intercept the MSR, then we need to
 	 * save it.
 	 */
-	if (!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL))
+	if (unlikely(!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL)))
 		vmx->spec_ctrl = native_read_msr(MSR_IA32_SPEC_CTRL);
 
 	if (vmx->spec_ctrl)
