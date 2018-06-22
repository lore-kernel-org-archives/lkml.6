Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B15AC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 143DB2150C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143DB2150C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751325AbeFVHSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 03:18:34 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:60114 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751164AbeFVHSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 03:18:32 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by baptiste.telenet-ops.be with bizsmtp
        id 1jJW1y0263XaVaC01jJW3a; Fri, 22 Jun 2018 09:18:31 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fWGL0-0007em-N3; Fri, 22 Jun 2018 09:18:30 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fWGL0-0000Nx-Ld; Fri, 22 Jun 2018 09:18:30 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        David Sterba <dsterba@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2] btrfs: Refactor count handling in btrfs_unpin_free_ino()
Date:   Fri, 22 Jun 2018 09:18:29 +0200
Message-Id: <20180622071829.1356-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With gcc 4.1.2:

    fs/btrfs/inode-map.c: In function ‘btrfs_unpin_free_ino’:
    fs/btrfs/inode-map.c:241: warning: ‘count’ may be used uninitialized in this function

While this warning is a false-positive, it can easily be killed by
refactoring the code.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Please review. Compile-tested only.

v2:
  - Rebased.
---
 fs/btrfs/inode-map.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/inode-map.c b/fs/btrfs/inode-map.c
index 12fcd8897c3368df..a56f88ea9c735d18 100644
--- a/fs/btrfs/inode-map.c
+++ b/fs/btrfs/inode-map.c
@@ -244,8 +244,6 @@ void btrfs_unpin_free_ino(struct btrfs_root *root)
 		return;
 
 	while (1) {
-		bool add_to_ctl = true;
-
 		spin_lock(rbroot_lock);
 		n = rb_first(rbroot);
 		if (!n) {
@@ -257,15 +255,14 @@ void btrfs_unpin_free_ino(struct btrfs_root *root)
 		BUG_ON(info->bitmap); /* Logic error */
 
 		if (info->offset > root->ino_cache_progress)
-			add_to_ctl = false;
-		else if (info->offset + info->bytes > root->ino_cache_progress)
-			count = root->ino_cache_progress - info->offset + 1;
+			count = 0;
 		else
-			count = info->bytes;
+			count = min(root->ino_cache_progress - info->offset + 1,
+				    info->bytes);
 
 		rb_erase(&info->offset_index, rbroot);
 		spin_unlock(rbroot_lock);
-		if (add_to_ctl)
+		if (count)
 			__btrfs_add_free_space(root->fs_info, ctl,
 					       info->offset, count);
 		kmem_cache_free(btrfs_free_space_cachep, info);
-- 
2.17.1

