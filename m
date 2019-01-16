Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F37C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD17C20859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391557AbfAPJBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 04:01:31 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:49278 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729385AbfAPJBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 04:01:31 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F3454F5771ABC8CEE8B7;
        Wed, 16 Jan 2019 17:01:28 +0800 (CST)
Received: from 138.huawei.com (10.175.124.28) by smtp.huawei.com (10.3.19.206)
 with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 16 Jan 2019 17:01:22
 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 1/5] staging: erofs: sunset erofs_workstation_cleanup_all
Date:   Wed, 16 Jan 2019 16:59:52 +0800
Message-ID: <20190116085956.21004-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.14.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is only one user calling erofs_workstation_cleanup_all,
and it is no likely that more users will use in that way
in the future.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
Hi,

 These 5 patches are all cleanup patches, no logic change.

Thanks,
Gao Xiang

 drivers/staging/erofs/internal.h | 5 -----
 drivers/staging/erofs/super.c    | 3 ++-
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index c3de24e7fb67..80cc09ea787d 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -283,11 +283,6 @@ extern int erofs_register_workgroup(struct super_block *sb,
 extern unsigned long erofs_shrink_workstation(struct erofs_sb_info *sbi,
 	unsigned long nr_shrink, bool cleanup);
 
-static inline void erofs_workstation_cleanup_all(struct super_block *sb)
-{
-	erofs_shrink_workstation(EROFS_SB(sb), ~0UL, true);
-}
-
 extern void erofs_workgroup_free_rcu(struct erofs_workgroup *grp);
 
 #ifdef EROFS_FS_HAS_MANAGED_CACHE
diff --git a/drivers/staging/erofs/super.c b/drivers/staging/erofs/super.c
index 45c7f6ddb9f5..69e1840d3842 100644
--- a/drivers/staging/erofs/super.c
+++ b/drivers/staging/erofs/super.c
@@ -494,7 +494,8 @@ static void erofs_put_super(struct super_block *sb)
 	mutex_lock(&sbi->umount_mutex);
 
 #ifdef CONFIG_EROFS_FS_ZIP
-	erofs_workstation_cleanup_all(sb);
+	/* clean up the compression space of this sb */
+	erofs_shrink_workstation(EROFS_SB(sb), ~0UL, true);
 #endif
 
 	erofs_unregister_super(sb);
-- 
2.14.4

