Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA255C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 23:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC3B223A4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 23:36:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CC3B223A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbeHJCDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 22:03:46 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:47492 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726979AbeHJCDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 22:03:46 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0T6MWc.W_1533857777;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T6MWc.W_1533857777)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Aug 2018 07:36:27 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mhocko@kernel.org, willy@infradead.org, ldufour@linux.vnet.ibm.com,
        kirill@shutemov.name, vbabka@suse.cz, akpm@linux-foundation.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC v7 PATCH 3/4] uprobes: make vma_has_uprobes non-static
Date:   Fri, 10 Aug 2018 07:36:02 +0800
Message-Id: <1533857763-43527-4-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1533857763-43527-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1533857763-43527-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vma_has_uprobes() will be used in the following patch to check if a vma
could be unmapped with holding read mmap_sem, but it is static. So, make
it non-static to use outside uprobe.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 include/linux/uprobes.h | 7 +++++++
 kernel/events/uprobes.c | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 0a294e9..caeb26b 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -149,6 +149,8 @@ struct uprobes_state {
 extern bool arch_uprobe_ignore(struct arch_uprobe *aup, struct pt_regs *regs);
 extern void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 					 void *src, unsigned long len);
+extern bool vma_has_uprobes(struct vm_area_struct *vma, unsigned long start,
+			    unsigned long end);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
 };
@@ -203,5 +205,10 @@ static inline void uprobe_copy_process(struct task_struct *t, unsigned long flag
 static inline void uprobe_clear_state(struct mm_struct *mm)
 {
 }
+static inline bool vma_has_uprobes(struct vm_area_struct *vma, unsigned long start,
+				   unsigned long end)
+{
+	return false;
+}
 #endif /* !CONFIG_UPROBES */
 #endif	/* _LINUX_UPROBES_H */
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index ccc579a..4880c46 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1095,7 +1095,7 @@ int uprobe_mmap(struct vm_area_struct *vma)
 	return 0;
 }
 
-static bool
+bool
 vma_has_uprobes(struct vm_area_struct *vma, unsigned long start, unsigned long end)
 {
 	loff_t min, max;
-- 
1.8.3.1

