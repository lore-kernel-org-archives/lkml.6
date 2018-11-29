Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D807BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0EF5213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwBRDAQk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0EF5213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389592AbeK3BiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:38:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:41844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389553AbeK3BiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:38:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1788D213A2;
        Thu, 29 Nov 2018 14:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501967;
        bh=LhNnFcntmpzhebNaAcYBQevssrOMXkGx1LG5piCeNT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RwBRDAQkERpUIwi/2Vq2NayWpwBXk16Qbpky3OqBA+b/IU8HVtPALBe9at5q7Lfcq
         1lsTma3vImPCCEfXyw7Ctauiu0fS3DsbeUV0AABfPrur8gdEhX+VWtzrlbPy/z3pSh
         UXxjYVyFwpzhCxCsk2yRmR/390PBQuchoPUppETo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Baoquan He <bhe@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 096/110] mm, memory_hotplug: check zone_movable in has_unmovable_pages
Date:   Thu, 29 Nov 2018 15:13:07 +0100
Message-Id: <20181129135925.126252836@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129135921.231283053@linuxfoundation.org>
References: <20181129135921.231283053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



