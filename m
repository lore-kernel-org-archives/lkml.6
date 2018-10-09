Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B32C64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 20:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A7E214DC
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 20:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="BeoElXDl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5A7E214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbeJJDdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 23:33:19 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45767 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbeJJDdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 23:33:18 -0400
Received: by mail-pl1-f194.google.com with SMTP id y15-v6so1350777plr.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 13:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V18Z3eBngl64nu3A+zrmzE7Etk3mR/lRybg06jtcvaQ=;
        b=BeoElXDlJzTZzVxV/Ugq+efw1Z1UhukGXfG0nBm39VLNGuUIQGhfUStb8xl10LFnn1
         QvM/8w5aImUG7sgfTeytSBUunMi6mULgs9DC2NDSmrWZBr6lQTLjxT0blWXN8tzL+/0g
         mjdqRhLnuChSYvjtl1k/nNhL4+gdGnOT67yDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V18Z3eBngl64nu3A+zrmzE7Etk3mR/lRybg06jtcvaQ=;
        b=jcCQb3zUA8HzG4UsiHbK353+HG63+OpPY6BnGJxx+jTBYJvt8xYWoVe3FhxdBu8C0h
         3/dn2cq75bq+ccghoix2rEALPMgOBxhHQOsak6a4XQjqmcJoh8Skck2lqo+85vqxnO+u
         DIkSlK4IrXiSd855fMkKy3B7zr1fMdRYXzCyM5ckLSYr5J8rjQpd9ionYeHSPr64ohSR
         Rtp+E4zOjzYhRmx+GEdAOe3jILzZIqjAbPrl1xnv94CHeuWEMhXZFr6hWKX/yAWMYx7j
         /vm2wenwU+8IKcxmhjIx6YU97jwbK9SM7ugatwqeDp2B7NAeu/UzoGqiGUnwdk+AF8eR
         RL5Q==
X-Gm-Message-State: ABuFfohAuHURwyMsvO2RxcqjMkzhc0EiqoBdDQFjaESE749TTQxVykDb
        Rgu4Y3D/6/s3cFhk+GjB2Z/WCj0f+78=
X-Google-Smtp-Source: ACcGV61V0RCzBgoeI8y85vA2psUTe3/j++wWW2JskMRkOixECYpMBrd8kiRPSIdV29vesF4/SmKLJQ==
X-Received: by 2002:a17:902:8543:: with SMTP id d3-v6mr30716888plo.81.1539116079648;
        Tue, 09 Oct 2018 13:14:39 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id z4-v6sm25555664pgs.50.2018.10.09.13.14.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 13:14:31 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     kernel-team@android.com, Joel Fernandes <joel@joelfernandes.org>,
        minchan@google.com, hughd@google.com, lokeshgidra@google.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] mm: Speed up mremap on large regions
Date:   Tue,  9 Oct 2018 13:14:00 -0700
Message-Id: <20181009201400.168705-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Android needs to mremap large regions of memory during memory management
related operations. The mremap system call can be really slow if THP is
not enabled. The bottleneck is move_page_tables, which is copying each
pte at a time, and can be really slow across a large map. Turning on THP
may not be a viable option, and is not for us. This patch speeds up the
performance for non-THP system by copying at the PMD level when possible.

The speed up is three orders of magnitude. On a 1GB mremap, the mremap
completion times drops from 160-250 millesconds to 380-400 microseconds.

Before:
Total mremap time for 1GB data: 242321014 nanoseconds.
Total mremap time for 1GB data: 196842467 nanoseconds.
Total mremap time for 1GB data: 167051162 nanoseconds.

After:
Total mremap time for 1GB data: 385781 nanoseconds.
Total mremap time for 1GB data: 388959 nanoseconds.
Total mremap time for 1GB data: 402813 nanoseconds.

Incase THP is enabled, the optimization is skipped. I also flush the
tlb every time we do this optimization since I couldn't find a way to
determine if the low-level PTEs are dirty. It is seen that the cost of
doing so is not much compared the improvement, on both x86-64 and arm64.

Cc: minchan@google.com
Cc: hughd@google.com
Cc: lokeshgidra@google.com
Cc: kernel-team@android.com
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 mm/mremap.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/mm/mremap.c b/mm/mremap.c
index 5c2e18505f75..68ddc9e9dfde 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -191,6 +191,54 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 		drop_rmap_locks(vma);
 }
 
+bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
+		  unsigned long new_addr, unsigned long old_end,
+		  pmd_t *old_pmd, pmd_t *new_pmd, bool *need_flush)
+{
+	spinlock_t *old_ptl, *new_ptl;
+	struct mm_struct *mm = vma->vm_mm;
+
+	if ((old_addr & ~PMD_MASK) || (new_addr & ~PMD_MASK)
+	    || old_end - old_addr < PMD_SIZE)
+		return false;
+
+	/*
+	 * The destination pmd shouldn't be established, free_pgtables()
+	 * should have release it.
+	 */
+	if (WARN_ON(!pmd_none(*new_pmd)))
+		return false;
+
+	/*
+	 * We don't have to worry about the ordering of src and dst
+	 * ptlocks because exclusive mmap_sem prevents deadlock.
+	 */
+	old_ptl = pmd_lock(vma->vm_mm, old_pmd);
+	if (old_ptl) {
+		pmd_t pmd;
+
+		new_ptl = pmd_lockptr(mm, new_pmd);
+		if (new_ptl != old_ptl)
+			spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
+
+		/* Clear the pmd */
+		pmd = *old_pmd;
+		pmd_clear(old_pmd);
+
+		VM_BUG_ON(!pmd_none(*new_pmd));
+
+		/* Set the new pmd */
+		set_pmd_at(mm, new_addr, new_pmd, pmd);
+		if (new_ptl != old_ptl)
+			spin_unlock(new_ptl);
+		spin_unlock(old_ptl);
+
+		*need_flush = true;
+		return true;
+	}
+	return false;
+}
+
 unsigned long move_page_tables(struct vm_area_struct *vma,
 		unsigned long old_addr, struct vm_area_struct *new_vma,
 		unsigned long new_addr, unsigned long len,
@@ -239,7 +287,21 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 			split_huge_pmd(vma, old_pmd, old_addr);
 			if (pmd_trans_unstable(old_pmd))
 				continue;
+		} else if (extent == PMD_SIZE) {
+			bool moved;
+
+			/* See comment in move_ptes() */
+			if (need_rmap_locks)
+				take_rmap_locks(vma);
+			moved = move_normal_pmd(vma, old_addr, new_addr,
+					old_end, old_pmd, new_pmd,
+					&need_flush);
+			if (need_rmap_locks)
+				drop_rmap_locks(vma);
+			if (moved)
+				continue;
 		}
+
 		if (pte_alloc(new_vma->vm_mm, new_pmd, new_addr))
 			break;
 		next = (new_addr + PMD_SIZE) & PMD_MASK;
-- 
2.19.0.605.g01d371f741-goog

