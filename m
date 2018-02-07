Return-Path: <schwidefsky@de.ibm.com>
X-Google-Smtp-Source: AH8x226rveqSr40+M/zc4X+uDyAU7nLrKbVbVQ/6JXtwhaGsWrogSYI7n4wmojJ/eDqMRpIFEwZV
ARC-Seal: i=1; a=rsa-sha256; t=1517986831; cv=none;
        d=google.com; s=arc-20160816;
        b=Q97copJBphzeZTOIdFiLYT0WjwGETfVPVzLgPhNdwHa/eUBBEqmsb0H4cuK2IqGYx0
         v9DupNoWtmGoCxOozRt+7g/6ptPoQBb99zkET7lBXK/Xn4t/G3Cow3hYhwEY5D6Lk4eO
         7P51saPRTobKt9rM0o9Ma/QutME0D+acHQTzlbbAVxBAILDfOMw6WyosbEezLBM+B78m
         IYQmmOps2xi5Lxd/TRTZm0oMngDilBqR+f5kKf9JBilLUZGhwM+Pdd0smi8nBoo1BIjl
         0Mys0kUHM7Xl9iOcklnDmNlmOQQS13yZ7T6GFd1KgE11+A4IgDj9UqFmQunea10QCFF9
         wzHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:references:in-reply-to:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Wh6PiL7lEN2S9WC5KEbfyojB/mzrrIe4mHX0XokLQnA=;
        b=Wi9T2iTOca6SlzbVD6ktAUVrr8ScLShqEGsC9+bhuF+ceVVXCoxmNYZWDBmtQNqrN+
         PMK0/qP+5ot5JBN77Q5RMwgC0TZ9VVTGcVYfINZ/haQiGq+NGdJMapf0vVCdXo0i9dYa
         Bo0YKdUwOLkFjHCnp6C9/CU80OXP+gVV0s4od4pKWIaQ7sTmEqVIN0llBAGY/18FNYtl
         Lu6gI98ZNZ4wRUt3CtoT2CrlULrkHG4AnNs3yMPqt+GFbBEyFOpWdhof7915xfbfz/nj
         63AznR3/KWxHB6wZcmT8g4oh834TMd3vx1HW7tsJYhXHxLlflwhwdpW+6c/KH9mInaY8
         M/Mw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of schwidefsky@de.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=schwidefsky@de.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of schwidefsky@de.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=schwidefsky@de.ibm.com;
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
Subject: [PATCH 5/6] s390: run user space and KVM guests with modified branch prediction
Date: Wed,  7 Feb 2018 08:00:10 +0100
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517986811-27819-1-git-send-email-schwidefsky@de.ibm.com>
References: <1517986811-27819-1-git-send-email-schwidefsky@de.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18020707-0020-0000-0000-000003F31BF5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020707-0021-0000-0000-000042859549
Message-Id: <1517986811-27819-6-git-send-email-schwidefsky@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-07_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802070089
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591724559955029227?=
X-GMAIL-MSGID: =?utf-8?q?1591724559955029227?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Define TIF_ISOLATE_BP and TIF_ISOLATE_BP_GUEST and add the necessary
plumbing in entry.S to be able to run user space and KVM guests with
limited branch prediction.

To switch a user space process to limited branch prediction the
s390_isolate_bp() function has to be call, and to run a vCPU of a KVM
guest associated with the current task with limited branch prediction
call s390_isolate_bp_guest().

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/include/asm/processor.h   |  3 +++
 arch/s390/include/asm/thread_info.h |  4 +++
 arch/s390/kernel/entry.S            | 51 +++++++++++++++++++++++++++++++++----
 arch/s390/kernel/processor.c        | 18 +++++++++++++
 4 files changed, 71 insertions(+), 5 deletions(-)

diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index 5f37f9c..7f2953c 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -378,6 +378,9 @@ extern void memcpy_absolute(void *, void *, size_t);
 	memcpy_absolute(&(dest), &__tmp, sizeof(__tmp));	\
 } while (0)
 
+extern int s390_isolate_bp(void);
+extern int s390_isolate_bp_guest(void);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __ASM_S390_PROCESSOR_H */
diff --git a/arch/s390/include/asm/thread_info.h b/arch/s390/include/asm/thread_info.h
index 25d6ec3..83ba575 100644
--- a/arch/s390/include/asm/thread_info.h
+++ b/arch/s390/include/asm/thread_info.h
@@ -58,6 +58,8 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 #define TIF_GUARDED_STORAGE	4	/* load guarded storage control block */
 #define TIF_PATCH_PENDING	5	/* pending live patching update */
 #define TIF_PGSTE		6	/* New mm's will use 4K page tables */
+#define TIF_ISOLATE_BP		8	/* Run process with isolated BP */
+#define TIF_ISOLATE_BP_GUEST	9	/* Run KVM guests with isolated BP */
 
 #define TIF_31BIT		16	/* 32bit process */
 #define TIF_MEMDIE		17	/* is terminating due to OOM killer */
@@ -78,6 +80,8 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 #define _TIF_UPROBE		_BITUL(TIF_UPROBE)
 #define _TIF_GUARDED_STORAGE	_BITUL(TIF_GUARDED_STORAGE)
 #define _TIF_PATCH_PENDING	_BITUL(TIF_PATCH_PENDING)
+#define _TIF_ISOLATE_BP		_BITUL(TIF_ISOLATE_BP)
+#define _TIF_ISOLATE_BP_GUEST	_BITUL(TIF_ISOLATE_BP_GUEST)
 
 #define _TIF_31BIT		_BITUL(TIF_31BIT)
 #define _TIF_SINGLE_STEP	_BITUL(TIF_SINGLE_STEP)
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index e6d7550..53145b5 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -107,6 +107,7 @@ _PIF_WORK	= (_PIF_PER_TRAP | _PIF_SYSCALL_RESTART)
 	aghi	%r15,-(STACK_FRAME_OVERHEAD + __PT_SIZE)
 	j	3f
 1:	UPDATE_VTIME %r14,%r15,\timer
+	BPENTER __TI_flags(%r12),_TIF_ISOLATE_BP
 2:	lg	%r15,__LC_ASYNC_STACK	# load async stack
 3:	la	%r11,STACK_FRAME_OVERHEAD(%r15)
 	.endm
@@ -187,6 +188,40 @@ _PIF_WORK	= (_PIF_PER_TRAP | _PIF_SYSCALL_RESTART)
 	.popsection
 	.endm
 
+	.macro BPENTER tif_ptr,tif_mask
+	.pushsection .altinstr_replacement, "ax"
+662:	.word	0xc004, 0x0000, 0x0000	# 6 byte nop
+	.word	0xc004, 0x0000, 0x0000	# 6 byte nop
+	.popsection
+664:	TSTMSK	\tif_ptr,\tif_mask
+	jz	. + 8
+	.long	0xb2e8d000
+	.pushsection .altinstructions, "a"
+	.long 664b - .
+	.long 662b - .
+	.word 82
+	.byte 12
+	.byte 12
+	.popsection
+	.endm
+
+	.macro BPEXIT tif_ptr,tif_mask
+	TSTMSK	\tif_ptr,\tif_mask
+	.pushsection .altinstr_replacement, "ax"
+662:	jnz	. + 8
+	.long	0xb2e8d000
+	.popsection
+664:	jz	. + 8
+	.long	0xb2e8c000
+	.pushsection .altinstructions, "a"
+	.long 664b - .
+	.long 662b - .
+	.word 82
+	.byte 8
+	.byte 8
+	.popsection
+	.endm
+
 	.section .kprobes.text, "ax"
 .Ldummy:
 	/*
@@ -240,9 +275,11 @@ ENTRY(__switch_to)
  */
 ENTRY(sie64a)
 	stmg	%r6,%r14,__SF_GPRS(%r15)	# save kernel registers
+	lg	%r12,__LC_CURRENT
 	stg	%r2,__SF_EMPTY(%r15)		# save control block pointer
 	stg	%r3,__SF_EMPTY+8(%r15)		# save guest register save area
 	xc	__SF_EMPTY+16(8,%r15),__SF_EMPTY+16(%r15) # reason code = 0
+	mvc	__SF_EMPTY+24(8,%r15),__TI_flags(%r12) # copy thread flags
 	TSTMSK	__LC_CPU_FLAGS,_CIF_FPU		# load guest fp/vx registers ?
 	jno	.Lsie_load_guest_gprs
 	brasl	%r14,load_fpu_regs		# load guest fp/vx regs
@@ -259,11 +296,12 @@ ENTRY(sie64a)
 	jnz	.Lsie_skip
 	TSTMSK	__LC_CPU_FLAGS,_CIF_FPU
 	jo	.Lsie_skip			# exit if fp/vx regs changed
-	BPON
+	BPEXIT	__SF_EMPTY+24(%r15),(_TIF_ISOLATE_BP|_TIF_ISOLATE_BP_GUEST)
 .Lsie_entry:
 	sie	0(%r14)
 .Lsie_exit:
 	BPOFF
+	BPENTER	__SF_EMPTY+24(%r15),(_TIF_ISOLATE_BP|_TIF_ISOLATE_BP_GUEST)
 .Lsie_skip:
 	ni	__SIE_PROG0C+3(%r14),0xfe	# no longer in SIE
 	lctlg	%c1,%c1,__LC_USER_ASCE		# load primary asce
@@ -324,6 +362,7 @@ ENTRY(system_call)
 	la	%r11,STACK_FRAME_OVERHEAD(%r15)	# pointer to pt_regs
 .Lsysc_vtime:
 	UPDATE_VTIME %r8,%r9,__LC_SYNC_ENTER_TIMER
+	BPENTER __TI_flags(%r12),_TIF_ISOLATE_BP
 	stmg	%r0,%r7,__PT_R0(%r11)
 	# clear user controlled register to prevent speculative use
 	xgr	%r0,%r0
@@ -362,7 +401,7 @@ ENTRY(system_call)
 	jnz	.Lsysc_work			# check for work
 	TSTMSK	__LC_CPU_FLAGS,_CIF_WORK
 	jnz	.Lsysc_work
-	BPON
+	BPEXIT	__TI_flags(%r12),_TIF_ISOLATE_BP
 .Lsysc_restore:
 	lg	%r14,__LC_VDSO_PER_CPU
 	lmg	%r0,%r10,__PT_R0(%r11)
@@ -597,6 +636,7 @@ ENTRY(pgm_check_handler)
 	aghi	%r15,-(STACK_FRAME_OVERHEAD + __PT_SIZE)
 	j	4f
 2:	UPDATE_VTIME %r14,%r15,__LC_SYNC_ENTER_TIMER
+	BPENTER __TI_flags(%r12),_TIF_ISOLATE_BP
 	lg	%r15,__LC_KERNEL_STACK
 	lgr	%r14,%r12
 	aghi	%r14,__TASK_thread	# pointer to thread_struct
@@ -729,7 +769,7 @@ ENTRY(io_int_handler)
 	mvc	__LC_RETURN_PSW(16),__PT_PSW(%r11)
 	tm	__PT_PSW+1(%r11),0x01	# returning to user ?
 	jno	.Lio_exit_kernel
-	BPON
+	BPEXIT	__TI_flags(%r12),_TIF_ISOLATE_BP
 .Lio_exit_timer:
 	stpt	__LC_EXIT_TIMER
 	mvc	__VDSO_ECTG_BASE(16,%r14),__LC_EXIT_TIMER
@@ -1165,7 +1205,7 @@ ENTRY(mcck_int_handler)
 	mvc	__LC_RETURN_MCCK_PSW(16),__PT_PSW(%r11) # move return PSW
 	tm	__LC_RETURN_MCCK_PSW+1,0x01 # returning to user ?
 	jno	0f
-	BPON
+	BPEXIT	__TI_flags(%r12),_TIF_ISOLATE_BP
 	stpt	__LC_EXIT_TIMER
 	mvc	__VDSO_ECTG_BASE(16,%r14),__LC_EXIT_TIMER
 0:	lmg	%r11,%r15,__PT_R11(%r11)
@@ -1292,7 +1332,8 @@ cleanup_critical:
 	clg     %r9,BASED(.Lsie_crit_mcck_length)
 	jh      1f
 	oi      __LC_CPU_FLAGS+7, _CIF_MCCK_GUEST
-1:	lg	%r9,__SF_EMPTY(%r15)		# get control block pointer
+1:	BPENTER __SF_EMPTY+24(%r15),(_TIF_ISOLATE_BP|_TIF_ISOLATE_BP_GUEST)
+	lg	%r9,__SF_EMPTY(%r15)		# get control block pointer
 	ni	__SIE_PROG0C+3(%r9),0xfe	# no longer in SIE
 	lctlg	%c1,%c1,__LC_USER_ASCE		# load primary asce
 	larl	%r9,sie_exit			# skip forward to sie_exit
diff --git a/arch/s390/kernel/processor.c b/arch/s390/kernel/processor.c
index 5362fd8..6fe2e18 100644
--- a/arch/s390/kernel/processor.c
+++ b/arch/s390/kernel/processor.c
@@ -197,3 +197,21 @@ const struct seq_operations cpuinfo_op = {
 	.stop	= c_stop,
 	.show	= show_cpuinfo,
 };
+
+int s390_isolate_bp(void)
+{
+	if (!test_facility(82))
+		return -EOPNOTSUPP;
+	set_thread_flag(TIF_ISOLATE_BP);
+	return 0;
+}
+EXPORT_SYMBOL(s390_isolate_bp);
+
+int s390_isolate_bp_guest(void)
+{
+	if (!test_facility(82))
+		return -EOPNOTSUPP;
+	set_thread_flag(TIF_ISOLATE_BP_GUEST);
+	return 0;
+}
+EXPORT_SYMBOL(s390_isolate_bp_guest);
-- 
2.7.4
