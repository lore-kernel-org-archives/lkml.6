Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225IkrbmA6NmaVkHJqA0+dVUVYFMd3vqmfyysS1i0ck5hdAWX0/x9Vr2UrPWaje1CTA3iY5B
ARC-Seal: i=1; a=rsa-sha256; t=1519217997; cv=none;
        d=google.com; s=arc-20160816;
        b=Yw7irEK85yPH/0Crk6x1Ri4ikNutP6QAsSBx67nYQpS9Jq/T41yyzvNp+9bdUw1uyj
         BNSosmRqoqhywjfnbILFNF983Yte0Wtc9tMhw+73xZObKiQWRzWqLmzAt9GlMaCWP05W
         4xWF0siyA0kS2sVm9XYCCdaIMC3TJ9rwXAfVUsx5FSu+10hT6x49sdl90LXMA1EXuEqm
         +8Qw9OHbFaJ4/Sm+FPUVVWjutz2iXSjpV70l0fOs3auvk2K5ynao7vy0js2qtw2PGZyl
         6BL22ECriMB6y7Ihw4ZVXHEpj1QYGZfh/4ctsyfHklnavzcvrAsh4T+YYtqLDK0znr48
         WUnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=S6BdgEWOYqUH/O/MrHgIj07FsqUD4uFX1erd7KnKD6I=;
        b=tGVQMaMgC5/xYnQU2C0UXoJ4gJY8VVE3xn9eUUdoeK85qdwpdXdY1rawPipbisomDp
         jqzbE6Zt6Un99lN2/Obp+ctjwSwcYNfGU3sRbga4ObRJecYRWrYzWSjpZRyUai7Ti7Qv
         gxJBl7ZZynEjdOhtRKG8wsYrzWsSaSpMA7pp5ZpV6VkKiVk7z65v2DPJ8sAN+mbjmDzB
         Qfk0VZd/JN2S0p/2aQd5CZMSvZ6ObtVjOzOtrAuXiOfa8uCnQbmAwwyNQDqc8htCgrQq
         gs+TtNu+xwue9StZBwcP8+rBntv7wbAUIAuWr1RBVdv81Nlg5NQyFm8kv2ZROaVGLx+h
         kacQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	KarimAllah Ahmed <karahmed@amazon.de>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Jim Mattson <jmattson@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	arjan.van.de.ven@intel.com,
	dave.hansen@intel.com,
	kvm@vger.kernel.org,
	sironi@amazon.de,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 052/167] X86/nVMX: Properly set spec_ctrl and pred_cmd before merging MSRs
Date: Wed, 21 Feb 2018 13:47:43 +0100
Message-Id: <20180221124527.388537081@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015311446762291?=
X-GMAIL-MSGID: =?utf-8?q?1593015531781859560?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: KarimAllah Ahmed <karahmed@amazon.de>

commit 206587a9fb764d71f035dc7f6d3b6488f5d5b304 upstream.

These two variables should check whether SPEC_CTRL and PRED_CMD are
supposed to be passed through to L2 guests or not. While
msr_write_intercepted_l01 would return 'true' if it is not passed through.

So just invert the result of msr_write_intercepted_l01 to implement the
correct semantics.

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Jim Mattson <jmattson@google.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: arjan.van.de.ven@intel.com
Cc: dave.hansen@intel.com
Cc: kvm@vger.kernel.org
Cc: sironi@amazon.de
Fixes: 086e7d4118cc ("KVM: VMX: Allow direct access to MSR_IA32_SPEC_CTRL")
Link: http://lkml.kernel.org/r/1518305967-31356-5-git-send-email-dwmw@amazon.co.uk
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -10216,8 +10216,8 @@ static inline bool nested_vmx_merge_msr_
 	 *    updated to reflect this when L1 (or its L2s) actually write to
 	 *    the MSR.
 	 */
-	bool pred_cmd = msr_write_intercepted_l01(vcpu, MSR_IA32_PRED_CMD);
-	bool spec_ctrl = msr_write_intercepted_l01(vcpu, MSR_IA32_SPEC_CTRL);
+	bool pred_cmd = !msr_write_intercepted_l01(vcpu, MSR_IA32_PRED_CMD);
+	bool spec_ctrl = !msr_write_intercepted_l01(vcpu, MSR_IA32_SPEC_CTRL);
 
 	if (!nested_cpu_has_virt_x2apic_mode(vmcs12) &&
 	    !pred_cmd && !spec_ctrl)
