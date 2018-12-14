Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF36DC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8076D2080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:11:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8076D2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbeLNLK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 06:10:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53958 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729587AbeLNLK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 06:10:58 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9FF389B302;
        Fri, 14 Dec 2018 11:10:57 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-139.ams2.redhat.com [10.36.117.139])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7427617C6F;
        Fri, 14 Dec 2018 11:10:54 +0000 (UTC)
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
Subject: [PATCH v1 4/9] riscv/vdso: don't clear PG_reserved
Date:   Fri, 14 Dec 2018 12:10:09 +0100
Message-Id: <20181214111014.15672-5-david@redhat.com>
In-Reply-To: <20181214111014.15672-1-david@redhat.com>
References: <20181214111014.15672-1-david@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 14 Dec 2018 11:10:57 +0000 (UTC)
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

