Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B866C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4948120876
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:30:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4948120876
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbeJNXL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:11:58 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36113 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727871AbeJNXL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:57 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLl-0004cW-3w; Sun, 14 Oct 2018 16:30:37 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLY-0000dw-N2; Sun, 14 Oct 2018 16:30:24 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Jan Kara" <jack@suse.cz>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Fabian Frederick" <fabf@skynet.be>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.361847216@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 292/366] ufs: Fix possible deadlock when looking up
 directories
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

From: Jan Kara <jack@suse.cz>

commit 514d748f69c97a51a2645eb198ac5c6218f22ff9 upstream.

Commit e4502c63f56aeca88 (ufs: deal with nfsd/iget races) made ufs
create inodes with I_NEW flag set. However ufs_mkdir() never cleared
this flag. Thus if someone ever tried to lookup the directory by inode
number, he would deadlock waiting for I_NEW to be cleared. Luckily this
mostly happens only if the filesystem is exported over NFS since
otherwise we have the inode attached to dentry and don't look it up by
inode number. In rare cases dentry can get freed without inode being
freed and then we'd hit the deadlock even without NFS export.

Fix the problem by clearing I_NEW before instantiating new directory
inode.

Fixes: e4502c63f56aeca887ced37f24e0def1ef11cec8
Reported-by: Fabian Frederick <fabf@skynet.be>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ufs/namei.c | 1 +
 1 file changed, 1 insertion(+)

--- a/fs/ufs/namei.c
+++ b/fs/ufs/namei.c
@@ -212,6 +212,7 @@ static int ufs_mkdir(struct inode * dir,
 		goto out_fail;
 	unlock_ufs(dir->i_sb);
 
+	unlock_new_inode(inode);
 	d_instantiate(dentry, inode);
 out:
 	return err;

