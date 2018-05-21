Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZottcyebgMMXBkfOICKdyiGCLjqwAkC7cEAzKBtiRAJxQX3sm4v9lVCImHosffXhRGMamMf
ARC-Seal: i=1; a=rsa-sha256; t=1526937475; cv=none;
        d=google.com; s=arc-20160816;
        b=cXT6gk3WKKpPJJovi3CwKQHZzSYhGnvFk7YDbgAigRrSZfZqksi2u0GMENAIoag+xF
         4Yfo88zEg0II9MXcIls90nEB85hroxsRZdNfvBukb6frl+NfmfKpo3Dm3Yw6m4bpHvKS
         Ck41Xe3zI1A2xcejl1S5xKvET3vn9PEtkUvssKBEDzKJ6aLF9U0ULtK4ME3xRx627ePV
         zLkhOri0yYCO+JiKXZmg7/ralbAli5xH61kqTM+RWW9gxHy/YhSsFvUDjdO8oGBYJxlo
         CJ2CL7HYZB+v9Lomp9QRXjawT0qzH+TDuq8EmXaL6ur7UgyPONJDvkhSLmrqlOACmGix
         XnMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=kOwL2/1n3qmVDPvAuR8dxylr55YKLYHVsvuFZlr5rQw=;
        b=Dy0ruVTYGjRz8wgEKN1ha+X5HNYnKAv38Dko1r7hU2EPuCXEd2+4TmW3gm94mBtGmJ
         h2Dg+mIWQmks1N+GPID6Nyo7dGbuiuZkfGLad0S5R+cLyu7NNyamuudK8aFee/7m2lL2
         zfoaJubE36GkL/RHkP4bJVvacIkC6m5WUmmKS2xrEqvFCtHOKC+DBQ3Vrlcvib1LwHbV
         AwduLQJ4vnIgwhSp+gDfLcZ/DATP2GA+9/98wWqAf7q2y3pl3NnNvEkMW6zie4mN6i3j
         EDlqQ4XL6SsECI21qHVP4JwTVorTe3ftGDzqNxjXsG/DIE30Uak3wRi+hyEtHKBsiyBQ
         U/yQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=CVovy1t1;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=CVovy1t1;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 52/87] x86/process: Optimize TIF_NOTSC switch
Date: Mon, 21 May 2018 23:11:28 +0200
Message-Id: <20180521210425.024101773@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109990390631253?=
X-GMAIL-MSGID: =?utf-8?q?1601109990390631253?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 5a920155e388ec22a22e0532fb695b9215c9b34d upstream

Provide and use a toggle helper instead of doing it with a branch.

x86_64: arch/x86/kernel/process.o
text	   data	    bss	    dec	    hex
3008	   8577	     16	  11601	   2d51 Before
2976       8577      16	  11569	   2d31 After

i386: arch/x86/kernel/process.o
text	   data	    bss	    dec	    hex
2925	   8673	      8	  11606	   2d56 Before
2893	   8673       8	  11574	   2d36 After

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Link: http://lkml.kernel.org/r/20170214081104.9244-4-khuey@kylehuey.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/tlbflush.h |   10 ++++++++++
 arch/x86/kernel/process.c       |   22 ++++------------------
 2 files changed, 14 insertions(+), 18 deletions(-)

--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -111,6 +111,16 @@ static inline void cr4_clear_bits(unsign
 	}
 }
 
+static inline void cr4_toggle_bits(unsigned long mask)
+{
+	unsigned long cr4;
+
+	cr4 = this_cpu_read(cpu_tlbstate.cr4);
+	cr4 ^= mask;
+	this_cpu_write(cpu_tlbstate.cr4, cr4);
+	__write_cr4(cr4);
+}
+
 /* Read the CR4 shadow. */
 static inline unsigned long cr4_read_shadow(void)
 {
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -134,11 +134,6 @@ void flush_thread(void)
 	fpu__clear(&tsk->thread.fpu);
 }
 
-static void hard_disable_TSC(void)
-{
-	cr4_set_bits(X86_CR4_TSD);
-}
-
 void disable_TSC(void)
 {
 	preempt_disable();
@@ -147,15 +142,10 @@ void disable_TSC(void)
 		 * Must flip the CPU state synchronously with
 		 * TIF_NOTSC in the current running context.
 		 */
-		hard_disable_TSC();
+		cr4_set_bits(X86_CR4_TSD);
 	preempt_enable();
 }
 
-static void hard_enable_TSC(void)
-{
-	cr4_clear_bits(X86_CR4_TSD);
-}
-
 static void enable_TSC(void)
 {
 	preempt_disable();
@@ -164,7 +154,7 @@ static void enable_TSC(void)
 		 * Must flip the CPU state synchronously with
 		 * TIF_NOTSC in the current running context.
 		 */
-		hard_enable_TSC();
+		cr4_clear_bits(X86_CR4_TSD);
 	preempt_enable();
 }
 
@@ -238,12 +228,8 @@ void __switch_to_xtra(struct task_struct
 		wrmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
 	}
 
-	if ((tifp ^ tifn) & _TIF_NOTSC) {
-		if (tifn & _TIF_NOTSC)
-			hard_disable_TSC();
-		else
-			hard_enable_TSC();
-	}
+	if ((tifp ^ tifn) & _TIF_NOTSC)
+		cr4_toggle_bits(X86_CR4_TSD);
 }
 
 /*
