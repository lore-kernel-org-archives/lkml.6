Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93379C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6163920657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfANM7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 07:59:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47324 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726679AbfANM7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 07:59:41 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C16B589AC9;
        Mon, 14 Jan 2019 12:59:40 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ED8FC5D756;
        Mon, 14 Jan 2019 12:59:37 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        David Hildenbrand <david@redhat.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Tobias Klauser <tklauser@distanz.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 4/9] riscv/vdso: don't clear PG_reserved
Date:   Mon, 14 Jan 2019 13:58:58 +0100
Message-Id: <20190114125903.24845-5-david@redhat.com>
In-Reply-To: <20190114125903.24845-1-david@redhat.com>
References: <20190114125903.24845-1-david@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 14 Jan 2019 12:59:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VDSO is part of the kernel image and therefore the struct pages are
marked as reserved during boot.

As we install a special mapping, the actual struct pages will never be
exposed to MM via the page tables. We can therefore leave the pages
marked as reserved.

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Tobias Klauser <tklauser@distanz.ch>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>
Acked-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/riscv/kernel/vdso.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index 582cb153eb24..0cd044122234 100644
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@ -54,7 +54,6 @@ static int __init vdso_init(void)
 		struct page *pg;
 
 		pg = virt_to_page(vdso_start + (i << PAGE_SHIFT));
-		ClearPageReserved(pg);
 		vdso_pagelist[i] = pg;
 	}
 	vdso_pagelist[i] = virt_to_page(vdso_data);
-- 
2.17.2

