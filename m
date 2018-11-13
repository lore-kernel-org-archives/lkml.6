Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3ABC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6523722507
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnO6lzGt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6523722507
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732428AbeKMPsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:48:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:34300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732413AbeKMPsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:48:10 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7F5822511;
        Tue, 13 Nov 2018 05:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542088302;
        bh=01UZQO41vzNh4Savahf7vssInXlOxgP+KXnpuRHFvB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HnO6lzGtfavJ4a0yEe3+D9TCHyjIPQ+IKnISXuc0Y5dm7cfd/MskXamxBABRli8Fp
         QeueDu1iDlDy2Y7q9zc1+QNDPI61b36SwRWiWSBvh+qt4nVDXHylWfiKPMJi4Xh6XK
         VxUkSQOZAaiyp/xsUEwHSJoSk+Go/qGNuoWfrBYI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pavel Tatashin <pasha.tatashin@oracle.com>,
        Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        David Rientjes <rientjes@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jan Kara <jack@suse.cz>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@gmail.com>,
        Pasha Tatashin <Pavel.Tatashin@microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org
Subject: [PATCH AUTOSEL 4.18 35/39] mm: calculate deferred pages after skipping mirrored memory
Date:   Tue, 13 Nov 2018 00:50:49 -0500
Message-Id: <20181113055053.78352-35-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113055053.78352-1-sashal@kernel.org>
References: <20181113055053.78352-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Tatashin <pasha.tatashin@oracle.com>

[ Upstream commit d3035be4ce2345d98633a45f93a74e526e94b802 ]

update_defer_init() should be called only when struct page is about to be
initialized. Because it counts number of initialized struct pages, but
there we may skip struct pages if there is some mirrored memory.

So move, update_defer_init() after checking for mirrored memory.

Also, rename update_defer_init() to defer_init() and reverse the return
boolean to emphasize that this is a boolean function, that tells that the
reset of memmap initialization should be deferred.

Make this function self-contained: do not pass number of already
initialized pages in this zone by using static counters.

I found this bug by reading the code.  The effect is that fewer than
expected struct pages are initialized early in boot, and it is possible
that in some corner cases we may fail to boot when mirrored pages are
used.  The deferred on demand code should somewhat mitigate this.  But
this still brings some inconsistencies compared to when booting without
mirrored pages, so it is better to fix.

[pasha.tatashin@oracle.com: add comment about defer_init's lack of locking]
  Link: http://lkml.kernel.org/r/20180726193509.3326-3-pasha.tatashin@oracle.com
[akpm@linux-foundation.org: make defer_init non-inline, __meminit]
Link: http://lkml.kernel.org/r/20180724235520.10200-3-pasha.tatashin@oracle.com
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Steven Sistare <steven.sistare@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: Pasha Tatashin <Pavel.Tatashin@microsoft.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 45 +++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 65f2e6481c99..eb3b250c7c9a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -306,24 +306,33 @@ static inline bool __meminit early_page_uninitialised(unsigned long pfn)
 }
 
 /*
- * Returns false when the remaining initialisation should be deferred until
+ * Returns true when the remaining initialisation should be deferred until
  * later in the boot cycle when it can be parallelised.
  */
-static inline bool update_defer_init(pg_data_t *pgdat,
-				unsigned long pfn, unsigned long zone_end,
-				unsigned long *nr_initialised)
+static bool __meminit
+defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
 {
+	static unsigned long prev_end_pfn, nr_initialised;
+
+	/*
+	 * prev_end_pfn static that contains the end of previous zone
+	 * No need to protect because called very early in boot before smp_init.
+	 */
+	if (prev_end_pfn != end_pfn) {
+		prev_end_pfn = end_pfn;
+		nr_initialised = 0;
+	}
+
 	/* Always populate low zones for address-constrained allocations */
-	if (zone_end < pgdat_end_pfn(pgdat))
-		return true;
-	(*nr_initialised)++;
-	if ((*nr_initialised > pgdat->static_init_pgcnt) &&
-	    (pfn & (PAGES_PER_SECTION - 1)) == 0) {
-		pgdat->first_deferred_pfn = pfn;
+	if (end_pfn < pgdat_end_pfn(NODE_DATA(nid)))
 		return false;
+	nr_initialised++;
+	if ((nr_initialised > NODE_DATA(nid)->static_init_pgcnt) &&
+	    (pfn & (PAGES_PER_SECTION - 1)) == 0) {
+		NODE_DATA(nid)->first_deferred_pfn = pfn;
+		return true;
 	}
-
-	return true;
+	return false;
 }
 #else
 static inline bool early_page_uninitialised(unsigned long pfn)
@@ -331,11 +340,9 @@ static inline bool early_page_uninitialised(unsigned long pfn)
 	return false;
 }
 
-static inline bool update_defer_init(pg_data_t *pgdat,
-				unsigned long pfn, unsigned long zone_end,
-				unsigned long *nr_initialised)
+static inline bool defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
 {
-	return true;
+	return false;
 }
 #endif
 
@@ -5462,9 +5469,7 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 		struct vmem_altmap *altmap)
 {
 	unsigned long end_pfn = start_pfn + size;
-	pg_data_t *pgdat = NODE_DATA(nid);
 	unsigned long pfn;
-	unsigned long nr_initialised = 0;
 	struct page *page;
 #ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
 	struct memblock_region *r = NULL, *tmp;
@@ -5492,8 +5497,6 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 			continue;
 		if (!early_pfn_in_nid(pfn, nid))
 			continue;
-		if (!update_defer_init(pgdat, pfn, end_pfn, &nr_initialised))
-			break;
 
 #ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
 		/*
@@ -5516,6 +5519,8 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 			}
 		}
 #endif
+		if (defer_init(nid, pfn, end_pfn))
+			break;
 
 not_early:
 		page = pfn_to_page(pfn);
-- 
2.17.1

