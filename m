Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id vVxzLuhIHlsrGQAAmS7hNA
	; Mon, 11 Jun 2018 10:03:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B0F33607BB; Mon, 11 Jun 2018 10:03:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 43006606FA;
	Mon, 11 Jun 2018 10:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 43006606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932791AbeFKKDG (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 06:03:06 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56079 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S932263AbeFKKDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 06:03:04 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C0CF1B15DAEC;
        Mon, 11 Jun 2018 18:02:59 +0800 (CST)
Received: from SZV1000284525.huawei.com (10.120.216.130) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.382.0; Mon, 11 Jun 2018 18:02:51 +0800
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: relocate readdir_ra configure initialization
Date: Mon, 11 Jun 2018 18:02:01 +0800
Message-ID: <20180611100202.68674-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

readdir_ra is sysfs configuration instead of mount option, so it should
not be initialized in default_options(), otherwise after remount, it can
be reset to be enabled which may not as user wish, so let's move it to
f2fs_tuning_parameters().

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 56f3af86f62c..19ef966a99e9 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1357,7 +1357,6 @@ static void default_options(struct f2fs_sb_info *sbi)
 	F2FS_OPTION(sbi).test_dummy_encryption = false;
 	F2FS_OPTION(sbi).s_resuid = make_kuid(&init_user_ns, F2FS_DEF_RESUID);
 	F2FS_OPTION(sbi).s_resgid = make_kgid(&init_user_ns, F2FS_DEF_RESGID);
-	sbi->readdir_ra = 1;
 
 	set_opt(sbi, BG_GC);
 	set_opt(sbi, INLINE_XATTR);
@@ -2655,6 +2654,8 @@ static void f2fs_tuning_parameters(struct f2fs_sb_info *sbi)
 		sm_i->dcc_info->discard_granularity = 1;
 		sm_i->ipu_policy = 1 << F2FS_IPU_FORCE;
 	}
+
+	sbi->readdir_ra = 1;
 }
 
 static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
-- 
2.18.0.rc1
