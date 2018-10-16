Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46191C169D4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 004BD2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYUM7y/k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 004BD2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbeJPVEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 17:04:38 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35758 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeJPVEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 17:04:38 -0400
Received: by mail-pl1-f195.google.com with SMTP id f8-v6so11034027plb.2;
        Tue, 16 Oct 2018 06:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b8n7ekTz4I5WPtItNykHetIxRP9150gP8kPb0BQtO90=;
        b=WYUM7y/kL8/+heRnnym3+/pjQXjKvyJ+4vExqnWSUKAt5OCcPWLDKAyjYXXX+3tTNR
         T6b0g4t9dmXMbmx3FIvcAqX7O329x5zhDruzeal6OmBiza0FOgjbU1RMeljPcpkbKp0/
         TFo8sX1VGUzkmoHiR1PFKoUwS+KpHNocpFVRrcfhk+rx6fduiPzvcVAXqnIL0cBl6THr
         hbVSz2bbtVDrUnEsJdSAy25sFuItTMKF0xRIJvWJnmBDgjGpCixgOlx4aG9rDmg6RsAx
         /uuAKEyJO8ldmQhR9iNJHXbr4spuqd6ROpfB/V469ofmS6CbDMXdpP6hxlUKVxCe5x+R
         3iTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b8n7ekTz4I5WPtItNykHetIxRP9150gP8kPb0BQtO90=;
        b=JABkrTjsCY4jxWGWuKpGOycfuoBON09Lbe6PlZThTUYLz6CJCGUO4lSy7aDpdmmTVk
         FVo/DomaaE5RzYk2p01G2LjwSBDLYkXdwposIQ0zvpUZPTcQR7W9fMIh9jSG1kXC6VTo
         TX7/ogiKXGnUMUnpQL6KtO0znT5nXhi+N8Ht+FRfegu2J4DaqUUyrYtGQ9M6jy/Vy2hq
         KIdu4Fug8LW+iXSDjM/SAMuEbx3qsH0AabkKH90cu9Cy+ze7k0YyHeZ7Qff+K7OO73IT
         53YbZ8ucFwigv2p62g74QTmitXcZ7yrbx+0JTVNHHBPYT8SxvTixfmF7dG94PvurmNHS
         nnLA==
X-Gm-Message-State: ABuFfogXmanZdGEx2/p0+kpg0HxoM3jCcB3hbp+c2tl+/TOOZyxJS50k
        St0FQidrzfWRzGo+wVGWibc=
X-Google-Smtp-Source: ACcGV63ooqapdfib9rvEhAj6eX85EavZn0yGkIHSWlSmi1u/6UNdDgdZJZkJZsL5NL3zvWoE/2y3vA==
X-Received: by 2002:a17:902:4681:: with SMTP id p1-v6mr13592768pld.97.1539695651671;
        Tue, 16 Oct 2018 06:14:11 -0700 (PDT)
Received: from roar.local0.net ([60.240.252.156])
        by smtp.gmail.com with ESMTPSA id j62-v6sm16043423pgd.40.2018.10.16.06.14.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 06:14:11 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>
Subject: [PATCH v2 3/5] mm/cow: optimise pte accessed bit handling in fork
Date:   Tue, 16 Oct 2018 23:13:41 +1000
Message-Id: <20181016131343.20556-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181016131343.20556-1-npiggin@gmail.com>
References: <20181016131343.20556-1-npiggin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fork clears dirty/accessed bits from new ptes in the child. This logic
has existed since mapped page reclaim was done by scanning ptes when
it may have been quite important. Today with physical based pte
scanning, there is less reason to clear these bits, so this patch
avoids clearing the accessed bit in the child.

Any accessed bit is treated similarly to many, with the difference
today with > 1 referenced bit causing the page to be activated, while
1 bit causes it to be kept. This patch causes pages shared by fork(2)
to be more readily activated, but this heuristic is very fuzzy anyway
-- a page can be accessed by multiple threads via a single pte and be
just as important as one that is accessed via multiple ptes, for
example. In the end I don't believe fork(2) is a significant driver of
page reclaim behaviour that this should matter too much.

This and the following change eliminate a major source of faults that
powerpc/radix requires to set dirty/accessed bits in ptes, speeding
up a fork/exit microbenchmark by about 5% on POWER9 (16600 -> 17500
fork/execs per second).

Skylake appears to have a micro-fault overhead too -- a test which
allocates 4GB anonymous memory, reads each page, then forks, and times
the child reading a byte from each page. The first pass over the pages
takes about 1000 cycles per page, the second pass takes about 27
cycles (TLB miss). With no additional minor faults measured due to
either child pass, and the page array well exceeding TLB capacity, the
large cost must be caused by micro faults caused by setting accessed
bit.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 mm/huge_memory.c | 2 --
 mm/memory.c      | 1 -
 mm/vmscan.c      | 8 ++++++++
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0fb0e3025f98..1f43265204d4 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -977,7 +977,6 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		pmdp_set_wrprotect(src_mm, addr, src_pmd);
 		pmd = pmd_wrprotect(pmd);
 	}
-	pmd = pmd_mkold(pmd);
 	set_pmd_at(dst_mm, addr, dst_pmd, pmd);
 
 	ret = 0;
@@ -1071,7 +1070,6 @@ int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		pudp_set_wrprotect(src_mm, addr, src_pud);
 		pud = pud_wrprotect(pud);
 	}
-	pud = pud_mkold(pud);
 	set_pud_at(dst_mm, addr, dst_pud, pud);
 
 	ret = 0;
diff --git a/mm/memory.c b/mm/memory.c
index c467102a5cbc..0387ee1e3582 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1033,7 +1033,6 @@ copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	 */
 	if (vm_flags & VM_SHARED)
 		pte = pte_mkclean(pte);
-	pte = pte_mkold(pte);
 
 	page = vm_normal_page(vma, addr, pte);
 	if (page) {
diff --git a/mm/vmscan.c b/mm/vmscan.c
index c5ef7240cbcb..e72d5b3336a0 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1031,6 +1031,14 @@ static enum page_references page_check_references(struct page *page,
 		 * to look twice if a mapped file page is used more
 		 * than once.
 		 *
+		 * fork() will set referenced bits in child ptes despite
+		 * not having been accessed, to avoid micro-faults of
+		 * setting accessed bits. This heuristic is not perfectly
+		 * accurate in other ways -- multiple map/unmap in the
+		 * same time window would be treated as multiple references
+		 * despite same number of actual memory accesses made by
+		 * the program.
+		 *
 		 * Mark it and spare it for another trip around the
 		 * inactive list.  Another page table reference will
 		 * lead to its activation.
-- 
2.18.0

