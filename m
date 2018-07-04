Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF58C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F29D24042
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F29D24042
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753526AbeGDVw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 17:52:26 -0400
Received: from mga03.intel.com ([134.134.136.65]:1054 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752958AbeGDVut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 17:50:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2018 14:50:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,309,1526367600"; 
   d="scan'208";a="62320546"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Jul 2018 14:50:47 -0700
Subject: [PATCH v5 05/11] mm,
 madvise_inject_error: Let memory_failure() optionally take a page
 reference
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Michal Hocko <mhocko@suse.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, hch@lst.de,
        hch@lst.de, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jack@suse.cz,
        ross.zwisler@linux.intel.com
Date:   Wed, 04 Jul 2018 14:40:49 -0700
Message-ID: <153074044986.27838.16910122305490506387.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <153074042316.27838.17319837331947007626.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <153074042316.27838.17319837331947007626.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The madvise_inject_error() routine uses get_user_pages() to lookup the
pfn and other information for injected error, but it does not release
that pin. The assumption is that failed pages should be taken out of
circulation.

However, for dax mappings it is not possible to take pages out of
circulation since they are 1:1 physically mapped as filesystem blocks,
or device-dax capacity. They also typically represent persistent memory
which has an error clearing capability.

In preparation for adding a special handler for dax mappings, shift the
responsibility of taking the page reference to memory_failure(). I.e.
drop the page reference and do not specify MF_COUNT_INCREASED to
memory_failure().

Cc: Michal Hocko <mhocko@suse.com>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 mm/madvise.c |   18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 4d3c922ea1a1..b731933dddae 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -631,11 +631,13 @@ static int madvise_inject_error(int behavior,
 
 
 	for (; start < end; start += PAGE_SIZE << order) {
+		unsigned long pfn;
 		int ret;
 
 		ret = get_user_pages_fast(start, 1, 0, &page);
 		if (ret != 1)
 			return ret;
+		pfn = page_to_pfn(page);
 
 		/*
 		 * When soft offlining hugepages, after migrating the page
@@ -651,17 +653,27 @@ static int madvise_inject_error(int behavior,
 
 		if (behavior == MADV_SOFT_OFFLINE) {
 			pr_info("Soft offlining pfn %#lx at process virtual address %#lx\n",
-						page_to_pfn(page), start);
+					pfn, start);
 
 			ret = soft_offline_page(page, MF_COUNT_INCREASED);
 			if (ret)
 				return ret;
 			continue;
 		}
+
 		pr_info("Injecting memory failure for pfn %#lx at process virtual address %#lx\n",
-						page_to_pfn(page), start);
+				pfn, start);
+
+		ret = memory_failure(pfn, 0);
+
+		/*
+		 * Drop the page reference taken by get_user_pages_fast(). In
+		 * the absence of MF_COUNT_INCREASED the memory_failure()
+		 * routine is responsible for pinning the page to prevent it
+		 * from being released back to the page allocator.
+		 */
+		put_page(page);
 
-		ret = memory_failure(page_to_pfn(page), MF_COUNT_INCREASED);
 		if (ret)
 			return ret;
 	}

