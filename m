Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DE4C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DCC52084A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUKZkRet"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DCC52084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730743AbeKAIJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:09:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:60196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730659AbeKAIJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:09:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EB6A2084A;
        Wed, 31 Oct 2018 23:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027383;
        bh=/HuDTDEc3gcaDaKMXd7gMKlIbW/K1yYOSuDjjy4HTN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AUKZkRet5c3yl0NJqmTkX5w4gynzP3Hu9DiMNP9E4W4eO+ZSMbQFvL167uhydMKYI
         4zb0EY2tnJIq0tkP5tCqD6OeV802IOKnaGR/kYA/hFjgvbhBbp3TmAIeo0k+5eBBdq
         KqOLRSneDi/OSSKu2bvj2ogtA/bOSKY6akS+k+Yo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yunlei He <heyunlei@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 121/126] f2fs: report error if quota off error during umount
Date:   Wed, 31 Oct 2018 19:07:49 -0400
Message-Id: <20181031230754.29029-121-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230754.29029-1-sashal@kernel.org>
References: <20181031230754.29029-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunlei He <heyunlei@huawei.com>

[ Upstream commit cda9cc595f0bb6ffa51a4efc4b6533dfa4039b4c ]

Now, we depend on fsck to ensure quota file data is ok,
so we scan whole partition if checkpoint without umount
flag. It's same for quota off error case, which may make
quota file data inconsistent.

generic/019 reports below error:

 __quota_error: 1160 callbacks suppressed
 Quota error (device zram1): write_blk: dquota write failed
 Quota error (device zram1): qtree_write_dquot: Error -28 occurred while creating quota
 Quota error (device zram1): write_blk: dquota write failed
 Quota error (device zram1): qtree_write_dquot: Error -28 occurred while creating quota
 Quota error (device zram1): write_blk: dquota write failed
 Quota error (device zram1): qtree_write_dquot: Error -28 occurred while creating quota
 Quota error (device zram1): write_blk: dquota write failed
 Quota error (device zram1): qtree_write_dquot: Error -28 occurred while creating quota
 Quota error (device zram1): write_blk: dquota write failed
 Quota error (device zram1): qtree_write_dquot: Error -28 occurred while creating quota
 VFS: Busy inodes after unmount of zram1. Self-destruct in 5 seconds.  Have a nice day...

If we failed in below path due to fail to write dquot block, we will miss
to release quota inode, fix it.

- f2fs_put_super
 - f2fs_quota_off_umount
  - f2fs_quota_off
   - f2fs_quota_sync   <-- failed
   - dquot_quota_off   <-- missed to call

Signed-off-by: Yunlei He <heyunlei@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 742147cbe759..a3e90e6f72a8 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1820,7 +1820,9 @@ static int f2fs_quota_off(struct super_block *sb, int type)
 	if (!inode || !igrab(inode))
 		return dquot_quota_off(sb, type);
 
-	f2fs_quota_sync(sb, type);
+	err = f2fs_quota_sync(sb, type);
+	if (err)
+		goto out_put;
 
 	err = dquot_quota_off(sb, type);
 	if (err || f2fs_sb_has_quota_ino(sb))
@@ -1839,9 +1841,20 @@ static int f2fs_quota_off(struct super_block *sb, int type)
 void f2fs_quota_off_umount(struct super_block *sb)
 {
 	int type;
+	int err;
+
+	for (type = 0; type < MAXQUOTAS; type++) {
+		err = f2fs_quota_off(sb, type);
+		if (err) {
+			int ret = dquot_quota_off(sb, type);
 
-	for (type = 0; type < MAXQUOTAS; type++)
-		f2fs_quota_off(sb, type);
+			f2fs_msg(sb, KERN_ERR,
+				"Fail to turn off disk quota "
+				"(type: %d, err: %d, ret:%d), Please "
+				"run fsck to fix it.", type, err, ret);
+			set_sbi_flag(F2FS_SB(sb), SBI_NEED_FSCK);
+		}
+	}
 }
 
 static int f2fs_get_projid(struct inode *inode, kprojid_t *projid)
-- 
2.17.1

