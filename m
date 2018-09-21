Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A31ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E3C21557
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E3C21557
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389642AbeIUPiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 11:38:55 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56116 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389565AbeIUPiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 11:38:54 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 71553441F4130;
        Fri, 21 Sep 2018 17:50:48 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.399.0; Fri, 21 Sep 2018
 17:50:41 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <akpm@linux-foundation.org>, <mst@redhat.com>,
        <keescook@chromium.org>, <kirill.shutemov@linux.intel.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] mm/gup_benchmark: Fix unsigned comparison to zero in __gup_benchmark_ioctl
Date:   Fri, 21 Sep 2018 17:50:15 +0800
Message-ID: <20180921095015.26088-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_user_pages_fast will return negative value if no pages were pinned,
then be converted to a unsigned, which is compared to zero, giving
the wrong result.

Fixes: 09e35a4a1ca8 ("mm/gup_benchmark: handle gup failures")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 mm/gup_benchmark.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/gup_benchmark.c b/mm/gup_benchmark.c
index 6a47370..7405c9d8 100644
--- a/mm/gup_benchmark.c
+++ b/mm/gup_benchmark.c
@@ -19,7 +19,8 @@ static int __gup_benchmark_ioctl(unsigned int cmd,
 		struct gup_benchmark *gup)
 {
 	ktime_t start_time, end_time;
-	unsigned long i, nr, nr_pages, addr, next;
+	unsigned long i, nr_pages, addr, next;
+	int nr;
 	struct page **pages;
 
 	nr_pages = gup->size / PAGE_SIZE;
-- 
2.7.0


