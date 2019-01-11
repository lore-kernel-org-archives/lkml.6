Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029FAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C964920872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218665;
	bh=a1RrmN80EN5ylCFOn6mmZGiY6ejKS9tO9/pfJqKruyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wAS2m6lCZMhBMmu7DwxeQfE/gk2vOumH39z5SamUAl5qfF/5uPoXh5CPwdq+yxnFV
	 R25sLTEgcRGtOPmccUQPluoHEnhAvG7DWGARi4o3yZVB6w2qamfWHrdHGU6ZbUhTPq
	 Mf3eiAUO6Y6tn1wZzokfI8uL8Js3Nw4JTSyWiOVs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390065AbfAKOfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:35:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:55280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390046AbfAKOfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:35:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7301204EC;
        Fri, 11 Jan 2019 14:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217301;
        bh=a1RrmN80EN5ylCFOn6mmZGiY6ejKS9tO9/pfJqKruyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sQyHh48i69jHKZ5A24Pt2lTQy4jggfgTJ1wIbdLtNbHsctb5E/3yKuSmL/Ey2SgQW
         cMQ+5BrBJcDFe+W2b6IukdNQAMRyLnkRMQkQm/FyUdeLYZ71PWnx8Q7vOphO+rUcSb
         tpY90FOtnmxOVeMCF3hKQY46WcCQE+MzvCydZLfo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver OHalloran <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 012/148] powerpc/mm: Fallback to RAM if the altmap is unusable
Date:   Fri, 11 Jan 2019 15:13:10 +0100
Message-Id: <20190111131114.826231183@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 9ef34630a4614ee1cd478f9859ebea55d55f10ec ]

The "altmap" is used to provide a pool of memory that is reserved for
the vmemmap backing of hot-plugged memory. This is useful when adding
large amount of ZONE_DEVICE memory to a system with a limited amount of
normal memory.

On ppc64 we use huge pages to map the vmemmap which requires the backing
storage to be contigious and aligned to the hugepage size. The altmap
implementation allows for the altmap provider to reserve a few PFNs at
the start of the range for it's own uses and when this occurs the
first chunk of the altmap is not usable for hugepage mappings. On hash
there is no sane way to fall back to a normal sized page mapping so we
fail the allocation. This results in memory hotplug failing with
ENOMEM when the new range doesn't fall into an existing vmemmap block.

This patch handles this case by falling back to using system memory
rather than failing if we cannot allocate from the altmap. This
fallback should only ever be used for the first vmemmap block so it
should not cause excess memory consumption.

Fixes: 7b73d978a5d0 ("mm: pass the vmem_altmap to vmemmap_populate")
Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/mm/init_64.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 7a9886f98b0c..a5091c034747 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -188,15 +188,20 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 	pr_debug("vmemmap_populate %lx..%lx, node %d\n", start, end, node);
 
 	for (; start < end; start += page_size) {
-		void *p;
+		void *p = NULL;
 		int rc;
 
 		if (vmemmap_populated(start, page_size))
 			continue;
 
+		/*
+		 * Allocate from the altmap first if we have one. This may
+		 * fail due to alignment issues when using 16MB hugepages, so
+		 * fall back to system memory if the altmap allocation fail.
+		 */
 		if (altmap)
 			p = altmap_alloc_block_buf(page_size, altmap);
-		else
+		if (!p)
 			p = vmemmap_alloc_block_buf(page_size, node);
 		if (!p)
 			return -ENOMEM;
@@ -255,8 +260,15 @@ void __ref vmemmap_free(unsigned long start, unsigned long end,
 {
 	unsigned long page_size = 1 << mmu_psize_defs[mmu_vmemmap_psize].shift;
 	unsigned long page_order = get_order(page_size);
+	unsigned long alt_start = ~0, alt_end = ~0;
+	unsigned long base_pfn;
 
 	start = _ALIGN_DOWN(start, page_size);
+	if (altmap) {
+		alt_start = altmap->base_pfn;
+		alt_end = altmap->base_pfn + altmap->reserve +
+			  altmap->free + altmap->alloc + altmap->align;
+	}
 
 	pr_debug("vmemmap_free %lx...%lx\n", start, end);
 
@@ -280,8 +292,9 @@ void __ref vmemmap_free(unsigned long start, unsigned long end,
 		page = pfn_to_page(addr >> PAGE_SHIFT);
 		section_base = pfn_to_page(vmemmap_section_start(start));
 		nr_pages = 1 << page_order;
+		base_pfn = PHYS_PFN(addr);
 
-		if (altmap) {
+		if (base_pfn >= alt_start && base_pfn < alt_end) {
 			vmem_altmap_free(altmap, nr_pages);
 		} else if (PageReserved(page)) {
 			/* allocated from bootmem */
-- 
2.19.1



