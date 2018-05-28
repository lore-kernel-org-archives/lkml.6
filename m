Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937381AbeE1KmC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:42:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163025AbeE1Kl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:41:57 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <jhogan@kernel.org>,
        "Maciej W. Rozycki" <macro@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 4.14 002/496] MIPS: ptrace: Expose FIR register through FP regset
Date: Mon, 28 May 2018 11:56:27 +0200
Message-Id: <20180528100319.614328600@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej W. Rozycki <macro@mips.com>

commit 71e909c0cdad28a1df1fa14442929e68615dee45 upstream.

Correct commit 7aeb753b5353 ("MIPS: Implement task_user_regset_view.")
and expose the FIR register using the unused 4 bytes at the end of the
NT_PRFPREG regset.  Without that register included clients cannot use
the PTRACE_GETREGSET request to retrieve the complete FPU register set
and have to resort to one of the older interfaces, either PTRACE_PEEKUSR
or PTRACE_GETFPREGS, to retrieve the missing piece of data.  Also the
register is irreversibly missing from core dumps.

This register is architecturally hardwired and read-only so the write
path does not matter.  Ignore data supplied on writes then.

Fixes: 7aeb753b5353 ("MIPS: Implement task_user_regset_view.")
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Maciej W. Rozycki <macro@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 3.13+
Patchwork: https://patchwork.linux-mips.org/patch/19273/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/ptrace.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -454,7 +454,7 @@ static int fpr_get_msa(struct task_struc
 /*
  * Copy the floating-point context to the supplied NT_PRFPREG buffer.
  * Choose the appropriate helper for general registers, and then copy
- * the FCSR register separately.
+ * the FCSR and FIR registers separately.
  */
 static int fpr_get(struct task_struct *target,
 		   const struct user_regset *regset,
@@ -462,6 +462,7 @@ static int fpr_get(struct task_struct *t
 		   void *kbuf, void __user *ubuf)
 {
 	const int fcr31_pos = NUM_FPU_REGS * sizeof(elf_fpreg_t);
+	const int fir_pos = fcr31_pos + sizeof(u32);
 	int err;
 
 	if (sizeof(target->thread.fpu.fpr[0]) == sizeof(elf_fpreg_t))
@@ -474,6 +475,12 @@ static int fpr_get(struct task_struct *t
 	err = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
 				  &target->thread.fpu.fcr31,
 				  fcr31_pos, fcr31_pos + sizeof(u32));
+	if (err)
+		return err;
+
+	err = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				  &boot_cpu_data.fpu_id,
+				  fir_pos, fir_pos + sizeof(u32));
 
 	return err;
 }
@@ -522,7 +529,8 @@ static int fpr_set_msa(struct task_struc
 /*
  * Copy the supplied NT_PRFPREG buffer to the floating-point context.
  * Choose the appropriate helper for general registers, and then copy
- * the FCSR register separately.
+ * the FCSR register separately.  Ignore the incoming FIR register
+ * contents though, as the register is read-only.
  *
  * We optimize for the case where `count % sizeof(elf_fpreg_t) == 0',
  * which is supposed to have been guaranteed by the kernel before
@@ -536,6 +544,7 @@ static int fpr_set(struct task_struct *t
 		   const void *kbuf, const void __user *ubuf)
 {
 	const int fcr31_pos = NUM_FPU_REGS * sizeof(elf_fpreg_t);
+	const int fir_pos = fcr31_pos + sizeof(u32);
 	u32 fcr31;
 	int err;
 
@@ -563,6 +572,11 @@ static int fpr_set(struct task_struct *t
 		ptrace_setfcr31(target, fcr31);
 	}
 
+	if (count > 0)
+		err = user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf,
+						fir_pos,
+						fir_pos + sizeof(u32));
+
 	return err;
 }
 
