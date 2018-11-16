Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1E4C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1662A20869
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Btn2ISmj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1662A20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389562AbeKPU4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:56:22 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:47758 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389532AbeKPU4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 15:56:21 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 1189624E1146;
        Fri, 16 Nov 2018 02:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542365075; bh=5pkZrd6kJ3caL9OXjHwvJuw9JnzWH4BYk+kQM13Wlb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Btn2ISmjfQGzBPQDSgOWxYE7T8rsf67eVS0O8jWjQmHNRll9z5qsPsra5fTaYGJH3
         R5flgujOx5wN/ZKUglexR7TcciSaRnoARmissbHC2neKHl/xUPz8pAwaP77GMGm6kN
         Aljk5kJv0jDqEgitu1aN8jeS/gbBHKrFzCXsxifiR8F4kElVwMiY7R6xdFV519aqjM
         eW5aaU7Sb35J8GMbjLThnurDpnxtJ6/W/18Ne0Xviuz0TfEmrUDdb6DK4maEO3h8dl
         /1xCAJO+gkRpb8tmH/8cvODKOaU3qPXpNfOkO0GvihQ1BgrLZGadZJyA94PdeHL8dl
         qh29SQv50L4zw==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.66])
        by mailhost.synopsys.com (Postfix) with ESMTP id 7340A55A2;
        Fri, 16 Nov 2018 02:44:32 -0800 (PST)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 1/3] ARC: split show_faulting_vma for logic and representation parts
Date:   Fri, 16 Nov 2018 13:44:25 +0300
Message-Id: <20181116104427.25264-2-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181116104427.25264-1-Eugeniy.Paltsev@synopsys.com>
References: <20181116104427.25264-1-Eugeniy.Paltsev@synopsys.com>
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

