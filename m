Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E43C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7769C2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7769C2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbeLEMaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:30:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43378 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727838AbeLEMaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:30:20 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B69453078A25;
        Wed,  5 Dec 2018 12:30:19 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-65.ams2.redhat.com [10.36.117.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C16E183D2;
        Wed,  5 Dec 2018 12:30:16 +0000 (UTC)
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
        yi.z.zhang@linux.intel.com, Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH RFC 7/7] mm: better document PG_reserved
Date:   Wed,  5 Dec 2018 13:28:51 +0100
Message-Id: <20181205122851.5891-8-david@redhat.com>
In-Reply-To: <20181205122851.5891-1-david@redhat.com>
References: <20181205122851.5891-1-david@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 05 Dec 2018 12:30:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usage of PG_reserved and how PG_reserved pages are to be treated is
burried deep down in different parts of the kernel. Let's shine some light
onto these details by documenting (most?) current users and expected
behavior.

I don't see a reason why we have to document "Some of them might not even
exist". If there is a user, we should document it. E.g. for balloon
drivers we now use PG_offline to indicate that a page might currently
not be backed by memory in the hypervisor. And that is independent from
PG_reserved.

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
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/page-flags.h | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 68b8495e2fbc..112526f5ba61 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -17,8 +17,22 @@
 /*
  * Various page->flags bits:
  *
- * PG_reserved is set for special pages, which can never be swapped out. Some
- * of them might not even exist...
+ * PG_reserved is set for special pages. The "struct page" of such a page
+ * should in general not be touched (e.g. set dirty) except by their owner.
+ * Pages marked as PG_reserved include:
+ * - Kernel image (including vDSO) and similar (e.g. BIOS, initrd)
+ * - Pages allocated early during boot (bootmem, memblock)
+ * - Zero pages
+ * - Pages that have been associated with a zone but are not available for
+ *   the page allocator (e.g. excluded via online_page_callback())
+ * - Pages to exclude from the hibernation image (e.g. loaded kexec images)
+ * - MMIO pages (communicate with a device, special caching strategy needed)
+ * - MCA pages on ia64 (pages with memory errors)
+ * - Device memory (e.g. PMEM, DAX, HMM)
+ * Some architectures don't allow to ioremap pages that are not marked
+ * PG_reserved (as they might be in use by somebody else who does not respect
+ * the caching strategy). Consequently, PG_reserved for a page mapped into
+ * user space can indicate the zero page, the vDSO, MMIO pages or device memory.
  *
  * The PG_private bitflag is set on pagecache pages if they contain filesystem
  * specific data (which is normally at page->private). It can be used by
-- 
2.17.2

