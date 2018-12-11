Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1961C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6AA12081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544538481;
	bh=uQcX2dzqrQM2orVQMvndQm6fzR0+LxorEv1I86IHsDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XHiOnvUVpVJbgCabRrIK/CUOfZf9lwPjwVLD3KofWasHGtrtJ7Cw8fKjhKwDbUbxn
	 CxRsCe+JnTW+UfM2ctLg8exs69swWXRXtVKkdx+KUG/AsweVdDFJKGyiusvrbud/sm
	 xmIm26px8I3hvVEddOBWsR4tuudyx8AVyw+tX48U=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6AA12081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbeLKO14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:27:56 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41566 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbeLKO1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 09:27:52 -0500
Received: by mail-ed1-f65.google.com with SMTP id z28so12664312edi.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 06:27:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xXwaJmog1/oEX/6A1+e5tKGx5C0bRqEwCwR2BHwUQq8=;
        b=N8ccPL4uv0pN6Z7hsJ2mcCCMLxUlH10tPTDxeC+oJhi+hPGupzlXEmRhQZGS0PxoSL
         6fs9bwp3x4VHVPSv5cTGA5RCbObjYDhEQ98HW2tpn7lsbt5DjVLVS7alnMliidFBUdEk
         x/+KZRbQ7dVaT158S2XgB38M3DPAx8xQuD/Hp6noKeu18lmG3Uq20996ea3fwwi3vi7E
         W4tiXjt6MsQay6KrkolTiyTQacQ/C56qKeSPQG0gub9m9Yt6sYyM6tZLdkGjO4h4xe4O
         qIubck+Ldedf8H/KX80HyUUsP75mpxhefRwhHQn6dA1Uxq7DeLZl984ideQculN8MFcO
         kzgw==
X-Gm-Message-State: AA+aEWb7sTUkg/l+jxIlL1f44iENcmPAGjWyRNOvuJ5ni4+2Zc9zc0ej
        K3zj/PrarcwKl4fVZ1zQBTs+T1XA
X-Google-Smtp-Source: AFSGD/WU5eBB4mLDzkmMW5SXZsrmL9erDeMhxzG1pm5Jdw/nZ0jvoqQoYpuRcJhGY3RoLQMZAwf91Q==
X-Received: by 2002:a17:906:7252:: with SMTP id n18-v6mr4309738ejk.192.1544538470766;
        Tue, 11 Dec 2018 06:27:50 -0800 (PST)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id g31sm4073975eda.96.2018.12.11.06.27.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 06:27:50 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH 1/3] mm, memory_hotplug: try to migrate full pfn range
Date:   Tue, 11 Dec 2018 15:27:39 +0100
Message-Id: <20181211142741.2607-2-mhocko@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181211142741.2607-1-mhocko@kernel.org>
References: <20181211142741.2607-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

do_migrate_range has been limiting the number of pages to migrate to 256
for some reason which is not documented. Even if the limit made some
sense back then when it was introduced it doesn't really serve a good
purpose these days. If the range contains huge pages then
we break out of the loop too early and go through LRU and pcp
caches draining and scan_movable_pages is quite suboptimal.

The only reason to limit the number of pages I can think of is to reduce
the potential time to react on the fatal signal. But even then the
number of pages is a questionable metric because even a single page
might migration block in a non-killable state (e.g. __unmap_and_move).

Remove the limit and offline the full requested range (this is one
membblock worth of pages with the current code). Should we ever get a
report that offlining takes too long to react on fatal signal then we
should rather fix the core migration to use killable waits and bailout
on a signal.

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/memory_hotplug.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index c82193db4be6..6263c8cd4491 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1339,18 +1339,16 @@ static struct page *new_node_page(struct page *page, unsigned long private)
 	return new_page_nodemask(page, nid, &nmask);
 }
 
-#define NR_OFFLINE_AT_ONCE_PAGES	(256)
 static int
 do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 {
 	unsigned long pfn;
 	struct page *page;
-	int move_pages = NR_OFFLINE_AT_ONCE_PAGES;
 	int not_managed = 0;
 	int ret = 0;
 	LIST_HEAD(source);
 
-	for (pfn = start_pfn; pfn < end_pfn && move_pages > 0; pfn++) {
+	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
 		if (!pfn_valid(pfn))
 			continue;
 		page = pfn_to_page(pfn);
@@ -1362,8 +1360,7 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 				ret = -EBUSY;
 				break;
 			}
-			if (isolate_huge_page(page, &source))
-				move_pages -= 1 << compound_order(head);
+			isolate_huge_page(page, &source);
 			continue;
 		} else if (PageTransHuge(page))
 			pfn = page_to_pfn(compound_head(page))
@@ -1382,7 +1379,6 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 		if (!ret) { /* Success */
 			put_page(page);
 			list_add_tail(&page->lru, &source);
-			move_pages--;
 			if (!__PageMovable(page))
 				inc_node_page_state(page, NR_ISOLATED_ANON +
 						    page_is_file_cache(page));
-- 
2.19.2

