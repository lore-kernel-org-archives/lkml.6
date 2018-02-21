Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225rYjR+8XM+I3YDGMpTPQbLj/FyXhxxRwOfHCvoemYH0zlHPtE7tU2RKpmYr2WfjA2jT05D
ARC-Seal: i=1; a=rsa-sha256; t=1519218430; cv=none;
        d=google.com; s=arc-20160816;
        b=Oaa+OG1GNBjaKPt02cKCkV15mrwQMDZnDVO0U4ldawlFVlnOfjqCs75vapP06/4Wp7
         MkP4JZ6p76W7FSM92459fsbkPFR+ceGRuATDe1dd/eQs5Hd0TKwrReO5hFRjjP/F/gu6
         WamLTAFNlSxNoH7QsLDqqK9GgNYYDEwrsAyzJQUKeIIZ/Xm/FbYOSSwVWOtoNiIGezp5
         jCpeVVlocVI4vpdM4T4jpf6f3DydgXyBP5+RqD9ZGWQK+6QTdvSKYGoNMkUW8YYCShuA
         1+2BdZ0ll4MiMWnbLes3wIQdmkeK21fFGaP65/3IqLgKqUYSYrIChltNYT+84LAhButu
         08IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=u7s0EeUQCkFeuj0DqV9/aLg5a6vGrvdYxVzfWL01rT4=;
        b=OsZUBARZshO9eFgnPMPXkvNqdwl5UMoNcEsXwU24EZGZldzw1GS6CQBHOA+VnrTImj
         jsYtRHurXJR0UznNnBGB1f1NaS4BDY6ENX2wScAWn79B7BR+Z4n46soFCAnQDx/HiT/2
         rcRys7HJTmAq8elugTe1uRW9FGUZhgBbJ8Ii4N+Gb9cQcJzhjkqnOn+KwFi6Rvgtm2/+
         eAt8v90xuwRz03frz0qfc2SjNbzPiUwMBDBaWw/v6jid041cmEUx6MJDSjLSwK/6SonD
         H98EY7xXbdvXYcuqEhllgJeloFJ9hpxStvMOD4rpaf0vI7dLScFzXHOEK3Xr9QftRIMB
         29hw==
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
Subject: [PATCH 4.15 037/163] x86/xen: init %gs very early to avoid page faults with stack protector
Date: Wed, 21 Feb 2018 13:47:46 +0100
Message-Id: <20180221124532.355272122@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015609230913571?=
X-GMAIL-MSGID: =?utf-8?q?1593015984635346515?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
