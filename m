Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854F7C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F10223F96
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F10223F96
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752222AbeFVJ25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 05:28:57 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8724 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751191AbeFVJ24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 05:28:56 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7912A2A0857BB;
        Fri, 22 Jun 2018 17:28:42 +0800 (CST)
Received: from localhost (10.177.23.164) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.382.0; Fri, 22 Jun 2018
 17:28:04 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Libin <huawei.libin@huawei.com>
Subject: [PATCH 1/1] kasan: fix shadow_size calculation error in kasan_module_alloc
Date:   Fri, 22 Jun 2018 17:27:06 +0800
Message-ID: <1529659626-12660-1-git-send-email-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 1.9.5.msysgit.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a special case that the size is "(N << KASAN_SHADOW_SCALE_SHIFT)
Pages plus X", the value of X is [1, KASAN_SHADOW_SCALE_SIZE-1]. The
operation "size >> KASAN_SHADOW_SCALE_SHIFT" will drop X, and the roundup
operation can not retrieve the missed one page. For example: size=0x28006,
PAGE_SIZE=0x1000, KASAN_SHADOW_SCALE_SHIFT=3, we will get
shadow_size=0x5000, but actually we need 6 pages.

shadow_size = round_up(size >> KASAN_SHADOW_SCALE_SHIFT, PAGE_SIZE);

This can lead kernel to be crashed, when kasan is enabled and the value
of mod->core_layout.size or mod->init_layout.size is like above. Because
the shadow memory of X has not been allocated and mapped.

move_module:
ptr = module_alloc(mod->core_layout.size);
...
memset(ptr, 0, mod->core_layout.size);		//crashed

Unable to handle kernel paging request at virtual address ffff0fffff97b000
......
Call trace:
[<ffff8000004694d4>] __asan_storeN+0x174/0x1a8
[<ffff800000469844>] memset+0x24/0x48
[<ffff80000025cf28>] layout_and_allocate+0xcd8/0x1800
[<ffff80000025dbe0>] load_module+0x190/0x23e8
[<ffff8000002601e8>] SyS_finit_module+0x148/0x180

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 mm/kasan/kasan.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/kasan/kasan.c b/mm/kasan/kasan.c
index 81a2f45..f5ac4ac 100644
--- a/mm/kasan/kasan.c
+++ b/mm/kasan/kasan.c
@@ -427,12 +427,13 @@ void kasan_kfree_large(const void *ptr)
 int kasan_module_alloc(void *addr, size_t size)
 {
 	void *ret;
+	size_t scaled_size;
 	size_t shadow_size;
 	unsigned long shadow_start;

 	shadow_start = (unsigned long)kasan_mem_to_shadow(addr);
-	shadow_size = round_up(size >> KASAN_SHADOW_SCALE_SHIFT,
-			PAGE_SIZE);
+	scaled_size = (size + KASAN_SHADOW_MASK) >> KASAN_SHADOW_SCALE_SHIFT;
+	shadow_size = round_up(scaled_size, PAGE_SIZE);

 	if (WARN_ON(!PAGE_ALIGNED(shadow_start)))
 		return -EINVAL;
--
1.8.3


