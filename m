Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752991AbeDZGXw convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 02:23:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47854 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751465AbeDZGXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 02:23:50 -0400
Date: Thu, 26 Apr 2018 08:23:44 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.17-rc3
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 18042606-0020-0000-0000-0000041632C7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042606-0021-0000-0000-000042AB361E
Message-Id: <20180426082344.054bbf6b@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-26_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804260061
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull from the 'for-linus' branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus

to receive the following updates:


A couple of bug fixes:

 * Correct some CPU-MF counter names for z13 and z14
 
 * Correct locking in the vfio-ccw fsm_io_helper function

 * Provide arch_uretprobe_is_alive to avoid sigsegv with uretprobes

 * Fix a corner case with CPU-MF sampling in regard to execve

 * Fix expoline code revert for loadable modules

 * Update chpid descriptor for resource accessibility events

 * Fix dasd I/O errors due to outdated device alias infomation


André Wild (1):
      s390/cpum_cf: rename IBM z13/z14 counter names

Cornelia Huck (1):
      vfio: ccw: process ssch with interrupts disabled

Heiko Carstens (1):
      s390/uprobes: implement arch_uretprobe_is_alive()

Martin Schwidefsky (2):
      s390: update sampling tag after task pid change
      s390: correct module section names for expoline code revert

Sebastian Ott (1):
      s390/cio: update chpid descriptor after resource accessibility event

Stefan Haberland (1):
      s390/dasd: fix IO error for newly defined devices

 arch/s390/include/asm/thread_info.h    |  3 +++
 arch/s390/kernel/module.c              |  4 ++--
 arch/s390/kernel/perf_cpum_cf_events.c |  8 ++++----
 arch/s390/kernel/process.c             | 10 ++++++++++
 arch/s390/kernel/uprobes.c             |  9 +++++++++
 drivers/s390/block/dasd_alias.c        | 13 +++++++++++--
 drivers/s390/cio/chsc.c                | 14 +++++++++++---
 drivers/s390/cio/vfio_ccw_fsm.c        | 19 ++++++++++++-------
 8 files changed, 62 insertions(+), 18 deletions(-)

diff --git a/arch/s390/include/asm/thread_info.h b/arch/s390/include/asm/thread_info.h
index 83ba575..3c883c3 100644
--- a/arch/s390/include/asm/thread_info.h
+++ b/arch/s390/include/asm/thread_info.h
@@ -45,6 +45,9 @@ struct thread_info {
 void arch_release_task_struct(struct task_struct *tsk);
 int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 
+void arch_setup_new_exec(void);
+#define arch_setup_new_exec arch_setup_new_exec
+
 #endif
 
 /*
diff --git a/arch/s390/kernel/module.c b/arch/s390/kernel/module.c
index 5a83be9..0dc8ac8 100644
--- a/arch/s390/kernel/module.c
+++ b/arch/s390/kernel/module.c
@@ -465,11 +465,11 @@ int module_finalize(const Elf_Ehdr *hdr,
 			apply_alternatives(aseg, aseg + s->sh_size);
 
 		if (IS_ENABLED(CONFIG_EXPOLINE) &&
-		    (!strcmp(".nospec_call_table", secname)))
+		    (!strncmp(".s390_indirect", secname, 14)))
 			nospec_revert(aseg, aseg + s->sh_size);
 
 		if (IS_ENABLED(CONFIG_EXPOLINE) &&
-		    (!strcmp(".nospec_return_table", secname)))
+		    (!strncmp(".s390_return", secname, 12)))
 			nospec_revert(aseg, aseg + s->sh_size);
 	}
 
diff --git a/arch/s390/kernel/perf_cpum_cf_events.c b/arch/s390/kernel/perf_cpum_cf_events.c
index 5ee27dc..feebb29 100644
--- a/arch/s390/kernel/perf_cpum_cf_events.c
+++ b/arch/s390/kernel/perf_cpum_cf_events.c
@@ -123,7 +123,7 @@ CPUMF_EVENT_ATTR(cf_zec12, L1I_OFFBOOK_L3_SOURCED_WRITES_IV, 0x00a1);
 CPUMF_EVENT_ATTR(cf_zec12, TX_NC_TABORT, 0x00b1);
 CPUMF_EVENT_ATTR(cf_zec12, TX_C_TABORT_NO_SPECIAL, 0x00b2);
 CPUMF_EVENT_ATTR(cf_zec12, TX_C_TABORT_SPECIAL, 0x00b3);
-CPUMF_EVENT_ATTR(cf_z13, L1D_WRITES_RO_EXCL, 0x0080);
+CPUMF_EVENT_ATTR(cf_z13, L1D_RO_EXCL_WRITES, 0x0080);
 CPUMF_EVENT_ATTR(cf_z13, DTLB1_WRITES, 0x0081);
 CPUMF_EVENT_ATTR(cf_z13, DTLB1_MISSES, 0x0082);
 CPUMF_EVENT_ATTR(cf_z13, DTLB1_HPAGE_WRITES, 0x0083);
@@ -179,7 +179,7 @@ CPUMF_EVENT_ATTR(cf_z13, TX_C_TABORT_NO_SPECIAL, 0x00db);
 CPUMF_EVENT_ATTR(cf_z13, TX_C_TABORT_SPECIAL, 0x00dc);
 CPUMF_EVENT_ATTR(cf_z13, MT_DIAG_CYCLES_ONE_THR_ACTIVE, 0x01c0);
 CPUMF_EVENT_ATTR(cf_z13, MT_DIAG_CYCLES_TWO_THR_ACTIVE, 0x01c1);
-CPUMF_EVENT_ATTR(cf_z14, L1D_WRITES_RO_EXCL, 0x0080);
+CPUMF_EVENT_ATTR(cf_z14, L1D_RO_EXCL_WRITES, 0x0080);
 CPUMF_EVENT_ATTR(cf_z14, DTLB2_WRITES, 0x0081);
 CPUMF_EVENT_ATTR(cf_z14, DTLB2_MISSES, 0x0082);
 CPUMF_EVENT_ATTR(cf_z14, DTLB2_HPAGE_WRITES, 0x0083);
@@ -371,7 +371,7 @@ static struct attribute *cpumcf_zec12_pmu_event_attr[] __initdata = {
 };
 
 static struct attribute *cpumcf_z13_pmu_event_attr[] __initdata = {
-	CPUMF_EVENT_PTR(cf_z13, L1D_WRITES_RO_EXCL),
+	CPUMF_EVENT_PTR(cf_z13, L1D_RO_EXCL_WRITES),
 	CPUMF_EVENT_PTR(cf_z13, DTLB1_WRITES),
 	CPUMF_EVENT_PTR(cf_z13, DTLB1_MISSES),
 	CPUMF_EVENT_PTR(cf_z13, DTLB1_HPAGE_WRITES),
@@ -431,7 +431,7 @@ static struct attribute *cpumcf_z13_pmu_event_attr[] __initdata = {
 };
 
 static struct attribute *cpumcf_z14_pmu_event_attr[] __initdata = {
-	CPUMF_EVENT_PTR(cf_z14, L1D_WRITES_RO_EXCL),
+	CPUMF_EVENT_PTR(cf_z14, L1D_RO_EXCL_WRITES),
 	CPUMF_EVENT_PTR(cf_z14, DTLB2_WRITES),
 	CPUMF_EVENT_PTR(cf_z14, DTLB2_MISSES),
 	CPUMF_EVENT_PTR(cf_z14, DTLB2_HPAGE_WRITES),
diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index 70576a2..6e758bb 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -29,6 +29,7 @@
 #include <linux/random.h>
 #include <linux/export.h>
 #include <linux/init_task.h>
+#include <asm/cpu_mf.h>
 #include <asm/io.h>
 #include <asm/processor.h>
 #include <asm/vtimer.h>
@@ -48,6 +49,15 @@ void flush_thread(void)
 {
 }
 
+void arch_setup_new_exec(void)
+{
+	if (S390_lowcore.current_pid != current->pid) {
+		S390_lowcore.current_pid = current->pid;
+		if (test_facility(40))
+			lpp(&S390_lowcore.lpp);
+	}
+}
+
 void arch_release_task_struct(struct task_struct *tsk)
 {
 	runtime_instr_release(tsk);
diff --git a/arch/s390/kernel/uprobes.c b/arch/s390/kernel/uprobes.c
index d9d1f51..5007fac 100644
--- a/arch/s390/kernel/uprobes.c
+++ b/arch/s390/kernel/uprobes.c
@@ -150,6 +150,15 @@ unsigned long arch_uretprobe_hijack_return_addr(unsigned long trampoline,
 	return orig;
 }
 
+bool arch_uretprobe_is_alive(struct return_instance *ret, enum rp_check ctx,
+			     struct pt_regs *regs)
+{
+	if (ctx == RP_CHECK_CHAIN_CALL)
+		return user_stack_pointer(regs) <= ret->stack;
+	else
+		return user_stack_pointer(regs) < ret->stack;
+}
+
 /* Instruction Emulation */
 
 static void adjust_psw_addr(psw_t *psw, unsigned long len)
diff --git a/drivers/s390/block/dasd_alias.c b/drivers/s390/block/dasd_alias.c
index 62f5f04..5e963fe 100644
--- a/drivers/s390/block/dasd_alias.c
+++ b/drivers/s390/block/dasd_alias.c
@@ -592,13 +592,22 @@ static int _schedule_lcu_update(struct alias_lcu *lcu,
 int dasd_alias_add_device(struct dasd_device *device)
 {
 	struct dasd_eckd_private *private = device->private;
-	struct alias_lcu *lcu;
+	__u8 uaddr = private->uid.real_unit_addr;
+	struct alias_lcu *lcu = private->lcu;
 	unsigned long flags;
 	int rc;
 
-	lcu = private->lcu;
 	rc = 0;
 	spin_lock_irqsave(&lcu->lock, flags);
+	/*
+	 * Check if device and lcu type differ. If so, the uac data may be
+	 * outdated and needs to be updated.
+	 */
+	if (private->uid.type !=  lcu->uac->unit[uaddr].ua_type) {
+		lcu->flags |= UPDATE_PENDING;
+		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
+			      "uid type mismatch - trigger rescan");
+	}
 	if (!(lcu->flags & UPDATE_PENDING)) {
 		rc = _add_device_to_lcu(lcu, device, device);
 		if (rc)
diff --git a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
index 6652a49..9029804 100644
--- a/drivers/s390/cio/chsc.c
+++ b/drivers/s390/cio/chsc.c
@@ -452,6 +452,7 @@ static void chsc_process_sei_link_incident(struct chsc_sei_nt0_area *sei_area)
 
 static void chsc_process_sei_res_acc(struct chsc_sei_nt0_area *sei_area)
 {
+	struct channel_path *chp;
 	struct chp_link link;
 	struct chp_id chpid;
 	int status;
@@ -464,10 +465,17 @@ static void chsc_process_sei_res_acc(struct chsc_sei_nt0_area *sei_area)
 	chpid.id = sei_area->rsid;
 	/* allocate a new channel path structure, if needed */
 	status = chp_get_status(chpid);
-	if (status < 0)
-		chp_new(chpid);
-	else if (!status)
+	if (!status)
 		return;
+
+	if (status < 0) {
+		chp_new(chpid);
+	} else {
+		chp = chpid_to_chp(chpid);
+		mutex_lock(&chp->lock);
+		chp_update_desc(chp);
+		mutex_unlock(&chp->lock);
+	}
 	memset(&link, 0, sizeof(struct chp_link));
 	link.chpid = chpid;
 	if ((sei_area->vf & 0xc0) != 0) {
diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index ff6963a..3c80064 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -20,12 +20,12 @@ static int fsm_io_helper(struct vfio_ccw_private *private)
 	int ccode;
 	__u8 lpm;
 	unsigned long flags;
+	int ret;
 
 	sch = private->sch;
 
 	spin_lock_irqsave(sch->lock, flags);
 	private->state = VFIO_CCW_STATE_BUSY;
-	spin_unlock_irqrestore(sch->lock, flags);
 
 	orb = cp_get_orb(&private->cp, (u32)(addr_t)sch, sch->lpm);
 
@@ -38,10 +38,12 @@ static int fsm_io_helper(struct vfio_ccw_private *private)
 		 * Initialize device status information
 		 */
 		sch->schib.scsw.cmd.actl |= SCSW_ACTL_START_PEND;
-		return 0;
+		ret = 0;
+		break;
 	case 1:		/* Status pending */
 	case 2:		/* Busy */
-		return -EBUSY;
+		ret = -EBUSY;
+		break;
 	case 3:		/* Device/path not operational */
 	{
 		lpm = orb->cmd.lpm;
@@ -51,13 +53,16 @@ static int fsm_io_helper(struct vfio_ccw_private *private)
 			sch->lpm = 0;
 
 		if (cio_update_schib(sch))
-			return -ENODEV;
-
-		return sch->lpm ? -EACCES : -ENODEV;
+			ret = -ENODEV;
+		else
+			ret = sch->lpm ? -EACCES : -ENODEV;
+		break;
 	}
 	default:
-		return ccode;
+		ret = ccode;
 	}
+	spin_unlock_irqrestore(sch->lock, flags);
+	return ret;
 }
 
 static void fsm_notoper(struct vfio_ccw_private *private,
