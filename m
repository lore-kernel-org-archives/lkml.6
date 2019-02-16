Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30256C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 14:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02CC0222E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 14:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfBPOBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 09:01:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53592 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbfBPOBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 09:01:36 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 199922FE552;
        Sat, 16 Feb 2019 14:01:36 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-24.pek2.redhat.com [10.72.12.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B03F6608E2;
        Sat, 16 Feb 2019 14:00:55 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, travis@sgi.com, thgarnie@google.com,
        keescook@chromium.org, akpm@linux-foundation.org,
        yamada.masahiro@socionext.com, kirill@shutemov.name,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 1/6] x86/mm/KASLR: Improve code comments about struct kaslr_memory_region
Date:   Sat, 16 Feb 2019 22:00:03 +0800
Message-Id: <20190216140008.28671-2-bhe@redhat.com>
In-Reply-To: <20190216140008.28671-1-bhe@redhat.com>
References: <20190216140008.28671-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Sat, 16 Feb 2019 14:01:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The old comment above kaslr_memory_region is not clear enough to explain
the concepts of memory region KASLR.

[Ingo suggested this and helped to prettify the text]

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/mm/kaslr.c | 55 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 52 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 3f452ffed7e9..d7c6e4e8e48e 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -42,10 +42,59 @@
 static const unsigned long vaddr_end = CPU_ENTRY_AREA_BASE;
 
 /*
- * Memory regions randomized by KASLR (except modules that use a separate logic
- * earlier during boot). The list is ordered based on virtual addresses. This
- * order is kept after randomization.
+ * 'struct kasl_memory_region' entries represent continuous chunks of
+ * kernel virtual memory regions, to be randomized by KASLR.
+ *
+ * ( The exception is the module space virtual memory window which
+ *   uses separate logic earlier during bootup. )
+ *
+ * Currently there are three such regions: the physical memory mapping,
+ * vmalloc and vmemmap regions.
+ *
+ * The array below has the entries ordered based on virtual addresses.
+ * The order is kept after randomization, i.e. the randomized
+ * virtual addresses of these regions are still ascending.
+ *
+ * Here are the fields:
+ *
+ * @base: points to a global variable used by the MM to get the
+ * virtual base address of any of the above regions. This allows the
+ * early KASLR code to modify these base addresses early during bootup,
+ * on a per bootup basis, without the MM code even being aware of whether
+ * it got changed and to what value.
+ *
+ * When KASLR is active then the MM code makes sure that for each region
+ * there's such a single, dynamic, global base address 'unsigned long'
+ * variable available for the KASLR code to point to and modify directly:
+ *
+ *	{ &page_offset_base, 0 },
+ *	{ &vmalloc_base,     0 },
+ *	{ &vmemmap_base,     1 },
+ *
+ * @size_tb: size in TB of each memory region. Thereinto, the size of
+ * the physical memory mapping region is variable, calculated according
+ * to the actual size of system RAM in order to save more space for
+ * randomization. The rest are fixed values related to paging mode.
+ *
+ * @size_tb: is the size of each memory region after randomization, and
+ * its unit is TB.
+ *
+ * Physical memory mapping: (actual RAM size + 10 TB padding)
+ * Vmalloc: 32 TB
+ * Vmemmap: 1 TB
+ *
+ * When randomize the layout, their order are kept, still the physical
+ * memory mapping region is handled fistly, next vmalloc and vmemmap.
+ * E.g the physical memory region, we limit the starting address to be
+ * taken from the 1st 1/3 part of the whole available virtual address
+ * space which is from 0xffff880000000000 to 0xfffffe0000000000, namely
+ * the original starting address of the physical memory mapping region
+ * to the starting address of cpu_entry_area mapping region. Once a random
+ * address is chosen for the physical memory mapping, we jump over the
+ * region and add 1G to begin the next region handling with the remaining
+ * available space.
  */
+
 static __initdata struct kaslr_memory_region {
 	unsigned long *base;
 	unsigned long size_tb;
-- 
2.17.2

