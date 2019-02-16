Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612ECC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 14:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 383A3222E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 14:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfBPOCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 09:02:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48162 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbfBPOCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 09:02:14 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D3D5BB216;
        Sat, 16 Feb 2019 14:02:13 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-24.pek2.redhat.com [10.72.12.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF43B648A2;
        Sat, 16 Feb 2019 14:01:37 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, travis@sgi.com, thgarnie@google.com,
        keescook@chromium.org, akpm@linux-foundation.org,
        yamada.masahiro@socionext.com, kirill@shutemov.name,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 2/6] x86/mm/KASLR: Open code unnecessary function get_padding
Date:   Sat, 16 Feb 2019 22:00:04 +0800
Message-Id: <20190216140008.28671-3-bhe@redhat.com>
In-Reply-To: <20190216140008.28671-1-bhe@redhat.com>
References: <20190216140008.28671-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Sat, 16 Feb 2019 14:02:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's used only twice and we do bit shifts in the parent function
anyway so it's not like it's hiding some uninteresting detail.

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/mm/kaslr.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index d7c6e4e8e48e..bf680929fe26 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -104,12 +104,6 @@ static __initdata struct kaslr_memory_region {
 	{ &vmemmap_base, 1 },
 };
 
-/* Get size in bytes used by the memory region */
-static inline unsigned long get_padding(struct kaslr_memory_region *region)
-{
-	return (region->size_tb << TB_SHIFT);
-}
-
 /*
  * Apply no randomization if KASLR was disabled at boot or if KASAN
  * is enabled. KASAN shadow mappings rely on regions being PGD aligned.
@@ -161,7 +155,7 @@ void __init kernel_randomize_memory(void)
 	/* Calculate entropy available between regions */
 	remain_entropy = vaddr_end - vaddr_start;
 	for (i = 0; i < ARRAY_SIZE(kaslr_regions); i++)
-		remain_entropy -= get_padding(&kaslr_regions[i]);
+		remain_entropy -= kaslr_regions[i].size_tb << TB_SHIFT;
 
 	prandom_seed_state(&rand_state, kaslr_get_random_long("Memory"));
 
@@ -185,7 +179,7 @@ void __init kernel_randomize_memory(void)
 		 * Jump the region and add a minimum padding based on
 		 * randomization alignment.
 		 */
-		vaddr += get_padding(&kaslr_regions[i]);
+		vaddr += kaslr_regions[i].size_tb << TB_SHIFT;
 		if (pgtable_l5_enabled())
 			vaddr = round_up(vaddr + 1, P4D_SIZE);
 		else
-- 
2.17.2

