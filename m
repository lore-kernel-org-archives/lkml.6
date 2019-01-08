Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD84C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E33206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbfAHLJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 06:09:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:44062 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727107AbfAHLJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 06:09:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A5EFAAE6E;
        Tue,  8 Jan 2019 11:09:54 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Roman Penyaev <rpenyaev@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Michal Hocko <mhocko@suse.com>,
        "David S . Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] mm/vmalloc: Make vmalloc_32_user() align base kernel virtual address to SHMLBA
Date:   Tue,  8 Jan 2019 12:09:44 +0100
Message-Id: <20190108110944.23591-1-rpenyaev@suse.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch repeats the original one from David S. Miller:

  2dca6999eed5 ("mm, perf_event: Make vmalloc_user() align base kernel virtual address to SHMLBA")

but for missed vmalloc_32_user() case, which also requires correct
alignment of virtual address on kernel side to avoid D-caches
aliases.  A bit of copy-paste from original patch to recover in
memory of what is all about:

  When a vmalloc'd area is mmap'd into userspace, some kind of
  co-ordination is necessary for this to work on platforms with cpu
  D-caches which can have aliases.

  Otherwise kernel side writes won't be seen properly in userspace
  and vice versa.

  If the kernel side mapping and the user side one have the same
  alignment, modulo SHMLBA, this can work as long as VM_SHARED is
  shared of VMA and for all current users this is true.  VM_SHARED
  will force SHMLBA alignment of the user side mmap on platforms with
  D-cache aliasing matters.

  David S. Miller

Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Michal Hocko <mhocko@suse.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 50b17c745149..e83961767dc1 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1971,7 +1971,7 @@ EXPORT_SYMBOL(vmalloc_32);
  */
 void *vmalloc_32_user(unsigned long size)
 {
-	return __vmalloc_node_range(size, 1,  VMALLOC_START, VMALLOC_END,
+	return __vmalloc_node_range(size, SHMLBA,  VMALLOC_START, VMALLOC_END,
 				    GFP_VMALLOC32 | __GFP_ZERO, PAGE_KERNEL,
 				    VM_USERMAP, NUMA_NO_NODE,
 				    __builtin_return_address(0));
-- 
2.19.1

