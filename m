Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B37DC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64AD62081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:00:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64AD62081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbeKBCEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 22:04:15 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:62587 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725982AbeKBCEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 22:04:15 -0400
X-UUID: 3963096f438c4c29b4b5f2f4c69d258f-20181102
X-UUID: 3963096f438c4c29b4b5f2f4c69d258f-20181102
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1551470932; Fri, 02 Nov 2018 01:00:16 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 2 Nov 2018 01:00:09 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 2 Nov 2018 01:00:08 +0800
From:   <miles.chen@mediatek.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Joe Perches <joe@perches.com>,
        Matthew Wilcox <willy@infradead.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: [PATCH v4] mm/page_owner: clamp read count to PAGE_SIZE
Date:   Fri, 2 Nov 2018 01:00:07 +0800
Message-ID: <1541091607-27402-1-git-send-email-miles.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miles Chen <miles.chen@mediatek.com>

The page owner read might allocate a large size of memory with
a large read count. Allocation fails can easily occur when doing
high order allocations.

Clamp buffer size to PAGE_SIZE to avoid arbitrary size allocation
and avoid allocation fails due to high order allocation.

Change since v3:
  - remove the change in kvmalloc
  - keep kmalloc in page_owner.c

Change since v2:
  - improve kvmalloc, allow sub page allocations fallback to
    vmalloc when CONFIG_HIGHMEM=y

Change since v1:
  - use kvmalloc()
  - clamp buffer size to PAGE_SIZE

Signed-off-by: Miles Chen <miles.chen@mediatek.com>
Cc: Joe Perches <joe@perches.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Michal Hocko <mhocko@kernel.org>
---
 mm/page_owner.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index 87bc0dfdb52b..b83f295e4eca 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -351,6 +351,7 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
 		.skip = 0
 	};
 
+	count = count > PAGE_SIZE ? PAGE_SIZE : count;
 	kbuf = kmalloc(count, GFP_KERNEL);
 	if (!kbuf)
 		return -ENOMEM;
-- 
2.18.0

