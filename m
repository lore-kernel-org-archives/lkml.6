Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227zO5qpmxZjVA1HcF4Su6+/XWFIhBSrL06lPv+K6eVz067ZGRrvSrQoDX8WY0CSxy32dUtf
ARC-Seal: i=1; a=rsa-sha256; t=1517855021; cv=none;
        d=google.com; s=arc-20160816;
        b=0C42qtfibJdeG4r0iaHGTsJ370okb9Dhn3tZ027zYAx6rX7vF5HHg5tHj/woaMbtmF
         jETSbVCyy3db32ererhv9H8Awx180YIxSkcs3/6HfW5xIpv2GMnT3CjmYeKza4B9Mbyn
         K5CR0XEemmp/tH8icq/a4kWLzEFaRcqW3V2039aFyfAom6p5GJf7OXWvNW2mdUStSPtL
         0nRpqw4ZVzfROTQJiSMBNFUDuakY+Pcb17WtVaBz1XDIFJ/SCpJdZMM9PNP/44MWT913
         M3/cThYD1F+0lMhtNaKgGG8WGl36GX12DR+ThmOjgH4yw+D5tejeN+47mUh4SIwJobp2
         48Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=K8C5dbJGgNhofRHtxH/ria+/2JNN52WI6srAH1+OyA4=;
        b=pIhh/vYXUlSGPMhp9fnIPEBU4QLM5uiG4yRi0+NNsP5o6TFTNgJsWbQN4LAi4UtUeS
         m5GfldLFWGZwdN15SZCXJB5JaW1QeEZx3hpibasVPdmujGTs7UKsKDK+EorFNmXBeX9a
         JNULVMOCLkF39UiX5hIRQlZJjSG3sJtaezJVodR0EqVT6H8YzWKnrShh8rRrFAMlf73l
         SMh/+ij7KnvXRDYrD8dLSYlBIl1Sd7+lPid3r8FHJWsiMsmKSKnRr/0YnLj1imhLcApi
         MxW8n3nrQ/SHVscU9IzTPmJFd24khJPn1gF7Ysqb+A7bXBdweuSvZw+/cIZRFV3b7ddR
         aFuA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Borislav Petkov <bp@suse.de>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	ak@linux.intel.com,
	dave.hansen@intel.com,
	karahmed@amazon.de,
	arjan@linux.intel.com,
	torvalds@linux-foundation.org,
	peterz@infradead.org,
	bp@alien8.de,
	pbonzini@redhat.com,
	tim.c.chen@linux.intel.com,
	gregkh@linux-foundation.org
Subject: [PATCH 4.14 21/64] x86/speculation: Simplify indirect_branch_prediction_barrier()
Date: Mon,  5 Feb 2018 10:22:40 -0800
Message-Id: <20180205182139.433019011@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182138.571333346@linuxfoundation.org>
References: <20180205182138.571333346@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586347373832119?=
X-GMAIL-MSGID: =?utf-8?q?1591586347373832119?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov bp@suse.de

commit 64e16720ea0879f8ab4547e3b9758936d483909b

Make it all a function which does the WRMSR instead of having a hairy
inline asm.

[dwmw2: export it, fix CONFIG_RETPOLINE issues]

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: ak@linux.intel.com
Cc: dave.hansen@intel.com
Cc: karahmed@amazon.de
Cc: arjan@linux.intel.com
Cc: torvalds@linux-foundation.org
Cc: peterz@infradead.org
Cc: bp@alien8.de
Cc: pbonzini@redhat.com
Cc: tim.c.chen@linux.intel.com
Cc: gregkh@linux-foundation.org
Link: https://lkml.kernel.org/r/1517070274-12128-4-git-send-email-dwmw@amazon.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/x86/include/asm/nospec-branch.h |   13 ++++---------
 arch/x86/include/asm/processor.h     |    3 +++
 arch/x86/kernel/cpu/bugs.c           |    6 ++++++
 3 files changed, 13 insertions(+), 9 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -164,15 +164,10 @@ static inline void vmexit_fill_RSB(void)
 
 static inline void indirect_branch_prediction_barrier(void)
 {
-	asm volatile(ALTERNATIVE("",
-				 "movl %[msr], %%ecx\n\t"
-				 "movl %[val], %%eax\n\t"
-				 "movl $0, %%edx\n\t"
-				 "wrmsr",
-				 X86_FEATURE_USE_IBPB)
-		     : : [msr] "i" (MSR_IA32_PRED_CMD),
-			 [val] "i" (PRED_CMD_IBPB)
-		     : "eax", "ecx", "edx", "memory");
+	alternative_input("",
+			  "call __ibp_barrier",
+			  X86_FEATURE_USE_IBPB,
+			  ASM_NO_INPUT_CLOBBER("eax", "ecx", "edx", "memory"));
 }
 
 #endif /* __ASSEMBLY__ */
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -970,4 +970,7 @@ bool xen_set_default_idle(void);
 
 void stop_this_cpu(void *dummy);
 void df_debug(struct pt_regs *regs, long error_code);
+
+void __ibp_barrier(void);
+
 #endif /* _ASM_X86_PROCESSOR_H */
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -311,3 +311,9 @@ ssize_t cpu_show_spectre_v2(struct devic
 		       spectre_v2_module_string());
 }
 #endif
+
+void __ibp_barrier(void)
+{
+	__wrmsr(MSR_IA32_PRED_CMD, PRED_CMD_IBPB, 0);
+}
+EXPORT_SYMBOL_GPL(__ibp_barrier);
