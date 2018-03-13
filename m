Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuEL5PH1g2QbhdnrFJVcFZvIcBxMFxyBvfPUdWGyWmbRELiZXX9qGpOOvIHjDjt3Y4+4gqI
ARC-Seal: i=1; a=rsa-sha256; t=1520955216; cv=none;
        d=google.com; s=arc-20160816;
        b=a59v3sZmi1rnrI0BkCBY1HYDfOH5l0JIp5djVYqm2mQ6zVQ+jMhwacBrsTQ65Na6Ke
         wReAJI2LXV2K4Ru/3f+rTdKLWRfEzn5+Pr1pEMqyhqn+9AxeLgxKMQvZoTNv3jN2rXmD
         TO4WhdgJ3JXDHefdNjvOnyeAO/Rrei3OBNNIsR9q8k6uHm6oAjx+FtEQQdsgHukkG8Z3
         WTRP6uEbBRWuiIzKXhQg/oYse5QsGPwfQr8H+muOdo2uBcPk0OltZao5nGStxRfFCPci
         OZ2WG+UQrRkfqvPZUhTcH66YMo9wEZY94Ng5HJYq3vdo3e7P1qMqmezo8/QiBzxnI1tR
         7/YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Rok51aOSWl2qk0gzhjMnt1NPOXRFgH8ojcNyLTIsoHA=;
        b=n10ecgHnLN9mS7Re0vR6orCgSA5LrzjFbWvJasMGau/tfw8wNdJJI7y8HFG7Bl6Rro
         r6PeSDYXuQoi9pB5sS8E38aoRopcq/gFwP46Il2uLOn7Le68SHoaiOZQTcqkIfxc/V0C
         9S+8bcZ0u/a8litlrFiekDVbz2+mkqIasLskFKrmD5PQOcFNTKBiA50W1voQPwPbINuL
         1rUfEI/Kkr8UCUmAlTM/3q2EPBsNAcrRS65Kxejd1fkhZRLhxZio7gtMA+kdjYNha8wS
         weiqWSeHHY0201ftCHSaCH2ZMycnLFF5ZaQiDONCoTG6n+pD8qh+74US6gqSM2EyyQ0v
         /1Hw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Francis Deslauriers <francis.deslauriers@efficios.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.15 103/146] x86/kprobes: Fix kernel crash when probing .entry_trampoline code
Date: Tue, 13 Mar 2018 16:24:30 +0100
Message-Id: <20180313152328.429220906@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837137341636186?=
X-GMAIL-MSGID: =?utf-8?q?1594837137341636186?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Francis Deslauriers <francis.deslauriers@efficios.com>

commit c07a8f8b08ba683ea24f3ac9159f37ae94daf47f upstream.

Disable the kprobe probing of the entry trampoline:

.entry_trampoline is a code area that is used to ensure page table
isolation between userspace and kernelspace.

At the beginning of the execution of the trampoline, we load the
kernel's CR3 register. This has the effect of enabling the translation
of the kernel virtual addresses to physical addresses. Before this
happens most kernel addresses can not be translated because the running
process' CR3 is still used.

If a kprobe is placed on the trampoline code before that change of the
CR3 register happens the kernel crashes because int3 handling pages are
not accessible.

To fix this, add the .entry_trampoline section to the kprobe blacklist
to prohibit the probing of code before all the kernel pages are
accessible.

Signed-off-by: Francis Deslauriers <francis.deslauriers@efficios.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: mathieu.desnoyers@efficios.com
Cc: mhiramat@kernel.org
Link: http://lkml.kernel.org/r/1520565492-4637-2-git-send-email-francis.deslauriers@efficios.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/sections.h |    1 +
 arch/x86/kernel/kprobes/core.c  |   10 +++++++++-
 arch/x86/kernel/vmlinux.lds.S   |    2 ++
 3 files changed, 12 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/sections.h
+++ b/arch/x86/include/asm/sections.h
@@ -10,6 +10,7 @@ extern struct exception_table_entry __st
 
 #if defined(CONFIG_X86_64)
 extern char __end_rodata_hpage_align[];
+extern char __entry_trampoline_start[], __entry_trampoline_end[];
 #endif
 
 #endif	/* _ASM_X86_SECTIONS_H */
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -1168,10 +1168,18 @@ NOKPROBE_SYMBOL(longjmp_break_handler);
 
 bool arch_within_kprobe_blacklist(unsigned long addr)
 {
+	bool is_in_entry_trampoline_section = false;
+
+#ifdef CONFIG_X86_64
+	is_in_entry_trampoline_section =
+		(addr >= (unsigned long)__entry_trampoline_start &&
+		 addr < (unsigned long)__entry_trampoline_end);
+#endif
 	return  (addr >= (unsigned long)__kprobes_text_start &&
 		 addr < (unsigned long)__kprobes_text_end) ||
 		(addr >= (unsigned long)__entry_text_start &&
-		 addr < (unsigned long)__entry_text_end);
+		 addr < (unsigned long)__entry_text_end) ||
+		is_in_entry_trampoline_section;
 }
 
 int __init arch_init_kprobes(void)
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -118,9 +118,11 @@ SECTIONS
 
 #ifdef CONFIG_X86_64
 		. = ALIGN(PAGE_SIZE);
+		VMLINUX_SYMBOL(__entry_trampoline_start) = .;
 		_entry_trampoline = .;
 		*(.entry_trampoline)
 		. = ALIGN(PAGE_SIZE);
+		VMLINUX_SYMBOL(__entry_trampoline_end) = .;
 		ASSERT(. - _entry_trampoline == PAGE_SIZE, "entry trampoline is too big");
 #endif
 
