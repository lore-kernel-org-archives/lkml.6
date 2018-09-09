Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA03C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 12:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E94E20865
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 12:50:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E94E20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbeIIRjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 13:39:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43668 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726906AbeIIRjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 13:39:35 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 818C28011462;
        Sun,  9 Sep 2018 12:49:59 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB99D108776;
        Sun,  9 Sep 2018 12:49:54 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        thgarnie@google.com, kirill.shutemov@linux.intel.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 2/3] x86/mm/KASLR: Calculate the actual size of vmemmap region
Date:   Sun,  9 Sep 2018 20:49:45 +0800
Message-Id: <20180909124946.17988-2-bhe@redhat.com>
In-Reply-To: <20180909124946.17988-1-bhe@redhat.com>
References: <20180909124946.17988-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Sun, 09 Sep 2018 12:49:59 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Sun, 09 Sep 2018 12:49:59 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vmemmap region has different maximum size depending on paging mode.
Now its size is hardcoded as 1TB in memory KASLR, this is not
right for 5-level paging mode. It will cause overflow if vmemmap
region is randomized to be adjacent to cpu_entry_area region and
its actual size is bigger than 1TB.

So here calculate how many TB by the actual size of vmemmap region
and align up to 1TB boundary.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/mm/kaslr.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 0988971069c9..1db8e166455e 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -51,7 +51,7 @@ static __initdata struct kaslr_memory_region {
 } kaslr_regions[] = {
 	{ &page_offset_base, 0 },
 	{ &vmalloc_base, 0 },
-	{ &vmemmap_base, 1 },
+	{ &vmemmap_base, 0 },
 };
 
 /* Get size in bytes used by the memory region */
@@ -77,6 +77,7 @@ void __init kernel_randomize_memory(void)
 	unsigned long rand, memory_tb;
 	struct rnd_state rand_state;
 	unsigned long remain_entropy;
+	unsigned long vmemmap_size;
 
 	vaddr_start = pgtable_l5_enabled() ? __PAGE_OFFSET_BASE_L5 : __PAGE_OFFSET_BASE_L4;
 	vaddr = vaddr_start;
@@ -108,6 +109,14 @@ void __init kernel_randomize_memory(void)
 	if (memory_tb < kaslr_regions[0].size_tb)
 		kaslr_regions[0].size_tb = memory_tb;
 
+	/*
+	 * Calculate how many TB vmemmap region needs, and align to
+	 * 1TB boundary.
+	 * */
+	vmemmap_size = (kaslr_regions[0].size_tb << (TB_SHIFT - PAGE_SHIFT)) *
+		sizeof(struct page);
+	kaslr_regions[2].size_tb = DIV_ROUND_UP(vmemmap_size, 1UL << TB_SHIFT);
+
 	/* Calculate entropy available between regions */
 	remain_entropy = vaddr_end - vaddr_start;
 	for (i = 0; i < ARRAY_SIZE(kaslr_regions); i++)
-- 
2.13.6

