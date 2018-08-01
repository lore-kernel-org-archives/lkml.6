Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B10EC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C11E0208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C11E0208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406377AbeHATJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:09:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50868 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405274AbeHATJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:09:53 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 41262CC9;
        Wed,  1 Aug 2018 17:23:11 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chengguang Xu <cgxu@mykernel.net>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 225/246] ovl: Sync upper dirty data when syncing overlayfs
Date:   Wed,  1 Aug 2018 18:52:15 +0200
Message-Id: <20180801165022.470509225@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165011.700991984@linuxfoundation.org>
References: <20180801165011.700991984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chengguang Xu <cgxu@mykernel.net>

commit e8d4bfe3a71537284a90561f77c85dea6c154369 upstream.

When executing filesystem sync or umount on overlayfs,
dirty data does not get synced as expected on upper filesystem.
This patch fixes sync filesystem method to keep data consistency
for overlayfs.

Signed-off-by: Chengguang Xu <cgxu@mykernel.net>
Fixes: e593b2bf513d ("ovl: properly implement sync_filesystem()")
Cc: <stable@vger.kernel.org> #4.11
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/overlayfs/super.c |   19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -232,6 +232,7 @@ static void ovl_put_super(struct super_b
 	kfree(ufs);
 }
 
+/* Sync real dirty inodes in upper filesystem (if it exists) */
 static int ovl_sync_fs(struct super_block *sb, int wait)
 {
 	struct ovl_fs *ufs = sb->s_fs_info;
@@ -240,14 +241,24 @@ static int ovl_sync_fs(struct super_bloc
 
 	if (!ufs->upper_mnt)
 		return 0;
-	upper_sb = ufs->upper_mnt->mnt_sb;
-	if (!upper_sb->s_op->sync_fs)
+
+	/*
+	 * If this is a sync(2) call or an emergency sync, all the super blocks
+	 * will be iterated, including upper_sb, so no need to do anything.
+	 *
+	 * If this is a syncfs(2) call, then we do need to call
+	 * sync_filesystem() on upper_sb, but enough if we do it when being
+	 * called with wait == 1.
+	 */
+	if (!wait)
 		return 0;
 
-	/* real inodes have already been synced by sync_filesystem(ovl_sb) */
+	upper_sb = ufs->upper_mnt->mnt_sb;
+
 	down_read(&upper_sb->s_umount);
-	ret = upper_sb->s_op->sync_fs(upper_sb, wait);
+	ret = sync_filesystem(upper_sb);
 	up_read(&upper_sb->s_umount);
+
 	return ret;
 }
 


