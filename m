Return-Path: <schwidefsky@de.ibm.com>
X-Google-Smtp-Source: AH8x224rpLEd0aYW0c2fPKcfDY+NAu5eKaS5BhNzWD0MQw0stUZ+JDlXTPFRafF2ymdxvj3QdgTv
ARC-Seal: i=1; a=rsa-sha256; t=1517986834; cv=none;
        d=google.com; s=arc-20160816;
        b=d2ANoxPQL8+uPgnrC1b7QYdttJDr4XBZuxpedydS/hQBtB401SPwnwr/Gp9IfZ6SCN
         6wapBt/IngoVNWoQBG0SqfojNuuy1y6SiL35TWQbPyFb0F8mm2MoeNHe0H69agNQ9N7p
         3CFWeN52KAflonTDKVblEoBReDhvoZkCO2nHOw42wDrw3ZgGXidR/0OFNxcu/Oz7Ftuu
         oMDPk1s70aFHqHhPAEPmQOIW3N3YZcCtaOsMnQ9+vtRshF41JWizGvRkUL15b3UApXlS
         CY10ESI1TI5ZZPJHdQ8+oc1xq0NaOFt+T/emz1NZYCmf0xCLf+MgHa3unS20q8n4/dM2
         sMYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:references:in-reply-to:date:subject:cc:to:from
         :arc-authentication-results;
        bh=lqtxH88DasDtN+ToLjea2YdKIJAV4LwjMMR0g+XT4k4=;
        b=R2Bc4I6GHlygiR565sjUm0qcLR8HsMqLL5YFYXZgyvRCf4i9lOujPk8QH4FUJ71MIQ
         ip+EAmf05cD4DUL1BiQTZR3wYEswF6oj6cBk1x2dJm5Pj3JCLZXTqApzmOxBxYEDih5K
         aBueoO57wU1RltHEqzvAzy/pTe3wrGDZirjdICyrH83lkDzje59QRNmVgp/W7mLQC9RN
         5Z3VNFaxr1bMLafGpplGGenx6VQRhh6DslndXKSh8xmwGf16RQeNQTJ+DLEvs8RUyQu9
         Hc2ZrscdgNMwz2R3pVA6rBOdjjGDbJ3RjAoI2hJZqtn3+vRKUb2rck2MGZfjy1ki4VIS
         pbtQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of schwidefsky@de.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=schwidefsky@de.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of schwidefsky@de.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=schwidefsky@de.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>,
        Jiri Kosina <jkosina@suse.cz>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@ucw.cz>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 4/6] s390: add options to change branch prediction behaviour for the kernel
Date: Wed,  7 Feb 2018 08:00:09 +0100
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517986811-27819-1-git-send-email-schwidefsky@de.ibm.com>
References: <1517986811-27819-1-git-send-email-schwidefsky@de.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18020707-0040-0000-0000-0000040D2D50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020707-0041-0000-0000-00002610DD8F
Message-Id: <1517986811-27819-5-git-send-email-schwidefsky@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-07_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802070089
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591724562454954787?=
X-GMAIL-MSGID: =?utf-8?q?1591724562454954787?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add the PPA instruction to the system entry and exit path to switch
the kernel to a different branch prediction behaviour. The instructions
are added via CPU alternatives and can be disabled with the "nospec"
or the "nobp=0" kernel parameter. If the default behaviour selected
with CONFIG_KERNEL_NOBP is set to "n" then the "nobp=1" parameter can be
used to enable the changed kernel branch prediction.

Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/Kconfig                 | 17 ++++++++++++++
 arch/s390/include/asm/processor.h |  1 +
 arch/s390/kernel/alternative.c    | 23 +++++++++++++++++++
 arch/s390/kernel/early.c          |  2 ++
 arch/s390/kernel/entry.S          | 48 +++++++++++++++++++++++++++++++++++++++
 arch/s390/kernel/ipl.c            |  1 +
 arch/s390/kernel/smp.c            |  2 ++
 7 files changed, 94 insertions(+)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 0105ce2..d514e25 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -540,6 +540,23 @@ config ARCH_RANDOM
 
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
 
 menu "Memory setup"
diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index bfbfad4..5f37f9c 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -91,6 +91,7 @@ void cpu_detect_mhz_feature(void);
 extern const struct seq_operations cpuinfo_op;
 extern int sysctl_ieee_emulation_warnings;
 extern void execve_tail(void);
+extern void __bpon(void);
 
 /*
  * User space process size: 2GB for 31 bit, 4TB or 8PT for 64 bit.
diff --git a/arch/s390/kernel/alternative.c b/arch/s390/kernel/alternative.c
index 1abf4f3..2247613 100644
--- a/arch/s390/kernel/alternative.c
+++ b/arch/s390/kernel/alternative.c
@@ -15,6 +15,29 @@ static int __init disable_alternative_instructions(char *str)
 
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
diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index 510f218..ac707a9 100644
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -196,6 +196,8 @@ static noinline __init void setup_facility_list(void)
 	memcpy(S390_lowcore.alt_stfle_fac_list,
 	       S390_lowcore.stfle_fac_list,
 	       sizeof(S390_lowcore.alt_stfle_fac_list));
+	if (!IS_ENABLED(CONFIG_KERNEL_NOBP))
+		__clear_facility(82, S390_lowcore.alt_stfle_fac_list);
 }
 
 static __init void detect_diag9c(void)
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 5d87eda..e6d7550 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -159,6 +159,34 @@ _PIF_WORK	= (_PIF_PER_TRAP | _PIF_SYSCALL_RESTART)
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
 .Ldummy:
 	/*
@@ -171,6 +199,11 @@ _PIF_WORK	= (_PIF_PER_TRAP | _PIF_SYSCALL_RESTART)
 	 */
 	nop	0
 
+ENTRY(__bpon)
+	.globl __bpon
+	BPON
+	br	%r14
+
 /*
  * Scheduler resume function, called by switch_to
  *  gpr2 = (task_struct *) prev
@@ -226,8 +259,11 @@ ENTRY(sie64a)
 	jnz	.Lsie_skip
 	TSTMSK	__LC_CPU_FLAGS,_CIF_FPU
 	jo	.Lsie_skip			# exit if fp/vx regs changed
+	BPON
 .Lsie_entry:
 	sie	0(%r14)
+.Lsie_exit:
+	BPOFF
 .Lsie_skip:
 	ni	__SIE_PROG0C+3(%r14),0xfe	# no longer in SIE
 	lctlg	%c1,%c1,__LC_USER_ASCE		# load primary asce
@@ -279,6 +315,7 @@ ENTRY(system_call)
 	stpt	__LC_SYNC_ENTER_TIMER
 .Lsysc_stmg:
 	stmg	%r8,%r15,__LC_SAVE_AREA_SYNC
+	BPOFF
 	lg	%r12,__LC_CURRENT
 	lghi	%r13,__TASK_thread
 	lghi	%r14,_PIF_SYSCALL
@@ -325,6 +362,7 @@ ENTRY(system_call)
 	jnz	.Lsysc_work			# check for work
 	TSTMSK	__LC_CPU_FLAGS,_CIF_WORK
 	jnz	.Lsysc_work
+	BPON
 .Lsysc_restore:
 	lg	%r14,__LC_VDSO_PER_CPU
 	lmg	%r0,%r10,__PT_R0(%r11)
@@ -530,6 +568,7 @@ ENTRY(kernel_thread_starter)
 
 ENTRY(pgm_check_handler)
 	stpt	__LC_SYNC_ENTER_TIMER
+	BPOFF
 	stmg	%r8,%r15,__LC_SAVE_AREA_SYNC
 	lg	%r10,__LC_LAST_BREAK
 	lg	%r12,__LC_CURRENT
@@ -637,6 +676,7 @@ ENTRY(pgm_check_handler)
 ENTRY(io_int_handler)
 	STCK	__LC_INT_CLOCK
 	stpt	__LC_ASYNC_ENTER_TIMER
+	BPOFF
 	stmg	%r8,%r15,__LC_SAVE_AREA_ASYNC
 	lg	%r12,__LC_CURRENT
 	larl	%r13,cleanup_critical
@@ -687,9 +727,13 @@ ENTRY(io_int_handler)
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
@@ -860,6 +904,7 @@ ENTRY(io_int_handler)
 ENTRY(ext_int_handler)
 	STCK	__LC_INT_CLOCK
 	stpt	__LC_ASYNC_ENTER_TIMER
+	BPOFF
 	stmg	%r8,%r15,__LC_SAVE_AREA_ASYNC
 	lg	%r12,__LC_CURRENT
 	larl	%r13,cleanup_critical
@@ -908,6 +953,7 @@ ENTRY(psw_idle)
 .Lpsw_idle_stcctm:
 #endif
 	oi	__LC_CPU_FLAGS+7,_CIF_ENABLED_WAIT
+	BPON
 	STCK	__CLOCK_IDLE_ENTER(%r2)
 	stpt	__TIMER_IDLE_ENTER(%r2)
 .Lpsw_idle_lpsw:
@@ -1008,6 +1054,7 @@ load_fpu_regs:
  */
 ENTRY(mcck_int_handler)
 	STCK	__LC_MCCK_CLOCK
+	BPOFF
 	la	%r1,4095		# validate r1
 	spt	__LC_CPU_TIMER_SAVE_AREA-4095(%r1)	# validate cpu timer
 	sckc	__LC_CLOCK_COMPARATOR			# validate comparator
@@ -1118,6 +1165,7 @@ ENTRY(mcck_int_handler)
 	mvc	__LC_RETURN_MCCK_PSW(16),__PT_PSW(%r11) # move return PSW
 	tm	__LC_RETURN_MCCK_PSW+1,0x01 # returning to user ?
 	jno	0f
+	BPON
 	stpt	__LC_EXIT_TIMER
 	mvc	__VDSO_ECTG_BASE(16,%r14),__LC_EXIT_TIMER
 0:	lmg	%r11,%r15,__PT_R11(%r11)
diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index da5cc3b..34477c1 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -543,6 +543,7 @@ static struct kset *ipl_kset;
 
 static void __ipl_run(void *unused)
 {
+	__bpon();
 	diag308(DIAG308_LOAD_CLEAR, NULL);
 	if (MACHINE_IS_VM)
 		__cpcmd("IPL", NULL, 0, NULL);
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index fc28c95..2fd7d60 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -319,6 +319,7 @@ static void pcpu_delegate(struct pcpu *pcpu, void (*func)(void *),
 	mem_assign_absolute(lc->restart_fn, (unsigned long) func);
 	mem_assign_absolute(lc->restart_data, (unsigned long) data);
 	mem_assign_absolute(lc->restart_source, source_cpu);
+	__bpon();
 	asm volatile(
 		"0:	sigp	0,%0,%2	# sigp restart to target cpu\n"
 		"	brc	2,0b	# busy, try again\n"
@@ -903,6 +904,7 @@ void __cpu_die(unsigned int cpu)
 void __noreturn cpu_die(void)
 {
 	idle_task_exit();
+	__bpon();
 	pcpu_sigp_retry(pcpu_devices + smp_processor_id(), SIGP_STOP, 0);
 	for (;;) ;
 }
-- 
2.7.4
