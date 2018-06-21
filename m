Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C7BC43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55713223C2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:18:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55713223C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933417AbeFUVSH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:18:07 -0400
Received: from mga14.intel.com ([192.55.52.115]:27241 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932753AbeFUVSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:18:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2018 14:18:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,253,1526367600"; 
   d="scan'208";a="48912131"
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
Subject: [PATCH v3 6/7] x86/tls,ptrace: provide regset access to the GDT
Date:   Thu, 21 Jun 2018 14:17:53 -0700
Message-Id: <20180621211754.12757-7-h.peter.anvin@intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180621211754.12757-1-h.peter.anvin@intel.com>
References: <20180621211754.12757-1-h.peter.anvin@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin" <hpa@linux.intel.com>

Provide access to the user-visible part of the GDT via a regset in
ptrace().  Note that we already provide a regset for the TLS area part
of the GDT; these can trivially be unified by looking at the contents
of the regset structure, especially since the TLS area is the only
user-modifiable part of the GDT.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Markus T. Metzger <markus.t.metzger@intel.com>
---
 arch/x86/kernel/ptrace.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++--
 arch/x86/kernel/tls.c    | 83 ++++++++++++++++++------------------------------
 arch/x86/kernel/tls.h    |  8 +++--
 include/uapi/linux/elf.h |  1 +
 4 files changed, 118 insertions(+), 57 deletions(-)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index e2ee403865eb..5ce10310f440 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -50,6 +50,7 @@ enum x86_regset {
 	REGSET_XSTATE,
 	REGSET_TLS,
 	REGSET_IOPERM32,
+	REGSET_GDT
 };
 
 struct pt_regs_offset {
@@ -747,6 +748,60 @@ static int ioperm_get(struct task_struct *target,
 				   0, IO_BITMAP_BYTES);
 }
 
+/*
+ * These provide read access to the GDT.  As the only part that is
+ * writable is the TLS area, that code is in tls.c.
+ */
+static int gdt_get(struct task_struct *target,
+		   const struct user_regset *regset,
+		   unsigned int pos, unsigned int count,
+		   void *kbuf, void __user *ubuf)
+{
+	struct desc_struct gdt_copy[GDT_LAST_USER + 1];
+	const struct desc_struct *p;
+	struct user_desc udesc;
+	unsigned int index, endindex;
+	int err;
+
+	if (pos % sizeof(struct user_desc))
+		return -EINVAL;
+
+	/* Get a snapshot of the GDT from an arbitrary CPU */
+	memcpy(gdt_copy, get_current_gdt_ro(), sizeof(gdt_copy));
+
+	/* Copy over the TLS area */
+	memcpy(&gdt_copy[GDT_ENTRY_TLS_MIN], target->thread.tls_array,
+	       sizeof(target->thread.tls_array));
+
+	/* Descriptor zero is never accessible */
+	memset(&gdt_copy[0], 0, sizeof(gdt_copy[0]));
+
+	index = pos/sizeof(struct user_desc);
+	endindex = index + count/sizeof(struct user_desc);
+	endindex = min_t(unsigned int, GDT_LAST_USER + 1 - regset->bias,
+			endindex);
+
+	p = &gdt_copy[index + regset->bias];
+
+	while (count && index < endindex) {
+		fill_user_desc(&udesc, index++, p++);
+		err = user_regset_copyout(&pos, &count, &kbuf, &ubuf, &udesc,
+					 pos, pos + sizeof(udesc));
+		if (err)
+			return err;
+	}
+
+	/* Return zero for the rest of the regset, if applicable. */
+	return user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf, 0, -1);
+}
+
+static int gdt_active(struct task_struct  *target,
+		      const struct user_regset *regset)
+{
+	(void)target;
+	return GDT_LAST_USER + 1;
+}
+
 /*
  * Called by kernel/ptrace.c when detaching..
  *
@@ -1262,7 +1317,8 @@ static struct user_regset x86_64_regsets[] __ro_after_init = {
 		.core_note_type = NT_PRFPREG,
 		.n = sizeof(struct user_i387_struct) / sizeof(long),
 		.size = sizeof(long), .align = sizeof(long),
-		.active = regset_xregset_fpregs_active, .get = xfpregs_get, .set = xfpregs_set
+		.active = regset_xregset_fpregs_active, .get = xfpregs_get,
+		.set = xfpregs_set
 	},
 	[REGSET_XSTATE] = {
 		.core_note_type = NT_X86_XSTATE,
@@ -1276,6 +1332,14 @@ static struct user_regset x86_64_regsets[] __ro_after_init = {
 		.size = sizeof(long), .align = sizeof(long),
 		.active = ioperm_active, .get = ioperm_get
 	},
+	[REGSET_GDT] = {
+		.core_note_type = NT_X86_GDT,
+		.n = LDT_ENTRIES, /* Theoretical maximum */
+		.size = sizeof(struct user_desc),
+		.align = sizeof(struct user_desc),
+		.active = gdt_active, .get = gdt_get,
+		.set = regset_gdt_set
+	},
 };
 
 static const struct user_regset_view user_x86_64_view = {
@@ -1309,7 +1373,8 @@ static struct user_regset x86_32_regsets[] __ro_after_init = {
 		.core_note_type = NT_PRXFPREG,
 		.n = sizeof(struct user32_fxsr_struct) / sizeof(u32),
 		.size = sizeof(u32), .align = sizeof(u32),
-		.active = regset_xregset_fpregs_active, .get = xfpregs_get, .set = xfpregs_set
+		.active = regset_xregset_fpregs_active, .get = xfpregs_get,
+		.set = xfpregs_set
 	},
 	[REGSET_XSTATE] = {
 		.core_note_type = NT_X86_XSTATE,
@@ -1323,7 +1388,7 @@ static struct user_regset x86_32_regsets[] __ro_after_init = {
 		.size = sizeof(struct user_desc),
 		.align = sizeof(struct user_desc),
 		.active = regset_tls_active,
-		.get = regset_tls_get, .set = regset_tls_set
+		.get = gdt_get, .set = regset_gdt_set
 	},
 	[REGSET_IOPERM32] = {
 		.core_note_type = NT_386_IOPERM,
@@ -1331,6 +1396,14 @@ static struct user_regset x86_32_regsets[] __ro_after_init = {
 		.size = sizeof(u32), .align = sizeof(u32),
 		.active = ioperm_active, .get = ioperm_get
 	},
+	[REGSET_GDT] = {
+		.core_note_type = NT_X86_GDT,
+		.n = LDT_ENTRIES, /* Theoretical maximum */
+		.size = sizeof(struct user_desc),
+		.align = sizeof(struct user_desc),
+		.active = gdt_active,
+		.get = gdt_get, .set = regset_gdt_set
+	},
 };
 
 static const struct user_regset_view user_x86_32_view = {
@@ -1399,3 +1472,7 @@ void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs,
 	/* Send us the fake SIGTRAP */
 	force_sig_info(SIGTRAP, &info, tsk);
 }
+
+/*
+ * Copy out a set of segment descriptors in user_desc format.
+ */
diff --git a/arch/x86/kernel/tls.c b/arch/x86/kernel/tls.c
index 7b8ecb760707..fd8aa21654ff 100644
--- a/arch/x86/kernel/tls.c
+++ b/arch/x86/kernel/tls.c
@@ -231,67 +231,46 @@ int regset_tls_active(struct task_struct *target,
 	return n;
 }
 
-int regset_tls_get(struct task_struct *target, const struct user_regset *regset,
-		   unsigned int pos, unsigned int count,
-		   void *kbuf, void __user *ubuf)
-{
-	const struct desc_struct *tls;
-
-	if (pos >= GDT_ENTRY_TLS_ENTRIES * sizeof(struct user_desc) ||
-	    (pos % sizeof(struct user_desc)) != 0 ||
-	    (count % sizeof(struct user_desc)) != 0)
-		return -EINVAL;
-
-	pos /= sizeof(struct user_desc);
-	count /= sizeof(struct user_desc);
-
-	tls = &target->thread.tls_array[pos];
-
-	if (kbuf) {
-		struct user_desc *info = kbuf;
-		while (count-- > 0)
-			fill_user_desc(info++, GDT_ENTRY_TLS_MIN + pos++,
-				       tls++);
-	} else {
-		struct user_desc __user *u_info = ubuf;
-		while (count-- > 0) {
-			struct user_desc info;
-			fill_user_desc(&info, GDT_ENTRY_TLS_MIN + pos++, tls++);
-			if (__copy_to_user(u_info++, &info, sizeof(info)))
-				return -EFAULT;
-		}
-	}
-
-	return 0;
-}
-
-int regset_tls_set(struct task_struct *target, const struct user_regset *regset,
+/* The only part of the GDT that is settable is the TLS area */
+int regset_gdt_set(struct task_struct *target,
+		   const struct user_regset *regset,
 		   unsigned int pos, unsigned int count,
 		   const void *kbuf, const void __user *ubuf)
 {
 	struct user_desc infobuf[GDT_ENTRY_TLS_ENTRIES];
-	const struct user_desc *info;
-	int i;
-
-	if (pos >= GDT_ENTRY_TLS_ENTRIES * sizeof(struct user_desc) ||
-	    (pos % sizeof(struct user_desc)) != 0 ||
-	    (count % sizeof(struct user_desc)) != 0)
+	const struct user_desc * const info = infobuf;
+	const unsigned int minpos =
+		GDT_ENTRY_TLS_MIN * sizeof(struct user_desc);
+	const unsigned int maxpos =
+		(GDT_ENTRY_TLS_MAX+1) * sizeof(struct user_desc);
+	int err;
+	unsigned int index, ntls, i;
+
+	if (pos % sizeof(struct user_desc))
 		return -EINVAL;
 
-	if (kbuf)
-		info = kbuf;
-	else if (__copy_from_user(infobuf, ubuf, count))
-		return -EFAULT;
-	else
-		info = infobuf;
+	pos += regset->bias * sizeof(struct user_desc);
+
+	/* Ignore entries before the TLS region */
+	err = user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf, 0, minpos);
+	if (err)
+		return err;
 
-	for (i = 0; i < count / sizeof(struct user_desc); i++)
-		if (!tls_desc_okay(info + i))
+	/* Load the TLS descriptor information */
+	index = pos/sizeof(struct user_desc);
+	ntls = count/sizeof(struct user_desc);
+	ntls  = min_t(unsigned int, GDT_ENTRY_TLS_ENTRIES, ntls);
+	err = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				infobuf, minpos, maxpos);
+	if (err)
+		return err;
+
+	for (i = 0; i < ntls; i++) {
+		if (!tls_desc_okay(&info[i]))
 			return -EINVAL;
+	}
 
-	set_tls_desc(target,
-		     GDT_ENTRY_TLS_MIN + (pos / sizeof(struct user_desc)),
-		     info, count / sizeof(struct user_desc));
+	set_tls_desc(target, index, info, ntls);
 
 	return 0;
 }
diff --git a/arch/x86/kernel/tls.h b/arch/x86/kernel/tls.h
index 2f083a2fe216..936680e904d0 100644
--- a/arch/x86/kernel/tls.h
+++ b/arch/x86/kernel/tls.h
@@ -14,8 +14,12 @@
 
 #include <linux/regset.h>
 
+#ifdef CONFIG_X86_TLS_AREA
 extern user_regset_active_fn regset_tls_active;
-extern user_regset_get_fn regset_tls_get;
-extern user_regset_set_fn regset_tls_set;
+extern user_regset_set_fn regset_gdt_set;
+#else
+#define regset_tls_active NULL
+#define regset_gdt_set NULL
+#endif
 
 #endif	/* _ARCH_X86_KERNEL_TLS_H */
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 4e12c423b9fe..8c386906eba8 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -400,6 +400,7 @@ typedef struct elf64_shdr {
 #define NT_386_TLS	0x200		/* i386 TLS slots (struct user_desc) */
 #define NT_386_IOPERM	0x201		/* x86 io permission bitmap (1=deny) */
 #define NT_X86_XSTATE	0x202		/* x86 extended state using xsave */
+#define NT_X86_GDT	0x203		/* x86 GDT content (user visible) */
 #define NT_S390_HIGH_GPRS	0x300	/* s390 upper register halves */
 #define NT_S390_TIMER	0x301		/* s390 timer register */
 #define NT_S390_TODCMP	0x302		/* s390 TOD clock comparator register */
-- 
2.14.4

