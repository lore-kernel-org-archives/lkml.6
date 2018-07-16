Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D08ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB96F20864
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:35:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB96F20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730667AbeGPIB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:01:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46572 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730092AbeGPIB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:01:56 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B63AFCB0;
        Mon, 16 Jul 2018 07:35:55 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 4.17 04/67] MIPS: Fix ioremap() RAM check
Date:   Mon, 16 Jul 2018 09:34:33 +0200
Message-Id: <20180716073443.806592965@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073443.294323458@linuxfoundation.org>
References: <20180716073443.294323458@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@mips.com>

commit 523402fa9101090c91d2033b7ebdfdcf65880488 upstream.

We currently attempt to check whether a physical address range provided
to __ioremap() may be in use by the page allocator by examining the
value of PageReserved for each page in the region - lowmem pages not
marked reserved are presumed to be in use by the page allocator, and
requests to ioremap them fail.

The way we check this has been broken since commit 92923ca3aace ("mm:
meminit: only set page reserved in the memblock region"), because
memblock will typically not have any knowledge of non-RAM pages and
therefore those pages will not have the PageReserved flag set. Thus when
we attempt to ioremap a region outside of RAM we incorrectly fail
believing that the region is RAM that may be in use.

In most cases ioremap() on MIPS will take a fast-path to use the
unmapped kseg1 or xkphys virtual address spaces and never hit this path,
so the only way to hit it is for a MIPS32 system to attempt to ioremap()
an address range in lowmem with flags other than _CACHE_UNCACHED.
Perhaps the most straightforward way to do this is using
ioremap_uncached_accelerated(), which is how the problem was discovered.

Fix this by making use of walk_system_ram_range() to test the address
range provided to __ioremap() against only RAM pages, rather than all
lowmem pages. This means that if we have a lowmem I/O region, which is
very common for MIPS systems, we're free to ioremap() address ranges
within it. A nice bonus is that the test is no longer limited to lowmem.

The approach here matches the way x86 performed the same test after
commit c81c8a1eeede ("x86, ioremap: Speed up check for RAM pages") until
x86 moved towards a slightly more complicated check using walk_mem_res()
for unrelated reasons with commit 0e4c12b45aa8 ("x86/mm, resource: Use
PAGE_KERNEL protection for ioremap of memory pages").

Signed-off-by: Paul Burton <paul.burton@mips.com>
Reported-by: Serge Semin <fancer.lancer@gmail.com>
Tested-by: Serge Semin <fancer.lancer@gmail.com>
Fixes: 92923ca3aace ("mm: meminit: only set page reserved in the memblock region")
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org # v4.2+
Patchwork: https://patchwork.linux-mips.org/patch/19786/
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/mm/ioremap.c |   37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

--- a/arch/mips/mm/ioremap.c
+++ b/arch/mips/mm/ioremap.c
@@ -9,6 +9,7 @@
 #include <linux/export.h>
 #include <asm/addrspace.h>
 #include <asm/byteorder.h>
+#include <linux/ioport.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
@@ -98,6 +99,20 @@ static int remap_area_pages(unsigned lon
 	return error;
 }
 
+static int __ioremap_check_ram(unsigned long start_pfn, unsigned long nr_pages,
+			       void *arg)
+{
+	unsigned long i;
+
+	for (i = 0; i < nr_pages; i++) {
+		if (pfn_valid(start_pfn + i) &&
+		    !PageReserved(pfn_to_page(start_pfn + i)))
+			return 1;
+	}
+
+	return 0;
+}
+
 /*
  * Generic mapping function (not visible outside):
  */
@@ -116,8 +131,8 @@ static int remap_area_pages(unsigned lon
 
 void __iomem * __ioremap(phys_addr_t phys_addr, phys_addr_t size, unsigned long flags)
 {
+	unsigned long offset, pfn, last_pfn;
 	struct vm_struct * area;
-	unsigned long offset;
 	phys_addr_t last_addr;
 	void * addr;
 
@@ -137,18 +152,16 @@ void __iomem * __ioremap(phys_addr_t phy
 		return (void __iomem *) CKSEG1ADDR(phys_addr);
 
 	/*
-	 * Don't allow anybody to remap normal RAM that we're using..
+	 * Don't allow anybody to remap RAM that may be allocated by the page
+	 * allocator, since that could lead to races & data clobbering.
 	 */
-	if (phys_addr < virt_to_phys(high_memory)) {
-		char *t_addr, *t_end;
-		struct page *page;
-
-		t_addr = __va(phys_addr);
-		t_end = t_addr + (size - 1);
-
-		for(page = virt_to_page(t_addr); page <= virt_to_page(t_end); page++)
-			if(!PageReserved(page))
-				return NULL;
+	pfn = PFN_DOWN(phys_addr);
+	last_pfn = PFN_DOWN(last_addr);
+	if (walk_system_ram_range(pfn, last_pfn - pfn + 1, NULL,
+				  __ioremap_check_ram) == 1) {
+		WARN_ONCE(1, "ioremap on RAM at %pa - %pa\n",
+			  &phys_addr, &last_addr);
+		return NULL;
 	}
 
 	/*


