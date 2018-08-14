Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6097FC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F4D2172C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12F4D2172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732372AbeHNPOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 11:14:18 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:32830 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728978AbeHNPOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 11:14:17 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 91ADD59360A98;
        Tue, 14 Aug 2018 20:27:15 +0800 (CST)
Received: from SIA1000068343.huawei.com (10.146.171.150) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.399.0; Tue, 14 Aug 2018 20:27:09 +0800
From:   Xiaofeng Yuan <yuanxiaofeng1@huawei.com>
To:     <keescook@chromium.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Xiaofeng Yuan <yuanxiaofeng1@huawei.com>
Subject: [PATCH RFC] usercopy: optimize stack check flow when the
Date:   Tue, 14 Aug 2018 20:17:31 +0800
Message-ID: <1534249051-56879-1-git-send-email-yuanxiaofeng1@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.146.171.150]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The check_heap_object() checks the spanning multiple pages and slab.
When the page-spanning test is disabled, the check_heap_object() is
redundant for spanning multiple pages. However, the kernel stacks are
multiple pages under certain conditions: CONFIG_ARCH_THREAD_STACK_ALLOCATOR
is not defined and (THREAD_SIZE >= PAGE_SIZE). At this point, We can skip
the check_heap_object() for kernel stacks to improve performance.
Similarly, the virtually-mapped stack can skip check_heap_object() also,
beacause virt_addr_valid() will return.

I launched more than 100 apps on smartphone, and recorded total check time
and numbers of kernel stacks. The average time of checking kernel stacks
reduced by 48%.


Signed-off-by: Xiaofeng Yuan <yuanxiaofeng1@huawei.com>
---
 mm/usercopy.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/mm/usercopy.c b/mm/usercopy.c
index e9e9325..af350f6 100644
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -255,6 +255,29 @@ void __check_object_size(const void *ptr, unsigned long n, bool to_user)
 	/* Check for invalid addresses. */
 	check_bogus_address((const unsigned long)ptr, n, to_user);
 
+#if !defined(CONFIG_HARDENED_USERCOPY_PAGESPAN) && \
+    !defined(CONFIG_ARCH_THREAD_STACK_ALLOCATOR) && \
+    (THREAD_SIZE >= PAGE_SIZE || defined(CONFIG_VMAP_STACK))
+	/* Check for bad stack object. */
+	switch (check_stack_object(ptr, n)) {
+	case NOT_STACK:
+		/* Object is not touching the current process stack. */
+		break;
+	case GOOD_FRAME:
+	case GOOD_STACK:
+		/*
+		 * Object is either in the correct frame (when it
+		 * is possible to check) or just generally on the
+		 * process stack (when frame checking not available).
+		 */
+		return;
+	default:
+		usercopy_abort("process stack", NULL, to_user, 0, n);
+	}
+
+	/* Check for bad heap object. */
+	check_heap_object(ptr, n, to_user);
+#else
 	/* Check for bad heap object. */
 	check_heap_object(ptr, n, to_user);
 
@@ -274,6 +297,7 @@ void __check_object_size(const void *ptr, unsigned long n, bool to_user)
 	default:
 		usercopy_abort("process stack", NULL, to_user, 0, n);
 	}
+#endif
 
 	/* Check for object in kernel to avoid text exposure. */
 	check_kernel_text_object((const unsigned long)ptr, n, to_user);
-- 
1.9.1

