Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3565C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C7BF208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4oSpAIE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C7BF208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406308AbeHATJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:09:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:58342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405186AbeHATJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:09:32 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD6C420844;
        Wed,  1 Aug 2018 17:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533144170;
        bh=U8Tl2F4aUsPdFWVE6dN+oQYLeOzbJqPZtekLJXP1PsY=;
        h=From:To:Cc:Subject:Date:From;
        b=K4oSpAIELES0dqW7zXr0mqOtIZwmofEkTFWZcVvw4mZnYrbzLF4DOqNbyOLlXvrB2
         F9BTB1/0DWyFrC/saWJQnDzbjoVNfn3Y69RQCbl2opxAUBSxRuAxWgnse+GYFjDOPb
         +Lh7Fdx33ME4Oxc+9uCgKy5Hn9ratTMFrXK1MqrY=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: avoid f2fs_bug_on() in cp_error case
Date:   Wed,  1 Aug 2018 10:22:49 -0700
Message-Id: <20180801172249.57306-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a subtle race condition to invoke f2fs_bug_on() in shutdown tests. I've
confirmed that the last checkpoint is preserved in consistent state, so it'd be
fine to just return error at this moment.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 6055d2d12640..21ffb784764c 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1075,6 +1075,10 @@ int f2fs_remove_inode_page(struct inode *inode)
 		f2fs_truncate_data_blocks_range(&dn, 1);
 
 	/* 0 is possible, after f2fs_new_inode() has failed */
+	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode)))) {
+		f2fs_put_dnode(&dn);
+		return -EIO;
+	}
 	f2fs_bug_on(F2FS_I_SB(inode),
 			inode->i_blocks != 0 && inode->i_blocks != 8);
 
-- 
2.17.0.441.gb46fe60e1d-goog

