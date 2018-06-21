Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFD4C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D3AC223C8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:18:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D3AC223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933485AbeFUVSc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:18:32 -0400
Received: from mga14.intel.com ([192.55.52.115]:27244 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932899AbeFUVSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:18:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2018 14:18:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,253,1526367600"; 
   d="scan'208";a="48912135"
Received: from hanvin-mobl2.amr.corp.intel.com ([10.254.42.214])
  by fmsmga007.fm.intel.com with ESMTP; 21 Jun 2018 14:18:03 -0700
From:   "H. Peter Anvin, Intel" <h.peter.anvin@intel.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     "H. Peter Anvin" <hpa@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        "Markus T . Metzger" <markus.t.metzger@intel.com>
Subject: [PATCH v3 7/7] x86/ldt,ptrace: provide regset access to the LDT
Date:   Thu, 21 Jun 2018 14:17:54 -0700
Message-Id: <20180621211754.12757-8-h.peter.anvin@intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180621211754.12757-1-h.peter.anvin@intel.com>
References: <20180621211754.12757-1-h.peter.anvin@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin" <hpa@linux.intel.com>

Provide ptrace/regset access to the LDT, if one exists.  This
interface provides both read and write access. The write code is
unified with modify_ldt(); the read code doesn't have enough
similarity so it has been kept made separate.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Markus T. Metzger <markus.t.metzger@intel.com>
---
 arch/x86/include/asm/desc.h |   2 +-
 arch/x86/include/asm/ldt.h  |  16 ++++
 arch/x86/kernel/ldt.c       | 209 +++++++++++++++++++++++++++++++++++---------
 arch/x86/kernel/ptrace.c    |  20 +++++
 include/uapi/linux/elf.h    |   1 +
 5 files changed, 204 insertions(+), 44 deletions(-)
 create mode 100644 arch/x86/include/asm/ldt.h

diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
index 5e69f993c9ff..12a759d76314 100644
--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -3,7 +3,7 @@
 #define _ASM_X86_DESC_H
 
 #include <asm/desc_defs.h>
-#include <asm/ldt.h>
+#include <uapi/asm/ldt.h>
 #include <asm/mmu.h>
 #include <asm/fixmap.h>
 #include <asm/irq_vectors.h>
diff --git a/arch/x86/include/asm/ldt.h b/arch/x86/include/asm/ldt.h
new file mode 100644
index 000000000000..302ec2d6d45d
--- /dev/null
+++ b/arch/x86/include/asm/ldt.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Ptrace interface to the LDT
+ *
+ */
+
+#ifndef _ARCH_X86_INCLUDE_ASM_LDT_H
+
+#include <linux/regset.h>
+#include <uapi/asm/ldt.h>
+
+extern user_regset_active_fn regset_ldt_active;
+extern user_regset_get_fn regset_ldt_get;
+extern user_regset_set_fn regset_ldt_set;
+
+#endif	/* _ARCH_X86_INCLUDE_ASM_LDT_H */
diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index 601d24268a99..e80dfde1f82f 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -392,53 +392,39 @@ static int read_default_ldt(void __user *ptr, unsigned long bytecount)
 	return bytecount;
 }
 
-static int write_ldt(void __user *ptr, unsigned long bytecount, int oldmode)
+
+static int do_write_ldt(const struct task_struct *target,
+			const void *kbuf, const void __user *ubuf,
+			unsigned long bytecount, unsigned int index,
+			bool oldmode)
 {
-	struct mm_struct *mm = current->mm;
+	struct mm_struct *mm = target->mm;
 	struct ldt_struct *new_ldt, *old_ldt;
-	unsigned int old_nr_entries, new_nr_entries;
+	unsigned int count, old_nr_entries, new_nr_entries;
 	struct user_desc ldt_info;
+	const struct user_desc *kptr = kbuf;
+	const struct user_desc __user *uptr = ubuf;
 	struct desc_struct ldt;
+	unsigned short first_index, last_index;
 	int error;
 
-	error = -EINVAL;
-	if (bytecount != sizeof(ldt_info))
-		goto out;
-	error = -EFAULT;
-	if (copy_from_user(&ldt_info, ptr, sizeof(ldt_info)))
-		goto out;
+	if (bytecount % sizeof(ldt_info) ||
+	    bytecount >= LDT_ENTRY_SIZE*LDT_ENTRIES)
+		return -EINVAL;
 
-	error = -EINVAL;
-	if (ldt_info.entry_number >= LDT_ENTRIES)
-		goto out;
-	if (ldt_info.contents == 3) {
-		if (oldmode)
-			goto out;
-		if (ldt_info.seg_not_present == 0)
-			goto out;
-	}
+	count = bytecount/sizeof(ldt_info);
+	if (index >= LDT_ENTRIES || index + count > LDT_ENTRIES)
+		return -EINVAL;
 
-	if ((oldmode && !ldt_info.base_addr && !ldt_info.limit) ||
-	    LDT_empty(&ldt_info)) {
-		/* The user wants to clear the entry. */
-		memset(&ldt, 0, sizeof(ldt));
-	} else {
-		if (!IS_ENABLED(CONFIG_X86_16BIT) && !ldt_info.seg_32bit) {
-			error = -EINVAL;
-			goto out;
-		}
-
-		fill_ldt(&ldt, &ldt_info);
-		if (oldmode)
-			ldt.avl = 0;
-	}
+	first_index = index;
+	last_index = index + count - 1;
 
 	if (down_write_killable(&mm->context.ldt_usr_sem))
 		return -EINTR;
 
-	old_ldt       = mm->context.ldt;
+	old_ldt	       = mm->context.ldt;
 	old_nr_entries = old_ldt ? old_ldt->nr_entries : 0;
-	new_nr_entries = max(ldt_info.entry_number + 1, old_nr_entries);
+	new_nr_entries = max(index + count, old_nr_entries);
 
 	error = -ENOMEM;
 	new_ldt = alloc_ldt_struct(new_nr_entries);
@@ -446,9 +432,46 @@ static int write_ldt(void __user *ptr, unsigned long bytecount, int oldmode)
 		goto out_unlock;
 
 	if (old_ldt)
-		memcpy(new_ldt->entries, old_ldt->entries, old_nr_entries * LDT_ENTRY_SIZE);
+		memcpy(new_ldt->entries, old_ldt->entries,
+		       old_nr_entries * LDT_ENTRY_SIZE);
+
+	while (count--) {
+		error = -EFAULT;
+		if (kptr) {
+			memcpy(&ldt_info, kptr++, sizeof(ldt_info));
+		} else {
+			if (__copy_from_user(&ldt_info, uptr++,
+					     sizeof(ldt_info)))
+				goto out_free;
+		}
+
+		error = -EINVAL;
+		if (ldt_info.contents == 3) {
+			if (oldmode)
+				goto out_free;
+			if (ldt_info.seg_not_present == 0)
+				goto out_free;
+		}
+
+		if ((oldmode && !ldt_info.base_addr && !ldt_info.limit) ||
+		    LDT_empty(&ldt_info)) {
+			/* The user wants to clear the entry. */
+			memset(&ldt, 0, sizeof(ldt));
+		} else {
+			if (!IS_ENABLED(CONFIG_X86_16BIT) &&
+			    !ldt_info.seg_32bit) {
+				error = -EINVAL;
+				goto out_free;
+			}
+		}
+
+		fill_ldt(&ldt, &ldt_info);
+		if (oldmode)
+			ldt.avl = 0;
+
+		new_ldt->entries[index++] = ldt;
+	}
 
-	new_ldt->entries[ldt_info.entry_number] = ldt;
 	finalize_ldt_struct(new_ldt);
 
 	/*
@@ -466,20 +489,41 @@ static int write_ldt(void __user *ptr, unsigned long bytecount, int oldmode)
 		 */
 		if (!WARN_ON_ONCE(old_ldt))
 			free_ldt_pgtables(mm);
-		free_ldt_struct(new_ldt);
-		goto out_unlock;
+		goto out_free;
 	}
 
-	install_ldt(mm, new_ldt, ldt_info.entry_number, ldt_info.entry_number);
-	free_ldt_struct(old_ldt);
+	install_ldt(mm, new_ldt, first_index, last_index);
+
+	/* Success! */
+	new_ldt = old_ldt;	/* Free the old LDT, not the new one */
 	error = 0;
 
+out_free:
+	free_ldt_struct(new_ldt);
 out_unlock:
 	up_write(&mm->context.ldt_usr_sem);
-out:
 	return error;
 }
 
+static int write_ldt(void __user *ptr, unsigned long bytecount, bool oldmode)
+{
+	struct user_desc ldt_info;
+
+	/*
+	 * We have to read the LDT entry number from the structure
+	 * ahead of time, so it is not practical to allow more than
+	 * one update here.
+	 */
+	if (bytecount != sizeof(ldt_info))
+		return -EINVAL;
+
+	if (copy_from_user(&ldt_info, ptr, sizeof(ldt_info)))
+		return -EFAULT;
+
+	return do_write_ldt(current, &ldt_info, NULL, sizeof(ldt_info),
+			    ldt_info.entry_number, oldmode);
+}
+
 SYSCALL_DEFINE3(modify_ldt, int , func , void __user * , ptr ,
 		unsigned long , bytecount)
 {
@@ -490,13 +534,13 @@ SYSCALL_DEFINE3(modify_ldt, int , func , void __user * , ptr ,
 		ret = read_ldt(ptr, bytecount);
 		break;
 	case 1:
-		ret = write_ldt(ptr, bytecount, 1);
+		ret = write_ldt(ptr, bytecount, true);
 		break;
 	case 2:
 		ret = read_default_ldt(ptr, bytecount);
 		break;
 	case 0x11:
-		ret = write_ldt(ptr, bytecount, 0);
+		ret = write_ldt(ptr, bytecount, false);
 		break;
 	}
 	/*
@@ -510,3 +554,82 @@ SYSCALL_DEFINE3(modify_ldt, int , func , void __user * , ptr ,
 	 */
 	return (unsigned int)ret;
 }
+
+int regset_ldt_active(struct task_struct *target,
+		      const struct user_regset *regset)
+{
+	struct mm_struct *mm = target->mm;
+	const struct desc_struct *p;
+	int n;
+
+	down_read(&mm->context.ldt_usr_sem);
+
+	if (!mm->context.ldt) {
+		n = 0;
+	} else {
+		n = mm->context.ldt->nr_entries;
+		p = mm->context.ldt->entries + n;
+		while (n > 0 && desc_empty(--p))
+		       n--;
+	}
+
+	up_read(&mm->context.ldt_usr_sem);
+	return n;
+}
+
+int regset_ldt_get(struct task_struct *target,
+		   const struct user_regset *regset,
+		   unsigned int pos, unsigned int count,
+		   void *kbuf, void __user *ubuf)
+{
+	struct mm_struct *mm = target->mm;
+	const struct desc_struct *p;
+	struct user_desc udesc;
+	unsigned int index, nr_entries;
+	int err = 0;
+
+	if (pos % sizeof(struct user_desc))
+		return -EINVAL;
+
+	index = pos/sizeof(struct user_desc);
+
+	down_read(&mm->context.ldt_usr_sem);
+
+	if (!mm->context.ldt) {
+		nr_entries = 0;
+		p = NULL;
+	} else {
+		nr_entries = mm->context.ldt->nr_entries;
+		p = mm->context.ldt->entries + index;
+	}
+
+	while (count >= sizeof(struct user_desc) && index < nr_entries) {
+		fill_user_desc(&udesc, index++, p++);
+		err = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+					  &udesc, pos, pos + sizeof(udesc));
+		if (err)
+			goto out_unlock;
+	}
+
+
+	up_read(&mm->context.ldt_usr_sem);
+
+	return user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
+					nr_entries*sizeof(struct user_desc),
+					LDT_ENTRIES*sizeof(struct user_desc));
+out_unlock:
+	up_read(&mm->context.ldt_usr_sem);
+	return err;
+}
+
+int regset_ldt_set(struct task_struct *target,
+		   const struct user_regset *regset,
+		   unsigned int pos, unsigned int count,
+		   const void *kbuf, const void __user *ubuf)
+{
+	if (pos % sizeof(struct user_desc))
+		return -EINVAL;
+
+	pos /= sizeof(struct user_desc);
+	return do_write_ldt(target, kbuf, ubuf, count, pos, false);
+}
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 5ce10310f440..4400ef506b5d 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -1340,6 +1340,16 @@ static struct user_regset x86_64_regsets[] __ro_after_init = {
 		.active = gdt_active, .get = gdt_get,
 		.set = regset_gdt_set
 	},
+#ifdef CONFIG_MODIFY_LDT_SYSCALL
+	[REGSET_LDT] = {
+		.core_note_type = NT_X86_LDT,
+		.n = LDT_ENTRIES,
+		.size = sizeof(struct user_desc),
+		.align = sizeof(struct user_desc),
+		.active = regset_ldt_active, .get = regset_ldt_get,
+		.set = regset_ldt_set
+	},
+#endif
 };
 
 static const struct user_regset_view user_x86_64_view = {
@@ -1404,6 +1414,16 @@ static struct user_regset x86_32_regsets[] __ro_after_init = {
 		.active = gdt_active,
 		.get = gdt_get, .set = regset_gdt_set
 	},
+#ifdef CONFIG_MODIFY_LDT_SYSCALL
+	[REGSET_LDT] = {
+		.core_note_type = NT_X86_LDT,
+		.n = LDT_ENTRIES,
+		.size = sizeof(struct user_desc),
+		.align = sizeof(struct user_desc),
+		.active = regset_ldt_active,
+		.get = regset_ldt_get, .set = regset_ldt_set
+	},
+#endif
 };
 
 static const struct user_regset_view user_x86_32_view = {
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 8c386906eba8..9d3564fd6daa 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -401,6 +401,7 @@ typedef struct elf64_shdr {
 #define NT_386_IOPERM	0x201		/* x86 io permission bitmap (1=deny) */
 #define NT_X86_XSTATE	0x202		/* x86 extended state using xsave */
 #define NT_X86_GDT	0x203		/* x86 GDT content (user visible) */
+#define NT_X86_LDT	0x204		/* x86 LDT content (if any) */
 #define NT_S390_HIGH_GPRS	0x300	/* s390 upper register halves */
 #define NT_S390_TIMER	0x301		/* s390 timer register */
 #define NT_S390_TODCMP	0x302		/* s390 TOD clock comparator register */
-- 
2.14.4

