Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386B4C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31D020882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E31D020882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbeILS34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 14:29:56 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:40494 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727332AbeILS3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 14:29:55 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07437672|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03308;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.CpvdKzK_1536758710;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CpvdKzK_1536758710)
          by smtp.aliyun-inc.com(10.147.41.158);
          Wed, 12 Sep 2018 21:25:10 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, arnd@arndb.de, devicetree@vger.kernel.org,
        andrea.parri@amarulasolutions.com, peterz@infradead.org
Cc:     c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, ren_guo@c-sky.com,
        green.hu@gmail.com
Subject: [PATCH V3 09/27] csky: VDSO and rt_sigreturn
Date:   Wed, 12 Sep 2018 21:24:43 +0800
Message-Id: <84b9dbc12dbd64c424d81356bce15bdde4c54eb8.1536757532.git.ren_guo@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1536757532.git.ren_guo@c-sky.com>
References: <cover.1536757532.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1536757532.git.ren_guo@c-sky.com>
References: <cover.1536757532.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/abiv1/inc/abi/vdso.h | 17 +++++++++
 arch/csky/abiv2/inc/abi/vdso.h | 24 ++++++++++++
 arch/csky/include/asm/vdso.h   | 12 ++++++
 arch/csky/kernel/vdso.c        | 85 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 138 insertions(+)
 create mode 100644 arch/csky/abiv1/inc/abi/vdso.h
 create mode 100644 arch/csky/abiv2/inc/abi/vdso.h
 create mode 100644 arch/csky/include/asm/vdso.h
 create mode 100644 arch/csky/kernel/vdso.c

diff --git a/arch/csky/abiv1/inc/abi/vdso.h b/arch/csky/abiv1/inc/abi/vdso.h
new file mode 100644
index 0000000..a99f0e4
--- /dev/null
+++ b/arch/csky/abiv1/inc/abi/vdso.h
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/uaccess.h>
+
+static inline int setup_vdso_page(unsigned short *ptr)
+{
+	int err = 0;
+
+	/* movi r1, 127 */
+	err |= __put_user(0x67f1, ptr + 0);
+	/* addi r1, (139 - 127) */
+	err |= __put_user(0x20b1, ptr + 1);
+	/* trap 0 */
+	err |= __put_user(0x0008, ptr + 2);
+
+	return err;
+}
diff --git a/arch/csky/abiv2/inc/abi/vdso.h b/arch/csky/abiv2/inc/abi/vdso.h
new file mode 100644
index 0000000..2b5f43b
--- /dev/null
+++ b/arch/csky/abiv2/inc/abi/vdso.h
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#ifndef __ABI_CSKY_VDSO_H
+#define __ABI_CSKY_VDSO_H
+
+#include <linux/uaccess.h>
+
+static inline int setup_vdso_page(unsigned short *ptr)
+{
+	int err = 0;
+
+	/* movi r7, 173 */
+	err |= __put_user(0xea07, ptr);
+	err |= __put_user(0x008b,      ptr+1);
+
+	/* trap 0 */
+	err |= __put_user(0xc000,   ptr+2);
+	err |= __put_user(0x2020,   ptr+3);
+
+	return err;
+}
+
+#endif /* __ABI_CSKY_STRING_H */
diff --git a/arch/csky/include/asm/vdso.h b/arch/csky/include/asm/vdso.h
new file mode 100644
index 0000000..b275440
--- /dev/null
+++ b/arch/csky/include/asm/vdso.h
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#ifndef __ASM_CSKY_VDSO_H
+#define __ASM_CSKY_VDSO_H
+
+#include <abi/vdso.h>
+
+struct csky_vdso {
+	unsigned short rt_signal_retcode[4];
+};
+
+#endif /* __ASM_CSKY_VDSO_H */
diff --git a/arch/csky/kernel/vdso.c b/arch/csky/kernel/vdso.c
new file mode 100644
index 0000000..55ed68b
--- /dev/null
+++ b/arch/csky/kernel/vdso.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#include <linux/kernel.h>
+#include <linux/err.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/init.h>
+#include <linux/binfmts.h>
+#include <linux/elf.h>
+#include <linux/vmalloc.h>
+#include <linux/unistd.h>
+#include <linux/uaccess.h>
+
+#include <asm/vdso.h>
+#include <asm/cacheflush.h>
+
+static struct page *vdso_page;
+
+static int __init init_vdso(void)
+{
+	struct csky_vdso *vdso;
+	int err = 0;
+
+	vdso_page = alloc_page(GFP_KERNEL);
+	if (!vdso_page)
+		panic("Cannot allocate vdso");
+
+	vdso = vmap(&vdso_page, 1, 0, PAGE_KERNEL);
+	if (!vdso)
+		panic("Cannot map vdso");
+
+	clear_page(vdso);
+
+	err = setup_vdso_page(vdso->rt_signal_retcode);
+	if (err) panic("Cannot set signal return code, err: %x.", err);
+
+	dcache_wb_range((unsigned long)vdso, (unsigned long)vdso + 16);
+
+	vunmap(vdso);
+
+	return 0;
+}
+subsys_initcall(init_vdso);
+
+int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
+{
+	int ret;
+	unsigned long addr;
+	struct mm_struct *mm = current->mm;
+
+	down_write(&mm->mmap_sem);
+
+	addr = get_unmapped_area(NULL, STACK_TOP, PAGE_SIZE, 0, 0);
+	if (IS_ERR_VALUE(addr)) {
+		ret = addr;
+		goto up_fail;
+	}
+
+	ret = install_special_mapping(
+			mm,
+			addr,
+			PAGE_SIZE,
+			VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
+			&vdso_page);
+	if (ret)
+		goto up_fail;
+
+	mm->context.vdso = (void *)addr;
+
+up_fail:
+	up_write(&mm->mmap_sem);
+	return ret;
+}
+
+const char *arch_vma_name(struct vm_area_struct *vma)
+{
+	if (vma->vm_mm == NULL)
+		return NULL;
+
+	if (vma->vm_start == (long)vma->vm_mm->context.vdso)
+		return "[vdso]";
+	else
+		return NULL;
+}
-- 
2.7.4

