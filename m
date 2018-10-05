Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E48C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D969213A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WY08ASR/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D969213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbeJEXCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:02:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:48108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbeJEXCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:02:43 -0400
Received: from localhost (unknown [104.132.1.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43D922084D;
        Fri,  5 Oct 2018 16:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538755403;
        bh=DcnMmqnDnnbUpxBfJ/U+Mhr+mjQppLS+z/6gFVmPxMs=;
        h=From:To:Cc:Subject:Date:From;
        b=WY08ASR/35cCH4Q0OJkrTVPJXeeBu+LTjc9kBdVZ2F4QV/P2QDyMP2nU6FYK31Qzd
         LVve+Vsfjrd0YMoBuKQ1OBXKzFNtTBUfppCg1ksTizaVLW0LHHantxnIHnngPF3yqa
         lMF0SLJKDIDQ9G4+13bqsy3wMqF3Watber8/nC44=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: allow to mount, if quota is failed
Date:   Fri,  5 Oct 2018 09:03:22 -0700
Message-Id: <20181005160322.42871-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we can use the filesystem without quotas till next boot.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 94eb7b55fc49..b3991e99a626 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3288,11 +3288,9 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	/* Enable quota usage during mount */
 	if (f2fs_sb_has_quota_ino(sb) && !f2fs_readonly(sb)) {
 		err = f2fs_enable_quotas(sb);
-		if (err) {
+		if (err)
 			f2fs_msg(sb, KERN_ERR,
 				"Cannot turn on quotas: error %d", err);
-			goto free_sysfs;
-		}
 	}
 #endif
 	/* if there are nt orphan nodes free them */
@@ -3393,9 +3391,6 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	 * falls into an infinite loop in f2fs_sync_meta_pages().
 	 */
 	truncate_inode_pages_final(META_MAPPING(sbi));
-#ifdef CONFIG_QUOTA
-free_sysfs:
-#endif
 	f2fs_unregister_sysfs(sbi);
 free_root_inode:
 	dput(sb->s_root);
-- 
2.19.0.605.g01d371f741-goog

