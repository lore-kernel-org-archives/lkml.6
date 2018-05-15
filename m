Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752061AbeEOWkq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 18:40:46 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:36926 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751634AbeEOWkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 18:40:45 -0400
Date: Tue, 15 May 2018 23:40:18 +0100
From: "Maciej W. Rozycki" <macro@mips.com>
To: James Hogan <jhogan@kernel.org>
CC: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <Paul.Burton@mips.com>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] MIPS: Add FP_MODE regset support
Message-ID: <alpine.DEB.2.00.1805111326000.10896@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.107]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1526424027-637138-23741-17424-1
X-BESS-VER: 2018.6-r1805102334
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.193020
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define an NT_MIPS_FP_MODE core file note and implement a corresponding 
regset holding the state handled by PR_SET_FP_MODE and PR_GET_FP_MODE 
prctl(2) requests.  This lets debug software correctly interpret the 
contents of floating-point general registers both in live debugging and 
in core files, and also switch floating-point modes of a live process.

Signed-off-by: Maciej W. Rozycki <macro@mips.com>
---
NB due to patch conflicts this change relies on the DSP ASE regset series 
<https://patchwork.kernel.org/patch/10402171/> to be applied first.
---
 arch/mips/kernel/ptrace.c |   63 ++++++++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/elf.h  |    1 
 2 files changed, 64 insertions(+)

linux-mips-nt-fp-mode.diff
Index: linux-jhogan-test/arch/mips/kernel/ptrace.c
===================================================================
--- linux-jhogan-test.orig/arch/mips/kernel/ptrace.c	2018-05-09 23:53:34.999776000 +0100
+++ linux-jhogan-test/arch/mips/kernel/ptrace.c	2018-05-09 23:54:22.778128000 +0100
@@ -759,10 +759,57 @@ static int dsp_active(struct task_struct
 	return cpu_has_dsp ? NUM_DSP_REGS + 1 : -ENODEV;
 }
 
+/* Copy the FP mode setting to the supplied NT_MIPS_FP_MODE buffer.  */
+static int fp_mode_get(struct task_struct *target,
+		       const struct user_regset *regset,
+		       unsigned int pos, unsigned int count,
+		       void *kbuf, void __user *ubuf)
+{
+	int fp_mode;
+
+	fp_mode = mips_get_process_fp_mode(target);
+	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, &fp_mode, 0,
+				   sizeof(fp_mode));
+}
+
+/*
+ * Copy the supplied NT_MIPS_FP_MODE buffer to the FP mode setting.
+ *
+ * We optimize for the case where `count % sizeof(int) == 0', which
+ * is supposed to have been guaranteed by the kernel before calling
+ * us, e.g. in `ptrace_regset'.  We enforce that requirement, so
+ * that we can safely avoid preinitializing temporaries for partial
+ * mode writes.
+ */
+static int fp_mode_set(struct task_struct *target,
+		       const struct user_regset *regset,
+		       unsigned int pos, unsigned int count,
+		       const void *kbuf, const void __user *ubuf)
+{
+	int fp_mode;
+	int err;
+
+	BUG_ON(count % sizeof(int));
+
+	if (pos + count > sizeof(fp_mode))
+		return -EIO;
+
+	err = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &fp_mode, 0,
+				 sizeof(fp_mode));
+	if (err)
+		return err;
+
+	if (count > 0)
+		err = mips_set_process_fp_mode(target, fp_mode);
+
+	return err;
+}
+
 enum mips_regset {
 	REGSET_GPR,
 	REGSET_FPR,
 	REGSET_DSP,
+	REGSET_FP_MODE,
 };
 
 struct pt_regs_offset {
@@ -877,6 +924,14 @@ static const struct user_regset mips_reg
 		.set		= dsp32_set,
 		.active		= dsp_active,
 	},
+	[REGSET_FP_MODE] = {
+		.core_note_type	= NT_MIPS_FP_MODE,
+		.n		= 1,
+		.size		= sizeof(int),
+		.align		= sizeof(int),
+		.get		= fp_mode_get,
+		.set		= fp_mode_set,
+	},
 };
 
 static const struct user_regset_view user_mips_view = {
@@ -917,6 +972,14 @@ static const struct user_regset mips64_r
 		.set		= dsp64_set,
 		.active		= dsp_active,
 	},
+	[REGSET_FP_MODE] = {
+		.core_note_type	= NT_MIPS_FP_MODE,
+		.n		= 1,
+		.size		= sizeof(int),
+		.align		= sizeof(int),
+		.get		= fp_mode_get,
+		.set		= fp_mode_set,
+	},
 };
 
 static const struct user_regset_view user_mips64_view = {
Index: linux-jhogan-test/include/uapi/linux/elf.h
===================================================================
--- linux-jhogan-test.orig/include/uapi/linux/elf.h	2018-05-09 23:53:35.003775000 +0100
+++ linux-jhogan-test/include/uapi/linux/elf.h	2018-05-09 23:54:22.787132000 +0100
@@ -425,6 +425,7 @@ typedef struct elf64_shdr {
 #define NT_METAG_TLS	0x502		/* Metag TLS pointer */
 #define NT_ARC_V2	0x600		/* ARCv2 accumulator/extra registers */
 #define NT_MIPS_DSP	0x700		/* MIPS DSP ASE registers */
+#define NT_MIPS_FP_MODE	0x701		/* MIPS floating-point mode */
 
 /* Note header in a PT_NOTE section */
 typedef struct elf32_note {
