Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F79DC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 02:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFDD62087C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 02:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFDD62087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbeH2GMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 02:12:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37706 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725882AbeH2GMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 02:12:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8B46F401EF04;
        Wed, 29 Aug 2018 02:18:04 +0000 (UTC)
Received: from 192.168.1.2 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4645F2026D6B;
        Wed, 29 Aug 2018 02:18:00 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        thgarnie@google.com, kirill.shutemov@linux.intel.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH 2/2] x86/mm/KASLR: Adjust the vmemmap size according to paging mode
Date:   Wed, 29 Aug 2018 10:17:54 +0800
Message-Id: <20180829021754.21850-2-bhe@redhat.com>
In-Reply-To: <20180829021754.21850-1-bhe@redhat.com>
References: <20180829021754.21850-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 29 Aug 2018 02:18:04 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 29 Aug 2018 02:18:04 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vmemmap area has different base and size depending on paging mode.
Now we just hardcode its size as 1TB in memory KASLR, it's not
right for 5-level paging mode.

Adjust it according to paging mode and use it during memory KASLR.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/include/asm/pgtable_64_types.h | 5 +++++
 arch/x86/mm/kaslr.c                     | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 04edd2d58211..fa759d2d3186 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -126,14 +126,19 @@ extern unsigned int ptrs_per_p4d;
 #define __VMEMMAP_BASE_L4	0xffffea0000000000UL
 #define __VMEMMAP_BASE_L5	0xffd4000000000000UL
 
+#define VMEMMAP_SIZE_TB_L4	1UL
+#define VMEMMAP_SIZE_TB_L5	512UL
+
 #ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
 # define VMALLOC_START		vmalloc_base
 # define VMALLOC_SIZE_TB	(pgtable_l5_enabled() ? VMALLOC_SIZE_TB_L5 : VMALLOC_SIZE_TB_L4)
 # define VMEMMAP_START		vmemmap_base
+# define VMEMMAP_SIZE_TB	(pgtable_l5_enabled() ? VMEMMAP_SIZE_TB_L5 : VMEMMAP_SIZE_TB_L4)
 #else
 # define VMALLOC_START		__VMALLOC_BASE_L4
 # define VMALLOC_SIZE_TB	VMALLOC_SIZE_TB_L4
 # define VMEMMAP_START		__VMEMMAP_BASE_L4
+# define VMEMMAP_SIZE_TB	VMEMMAP_SIZE_TB_L4
 #endif /* CONFIG_DYNAMIC_MEMORY_LAYOUT */
 
 #define VMALLOC_END		(VMALLOC_START + (VMALLOC_SIZE_TB << 40) - 1)
diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 0988971069c9..69228af4c7d7 100644
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
@@ -95,6 +95,7 @@ void __init kernel_randomize_memory(void)
 
 	kaslr_regions[0].size_tb = 1 << (MAX_PHYSMEM_BITS - TB_SHIFT);
 	kaslr_regions[1].size_tb = VMALLOC_SIZE_TB;
+	kaslr_regions[2].size_tb = VMEMMAP_SIZE_TB;
 
 	/*
 	 * Update Physical memory mapping to available and
-- 
2.13.6

