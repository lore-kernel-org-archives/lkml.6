Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD69ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EAF320BEC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:42:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EAF320BEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731624AbeGQNPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 09:15:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9632 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731213AbeGQNPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 09:15:22 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A981F8C9E1815;
        Tue, 17 Jul 2018 20:42:37 +0800 (CST)
Received: from SZV1000284525.huawei.com (10.120.216.130) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.382.0; Tue, 17 Jul 2018 20:42:30 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/5] f2fs: clean up with get_current_nat_page
Date:   Tue, 17 Jul 2018 20:41:46 +0800
Message-ID: <20180717124149.32523-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20180717124149.32523-1-yuchao0@huawei.com>
References: <20180717124149.32523-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just cleanup, no logic change.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/node.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 99dc1a1d02e3..021d095dc3c5 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -113,25 +113,22 @@ static void clear_node_page_dirty(struct page *page)
 
 static struct page *get_current_nat_page(struct f2fs_sb_info *sbi, nid_t nid)
 {
-	pgoff_t index = current_nat_addr(sbi, nid);
-	return f2fs_get_meta_page_nofail(sbi, index);
+	return f2fs_get_meta_page_nofail(sbi, current_nat_addr(sbi, nid));
 }
 
 static struct page *get_next_nat_page(struct f2fs_sb_info *sbi, nid_t nid)
 {
 	struct page *src_page;
 	struct page *dst_page;
-	pgoff_t src_off;
 	pgoff_t dst_off;
 	void *src_addr;
 	void *dst_addr;
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 
-	src_off = current_nat_addr(sbi, nid);
-	dst_off = next_nat_addr(sbi, src_off);
+	dst_off = next_nat_addr(sbi, current_nat_addr(sbi, nid));
 
 	/* get current nat block page with lock */
-	src_page = f2fs_get_meta_page(sbi, src_off);
+	src_page = get_current_nat_page(sbi, nid);
 	dst_page = f2fs_grab_meta_page(sbi, dst_off);
 	f2fs_bug_on(sbi, PageDirty(src_page));
 
-- 
2.18.0.rc1

