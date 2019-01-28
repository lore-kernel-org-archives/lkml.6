Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015EBC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB8EF2148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548692335;
	bh=S57QohYHsGAIlZI93+42YFU/Aqip7Ade/8Mz+dbvEyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tBMoxBasGp5zQvAQzofR6bUjI39q/yt76pGEkbKTZcPHpqiV/NdSdHJtCe2wSwxvC
	 cY6h7umRezBBZkEiy1Gj9T7NkwtD5WWDdVIJ5UiJj9ziIK8ZorJBTZ7NJAAWM/e9Mr
	 q4QcSaQLeTdqFEO9baNiaFYVeX7Xs9qmijI2sLzc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387927AbfA1QSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:18:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:53144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387976AbfA1QSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:18:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34DF42175B;
        Mon, 28 Jan 2019 16:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692326;
        bh=S57QohYHsGAIlZI93+42YFU/Aqip7Ade/8Mz+dbvEyk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GhmAErRDdisYJPKL+zcxdtx6IGjIzrolCWZfVOPzbh5GJ8TiDZwZxTmwxCyt/yE6s
         WD4a/A48IYCQoxIJOavaaqUpVaKV+PD1x+euPTaj0cYDpdsVuM5+lFZ3MpQAwl2i9A
         tyiNNP7ZmS2JShYvipZ3Hb6WZ/lHjIAWFwC4ypE8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Miles Chen <miles.chen@mediatek.com>,
        Joe Perches <joe@perches.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org
Subject: [PATCH AUTOSEL 4.14 153/170] mm/page_owner: clamp read count to PAGE_SIZE
Date:   Mon, 28 Jan 2019 11:11:43 -0500
Message-Id: <20190128161200.55107-153-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miles Chen <miles.chen@mediatek.com>

[ Upstream commit c8f61cfc871fadfb73ad3eacd64fda457279e911 ]

The (root-only) page owner read might allocate a large size of memory with
a large read count.  Allocation fails can easily occur when doing high
order allocations.

Clamp buffer size to PAGE_SIZE to avoid arbitrary size allocation
and avoid allocation fails due to high order allocation.

[akpm@linux-foundation.org: use min_t()]
Link: http://lkml.kernel.org/r/1541091607-27402-1-git-send-email-miles.chen@mediatek.com
Signed-off-by: Miles Chen <miles.chen@mediatek.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Joe Perches <joe@perches.com>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_owner.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index a71fe4c623ef..7232c6e24234 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -351,6 +351,7 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
 		.skip = 0
 	};
 
+	count = min_t(size_t, count, PAGE_SIZE);
 	kbuf = kmalloc(count, GFP_KERNEL);
 	if (!kbuf)
 		return -ENOMEM;
-- 
2.19.1

