Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C04AC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E5C120644
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E5C120644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbeJNXhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:37:04 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36041 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727718AbeJNXLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:55 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLh-0004cd-TZ; Sun, 14 Oct 2018 16:30:34 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLa-0000jq-KC; Sun, 14 Oct 2018 16:30:26 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Al Viro" <viro@zeniv.linux.org.uk>,
        "David Sterba" <dsterba@suse.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.533778459@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 340/366] affs_lookup(): close a race with
 affs_remove_link()
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

commit 30da870ce4a4e007c901858a96e9e394a1daa74a upstream.

we unlock the directory hash too early - if we are looking at secondary
link and primary (in another directory) gets removed just as we unlock,
we could have the old primary moved in place of the secondary, leaving
us to look into freed entry (and leaving our dentry with ->d_fsdata
pointing to a freed entry).

Acked-by: David Sterba <dsterba@suse.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/affs/namei.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/fs/affs/namei.c
+++ b/fs/affs/namei.c
@@ -224,9 +224,10 @@ affs_lookup(struct inode *dir, struct de
 
 	affs_lock_dir(dir);
 	bh = affs_find_entry(dir, dentry);
-	affs_unlock_dir(dir);
-	if (IS_ERR(bh))
+	if (IS_ERR(bh)) {
+		affs_unlock_dir(dir);
 		return ERR_CAST(bh);
+	}
 	if (bh) {
 		u32 ino = bh->b_blocknr;
 
@@ -240,10 +241,13 @@ affs_lookup(struct inode *dir, struct de
 		}
 		affs_brelse(bh);
 		inode = affs_iget(sb, ino);
-		if (IS_ERR(inode))
+		if (IS_ERR(inode)) {
+			affs_unlock_dir(dir);
 			return ERR_CAST(inode);
+		}
 	}
 	d_add(dentry, inode);
+	affs_unlock_dir(dir);
 	return NULL;
 }
 

