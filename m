Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04260C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC752086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfANNAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 08:00:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41438 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbfANNAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 08:00:50 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D235DA7EF;
        Mon, 14 Jan 2019 13:00:48 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0990F5D784;
        Mon, 14 Jan 2019 13:00:44 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Miles Chen <miles.chen@mediatek.com>,
        yi.z.zhang@linux.intel.com,
        Dan Williams <dan.j.williams@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 9/9] mm: better document PG_reserved
Date:   Mon, 14 Jan 2019 13:59:03 +0100
Message-Id: <20190114125903.24845-10-david@redhat.com>
In-Reply-To: <20190114125903.24845-1-david@redhat.com>
References: <20190114125903.24845-1-david@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 14 Jan 2019 13:00:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usage of PG_reserved and how PG_reserved pages are to be treated is
buried deep down in different parts of the kernel. Let's shine some light
onto these details by documenting current users and expected
behavior.

Especially, clarify on the "Some of them might not even exist" case.
These are physical memory gaps that will never be dumped as they
are not marked as IORESOURCE_SYSRAM. PG_reserved does in general not
hinder anybody from dumping or swapping. In some cases, these pages
will not be stored in the hibernation image.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: Miles Chen <miles.chen@mediatek.com>
Cc: yi.z.zhang@linux.intel.com
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/page-flags.h | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 808b4183e30d..9f8712a4b1a5 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -17,8 +17,37 @@
 /*
  * Various page->flags bits:
  *
- * PG_reserved is set for special pages, which can never be swapped out. Some
- * of them might not even exist...
+ * PG_reserved is set for special pages. The "struct page" of such a page
+ * should in general not be touched (e.g. set dirty) except by its owner.
+ * Pages marked as PG_reserved include:
+ * - Pages part of the kernel image (including vDSO) and similar (e.g. BIOS,
+ *   initrd, HW tables)
+ * - Pages reserved or allocated early during boot (before the page allocator
+ *   was initialized). This includes (depending on the architecture) the
+ *   initial vmemmap, initial page tables, crashkernel, elfcorehdr, and much
+ *   much more. Once (if ever) freed, PG_reserved is cleared and they will
+ *   be given to the page allocator.
+ * - Pages falling into physical memory gaps - not IORESOURCE_SYSRAM. Trying
+ *   to read/write these pages might end badly. Don't touch!
+ * - The zero page(s)
+ * - Pages not added to the page allocator when onlining a section because
+ *   they were excluded via the online_page_callback() or because they are
+ *   PG_hwpoison.
+ * - Pages allocated in the context of kexec/kdump (loaded kernel image,
+ *   control pages, vmcoreinfo)
+ * - MMIO/DMA pages. Some architectures don't allow to ioremap pages that are
+ *   not marked PG_reserved (as they might be in use by somebody else who does
+ *   not respect the caching strategy).
+ * - Pages part of an offline section (struct pages of offline sections should
+ *   not be trusted as they will be initialized when first onlined).
+ * - MCA pages on ia64
+ * - Pages holding CPU notes for POWER Firmware Assisted Dump
+ * - Device memory (e.g. PMEM, DAX, HMM)
+ * Some PG_reserved pages will be excluded from the hibernation image.
+ * PG_reserved does in general not hinder anybody from dumping or swapping
+ * and is no longer required for remap_pfn_range(). ioremap might require it.
+ * Consequently, PG_reserved for a page mapped into user space can indicate
+ * the zero page, the vDSO, MMIO pages or device memory.
  *
  * The PG_private bitflag is set on pagecache pages if they contain filesystem
  * specific data (which is normally at page->private). It can be used by
-- 
2.17.2

