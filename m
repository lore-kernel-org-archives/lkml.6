Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E70C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE7520672
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlgxrVOt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE7520672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406955AbeKWGff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 01:35:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:34360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404725AbeKWGfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 01:35:34 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A626A20672;
        Thu, 22 Nov 2018 19:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542916482;
        bh=cEI4xZXD/nCA45zDyQn1uqDbcZn+7YfiZfdn9YA3Bbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qlgxrVOt4xGUrFU6Xg8g3hN+owDpAy+xZpsLE/xG4RF5EFOpgbR23ILlrHGU/nlMe
         tyomIChSXHesT5yQntDQ9AHNbwq/wYZHRXgqplxqzQSodXRfXnB3asyj4jQIMpO/CE
         UptynUgatfUX/fqromdhpstajHZuHbBk2mIBY0aE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org
Subject: [PATCH AUTOSEL 4.19 34/36] mm, memory_hotplug: check zone_movable in has_unmovable_pages
Date:   Thu, 22 Nov 2018 14:52:38 -0500
Message-Id: <20181122195240.13123-34-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181122195240.13123-1-sashal@kernel.org>
References: <20181122195240.13123-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

[ Upstream commit 9d7899999c62c1a81129b76d2a6ecbc4655e1597 ]

Page state checks are racy.  Under a heavy memory workload (e.g.  stress
-m 200 -t 2h) it is quite easy to hit a race window when the page is
allocated but its state is not fully populated yet.  A debugging patch to
dump the struct page state shows

  has_unmovable_pages: pfn:0x10dfec00, found:0x1, count:0x0
  page:ffffea0437fb0000 count:1 mapcount:1 mapping:ffff880e05239841 index:0x7f26e5000 compound_mapcount: 1
  flags: 0x5fffffc0090034(uptodate|lru|active|head|swapbacked)

Note that the state has been checked for both PageLRU and PageSwapBacked
already.  Closing this race completely would require some sort of retry
logic.  This can be tricky and error prone (think of potential endless
or long taking loops).

Workaround this problem for movable zones at least.  Such a zone should
only contain movable pages.  Commit 15c30bc09085 ("mm, memory_hotplug:
make has_unmovable_pages more robust") has told us that this is not
strictly true though.  Bootmem pages should be marked reserved though so
we can move the original check after the PageReserved check.  Pages from
other zones are still prone to races but we even do not pretend that
memory hotremove works for those so pre-mature failure doesn't hurt that
much.

Link: http://lkml.kernel.org/r/20181106095524.14629-1-mhocko@kernel.org
Fixes: 15c30bc09085 ("mm, memory_hotplug: make has_unmovable_pages more robust")
Signed-off-by: Michal Hocko <mhocko@suse.com>
Reported-by: Baoquan He <bhe@redhat.com>
Tested-by: Baoquan He <bhe@redhat.com>
Acked-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Acked-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e2ef1c17942f..3a4065312938 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7690,6 +7690,14 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
 		if (PageReserved(page))
 			goto unmovable;
 
+		/*
+		 * If the zone is movable and we have ruled out all reserved
+		 * pages then it should be reasonably safe to assume the rest
+		 * is movable.
+		 */
+		if (zone_idx(zone) == ZONE_MOVABLE)
+			continue;
+
 		/*
 		 * Hugepages are not in LRU lists, but they're movable.
 		 * We need not scan over tail pages bacause we don't
-- 
2.17.1

