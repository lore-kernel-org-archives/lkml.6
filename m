Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2EDC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AB2D204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Q5TgxY+m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AB2D204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbeJ3B7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 21:59:17 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:52794 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbeJ3B7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 21:59:16 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 0F3AE10C031B;
        Mon, 29 Oct 2018 10:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1540832988; bh=5pkZrd6kJ3caL9OXjHwvJuw9JnzWH4BYk+kQM13Wlb0=;
        h=From:To:Cc:Subject:Date:From;
        b=Q5TgxY+mEKKWi9k2QyyqECOTAhl/ZJj5UZTeZA/3Lo9YKaK3MQH5ny3is9XPJ5Gfq
         gTnZ92SOn9vcfkrN9Z2W2R6up9XisgcbmGUIeBHoG1V39c7NHsnF2EewRB1kZLTm3D
         nUN7R7FcT71ayG3ALS9dJNpcUyAachbcG8tUSP0xpmyFkZLgLDLY7TbFKNRJYbbyNM
         Uxswx55TNSzqZt0aFdqfV1leRJA8KA2ihO3KJV0qWEBAnHgB4HKtHU4wWcDwPhtbYU
         SIi7nFVKSBOw3Tzsc3lM50Rilt8aV0/G6/9K6MfdxNvvx90kdhsUDHFq4uBDuAeDEs
         hKzQFHCqCHlzg==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.38])
        by mailhost.synopsys.com (Postfix) with ESMTP id 59DF8363F;
        Mon, 29 Oct 2018 10:09:46 -0700 (PDT)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [RFC v2 1/2] ARC: split show_faulting_vma for logic and representation parts
Date:   Mon, 29 Oct 2018 20:09:40 +0300
Message-Id: <20181029170941.13811-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for introduncing SmaRT support for ARC split
show_faulting_vma() for logic and representation parts to be
able to use logic part in SmaRT code.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/include/asm/bug.h     |  9 +++++++++
 arch/arc/kernel/troubleshoot.c | 43 ++++++++++++++++++++++++++++++------------
 2 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/arch/arc/include/asm/bug.h b/arch/arc/include/asm/bug.h
index b68f7f82f2d8..064391646d38 100644
--- a/arch/arc/include/asm/bug.h
+++ b/arch/arc/include/asm/bug.h
@@ -15,6 +15,15 @@
 
 struct task_struct;
 
+struct faulting_vma_info {
+	char *file_path;
+	unsigned long offset;
+	unsigned long vm_start;
+	unsigned long vm_end;
+};
+
+int get_faulting_vma_info(unsigned long address, char *buf, int buflen,
+			  struct faulting_vma_info *fvma);
 void show_regs(struct pt_regs *regs);
 void show_exception_mesg(struct pt_regs *regs);
 void show_stacktrace(struct task_struct *tsk, struct pt_regs *regs);
diff --git a/arch/arc/kernel/troubleshoot.c b/arch/arc/kernel/troubleshoot.c
index fdfba1942a06..00efcdfde0ee 100644
--- a/arch/arc/kernel/troubleshoot.c
+++ b/arch/arc/kernel/troubleshoot.c
@@ -80,11 +80,14 @@ static void print_task_path_n_nm(struct task_struct *tsk, char *buf)
 	pr_info("Path: %s\n", !IS_ERR(path_nm) ? path_nm : "?");
 }
 
-static void show_faulting_vma(unsigned long address, char *buf)
+int get_faulting_vma_info(unsigned long address, char *buf, int buflen,
+			  struct faulting_vma_info *fvma)
 {
 	struct vm_area_struct *vma;
-	char *nm = buf;
 	struct mm_struct *active_mm = current->active_mm;
+	int ret = -ENOENT;
+
+	fvma->file_path = "?";
 
 	/* can't use print_vma_addr() yet as it doesn't check for
 	 * non-inclusive vma
@@ -97,19 +100,35 @@ static void show_faulting_vma(unsigned long address, char *buf)
 	 */
 	if (vma && (vma->vm_start <= address)) {
 		if (vma->vm_file) {
-			nm = file_path(vma->vm_file, buf, PAGE_SIZE - 1);
-			if (IS_ERR(nm))
-				nm = "?";
+			fvma->file_path = file_path(vma->vm_file, buf, buflen);
+			if (IS_ERR(fvma->file_path))
+				fvma->file_path = "?";
 		}
 
-		pr_cont("[off 0x%lx in %s, VMA: %08lx:%08lx] ",
-			vma->vm_start < TASK_UNMAPPED_BASE ?
-				address : address - vma->vm_start,
-			nm, vma->vm_start, vma->vm_end);
-	} else
-		pr_cont("[No matching VMA found] ");
+		fvma->vm_start = vma->vm_start;
+		fvma->vm_end = vma->vm_end;
+		fvma->offset = vma->vm_start < TASK_UNMAPPED_BASE ?
+				address : address - vma->vm_start;
+
+		ret = 0;
+	}
 
 	up_read(&active_mm->mmap_sem);
+
+	return ret;
+}
+
+static void show_faulting_vma(unsigned long address, char *buf, int buflen)
+{
+	struct faulting_vma_info fvma;
+	int ret;
+
+	ret = get_faulting_vma_info(address, buf, buflen, &fvma);
+	if (ret)
+		pr_cont("[No matching VMA found] ");
+	else
+		pr_cont("[off 0x%lx in %s, VMA: %08lx:%08lx] ", fvma.offset,
+			fvma.file_path, fvma.vm_start, fvma.vm_end);
 }
 
 static void show_ecr_verbose(struct pt_regs *regs)
@@ -175,7 +194,7 @@ static inline void show_exception_mesg_u(struct pt_regs *regs)
 
 	buf = (char *)__get_free_page(GFP_NOWAIT);
 	if (buf) {
-		show_faulting_vma(regs->ret, buf);
+		show_faulting_vma(regs->ret, buf, PAGE_SIZE - 1);
 		free_page((unsigned long)buf);
 	}
 
-- 
2.14.5

