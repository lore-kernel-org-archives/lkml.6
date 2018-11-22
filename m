Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24E5C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B6B20684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:09:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B6B20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393853AbeKVUs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:48:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42872 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731910AbeKVUs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 15:48:27 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 679518EC;
        Thu, 22 Nov 2018 10:09:41 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-206.ams2.redhat.com [10.36.116.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 36E6557B0;
        Thu, 22 Nov 2018 10:09:39 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        devel@linuxdriverproject.org, linux-fsdevel@vger.kernel.org,
        linux-pm@vger.kernel.org, xen-devel@lists.xenproject.org,
        kexec-ml <kexec@lists.infradead.org>, pv-drivers@vmware.com,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v2] makedumpfile: exclude pages that are logically offline
Date:   Thu, 22 Nov 2018 11:09:38 +0100
Message-Id: <20181122100938.5567-1-david@redhat.com>
In-Reply-To: <20181122100627.5189-1-david@redhat.com>
References: <20181122100627.5189-1-david@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 22 Nov 2018 10:09:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux marks pages that are logically offline via a page flag (map count).
Such pages e.g. include pages infated as part of a balloon driver or
pages that were not actually onlined when onlining the whole section.

While the hypervisor usually allows to read such inflated memory, we
basically read and dump data that is completely irrelevant. Also, this
might result in quite some overhead in the hypervisor. In addition,
we saw some problems under Hyper-V, whereby we can crash the kernel by
dumping, when reading memory of a partially onlined memory segment
(for memory added by the Hyper-V balloon driver).

Therefore, don't read and dump pages that are marked as being logically
offline.

Signed-off-by: David Hildenbrand <david@redhat.com>
---

v1 -> v2:
- Fix PAGE_BUDDY_MAPCOUNT_VALUE vs. PAGE_OFFLINE_MAPCOUNT_VALUE

 makedumpfile.c | 34 ++++++++++++++++++++++++++++++----
 makedumpfile.h |  1 +
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 8923538..a5f2ea9 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -88,6 +88,7 @@ mdf_pfn_t pfn_cache_private;
 mdf_pfn_t pfn_user;
 mdf_pfn_t pfn_free;
 mdf_pfn_t pfn_hwpoison;
+mdf_pfn_t pfn_offline;
 
 mdf_pfn_t num_dumped;
 
@@ -249,6 +250,21 @@ isHugetlb(unsigned long dtor)
                     && (SYMBOL(free_huge_page) == dtor));
 }
 
+static int
+isOffline(unsigned long flags, unsigned int _mapcount)
+{
+	if (NUMBER(PAGE_OFFLINE_MAPCOUNT_VALUE) == NOT_FOUND_NUMBER)
+		return FALSE;
+
+	if (flags & (1UL << NUMBER(PG_slab)))
+		return FALSE;
+
+	if (_mapcount == (int)NUMBER(PAGE_OFFLINE_MAPCOUNT_VALUE))
+		return TRUE;
+
+	return FALSE;
+}
+
 static int
 is_cache_page(unsigned long flags)
 {
@@ -2287,6 +2303,8 @@ write_vmcoreinfo_data(void)
 	WRITE_NUMBER("PG_hwpoison", PG_hwpoison);
 
 	WRITE_NUMBER("PAGE_BUDDY_MAPCOUNT_VALUE", PAGE_BUDDY_MAPCOUNT_VALUE);
+	WRITE_NUMBER("PAGE_OFFLINE_MAPCOUNT_VALUE",
+		     PAGE_OFFLINE_MAPCOUNT_VALUE);
 	WRITE_NUMBER("phys_base", phys_base);
 
 	WRITE_NUMBER("HUGETLB_PAGE_DTOR", HUGETLB_PAGE_DTOR);
@@ -2687,6 +2705,7 @@ read_vmcoreinfo(void)
 	READ_SRCFILE("pud_t", pud_t);
 
 	READ_NUMBER("PAGE_BUDDY_MAPCOUNT_VALUE", PAGE_BUDDY_MAPCOUNT_VALUE);
+	READ_NUMBER("PAGE_OFFLINE_MAPCOUNT_VALUE", PAGE_OFFLINE_MAPCOUNT_VALUE);
 	READ_NUMBER("phys_base", phys_base);
 #ifdef __aarch64__
 	READ_NUMBER("VA_BITS", VA_BITS);
@@ -6041,6 +6060,12 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 		else if (isHWPOISON(flags)) {
 			pfn_counter = &pfn_hwpoison;
 		}
+		/*
+		 * Exclude pages that are logically offline.
+		 */
+		else if (isOffline(flags, _mapcount)) {
+			pfn_counter = &pfn_offline;
+		}
 		/*
 		 * Unexcludable page
 		 */
@@ -7522,7 +7547,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 	 */
 	if (info->flag_cyclic) {
 		pfn_zero = pfn_cache = pfn_cache_private = 0;
-		pfn_user = pfn_free = pfn_hwpoison = 0;
+		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = 0;
 		pfn_memhole = info->max_mapnr;
 	}
 
@@ -8804,7 +8829,7 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
 		 * Reset counter for debug message.
 		 */
 		pfn_zero = pfn_cache = pfn_cache_private = 0;
-		pfn_user = pfn_free = pfn_hwpoison = 0;
+		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = 0;
 		pfn_memhole = info->max_mapnr;
 
 		/*
@@ -9749,7 +9774,7 @@ print_report(void)
 	pfn_original = info->max_mapnr - pfn_memhole;
 
 	pfn_excluded = pfn_zero + pfn_cache + pfn_cache_private
-	    + pfn_user + pfn_free + pfn_hwpoison;
+	    + pfn_user + pfn_free + pfn_hwpoison + pfn_offline;
 	shrinking = (pfn_original - pfn_excluded) * 100;
 	shrinking = shrinking / pfn_original;
 
@@ -9763,6 +9788,7 @@ print_report(void)
 	REPORT_MSG("    User process data pages : 0x%016llx\n", pfn_user);
 	REPORT_MSG("    Free pages              : 0x%016llx\n", pfn_free);
 	REPORT_MSG("    Hwpoison pages          : 0x%016llx\n", pfn_hwpoison);
+	REPORT_MSG("    Offline pages           : 0x%016llx\n", pfn_offline);
 	REPORT_MSG("  Remaining pages  : 0x%016llx\n",
 	    pfn_original - pfn_excluded);
 	REPORT_MSG("  (The number of pages is reduced to %lld%%.)\n",
@@ -9790,7 +9816,7 @@ print_mem_usage(void)
 	pfn_original = info->max_mapnr - pfn_memhole;
 
 	pfn_excluded = pfn_zero + pfn_cache + pfn_cache_private
-	    + pfn_user + pfn_free + pfn_hwpoison;
+	    + pfn_user + pfn_free + pfn_hwpoison + pfn_offline;
 	shrinking = (pfn_original - pfn_excluded) * 100;
 	shrinking = shrinking / pfn_original;
 	total_size = info->page_size * pfn_original;
diff --git a/makedumpfile.h b/makedumpfile.h
index f02f86d..e3a2b29 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1927,6 +1927,7 @@ struct number_table {
 	long    PG_hwpoison;
 
 	long	PAGE_BUDDY_MAPCOUNT_VALUE;
+	long	PAGE_OFFLINE_MAPCOUNT_VALUE;
 	long	SECTION_SIZE_BITS;
 	long	MAX_PHYSMEM_BITS;
 	long    HUGETLB_PAGE_DTOR;
-- 
2.17.2

