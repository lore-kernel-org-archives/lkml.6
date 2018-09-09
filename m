Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A48CC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 12:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B15020865
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 12:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B15020865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbeIIRjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 13:39:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43690 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726838AbeIIRjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 13:39:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1A9AD81A4EB9;
        Sun,  9 Sep 2018 12:50:05 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2F6817D4CD;
        Sun,  9 Sep 2018 12:49:59 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        thgarnie@google.com, kirill.shutemov@linux.intel.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 3/3] mm: Add build time sanity chcek for struct page size
Date:   Sun,  9 Sep 2018 20:49:46 +0800
Message-Id: <20180909124946.17988-3-bhe@redhat.com>
In-Reply-To: <20180909124946.17988-1-bhe@redhat.com>
References: <20180909124946.17988-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Sun, 09 Sep 2018 12:50:05 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Sun, 09 Sep 2018 12:50:05 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Size of struct page might be larger than 64 bytes if debug options
enabled, or fields added for debugging intentionally. Yet an upper
limit need be added at build time to trigger an alert in case the
size is too big to boot up system, warning people to check if it's
be done on purpose in advance.

Here 1/4 of PAGE_SIZE is chosen since system must have been insane
with this value. For those systems with PAGE_SIZE larger than 4KB,
1KB is simply taken.

Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/page_alloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e62e26d41796..d3d1284bba77 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -67,6 +67,7 @@
 #include <linux/ftrace.h>
 #include <linux/lockdep.h>
 #include <linux/nmi.h>
+#include <linux/sizes.h>
 
 #include <asm/sections.h>
 #include <asm/tlbflush.h>
@@ -6849,6 +6850,7 @@ void __init free_area_init_nodes(unsigned long *max_zone_pfn)
 	unsigned long start_pfn, end_pfn;
 	int i, nid;
 
+	BUILD_BUG_ON(sizeof(struct page) < min(SZ_1K, PAGE_SIZE/4));
 	/* Record where the zone boundaries are */
 	memset(arch_zone_lowest_possible_pfn, 0,
 				sizeof(arch_zone_lowest_possible_pfn));
-- 
2.13.6

