Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrcaGgDqM2FWkd64J8PtOv9HT78g3qYnQiHjLXoy4RwVpzYN5LhjLlJdqDFM2fTTlQm6K9p
ARC-Seal: i=1; a=rsa-sha256; t=1524837654; cv=none;
        d=google.com; s=arc-20160816;
        b=anj4j56Y2WkmTmZXABPpwr5nvG/mHiAW2xmk5NDepCS7mpsuuosnTaLZ+Go7ctLZzS
         MbQ0y3TsfXrIqoSYUjxBGHki0CnKCFa828hkSciWOJxBRq5tv9ME5RkzoMsmAzRijetP
         XK7B7sex41JPJ76zHHfljZ1x2ky85aAR9vVJoDzXW0lB5YBVVPKVLfxuyhZiM9C+0Fhl
         pOr6gIO8GDIE1wdgbf/m0gX68L7TxGFEqwKafl1TvBfaPpeGy+VjDUBFq8OsMmCG1YLk
         PcgY9Q8bdeBN5Y496jUis5IFV7ez5QsL+MiE5ane4YF2OFfHSPUroaZQKDvPtUDBiJK8
         MgNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=4D0Stab0ngP+szBQZryreRWxnCIcG1UD25uO1oaDuHo=;
        b=YOvNZcQ3reIber6c9Q0fimtbm0l0+9A3IIn4BKRqjTxHBRI7DyWZD4J4HAXXL3kFVY
         vGzc8v68Qn2nK/BgfmXmvrikc/J8P7sR6YsBImumR3ffJ4znuMIN7d2gc+k7hujR651B
         dwbLYt6K/KhgAsm+kQXM0Q7tGZ2U1YfRejHuZ/7Mcx6eu/LjdQ7eM/FdBrueEf7ob2ut
         PD69ljK7uw/29SydFYP3Ko4FHw9g0H1vi5mBbiRGEr3IY9pShXXrBt5clAhNGobBrZ86
         VQVFfm4VS/92v8PzjZlsKdScRDidOc3vK1gesOTc7dpjseq3qp1qusDVAMNAgcYp3r2y
         YVxA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A2E22189F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 4.4 16/50] s390: add options to change branch prediction behaviour for the kernel
Date: Fri, 27 Apr 2018 15:58:18 +0200
Message-Id: <20180427135656.701217280@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135655.623669681@linuxfoundation.org>
References: <20180427135655.623669681@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908168299324374?=
X-GMAIL-MSGID: =?utf-8?q?1598908168299324374?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>


[ Upstream commit d768bd892fc8f066cd3aa000eb1867bcf32db0ee ]

Add the PPA instruction to the system entry and exit path to switch
the kernel to a different branch prediction behaviour. The instructions
are added via CPU alternatives and can be disabled with the "nospec"
or the "nobp=0" kernel parameter. If the default behaviour selected
with CONFIG_KERNEL_NOBP is set to "n" then the "nobp=1" parameter can be
used to enable the changed kernel branch prediction.

Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/Kconfig                 |   17 +++++++++++++
 arch/s390/include/asm/processor.h |    1 
 arch/s390/kernel/alternative.c    |   23 ++++++++++++++++++
 arch/s390/kernel/early.c          |    2 +
 arch/s390/kernel/entry.S          |   48 ++++++++++++++++++++++++++++++++++++++
 arch/s390/kernel/ipl.c            |    1 
 arch/s390/kernel/smp.c            |    2 +
 7 files changed, 94 insertions(+)

--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -705,6 +705,23 @@ config SECCOMP
 
 	  If unsure, say Y.
 
+config KERNEL_NOBP
+	def_bool n
+	prompt "Enable modified branch prediction for the kernel by default"
+	help
+	  If this option is selected the kernel will switch to a modified
+	  branch prediction mode if the firmware interface is available.
+	  The modified branch prediction mode improves the behaviour in
+	  regard to speculative execution.
+
+	  With the option enabled the kernel parameter "nobp=0" or "nospec"
+	  can be used to run the kernel in the normal branch prediction mode.
+
+	  With the option disabled the modified branch prediction mode is
+	  enabled with the "nobp=1" kernel parameter.
+
+	  If unsure, say N.
+
 endmenu
 
 menu "Power Management"
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -69,6 +69,7 @@ extern void s390_adjust_jiffies(void);
 extern const struct seq_operations cpuinfo_op;
 extern int sysctl_ieee_emulation_warnings;
 extern void execve_tail(void);
+extern void __bpon(void);
 
 /*
  * User space process size: 2GB for 31 bit, 4TB or 8PT for 64 bit.
--- a/arch/s390/kernel/alternative.c
+++ b/arch/s390/kernel/alternative.c
@@ -14,6 +14,29 @@ static int __init disable_alternative_in
 
 early_param("noaltinstr", disable_alternative_instructions);
 
+static int __init nobp_setup_early(char *str)
+{
+	bool enabled;
+	int rc;
+
+	rc = kstrtobool(str, &enabled);
+	if (rc)
+		return rc;
+	if (enabled && test_facility(82))
+		__set_facility(82, S390_lowcore.alt_stfle_fac_list);
+	else
+		__clear_facility(82, S390_lowcore.alt_stfle_fac_list);
+	return 0;
+}
+early_param("nobp", nobp_setup_early);
+
+static int __init nospec_setup_early(char *str)
+{
+	__clear_facility(82, S390_lowcore.alt_stfle_fac_list);
+	return 0;
+}
+early_param("nospec", nospec_setup_early);
+
 struct brcl_insn {
 	u16 opc;
 	s32 disp;
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -282,6 +282,8 @@ static noinline __init void setup_facili
 	memcpy(S390_lowcore.alt_stfle_fac_list,
 	       S390_lowcore.stfle_fac_list,
 	       sizeof(S390_lowcore.alt_stfle_fac_list));
+	if (!IS_ENABLED(CONFIG_KERNEL_NOBP))
+		__clear_facility(82, S390_lowcore.alt_stfle_fac_list);
 }
 
 static __init void detect_diag9c(void)
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -162,8 +162,41 @@ _PIF_WORK	= (_PIF_PER_TRAP)
 		tm	off+\addr, \mask
 	.endm
 
+	.macro BPOFF
+	.pushsection .altinstr_replacement, "ax"
+660:	.long	0xb2e8c000
+	.popsection
+661:	.long	0x47000000
+	.pushsection .altinstructions, "a"
+	.long 661b - .
+	.long 660b - .
+	.word 82
+	.byte 4
+	.byte 4
+	.popsection
+	.endm
+
+	.macro BPON
+	.pushsection .altinstr_replacement, "ax"
+662:	.long	0xb2e8d000
+	.popsection
+663:	.long	0x47000000
+	.pushsection .altinstructions, "a"
+	.long 663b - .
+	.long 662b - .
+	.word 82
+	.byte 4
+	.byte 4
+	.popsection
+	.endm
+
 	.section .kprobes.text, "ax"
 
+ENTRY(__bpon)
+	.globl __bpon
+	BPON
+	br	%r14
+
 /*
  * Scheduler resume function, called by switch_to
  *  gpr2 = (task_struct *) prev
@@ -223,7 +256,10 @@ ENTRY(sie64a)
 	jnz	.Lsie_skip
 	TSTMSK	__LC_CPU_FLAGS,_CIF_FPU
 	jo	.Lsie_skip			# exit if fp/vx regs changed
+	BPON
 	sie	0(%r14)
+.Lsie_exit:
+	BPOFF
 .Lsie_skip:
 	ni	__SIE_PROG0C+3(%r14),0xfe	# no longer in SIE
 	lctlg	%c1,%c1,__LC_USER_ASCE		# load primary asce
@@ -273,6 +309,7 @@ ENTRY(system_call)
 	stpt	__LC_SYNC_ENTER_TIMER
 .Lsysc_stmg:
 	stmg	%r8,%r15,__LC_SAVE_AREA_SYNC
+	BPOFF
 	lg	%r10,__LC_LAST_BREAK
 	lg	%r12,__LC_THREAD_INFO
 	lghi	%r14,_PIF_SYSCALL
@@ -319,6 +356,7 @@ ENTRY(system_call)
 	jnz	.Lsysc_work			# check for work
 	TSTMSK	__LC_CPU_FLAGS,_CIF_WORK
 	jnz	.Lsysc_work
+	BPON
 .Lsysc_restore:
 	lg	%r14,__LC_VDSO_PER_CPU
 	lmg	%r0,%r10,__PT_R0(%r11)
@@ -479,6 +517,7 @@ ENTRY(kernel_thread_starter)
 
 ENTRY(pgm_check_handler)
 	stpt	__LC_SYNC_ENTER_TIMER
+	BPOFF
 	stmg	%r8,%r15,__LC_SAVE_AREA_SYNC
 	lg	%r10,__LC_LAST_BREAK
 	lg	%r12,__LC_THREAD_INFO
@@ -577,6 +616,7 @@ ENTRY(pgm_check_handler)
 ENTRY(io_int_handler)
 	STCK	__LC_INT_CLOCK
 	stpt	__LC_ASYNC_ENTER_TIMER
+	BPOFF
 	stmg	%r8,%r15,__LC_SAVE_AREA_ASYNC
 	lg	%r10,__LC_LAST_BREAK
 	lg	%r12,__LC_THREAD_INFO
@@ -628,9 +668,13 @@ ENTRY(io_int_handler)
 	lg	%r14,__LC_VDSO_PER_CPU
 	lmg	%r0,%r10,__PT_R0(%r11)
 	mvc	__LC_RETURN_PSW(16),__PT_PSW(%r11)
+	tm	__PT_PSW+1(%r11),0x01	# returning to user ?
+	jno	.Lio_exit_kernel
+	BPON
 .Lio_exit_timer:
 	stpt	__LC_EXIT_TIMER
 	mvc	__VDSO_ECTG_BASE(16,%r14),__LC_EXIT_TIMER
+.Lio_exit_kernel:
 	lmg	%r11,%r15,__PT_R11(%r11)
 	lpswe	__LC_RETURN_PSW
 .Lio_done:
@@ -762,6 +806,7 @@ ENTRY(io_int_handler)
 ENTRY(ext_int_handler)
 	STCK	__LC_INT_CLOCK
 	stpt	__LC_ASYNC_ENTER_TIMER
+	BPOFF
 	stmg	%r8,%r15,__LC_SAVE_AREA_ASYNC
 	lg	%r10,__LC_LAST_BREAK
 	lg	%r12,__LC_THREAD_INFO
@@ -810,6 +855,7 @@ ENTRY(psw_idle)
 	.insn	rsy,0xeb0000000017,%r1,5,__SF_EMPTY+16(%r15)
 .Lpsw_idle_stcctm:
 #endif
+	BPON
 	STCK	__CLOCK_IDLE_ENTER(%r2)
 	stpt	__TIMER_IDLE_ENTER(%r2)
 .Lpsw_idle_lpsw:
@@ -914,6 +960,7 @@ load_fpu_regs:
  */
 ENTRY(mcck_int_handler)
 	STCK	__LC_MCCK_CLOCK
+	BPOFF
 	la	%r1,4095		# revalidate r1
 	spt	__LC_CPU_TIMER_SAVE_AREA-4095(%r1)	# revalidate cpu timer
 	lmg	%r0,%r15,__LC_GPREGS_SAVE_AREA-4095(%r1)# revalidate gprs
@@ -980,6 +1027,7 @@ ENTRY(mcck_int_handler)
 	mvc	__LC_RETURN_MCCK_PSW(16),__PT_PSW(%r11) # move return PSW
 	tm	__LC_RETURN_MCCK_PSW+1,0x01 # returning to user ?
 	jno	0f
+	BPON
 	stpt	__LC_EXIT_TIMER
 	mvc	__VDSO_ECTG_BASE(16,%r14),__LC_EXIT_TIMER
 0:	lmg	%r11,%r15,__PT_R11(%r11)
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -563,6 +563,7 @@ static struct kset *ipl_kset;
 
 static void __ipl_run(void *unused)
 {
+	__bpon();
 	diag308(DIAG308_IPL, NULL);
 	if (MACHINE_IS_VM)
 		__cpcmd("IPL", NULL, 0, NULL);
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -301,6 +301,7 @@ static void pcpu_delegate(struct pcpu *p
 	mem_assign_absolute(lc->restart_fn, (unsigned long) func);
 	mem_assign_absolute(lc->restart_data, (unsigned long) data);
 	mem_assign_absolute(lc->restart_source, source_cpu);
+	__bpon();
 	asm volatile(
 		"0:	sigp	0,%0,%2	# sigp restart to target cpu\n"
 		"	brc	2,0b	# busy, try again\n"
@@ -890,6 +891,7 @@ void __cpu_die(unsigned int cpu)
 void __noreturn cpu_die(void)
 {
 	idle_task_exit();
+	__bpon();
 	pcpu_sigp_retry(pcpu_devices + smp_processor_id(), SIGP_STOP, 0);
 	for (;;) ;
 }
