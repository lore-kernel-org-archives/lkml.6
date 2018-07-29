Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30CFF83CA1
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 06:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D8A920893
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 06:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzgxFwPt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D8A920893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbeG2Hk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 03:40:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbeG2Hk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 03:40:59 -0400
Received: from localhost (c-67-160-202-76.hsd1.ca.comcast.net [67.160.202.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96EA020873;
        Sun, 29 Jul 2018 06:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532844703;
        bh=gQNI9okL36LztvS5XviqLkk5XvXWPG6XjXfVpFsDn2A=;
        h=From:To:Cc:Subject:Date:From;
        b=hzgxFwPt92Cr7UeI93KAVqhdbPsbEJ93V3oJTe9OUXyjHnjn/sSSuIxwbyfXFVAh2
         O4Xlr5ZXb0PV2CDMZsCXYBOriYW5liWrGxOq8ZLpWUmfMyysKv78+QAT3JF4gFXViQ
         aJJ9od3JhA9YBJuZ+qUEk5qlKmY8bv/oWTBao+A8=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: return fake len for quota if cp is shutdown
Date:   Sat, 28 Jul 2018 23:11:41 -0700
Message-Id: <20180729061141.4846-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If cp is shutdown, let's just return success to unmount the partition.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index e0a828188f65..d56bc6eb8760 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1625,6 +1625,10 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
 	int tocopy;
 
 	while (towrite > 0) {
+
+		if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
+			return len;
+
 		tocopy = min_t(unsigned long, sb->s_blocksize - offset,
 								towrite);
 retry:
-- 
2.17.0.441.gb46fe60e1d-goog

