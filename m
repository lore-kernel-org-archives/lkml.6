Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BF1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 07:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2F4B223DD
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 07:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTn9mHRw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2F4B223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbeKOR5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 12:57:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:36590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbeKOR5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 12:57:24 -0500
Received: from localhost (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B998621582;
        Thu, 15 Nov 2018 07:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542268240;
        bh=dW5thBo9QZtFQDiLs1oyMwoVBSfecm34gHQIkSStpO4=;
        h=From:To:Cc:Subject:Date:From;
        b=gTn9mHRw0gRcY+dD/Cio28cBNZnu1PbKV0LAcPjVRm1sya10Fdndwi66E5KKj0CWS
         Gma5rzc55D2A5FsY92AcBQExvun6OblzOdJ9bEyVY3Bj8+YntURT0vSw69y5WW8/Gj
         gHFpNInbn21PKGlQDFbNc6udTbMiXpqN8QERpBAs=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: check memory boundary by insane namelen
Date:   Wed, 14 Nov 2018 23:50:40 -0800
Message-Id: <20181115075040.83500-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If namelen is corrupted to have very long value, fill_dentries can copy
wrong memory area.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/dir.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index bacc667950b6..c0c845da12fa 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -808,6 +808,17 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 		de_name.name = d->filename[bit_pos];
 		de_name.len = le16_to_cpu(de->name_len);
 
+		/* check memory boundary before moving forward */
+		bit_pos += GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
+		if (unlikely(bit_pos > d->max)) {
+			f2fs_msg(sbi->sb, KERN_WARNING,
+				"%s: corrupted namelen=%d, run fsck to fix.",
+				__func__, le16_to_cpu(de->name_len));
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			err = -EINVAL;
+			goto out;
+		}
+
 		if (f2fs_encrypted_inode(d->inode)) {
 			int save_len = fstr->len;
 
@@ -830,7 +841,6 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 		if (readdir_ra)
 			f2fs_ra_node_page(sbi, le32_to_cpu(de->ino));
 
-		bit_pos += GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
 		ctx->pos = start_pos + bit_pos;
 	}
 out:
-- 
2.19.0.605.g01d371f741-goog

