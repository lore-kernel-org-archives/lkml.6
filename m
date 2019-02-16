Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1751C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 14:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C5321924
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 14:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbfBPOEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 09:04:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48632 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbfBPOEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 09:04:14 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5931BB216;
        Sat, 16 Feb 2019 14:04:14 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-24.pek2.redhat.com [10.72.12.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 61CBC608E2;
        Sat, 16 Feb 2019 14:03:37 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, travis@sgi.com, thgarnie@google.com,
        keescook@chromium.org, akpm@linux-foundation.org,
        yamada.masahiro@socionext.com, kirill@shutemov.name,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 5/6] x86/mm/KASLR: Calculate the actual size of vmemmap region
Date:   Sat, 16 Feb 2019 22:00:07 +0800
Message-Id: <20190216140008.28671-6-bhe@redhat.com>
In-Reply-To: <20190216140008.28671-1-bhe@redhat.com>
References: <20190216140008.28671-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Sat, 16 Feb 2019 14:04:14 +0000 (UTC)
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
index 97768df923e3..ca12ed4e5239 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -101,7 +101,7 @@ static __initdata struct kaslr_memory_region {
 } kaslr_regions[] = {
 	{ &page_offset_base, 0 },
 	{ &vmalloc_base, 0 },
-	{ &vmemmap_base, 1 },
+	{ &vmemmap_base, 0 },
 };
 
 /*
@@ -121,6 +121,7 @@ void __init kernel_randomize_memory(void)
 	unsigned long rand, memory_tb;
 	struct rnd_state rand_state;
 	unsigned long remain_entropy;
+	unsigned long vmemmap_size;
 
 	vaddr_start = pgtable_l5_enabled() ? __PAGE_OFFSET_BASE_L5 : __PAGE_OFFSET_BASE_L4;
 	vaddr = vaddr_start;
@@ -152,6 +153,14 @@ void __init kernel_randomize_memory(void)
 	if (memory_tb < kaslr_regions[0].size_tb)
 		kaslr_regions[0].size_tb = memory_tb;
 
+	/*
+	 * Calculate how many TB vmemmap region needs, and align to
+	 * 1TB boundary.
+	 */
+	vmemmap_size = (kaslr_regions[0].size_tb << (TB_SHIFT - PAGE_SHIFT)) *
+		sizeof(struct page);
+	kaslr_regions[2].size_tb = DIV_ROUND_UP(vmemmap_size, 1UL << TB_SHIFT);
+
 	/* Calculate entropy available between regions */
 	remain_entropy = vaddr_end - vaddr_start;
 	for (i = 0; i < ARRAY_SIZE(kaslr_regions); i++)
-- 
2.17.2

