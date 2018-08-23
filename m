Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C87C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 483AC206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 483AC206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbeHWLiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:38:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45244 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbeHWLiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:38:11 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5AC30C74;
        Thu, 23 Aug 2018 08:09:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhen Lei <thunder.leizhen@huawei.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 074/130] kasan: fix shadow_size calculation error in kasan_module_alloc
Date:   Thu, 23 Aug 2018 09:53:10 +0200
Message-Id: <20180823074932.128556224@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074927.161454870@linuxfoundation.org>
References: <20180823074927.161454870@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhen Lei <thunder.leizhen@huawei.com>

[ Upstream commit 1e8e18f694a52d703665012ca486826f64bac29d ]

There is a special case that the size is "(N << KASAN_SHADOW_SCALE_SHIFT)
Pages plus X", the value of X is [1, KASAN_SHADOW_SCALE_SIZE-1].  The
operation "size >> KASAN_SHADOW_SCALE_SHIFT" will drop X, and the
roundup operation can not retrieve the missed one page.  For example:
size=0x28006, PAGE_SIZE=0x1000, KASAN_SHADOW_SCALE_SHIFT=3, we will get
shadow_size=0x5000, but actually we need 6 pages.

  shadow_size = round_up(size >> KASAN_SHADOW_SCALE_SHIFT, PAGE_SIZE);

This can lead to a kernel crash when kasan is enabled and the value of
mod->core_layout.size or mod->init_layout.size is like above.  Because
the shadow memory of X has not been allocated and mapped.

move_module:
  ptr = module_alloc(mod->core_layout.size);
  ...
  memset(ptr, 0, mod->core_layout.size);		//crashed

  Unable to handle kernel paging request at virtual address ffff0fffff97b000
  ......
  Call trace:
    __asan_storeN+0x174/0x1a8
    memset+0x24/0x48
    layout_and_allocate+0xcd8/0x1800
    load_module+0x190/0x23e8
    SyS_finit_module+0x148/0x180

Link: http://lkml.kernel.org/r/1529659626-12660-1-git-send-email-thunder.leizhen@huawei.com
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Reviewed-by: Dmitriy Vyukov <dvyukov@google.com>
Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Libin <huawei.libin@huawei.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/kasan/kasan.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/mm/kasan/kasan.c
+++ b/mm/kasan/kasan.c
@@ -660,12 +660,13 @@ void kasan_kfree_large(const void *ptr)
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


