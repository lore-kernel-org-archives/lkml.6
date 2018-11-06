Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BA0C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BCAF20827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BCAF20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387538AbeKFTUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 14:20:01 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37681 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729886AbeKFTUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 14:20:01 -0500
Received: by mail-ed1-f66.google.com with SMTP id y10-v6so3456284edr.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 01:55:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x3QB24GscqKW6OlfJNvDgSgXHJOuhucfbfMPrZrMSTQ=;
        b=dwQjsfC+4ZDpMDYTY/nIA8u1wAvk11qNfGsx3DQyRdTy1QjZ5QZjgcmkR+LCZ5RO96
         7OqsFmHi+Vm9AC9VlFnwpz8cf1iit5jKWnSt0hwNZWu/JQFyfseVdivRTAxwY0pjBvbB
         wMyCewqvw5ge6R3pLHlnCmvl4QUbRMaWVHxy6Q1AboUW5dtl+ffMgXpIvFYJsWj8E9bT
         0ZSArenr+ur0SYnRDUOa22Q3nNFVXJNCgL9TQKi6J7BIVWWm3+CEk1SPZQCQA7EN7WUq
         Jsr3/cpOxZ1kTPOVVWOfg1UrgZoDsUCq21jVmEcSnxMLI/lERXX7a9fg4jRVBmftTRlT
         uWjg==
X-Gm-Message-State: AGRZ1gLxY2CaB4ZhXpCEjNgvkTlI28OnqAI/pThgizBOpA9XshU8WqQ0
        rQViv5jBYGxPd6ho8fqDYa4=
X-Google-Smtp-Source: AJdET5e6Y/4UEzYitJHRDi9SVaYsmhKzVjuRWC8WSCVZyBRihPZ/cCHv6hil1p3VDbsWL4FOmdp5iQ==
X-Received: by 2002:a50:a9c4:: with SMTP id n62-v6mr20483983edc.187.1541498133562;
        Tue, 06 Nov 2018 01:55:33 -0800 (PST)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id gp22-v6sm1431007ejb.4.2018.11.06.01.55.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 01:55:32 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Baoquan He <bhe@redhat.com>, Oscar Salvador <OSalvador@suse.com>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH] mm, memory_hotplug: check zone_movable in has_unmovable_pages
Date:   Tue,  6 Nov 2018 10:55:24 +0100
Message-Id: <20181106095524.14629-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

Page state checks are racy. Under a heavy memory workload (e.g. stress
-m 200 -t 2h) it is quite easy to hit a race window when the page is
allocated but its state is not fully populated yet. A debugging patch to
dump the struct page state shows
: [  476.575516] has_unmovable_pages: pfn:0x10dfec00, found:0x1, count:0x0
: [  476.582103] page:ffffea0437fb0000 count:1 mapcount:1 mapping:ffff880e05239841 index:0x7f26e5000 compound_mapcount: 1
: [  476.592645] flags: 0x5fffffc0090034(uptodate|lru|active|head|swapbacked)

Note that the state has been checked for both PageLRU and PageSwapBacked
already. Closing this race completely would require some sort of retry
logic. This can be tricky and error prone (think of potential endless
or long taking loops).

Workaround this problem for movable zones at least. Such a zone should
only contain movable pages. 15c30bc09085 ("mm, memory_hotplug: make
has_unmovable_pages more robust") has told us that this is not strictly
true though. Bootmem pages should be marked reserved though so we can
move the original check after the PageReserved check. Pages from other
zones are still prone to races but we even do not pretend that memory
hotremove works for those so pre-mature failure doesn't hurt that much.

Reported-and-tested-by: Baoquan He <bhe@redhat.com>
Acked-by: Baoquan He <bhe@redhat.com>
Fixes: "mm, memory_hotplug: make has_unmovable_pages more robust")
Signed-off-by: Michal Hocko <mhocko@suse.com>
---

Hi,
this has been reported [1] and we have tried multiple things to address
the issue. The only reliable way was to reintroduce the movable zone
check into has_unmovable_pages. This time it should be safe also for
the bug originally fixed by 15c30bc09085.

[1] http://lkml.kernel.org/r/20181101091055.GA15166@MiWiFi-R3L-srv
 mm/page_alloc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 863d46da6586..c6d900ee4982 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7788,6 +7788,14 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
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
2.19.1

