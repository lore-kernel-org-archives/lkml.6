Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224x+tMyAKY00/14eJ4920rjWvSrnAiztXKZJT+XLyT6TDeSjuC6RaZ2ztOwLoDNYj82+xnc
ARC-Seal: i=1; a=rsa-sha256; t=1517855148; cv=none;
        d=google.com; s=arc-20160816;
        b=Y0gdGQvNCv5f/zmRZGzhf/SZgpGxu0kCiWZW6X0G7tMcluTHuMH7H7MqoxaUi7ReRg
         a0HyHNuN5PhyHZJYAXD/7pURzsdfgDAJRaRzaqvk7lLp5pcGVVlN2xOcn6aXUfdJFyzM
         AL/pzGm5NumhPZqGcYAZkcqFpuFOWYcuUgjtUrq4r+1gNsGn23Iq5Do1zY9Gqka7GY4I
         w8WDAODp2rXBcBTukN6nkkYF+3h1FD2Dcwu4pgrq4ocfS1e1krUq6bs2zpVD0hmWEsP+
         a/ZjCvY7Spty1WNqbGKBeJIrQzrBpMxZUvz+fyEU5ESUuhF8viTX/coYxS+HF5TGOS0a
         L/gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5Mssj9LRNZfsnjBCsEwQbGOX3qBc0x1rWsQizdmxsns=;
        b=XpLGn6zCrI9hfK5Ga5qOAN4JdTdLyUxU9LdxJCOAT9UKEm4oyL7pbus6ZIw4x9fGir
         /2l8g1x+M2d6xAGrDQLwSURtfydDRDf+N6yGrLK8rJn4BoPsOWm3W28YJUZv2Z9/ROnW
         O7c6L0OSfYXivA6t/Vf8L6tk88OsJSY+8GZqtmgAS72w4I4bdGIls9wI2ZTA0iS2XNy/
         ddXWubgsDoZPyg6i6nseJBLlh5Y9prhprr5F/34VKpmNOVnGoH2PyQTzbxAbbFkhmGUG
         fTisDHuL+2i54mPGIPUSOAv1lbnRVfiEYFpxQPj5SnhD5UcDVwduOLnQt4RCigIvvtZM
         WE+g==
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
Subject: [PATCH 4.15 17/60] x86/speculation: Simplify indirect_branch_prediction_barrier()
Date: Mon,  5 Feb 2018 10:22:50 -0800
Message-Id: <20180205182214.630922743@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
References: <20180205182213.902626065@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586347373832119?=
X-GMAIL-MSGID: =?utf-8?q?1591586480167120712?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -971,4 +971,7 @@ bool xen_set_default_idle(void);
 
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
