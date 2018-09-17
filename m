Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD975ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A053A2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A053A2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731780AbeIREiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:38:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49944 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbeIREiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:38:09 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7DB42707;
        Mon, 17 Sep 2018 23:08:38 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Haren Myneni <haren@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.18 007/158] mm/hugetlb: filter out hugetlb pages if HUGEPAGE migration is not supported.
Date:   Tue, 18 Sep 2018 00:40:37 +0200
Message-Id: <20180917211710.921267739@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

commit 464c7ffbcb164b2e5cebfa406b7fc6cdb7945344 upstream.

When scanning for movable pages, filter out Hugetlb pages if hugepage
migration is not supported.  Without this we hit infinte loop in
__offline_pages() where we do

	pfn = scan_movable_pages(start_pfn, end_pfn);
	if (pfn) { /* We have movable pages */
		ret = do_migrate_range(pfn, end_pfn);
		goto repeat;
	}

Fix this by checking hugepage_migration_supported both in
has_unmovable_pages which is the primary backoff mechanism for page
offlining and for consistency reasons also into scan_movable_pages
because it doesn't make any sense to return a pfn to non-migrateable
huge page.

This issue was revealed by, but not caused by 72b39cfc4d75 ("mm,
memory_hotplug: do not fail offlining too early").

Link: http://lkml.kernel.org/r/20180824063314.21981-1-aneesh.kumar@linux.ibm.com
Fixes: 72b39cfc4d75 ("mm, memory_hotplug: do not fail offlining too early")
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Reported-by: Haren Myneni <haren@linux.vnet.ibm.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/memory_hotplug.c |    3 ++-
 mm/page_alloc.c     |    4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1341,7 +1341,8 @@ static unsigned long scan_movable_pages(
 			if (__PageMovable(page))
 				return pfn;
 			if (PageHuge(page)) {
-				if (page_huge_active(page))
+				if (hugepage_migration_supported(page_hstate(page)) &&
+				    page_huge_active(page))
 					return pfn;
 				else
 					pfn = round_up(pfn + 1,
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7649,6 +7649,10 @@ bool has_unmovable_pages(struct zone *zo
 		 * handle each tail page individually in migration.
 		 */
 		if (PageHuge(page)) {
+
+			if (!hugepage_migration_supported(page_hstate(page)))
+				goto unmovable;
+
 			iter = round_up(iter + 1, 1<<compound_order(page)) - 1;
 			continue;
 		}


