Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE0AECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E4F20846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0E4F20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388113AbeGWMUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 08:20:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:57208 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387843AbeGWMUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 08:20:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D2A27AEDA;
        Mon, 23 Jul 2018 11:19:49 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Daniel Colascione <dancol@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-api@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 2/4] mm: proc/pid/smaps: factor out mem stats gathering
Date:   Mon, 23 Jul 2018 13:19:31 +0200
Message-Id: <20180723111933.15443-3-vbabka@suse.cz>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723111933.15443-1-vbabka@suse.cz>
References: <20180723111933.15443-1-vbabka@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prepare for handling /proc/pid/smaps_rollup differently from /proc/pid/smaps
factor out vma mem stats gathering from show_smap() - it will be used by both.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 fs/proc/task_mmu.c | 55 ++++++++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 24 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index a3f98ca50981..d2ca88c92d9d 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -702,14 +702,9 @@ static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
 }
 #endif /* HUGETLB_PAGE */
 
-#define SEQ_PUT_DEC(str, val) \
-		seq_put_decimal_ull_width(m, str, (val) >> 10, 8)
-static int show_smap(struct seq_file *m, void *v)
+static void smap_gather_stats(struct vm_area_struct *vma,
+			     struct mem_size_stats *mss)
 {
-	struct proc_maps_private *priv = m->private;
-	struct vm_area_struct *vma = v;
-	struct mem_size_stats mss_stack;
-	struct mem_size_stats *mss;
 	struct mm_walk smaps_walk = {
 		.pmd_entry = smaps_pte_range,
 #ifdef CONFIG_HUGETLB_PAGE
@@ -717,23 +712,6 @@ static int show_smap(struct seq_file *m, void *v)
 #endif
 		.mm = vma->vm_mm,
 	};
-	int ret = 0;
-	bool rollup_mode;
-	bool last_vma;
-
-	if (priv->rollup) {
-		rollup_mode = true;
-		mss = priv->rollup;
-		if (mss->first) {
-			mss->first_vma_start = vma->vm_start;
-			mss->first = false;
-		}
-		last_vma = !m_next_vma(priv, vma);
-	} else {
-		rollup_mode = false;
-		memset(&mss_stack, 0, sizeof(mss_stack));
-		mss = &mss_stack;
-	}
 
 	smaps_walk.private = mss;
 
@@ -765,6 +743,35 @@ static int show_smap(struct seq_file *m, void *v)
 	walk_page_vma(vma, &smaps_walk);
 	if (vma->vm_flags & VM_LOCKED)
 		mss->pss_locked += mss->pss;
+}
+
+#define SEQ_PUT_DEC(str, val) \
+		seq_put_decimal_ull_width(m, str, (val) >> 10, 8)
+static int show_smap(struct seq_file *m, void *v)
+{
+	struct proc_maps_private *priv = m->private;
+	struct vm_area_struct *vma = v;
+	struct mem_size_stats mss_stack;
+	struct mem_size_stats *mss;
+	int ret = 0;
+	bool rollup_mode;
+	bool last_vma;
+
+	if (priv->rollup) {
+		rollup_mode = true;
+		mss = priv->rollup;
+		if (mss->first) {
+			mss->first_vma_start = vma->vm_start;
+			mss->first = false;
+		}
+		last_vma = !m_next_vma(priv, vma);
+	} else {
+		rollup_mode = false;
+		memset(&mss_stack, 0, sizeof(mss_stack));
+		mss = &mss_stack;
+	}
+
+	smap_gather_stats(vma, mss);
 
 	if (!rollup_mode) {
 		show_map_vma(m, vma);
-- 
2.18.0

