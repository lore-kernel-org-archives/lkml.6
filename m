Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93289C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B33420837
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B33420837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbeKCBDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 21:03:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46255 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbeKCBDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 21:03:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id w7so1148923pgp.13;
        Fri, 02 Nov 2018 08:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NBhzy/S34A7on+K+3b8oAVAcy3NIhz+CjCrdYxmOkqg=;
        b=sArwTtr33EWFPqGZDuTtmw81DoI4uxaZGanybgpdiPGEufR/omHzktlv8kKTn99y93
         Doxvzw7hxsGA/4caTEgZRpb0QsW/O6KVc28/Y7CZ+H5yVL6Y8y2ixjcWTxxZP0ZnIkv+
         VGkOGbI+qmDApTpPUpdy7ugCXCqn8+Lc7D8wnp63S7rJNJG2ESjnIgBNJrZcv2xqmYn3
         UQ+7LPv8C1zEgeuq3jtk58xN64UYGW4skMgxaJUA+fBRue0g1L3oDp7PYCA8avOGmYBW
         is6yq/jwdFhP1kveS1xqoN+WhyyjR61ra/pp8h/piHt9qpjMvjay7ugM/Sx+LHHwL5eg
         b+zA==
X-Gm-Message-State: AGRZ1gJOLtIBkL9BpzPPCsFWpITWMJfB8F6X1fpK/iK54X66Pmk+JVsz
        FAqAJkp12NXFTd9RKURqz6Y=
X-Google-Smtp-Source: AJdET5dN98hD68jh8474F3d1oQmmUomdIhwgXklv8G5Yd3IgkRqmnBdRbm94PuJaH/khaEiactycgQ==
X-Received: by 2002:a63:9343:: with SMTP id w3-v6mr11202938pgm.343.1541174137963;
        Fri, 02 Nov 2018 08:55:37 -0700 (PDT)
Received: from tiehlicka.microfocus.com (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id 27-v6sm55208581pfm.36.2018.11.02.08.55.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 08:55:36 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Baoquan He <bhe@redhat.com>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Stable tree <stable@vger.kernel.org>
Subject: [PATCH] mm, memory_hotplug: teach has_unmovable_pages about of LRU migrateable pages
Date:   Fri,  2 Nov 2018 16:55:28 +0100
Message-Id: <20181102155528.20358-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181101091055.GA15166@MiWiFi-R3L-srv>
References: <20181101091055.GA15166@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

Baoquan He has noticed that 15c30bc09085  ("mm, memory_hotplug: make
has_unmovable_pages more robust") is causing memory offlining failures
on a movable node. After a further debugging it turned out that
has_unmovable_pages fails prematurely because it stumbles over off-LRU
pages. Nevertheless those pages are not on LRU because they are waiting
on the pcp LRU caches (an example of __dump_page added by a debugging
patch)
[  560.923297] page:ffffea043f39fa80 count:1 mapcount:0 mapping:ffff880e5dce1b59 index:0x7f6eec459
[  560.931967] flags: 0x5fffffc0080024(uptodate|active|swapbacked)
[  560.937867] raw: 005fffffc0080024 dead000000000100 dead000000000200 ffff880e5dce1b59
[  560.945606] raw: 00000007f6eec459 0000000000000000 00000001ffffffff ffff880e43ae8000
[  560.953323] page dumped because: hotplug
[  560.957238] page->mem_cgroup:ffff880e43ae8000
[  560.961620] has_unmovable_pages: pfn:0x10fd030d, found:0x1, count:0x0
[  560.968127] page:ffffea043f40c340 count:2 mapcount:0 mapping:ffff880e2f2d8628 index:0x0
[  560.976104] flags: 0x5fffffc0000006(referenced|uptodate)
[  560.981401] raw: 005fffffc0000006 dead000000000100 dead000000000200 ffff880e2f2d8628
[  560.989119] raw: 0000000000000000 0000000000000000 00000002ffffffff ffff88010a8f5000
[  560.996833] page dumped because: hotplug

The issue could be worked around by calling lru_add_drain_all but we can
do better than that. We know that all swap backed pages are migrateable
and the same applies for pages which do implement the migratepage
callback.

Reported-by: Baoquan He <bhe@redhat.com>
Fixes: 15c30bc09085  ("mm, memory_hotplug: make has_unmovable_pages more robust")
Cc: stable
Signed-off-by: Michal Hocko <mhocko@suse.com>
---

Hi,
we have been discussing issue reported by Baoquan [1] mostly off-list
and he has confirmed the patch solved failures he is seeing. I believe
that has_unmovable_pages begs for a much better implementation and/or
substantial pages isolation design rethinking but let's close the bug
which can be really annoying first.

[1] http://lkml.kernel.org/r/20181101091055.GA15166@MiWiFi-R3L-srv

 mm/page_alloc.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 863d46da6586..48ceda313332 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7824,8 +7824,22 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
 		if (__PageMovable(page))
 			continue;
 
-		if (!PageLRU(page))
-			found++;
+		if (PageLRU(page))
+			continue;
+
+		/*
+		 * Some LRU pages might be temporarily off-LRU for all
+		 * sort of different reasons - reclaim, migration,
+		 * per-cpu LRU caches etc.
+		 * Make sure we do not consider those pages to be unmovable.
+		 */
+		if (PageSwapBacked(page))
+			continue;
+
+		if (page->mapping && page->mapping->a_ops &&
+				page->mapping->a_ops->migratepage)
+			continue;
+
 		/*
 		 * If there are RECLAIMABLE pages, we need to check
 		 * it.  But now, memory offline itself doesn't call
@@ -7839,7 +7853,7 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
 		 * is set to both of a memory hole page and a _used_ kernel
 		 * page at boot.
 		 */
-		if (found > count)
+		if (++found > count)
 			goto unmovable;
 	}
 	return false;
-- 
2.19.1

