Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CC4C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 14:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B65222E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 14:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfBPOC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 09:02:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43952 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbfBPOCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 09:02:55 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 45CC51E317;
        Sat, 16 Feb 2019 14:02:55 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-24.pek2.redhat.com [10.72.12.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 930C3608E2;
        Sat, 16 Feb 2019 14:02:15 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, travis@sgi.com, thgarnie@google.com,
        keescook@chromium.org, akpm@linux-foundation.org,
        yamada.masahiro@socionext.com, kirill@shutemov.name,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 3/6] mm: Add build time sanity check for struct page size
Date:   Sat, 16 Feb 2019 22:00:05 +0800
Message-Id: <20190216140008.28671-4-bhe@redhat.com>
In-Reply-To: <20190216140008.28671-1-bhe@redhat.com>
References: <20190216140008.28671-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Sat, 16 Feb 2019 14:02:55 +0000 (UTC)
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

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/page_alloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 35fdde041f5c..eb6c8e22333b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -67,6 +67,7 @@
 #include <linux/lockdep.h>
 #include <linux/nmi.h>
 #include <linux/psi.h>
+#include <linux/sizes.h>
 
 #include <asm/sections.h>
 #include <asm/tlbflush.h>
@@ -7084,6 +7085,7 @@ void __init free_area_init_nodes(unsigned long *max_zone_pfn)
 	unsigned long start_pfn, end_pfn;
 	int i, nid;
 
+	BUILD_BUG_ON(sizeof(struct page) > min_t(size_t, SZ_1K, PAGE_SIZE));
 	/* Record where the zone boundaries are */
 	memset(arch_zone_lowest_possible_pfn, 0,
 				sizeof(arch_zone_lowest_possible_pfn));
-- 
2.17.2

