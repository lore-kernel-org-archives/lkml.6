Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224xnbUjJBVvJ5Pr+D+KRUbXr0WmZy8+FIOkgD2/kZEG82mfbJiwSPI4sGyK70/Ur6Bubv7N
ARC-Seal: i=1; a=rsa-sha256; t=1519218477; cv=none;
        d=google.com; s=arc-20160816;
        b=Wx03spn6jxNZL6WjGoXtplGwvvXgUxlCUon5wNV8CW8mECOQw8L1wT6RS6YwBA/3bI
         rLwEgeJMimef4GhL0mSwyqYz7WG4GxNdNSFxXVTlTBH7D9e5A6GmcDh3d/EHrcQY0gru
         ha/U8+aMFvr5wFtT8lSj+0G1qJPr2+1EZng8NmPiR5KRQ1oA+qJ9zQxmZgXtIC+cfcqi
         CLbUyNCjR7nL0XnBFvEdGqoi62CpuLWxN5R+nd4WVqRnLp0hZ6dMDLiglIke3WRBsASt
         shrBuwBSbNjTRtICiWDqabD7YYsNzOM6imhAIqlo9zzgjfJXGaF3ASRR7POSyj8ihiOO
         Y4WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3gl6JlpGL6RbTBMk1ERTEHuC6jcDhirMXQETOzXfErU=;
        b=PJM0YqoEJ00Gqr1fGJPLUXtrkX/HUlYTtP2j+rLpIxT4N74VFD0NLfxPpdXac5/Dcw
         C3CxyvigUZ+fiRpv7dyxCGCX8wsGhA3rn5TdepLJD84uFGnRXUQM0lIIYhN9HuAa6Eqs
         PzRzIL9ufQlHe2vyVbfQX4fkE1lbf4xdvA9UBoABdBZP1IwrQSBpykc6h/ten71Pyg9s
         PRfd6ilPmniWKcaWn7c0UBy9Yv+rJ/LSWAMBMeSF/o5PRpoW+PqfoKfB1qOXxzscrk4U
         xHRy/vbZ0/JWZcR1UuBfIF5N+VboaejEMKG6EUBOkQwe7e4kZ7k3MBrc90gdpI+LSoPh
         P2yA==
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
Subject: [PATCH 4.15 052/163] X86/nVMX: Properly set spec_ctrl and pred_cmd before merging MSRs
Date: Wed, 21 Feb 2018 13:48:01 +0100
Message-Id: <20180221124533.316373673@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015311446762291?=
X-GMAIL-MSGID: =?utf-8?q?1593016034373356847?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -10220,8 +10220,8 @@ static inline bool nested_vmx_merge_msr_
 	 *    updated to reflect this when L1 (or its L2s) actually write to
 	 *    the MSR.
 	 */
-	bool pred_cmd = msr_write_intercepted_l01(vcpu, MSR_IA32_PRED_CMD);
-	bool spec_ctrl = msr_write_intercepted_l01(vcpu, MSR_IA32_SPEC_CTRL);
+	bool pred_cmd = !msr_write_intercepted_l01(vcpu, MSR_IA32_PRED_CMD);
+	bool spec_ctrl = !msr_write_intercepted_l01(vcpu, MSR_IA32_SPEC_CTRL);
 
 	if (!nested_cpu_has_virt_x2apic_mode(vmcs12) &&
 	    !pred_cmd && !spec_ctrl)
