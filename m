Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612DCECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A5B20868
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWWvLIV2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A5B20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbeJYWre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:47:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:55596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728532AbeJYWrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:47:33 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1360820856;
        Thu, 25 Oct 2018 14:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476877;
        bh=r+BP4uZoLG1zK5wUhXp9vFFcPCLQIBwbaCPHVBnpjKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EWWvLIV2lrAl5IysfXGhQxO4pHNR5L6EXVb5HyVc0UEAhQ9qyezenQLbYnOBudUIe
         4kTEynoaOi2pV5HtCcWJKB07OGrSSLcM/MlHKui2norX+U6egBySBIhDsZCXnQEEh3
         v1ujCrCaKAYCTgVHipzGP7ML2MhtxVn4oCxh1I/s=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sheng Yong <shengyong1@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 06/98] f2fs: fix multiple f2fs_add_link() having same name for inline dentry
Date:   Thu, 25 Oct 2018 10:12:51 -0400
Message-Id: <20181025141423.213774-6-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sheng Yong <shengyong1@huawei.com>

[ Upstream commit d3bb910c15d75ee3340311c64a1c05985bb663a3 ]

Commit 88c5c13a5027 (f2fs: fix multiple f2fs_add_link() calls having
same name) does not cover the scenario where inline dentry is enabled.
In that case, F2FS_I(dir)->task will be NULL, and __f2fs_add_link will
lookup dentries one more time.

This patch fixes it by moving the assigment of current task to a upper
level to cover both normal and inline dentry.

Cc: <stable@vger.kernel.org>
Fixes: 88c5c13a5027 (f2fs: fix multiple f2fs_add_link() calls having same name)
Signed-off-by: Sheng Yong <shengyong1@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/dir.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 8add4e8bab99..af719d93507e 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -212,13 +212,9 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 		f2fs_put_page(dentry_page, 0);
 	}
 
-	/* This is to increase the speed of f2fs_create */
-	if (!de && room) {
-		F2FS_I(dir)->task = current;
-		if (F2FS_I(dir)->chash != namehash) {
-			F2FS_I(dir)->chash = namehash;
-			F2FS_I(dir)->clevel = level;
-		}
+	if (!de && room && F2FS_I(dir)->chash != namehash) {
+		F2FS_I(dir)->chash = namehash;
+		F2FS_I(dir)->clevel = level;
 	}
 
 	return de;
@@ -259,6 +255,9 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
 			break;
 	}
 out:
+	/* This is to increase the speed of f2fs_create */
+	if (!de)
+		F2FS_I(dir)->task = current;
 	return de;
 }
 
-- 
2.17.1

