Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AADC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE19320657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfANM7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 07:59:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:16037 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726679AbfANM7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 07:59:43 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9046480F7D;
        Mon, 14 Jan 2019 12:59:43 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 19CA05D73F;
        Mon, 14 Jan 2019 12:59:40 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        David Hildenbrand <david@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 5/9] m68k/mm: use __ClearPageReserved()
Date:   Mon, 14 Jan 2019 13:58:59 +0100
Message-Id: <20190114125903.24845-6-david@redhat.com>
In-Reply-To: <20190114125903.24845-1-david@redhat.com>
References: <20190114125903.24845-1-david@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 14 Jan 2019 12:59:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PG_reserved flag is cleared from memory that is part of the kernel
image (and therefore marked as PG_reserved). Avoid using PG_reserved
directly.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/m68k/mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/mm/memory.c b/arch/m68k/mm/memory.c
index b86a2e21693b..227c04fe60d2 100644
--- a/arch/m68k/mm/memory.c
+++ b/arch/m68k/mm/memory.c
@@ -51,7 +51,7 @@ void __init init_pointer_table(unsigned long ptable)
 	pr_debug("init_pointer_table: %lx, %x\n", ptable, PD_MARKBITS(dp));
 
 	/* unreserve the page so it's possible to free that page */
-	PD_PAGE(dp)->flags &= ~(1 << PG_reserved);
+	__ClearPageReserved(PD_PAGE(dp));
 	init_page_count(PD_PAGE(dp));
 
 	return;
-- 
2.17.2

