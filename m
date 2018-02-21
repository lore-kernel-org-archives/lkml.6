Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226HpZpG//+nFaGNBMofJB67Obnlwlsr2eBeOVTqu2qCUqebuF5MDfQrBqbofOSnPQjaD9sZ
ARC-Seal: i=1; a=rsa-sha256; t=1519218000; cv=none;
        d=google.com; s=arc-20160816;
        b=hJwDM0W1q2OytJtYF2tiiPAIAMx/AHTmpLX0dH7TAvn1VOrvvdkTTZ/ReTIHe9Msnx
         rlEkzNThsx0kHRs4OOADJemxKITeoW/g0smTOMnPSTOWMiaLscVyrrNYS5jkIxmfkQGe
         p6TbtUt1LEOb6cRyPTVYdGL1IkZy108ROUTYnT9GcdAISPTEAghfKyx3Vh5Q4Kpxq1pE
         zKHnCQPFAe+r5hEj7rOcMUA8ouPc1GzPjbGKnnxHrBNlhrWyvddkM2bDk+y+1Hvdamwh
         MzGCwZ+3DgcIBcGbQNcJcm4E3bu1lOSegksRX5vkLMxFI76Ll4y+Ne2yeUbTW0wBGQP4
         m2Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=w1HH9x+jfpvDbWXOH15traTsflm0//gMKiTaplQKIzQ=;
        b=fOs2JPXhpE3/gF8PIIUdPGqCQV3ndFk52zYSZwtv2t6tFU7rBepZTcSF6h3myI0NdM
         HMRLnJrzCe8r2shv0Rqqf9W4wxmipA97pYxLAwafK7rLvslU7eqCKT1dyDXlUgEFXzEN
         BZ6QZzsXXMJFJh7KwPJoWIve6XLKzzxIKosfJ5ztg5Tl17DXZmnBOf4gjKb5bwny9dD6
         hf5M+QLW83vUldFtEx50mu8n4+Ha+iVIzbAxGZKZGiy2SLJyvS1DQTCF+DdibPACWokz
         tL1VzJtPNPOQtzvRqXgr/M4E7U8w9ENTfGnj9vRoMND1kQuF0FXN81k2TMAD4mD7OeM1
         eXwg==
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
	jmattson@google.com,
	kvm@vger.kernel.org,
	sironi@amazon.de,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 053/167] KVM/nVMX: Set the CPU_BASED_USE_MSR_BITMAPS if we have a valid L02 MSR bitmap
Date: Wed, 21 Feb 2018 13:47:44 +0100
Message-Id: <20180221124527.451887429@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015534029730793?=
X-GMAIL-MSGID: =?utf-8?q?1593015534029730793?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: KarimAllah Ahmed <karahmed@amazon.de>

commit 3712caeb14dcb33fb4d5114f14c0beef10aca101 upstream.

We either clear the CPU_BASED_USE_MSR_BITMAPS and end up intercepting all
MSR accesses or create a valid L02 MSR bitmap and use that. This decision
has to be made every time we evaluate whether we are going to generate the
L02 MSR bitmap.

Before commit:

  d28b387fb74d ("KVM/VMX: Allow direct access to MSR_IA32_SPEC_CTRL")

... this was probably OK since the decision was always identical.

This is no longer the case now since the MSR bitmap might actually
change once we decide to not intercept SPEC_CTRL and PRED_CMD.

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
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
Cc: jmattson@google.com
Cc: kvm@vger.kernel.org
Cc: sironi@amazon.de
Link: http://lkml.kernel.org/r/1518305967-31356-6-git-send-email-dwmw@amazon.co.uk
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -10127,7 +10127,8 @@ static void nested_get_vmcs12_pages(stru
 	if (cpu_has_vmx_msr_bitmap() &&
 	    nested_cpu_has(vmcs12, CPU_BASED_USE_MSR_BITMAPS) &&
 	    nested_vmx_merge_msr_bitmap(vcpu, vmcs12))
-		;
+		vmcs_set_bits(CPU_BASED_VM_EXEC_CONTROL,
+			      CPU_BASED_USE_MSR_BITMAPS);
 	else
 		vmcs_clear_bits(CPU_BASED_VM_EXEC_CONTROL,
 				CPU_BASED_USE_MSR_BITMAPS);
