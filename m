Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB5FC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 18:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 478E221528
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 18:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 478E221528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbeHOVnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 17:43:47 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:60899 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727592AbeHOVnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 17:43:46 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0T6gJtNa_1534358999;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T6gJtNa_1534358999)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 16 Aug 2018 02:50:07 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mhocko@kernel.org, willy@infradead.org, ldufour@linux.vnet.ibm.com,
        kirill@shutemov.name, vbabka@suse.cz, akpm@linux-foundation.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC v8 PATCH 2/5] uprobes: introduce has_uprobes helper
Date:   Thu, 16 Aug 2018 02:49:47 +0800
Message-Id: <1534358990-85530-3-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1534358990-85530-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1534358990-85530-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need check if mm or vma has uprobes in the following patch to check
if a vma could be unmapped with holding read mmap_sem. The checks and
pre-conditions used by uprobe_munmap() look just suitable for this
purpose.

Extracting those checks into a helper function, has_uprobes().

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 include/linux/uprobes.h |  7 +++++++
 kernel/events/uprobes.c | 23 ++++++++++++++++-------
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 0a294e9..418764e 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -149,6 +149,8 @@ struct uprobes_state {
 extern bool arch_uprobe_ignore(struct arch_uprobe *aup, struct pt_regs *regs);
 extern void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 					 void *src, unsigned long len);
+extern bool has_uprobes(struct vm_area_struct *vma, unsigned long start,
+			unsigned long end);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
 };
@@ -203,5 +205,10 @@ static inline void uprobe_copy_process(struct task_struct *t, unsigned long flag
 static inline void uprobe_clear_state(struct mm_struct *mm)
 {
 }
+static inline bool has_uprobes(struct vm_area_struct *vma, unsigned long start,
+			       unsgined long end)
+{
+	return false;
+}
 #endif /* !CONFIG_UPROBES */
 #endif	/* _LINUX_UPROBES_H */
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index aed1ba5..568481c 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1114,22 +1114,31 @@ int uprobe_mmap(struct vm_area_struct *vma)
 	return !!n;
 }
 
-/*
- * Called in context of a munmap of a vma.
- */
-void uprobe_munmap(struct vm_area_struct *vma, unsigned long start, unsigned long end)
+bool
+has_uprobes(struct vm_area_struct *vma, unsigned long start, unsigned long end)
 {
 	if (no_uprobe_events() || !valid_vma(vma, false))
-		return;
+		return false;
 
 	if (!atomic_read(&vma->vm_mm->mm_users)) /* called by mmput() ? */
-		return;
+		return false;
 
 	if (!test_bit(MMF_HAS_UPROBES, &vma->vm_mm->flags) ||
 	     test_bit(MMF_RECALC_UPROBES, &vma->vm_mm->flags))
-		return;
+		return false;
 
 	if (vma_has_uprobes(vma, start, end))
+		return true;
+
+	return false;
+}
+
+/*
+ * Called in context of a munmap of a vma.
+ */
+void uprobe_munmap(struct vm_area_struct *vma, unsigned long start, unsigned long end)
+{
+	if (has_uprobes(vma, start, end))
 		set_bit(MMF_RECALC_UPROBES, &vma->vm_mm->flags);
 }
 
-- 
1.8.3.1

