Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467A1ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F2620892
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpfpbjI+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09F2620892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731293AbeKIHlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:41:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:32942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730843AbeKIHlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:41:12 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 371EF208E3;
        Thu,  8 Nov 2018 22:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714623;
        bh=ZQO8ZnxdDvEyIRxWuBmCzesDsKhktkP1Hz6VUDExbAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CpfpbjI+ZqQ2ntcxkJk8XWyFYJ2/hvI9vmeElfwhz6DhGvO3cZhPJvOkpP5LNbZNd
         m1i6ueCbqi2ETFbK3EzetlzayDjdVFjKYD/c3tpuaSoOt4pDMChEHSmwSIfllWNZCm
         Lb18F31eIBrZuqNcBh7MWh9NDu9/OM1TvKgeUsRA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, zhong jiang <zhongjiang@huawei.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 033/171] mm/memory_hotplug.c: fix overflow in test_pages_in_a_zone()
Date:   Thu,  8 Nov 2018 13:50:03 -0800
Message-Id: <20181108215129.734082951@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit d6d8c8a48291b929b2e039f220f0b62958cccfea ]

When mainline introduced commit a96dfddbcc04 ("base/memory, hotplug: fix
a kernel oops in show_valid_zones()"), it obtained the valid start and
end pfn from the given pfn range.  The valid start pfn can fix the
actual issue, but it introduced another issue.  The valid end pfn will
may exceed the given end_pfn.

Although the incorrect overflow will not result in actual problem at
present, but I think it need to be fixed.

[toshi.kani@hpe.com: remove assumption that end_pfn is aligned by MAX_ORDER_NR_PAGES]
Fixes: a96dfddbcc04 ("base/memory, hotplug: fix a kernel oops in show_valid_zones()")
Link: http://lkml.kernel.org/r/1486467299-22648-1-git-send-email-zhongjiang@huawei.com
Signed-off-by: zhong jiang <zhongjiang@huawei.com>
Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memory_hotplug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index c9f715b2917f..0f962cc3f1bf 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1508,7 +1508,7 @@ int test_pages_in_a_zone(unsigned long start_pfn, unsigned long end_pfn,
 			while ((i < MAX_ORDER_NR_PAGES) &&
 				!pfn_valid_within(pfn + i))
 				i++;
-			if (i == MAX_ORDER_NR_PAGES)
+			if (i == MAX_ORDER_NR_PAGES || pfn + i >= end_pfn)
 				continue;
 			page = pfn_to_page(pfn + i);
 			if (zone && page_zone(page) != zone)
@@ -1522,7 +1522,7 @@ int test_pages_in_a_zone(unsigned long start_pfn, unsigned long end_pfn,
 
 	if (zone) {
 		*valid_start = start;
-		*valid_end = end;
+		*valid_end = min(end, end_pfn);
 		return 1;
 	} else {
 		return 0;
-- 
2.17.1



