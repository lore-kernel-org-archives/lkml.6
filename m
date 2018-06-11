Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Kb9XHHNIHlsVFQAAmS7hNA
	; Mon, 11 Jun 2018 10:03:09 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5255660792; Mon, 11 Jun 2018 10:03:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B94C7606FA;
	Mon, 11 Jun 2018 10:03:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B94C7606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932815AbeFKKDH (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 06:03:07 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56089 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S932453AbeFKKDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 06:03:04 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E28B6972C86D3;
        Mon, 11 Jun 2018 18:02:59 +0800 (CST)
Received: from SZV1000284525.huawei.com (10.120.216.130) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.382.0; Mon, 11 Jun 2018 18:02:52 +0800
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: fix error path of fill_super
Date: Mon, 11 Jun 2018 18:02:02 +0800
Message-ID: <20180611100202.68674-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20180611100202.68674-1-yuchao0@huawei.com>
References: <20180611100202.68674-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In fill_super, if root inode's attribute is incorrect, we need to
call f2fs_destroy_stats to release stats memory.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 19ef966a99e9..a790dae6c16f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2914,7 +2914,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	if (!S_ISDIR(root->i_mode) || !root->i_blocks || !root->i_size) {
 		iput(root);
 		err = -EINVAL;
-		goto free_node_inode;
+		goto free_stats;
 	}
 
 	sb->s_root = d_make_root(root); /* allocate root dentry */
-- 
2.18.0.rc1
