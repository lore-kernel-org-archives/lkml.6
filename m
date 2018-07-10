Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2E6C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBEA52083E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YuttjFIc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBEA52083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933349AbeGJAuL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 20:50:11 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:32814 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933025AbeGJAuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 20:50:05 -0400
Received: by mail-pl0-f67.google.com with SMTP id 6-v6so6792037plb.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 17:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=IqiUZ33GqRn3PXo40N7IwiYQfJSSTHFLTLMGHHlWO44=;
        b=YuttjFIccqLY8XMptyXW8jvNCnucGhgxH4qMmrWBWiOb61/RLa9dX5g8UNEIWfK6ef
         yg6fb4wN+eWyNieEppWQCeSkVNbeNkinDE86oZzZYdkyD/LRdXKlrfWgtCciAtZ7c1nh
         yeIvzXfP62hMClIiY1c8G4j2xJAXwjeB3Bys++NlaiL184QbGJ5MDU+E3NQu9dL7eWCA
         FbaBZzO2AeI5Iak3iVKp15unbVtEm/drZV8yrPs79P1MsSgwzWlnZFuJdMXf5/+p3RNZ
         BRcEHns0JuzWew1pPTbofkprXX7mglQzdsCcsQGS5MECVWAA6CNqMqazhHK2SB+NA0yf
         JoqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=IqiUZ33GqRn3PXo40N7IwiYQfJSSTHFLTLMGHHlWO44=;
        b=rFitgvadFg4fI5Y3gxPbVAu0SJ0PRjSWyAZKe3/5roKbeAmIRi1WI+AtqZDeMGJeQt
         GeA76kOJtMMTVR0I6H1ALiqNiaGP/RafpQ8a78F45kqNClS5unYW/4IMLhw48WWEOtWX
         I7reyZgBC0bGfTiL6BbfDKQz1HR6liVN6KvsOZk38RSVW38pHIHW0oBrlhW9z3Y+v8ab
         cXqQ6zZ0GF23NO1kaEin+gP4eq/gN2bCkxxJDH/AJRd79A12nYWajg09STUk5Iv57KG9
         ds+WJ2uh2faIiJqsUBMvFJbGXftK2WiwnSLafUgO7CrDcg99Vv8DEbmtw4FZJjTwdDDW
         3MKQ==
X-Gm-Message-State: APt69E00+WDZGhPAs+Iy5HVJE0a8pA0lXb1JKmcCYj7M6HD5o8jLSJzA
        6sN9GXXSUPidUpt8B2utQSKUYA==
X-Google-Smtp-Source: AAOMgpeWeCoaZooorww6LFD3rKy/LzATSWA4DGbNRBYDJCP/rIKdl9Ew/fsDC4bE3lfOufJuc0QqJw==
X-Received: by 2002:a17:902:280b:: with SMTP id e11-v6mr22448704plb.298.1531183804945;
        Mon, 09 Jul 2018 17:50:04 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id s22-v6sm26642174pgs.34.2018.07.09.17.50.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 17:50:04 -0700 (PDT)
Date:   Mon, 9 Jul 2018 17:50:03 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [patch] mm, vmacache: hash addresses based on pmd
Message-ID: <alpine.DEB.2.21.1807091749150.114630@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When perf profiling a wide variety of different workloads, it was found
that vmacache_find() had higher than expected cost: up to 0.08% of cpu
utilization in some cases.  This was found to rival other core VM
functions such as alloc_pages_vma() with thp enabled and default
mempolicy, and the conditionals in __get_vma_policy().

VMACACHE_HASH() determines which of the four per-task_struct slots a vma
is cached for a particular address.  This currently depends on the pfn,
so pfn 5212 occupies a different vmacache slot than its neighboring
pfn 5213.

vmacache_find() iterates through all four of current's vmacache slots
when looking up an address.  Hashing based on pfn, an address has
~1/VMACACHE_SIZE chance of being cached in the first vmacache slot, or
about 25%, *if* the vma is cached.

This patch hashes an address by its pmd instead of pte to optimize for
workloads with good spatial locality.  This results in a higher
probability of vmas being cached in the first slot that is checked:
normally ~70% on the same workloads instead of 25%.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 include/linux/vmacache.h |  6 ------
 mm/vmacache.c            | 32 ++++++++++++++++++++++----------
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/include/linux/vmacache.h b/include/linux/vmacache.h
--- a/include/linux/vmacache.h
+++ b/include/linux/vmacache.h
@@ -5,12 +5,6 @@
 #include <linux/sched.h>
 #include <linux/mm.h>
 
-/*
- * Hash based on the page number. Provides a good hit rate for
- * workloads with good locality and those with random accesses as well.
- */
-#define VMACACHE_HASH(addr) ((addr >> PAGE_SHIFT) & VMACACHE_MASK)
-
 static inline void vmacache_flush(struct task_struct *tsk)
 {
 	memset(tsk->vmacache.vmas, 0, sizeof(tsk->vmacache.vmas));
diff --git a/mm/vmacache.c b/mm/vmacache.c
--- a/mm/vmacache.c
+++ b/mm/vmacache.c
@@ -7,6 +7,12 @@
 #include <linux/mm.h>
 #include <linux/vmacache.h>
 
+/*
+ * Hash based on the pmd of addr.  Provides a good hit rate for workloads with
+ * spatial locality.
+ */
+#define VMACACHE_HASH(addr) ((addr >> PMD_SHIFT) & VMACACHE_MASK)
+
 /*
  * Flush vma caches for threads that share a given mm.
  *
@@ -87,6 +93,7 @@ static bool vmacache_valid(struct mm_struct *mm)
 
 struct vm_area_struct *vmacache_find(struct mm_struct *mm, unsigned long addr)
 {
+	int idx = VMACACHE_HASH(addr);
 	int i;
 
 	count_vm_vmacache_event(VMACACHE_FIND_CALLS);
@@ -95,16 +102,18 @@ struct vm_area_struct *vmacache_find(struct mm_struct *mm, unsigned long addr)
 		return NULL;
 
 	for (i = 0; i < VMACACHE_SIZE; i++) {
-		struct vm_area_struct *vma = current->vmacache.vmas[i];
-
-		if (!vma)
-			continue;
-		if (WARN_ON_ONCE(vma->vm_mm != mm))
-			break;
-		if (vma->vm_start <= addr && vma->vm_end > addr) {
-			count_vm_vmacache_event(VMACACHE_FIND_HITS);
-			return vma;
+		struct vm_area_struct *vma = current->vmacache.vmas[idx];
+
+		if (vma) {
+			if (WARN_ON_ONCE(vma->vm_mm != mm))
+				break;
+			if (vma->vm_start <= addr && vma->vm_end > addr) {
+				count_vm_vmacache_event(VMACACHE_FIND_HITS);
+				return vma;
+			}
 		}
+		if (++idx == VMACACHE_SIZE)
+			idx = 0;
 	}
 
 	return NULL;
@@ -115,6 +124,7 @@ struct vm_area_struct *vmacache_find_exact(struct mm_struct *mm,
 					   unsigned long start,
 					   unsigned long end)
 {
+	int idx = VMACACHE_HASH(addr);
 	int i;
 
 	count_vm_vmacache_event(VMACACHE_FIND_CALLS);
@@ -123,12 +133,14 @@ struct vm_area_struct *vmacache_find_exact(struct mm_struct *mm,
 		return NULL;
 
 	for (i = 0; i < VMACACHE_SIZE; i++) {
-		struct vm_area_struct *vma = current->vmacache.vmas[i];
+		struct vm_area_struct *vma = current->vmacache.vmas[idx];
 
 		if (vma && vma->vm_start == start && vma->vm_end == end) {
 			count_vm_vmacache_event(VMACACHE_FIND_HITS);
 			return vma;
 		}
+		if (++idx == VMACACHE_SIZE)
+			idx = 0;
 	}
 
 	return NULL;
