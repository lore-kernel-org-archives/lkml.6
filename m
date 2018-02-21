Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225eDm5eVIYqjHsgqWxpmKWhje4yK6PbSncqCyibHIsTd0Zg27liMJm1Q488nGJ6q9/+/ub9
ARC-Seal: i=1; a=rsa-sha256; t=1519218072; cv=none;
        d=google.com; s=arc-20160816;
        b=Yf09k8dEi1pTQnQuoxeCtFDwD91jP4+017A7/rywqLRMJDQ58PKBH/TKG6KmNQ566a
         o4xmevAb+8rjwnc10CLtswuffd9FX7DDx49aIBAafvUnpeY24yzTU4KSKEPl8Ud/nvy8
         nsOyHrIaCMHZa6cxikPHSgQnPFhts/uLyWgBVhKHvjis2C14U0f37d5rdoDq3eigOIdS
         Wyiomrmv7X2nFNrNIo+dXjl1lZjhkPk51Mzq+uQuOLJgk3tCCrpu8orFwk6gxGqhkq5/
         V4hhky4nu7aWazCml8rxMh/6s/IwjcAij2aQhJFdRhfVzooJEETDHCfke3pjKdt4nDd8
         Ltfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=sPXVGmUo0KEbJ6ImmLViOflp43XSswBgcGICGJwxGHo=;
        b=Hgy5CTp9ezVTTrc+n/2HMOepvuBcG9/q50Ie2sxdPEdjbwVCc+agYQtO+wpC0LRp+J
         /EZ+nUZdtHekzSSOPeZwrJAW0VDpAHVd1epmc47GN6tBfzIJ2bzDcWP4TJJmbxVL7Glh
         d8GQwRbYqC8/KesFL/aluAYTgxNuzqtR04dgSY6ZXTNyNJ7z+uZTaXlS9Lw8n6Apnv+N
         2C0TeGJMahZaW8yAICBN1GK3n/kTBWiC9klq8By+wk6GxdpWusHu6+2XC5PZUayIgkGN
         FY+aO3nnYksLPCUTcTD4i3cbqkSWzq9NButxcqw4MOFr4WcWMeAeDXSEcqoFV3rBVMQQ
         pBPw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Chris Patterson <cjp256@gmail.com>
Subject: [PATCH 4.14 038/167] x86/xen: init %gs very early to avoid page faults with stack protector
Date: Wed, 21 Feb 2018 13:47:29 +0100
Message-Id: <20180221124526.680823597@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015609230913571?=
X-GMAIL-MSGID: =?utf-8?q?1593015609230913571?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Juergen Gross <jgross@suse.com>

commit 4f277295e54c5b7340e48efea3fc5cc21a2872b7 upstream.

When running as Xen pv guest %gs is initialized some time after
C code is started. Depending on stack protector usage this might be
too late, resulting in page faults.

So setup %gs and MSR_GS_BASE in assembly code already.

Cc: stable@vger.kernel.org
Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Tested-by: Chris Patterson <cjp256@gmail.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/xen/xen-head.S |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -9,7 +9,9 @@
 
 #include <asm/boot.h>
 #include <asm/asm.h>
+#include <asm/msr.h>
 #include <asm/page_types.h>
+#include <asm/percpu.h>
 #include <asm/unwind_hints.h>
 
 #include <xen/interface/elfnote.h>
@@ -35,6 +37,20 @@ ENTRY(startup_xen)
 	mov %_ASM_SI, xen_start_info
 	mov $init_thread_union+THREAD_SIZE, %_ASM_SP
 
+#ifdef CONFIG_X86_64
+	/* Set up %gs.
+	 *
+	 * The base of %gs always points to the bottom of the irqstack
+	 * union.  If the stack protector canary is enabled, it is
+	 * located at %gs:40.  Note that, on SMP, the boot cpu uses
+	 * init data section till per cpu areas are set up.
+	 */
+	movl	$MSR_GS_BASE,%ecx
+	movq	$INIT_PER_CPU_VAR(irq_stack_union),%rax
+	cdq
+	wrmsr
+#endif
+
 	jmp xen_start_kernel
 END(startup_xen)
 	__FINIT
