Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59FCC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 854972082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBVmbsGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbfBDSQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 13:16:02 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36927 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729548AbfBDSQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 13:16:01 -0500
Received: by mail-pf1-f195.google.com with SMTP id y126so293259pfb.4;
        Mon, 04 Feb 2019 10:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=BH3kUGOLH4rXiV4UZ/yFSk8Kv2EdG9WZAShG2rqLHTM=;
        b=HBVmbsGODWcw1Zzq6loJb9qa/nqzCqIjc1caWDwzjyVMZ0cmFJhvTchZVI2WOq0SGD
         K4mHhjv+oZT7Dk4YHXIh0FzSfuUvWLrG1BGCDIpuHv+axbdWqQYThhkdY5vAh6CubTRI
         6G4HgTpmqZTTI1aEb1ZK3zYjOIvHQ9+xhErmeERXv3lpM/Hbv04CdXW8ILjza6RN2IJa
         q+7M7+iRHnlW3ZY88/DcYz7Uy5sz23/8oKf6rqSooCtg8X23HxZJlCOC3paGvl4fG0eN
         amSuhIznkGkG7AuuxMuc46cqDxIP0uc2r4qUVRoHCp5Qyz4dV046yyikJ4zcIEwnzJH3
         XWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=BH3kUGOLH4rXiV4UZ/yFSk8Kv2EdG9WZAShG2rqLHTM=;
        b=IrmLqhOl9Aaqfbco4/DVHqILJ0IDIU2MVTzOcmIEWNkaj3Rtql45xu2IOv4+L+Zxd2
         r/H+0K07pqWa9dO5C+RhUs5ecD09RtctlMMrWpA4OznCXf70GCJqSO/AUIlo92SgT5Ae
         zAiQ4RcexFq93kIvkFeGMHMXSaW+NUNW8V50ZeHnmTb+S3Chts39BQ2WWgp+QK2+gBa3
         SzKQvV1vCWly91rJ6vKFMoVUh6JRvdJmtyRuPzowdf8AaQHIbHAH8yu8uFBbU0cJsekY
         H9mWxsEkuBMQ8DuGhKvpJ1gm02JGiPhPA9Lv3jrGpIG5JnEWK1CEa0AsMgrrr58QEQcC
         AS7g==
X-Gm-Message-State: AHQUAuaW+i3hOzDpr4jYEZzoaUmhKrjUQkrD8cxj3yx88iyhRnynvpGy
        I1CkcY+zhZFpTcnewjHfT1o=
X-Google-Smtp-Source: AHgI3IatDmHCVIQvkPjf403DPZXddCGM1dtT3pI76p0hmmxOMfvPU6zQrFp/JIlwwbmQbdyNZzEbOA==
X-Received: by 2002:a62:37c3:: with SMTP id e186mr635900pfa.251.1549304159979;
        Mon, 04 Feb 2019 10:15:59 -0800 (PST)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d129sm991541pfc.31.2019.02.04.10.15.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 10:15:59 -0800 (PST)
Subject: [RFC PATCH 4/4] mm: Add merge page notifier
From:   Alexander Duyck <alexander.duyck@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     rkrcmar@redhat.com, alexander.h.duyck@linux.intel.com,
        x86@kernel.org, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        pbonzini@redhat.com, tglx@linutronix.de, akpm@linux-foundation.org
Date:   Mon, 04 Feb 2019 10:15:58 -0800
Message-ID: <20190204181558.12095.83484.stgit@localhost.localdomain>
In-Reply-To: <20190204181118.12095.38300.stgit@localhost.localdomain>
References: <20190204181118.12095.38300.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Because the implementation was limiting itself to only providing hints on
pages huge TLB order sized or larger we introduced the possibility for free
pages to slip past us because they are freed as something less then
huge TLB in size and aggregated with buddies later.

To address that I am adding a new call arch_merge_page which is called
after __free_one_page has merged a pair of pages to create a higher order
page. By doing this I am able to fill the gap and provide full coverage for
all of the pages huge TLB order or larger.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 arch/x86/include/asm/page.h |   12 ++++++++++++
 arch/x86/kernel/kvm.c       |   28 ++++++++++++++++++++++++++++
 include/linux/gfp.h         |    4 ++++
 mm/page_alloc.c             |    2 ++
 4 files changed, 46 insertions(+)

diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
index 4487ad7a3385..9540a97c9997 100644
--- a/arch/x86/include/asm/page.h
+++ b/arch/x86/include/asm/page.h
@@ -29,6 +29,18 @@ static inline void arch_free_page(struct page *page, unsigned int order)
 	if (static_branch_unlikely(&pv_free_page_hint_enabled))
 		__arch_free_page(page, order);
 }
+
+struct zone;
+
+#define HAVE_ARCH_MERGE_PAGE
+void __arch_merge_page(struct zone *zone, struct page *page,
+		       unsigned int order);
+static inline void arch_merge_page(struct zone *zone, struct page *page,
+				   unsigned int order)
+{
+	if (static_branch_unlikely(&pv_free_page_hint_enabled))
+		__arch_merge_page(zone, page, order);
+}
 #endif
 
 #include <linux/range.h>
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 09c91641c36c..957bb4f427bb 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -785,6 +785,34 @@ void __arch_free_page(struct page *page, unsigned int order)
 		       PAGE_SIZE << order);
 }
 
+void __arch_merge_page(struct zone *zone, struct page *page,
+		       unsigned int order)
+{
+	/*
+	 * The merging logic has merged a set of buddies up to the
+	 * KVM_PV_UNUSED_PAGE_HINT_MIN_ORDER. Since that is the case, take
+	 * advantage of this moment to notify the hypervisor of the free
+	 * memory.
+	 */
+	if (order != KVM_PV_UNUSED_PAGE_HINT_MIN_ORDER)
+		return;
+
+	/*
+	 * Drop zone lock while processing the hypercall. This
+	 * should be safe as the page has not yet been added
+	 * to the buddy list as of yet and all the pages that
+	 * were merged have had their buddy/guard flags cleared
+	 * and their order reset to 0.
+	 */
+	spin_unlock(&zone->lock);
+
+	kvm_hypercall2(KVM_HC_UNUSED_PAGE_HINT, page_to_phys(page),
+		       PAGE_SIZE << order);
+
+	/* reacquire lock and resume freeing memory */
+	spin_lock(&zone->lock);
+}
+
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
 
 /* Kick a cpu by its apicid. Used to wake up a halted vcpu */
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index fdab7de7490d..4746d5560193 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -459,6 +459,10 @@ static inline struct zonelist *node_zonelist(int nid, gfp_t flags)
 #ifndef HAVE_ARCH_FREE_PAGE
 static inline void arch_free_page(struct page *page, int order) { }
 #endif
+#ifndef HAVE_ARCH_MERGE_PAGE
+static inline void
+arch_merge_page(struct zone *zone, struct page *page, int order) { }
+#endif
 #ifndef HAVE_ARCH_ALLOC_PAGE
 static inline void arch_alloc_page(struct page *page, int order) { }
 #endif
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c954f8c1fbc4..7a1309b0b7c5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -913,6 +913,8 @@ static inline void __free_one_page(struct page *page,
 		page = page + (combined_pfn - pfn);
 		pfn = combined_pfn;
 		order++;
+
+		arch_merge_page(zone, page, order);
 	}
 	if (max_order < MAX_ORDER) {
 		/* If we are here, it means order is >= pageblock_order.

