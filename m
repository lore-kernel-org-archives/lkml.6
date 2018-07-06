Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0382BC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E8B22BD2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:45:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9E8B22BD2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934192AbeGFUp2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 16:45:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41687 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933856AbeGFUp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 16:45:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id h10-v6so5304555wrq.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 13:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=p5MFyrylEUGL40LVs+lJKPdZi1bxh4N3wg6eoW82tgU=;
        b=aooCUDGfsHF9l3TtqFtCL8fLrlwbORSNa9JmPefEpg4TyouM0z90YFnAtxjOsm1VzL
         4DWVNcm52ftGcW83bDB5aS0R4sZtXAudIhGwQbkOUhNDUWs2nEDMt2hWblOisrvtvXrl
         cIxsXvzm6R4gCTBDgxazfJozz+RM2dJpCtQrCr6vA+09y+bPnNjeSC5ojQBvBJmHsqx7
         l7jlFtZzU5XYXTxoGBWWgEOXd1CRRje0pVh5apFqc7+mDle6PInSXlP6C9Ar1odxz9qG
         V6B1OIB2TABl81WXEUs2iwXGGa1DPsBEuqOhqKMRj5WZvm0Uq7O+gcm4q1cbVK3OuPOt
         DRqA==
X-Gm-Message-State: APt69E1f3P5fr5BhxS8K7ugZlAYWCoovpqPZSGo9LDbUZMZPN3i7qetG
        W7lHGw0YODnPO6KRHps+RgsETQ==
X-Google-Smtp-Source: AAOMgpfxan4yxo6x/Xx9SHBDS7CSSfm5AmJJfYuvK4n6YJC1MsBD2WAj/4aPtZ9g7whRpCtLpQPU5Q==
X-Received: by 2002:adf:9a0b:: with SMTP id z11-v6mr8244468wrb.47.1530909925701;
        Fri, 06 Jul 2018 13:45:25 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id t1-v6sm12242660wmt.40.2018.07.06.13.45.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 13:45:25 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 (v4.18 regression fix)] vfs: don't evict uninitialized inode
Date:   Fri,  6 Jul 2018 22:45:21 +0200
Message-Id: <20180706204521.29654-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iput() ends up calling ->evict() on new inode, which is not yet initialized
by owning fs.  So use destroy_inode() instead.

Add to sb->s_inodes list only if inode is not in I_CREATING state (meaning
that it wasn't allocated with new_inode(), which already does the
insertion).

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Fixes: 80ea09a002bf ("vfs: factor out inode_insert5()")
---
 fs/inode.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 04dd7e0d5142..e7de38c1d9d8 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1050,6 +1050,7 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
 {
 	struct hlist_head *head = inode_hashtable + hash(inode->i_sb, hashval);
 	struct inode *old;
+	bool creating = inode->i_state & I_CREATING;
 
 again:
 	spin_lock(&inode_hash_lock);
@@ -1083,6 +1084,8 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
 	inode->i_state |= I_NEW;
 	hlist_add_head(&inode->i_hash, head);
 	spin_unlock(&inode->i_lock);
+	if (!creating)
+		inode_sb_list_add(inode);
 unlock:
 	spin_unlock(&inode_hash_lock);
 
@@ -1117,12 +1120,12 @@ struct inode *iget5_locked(struct super_block *sb, unsigned long hashval,
 	struct inode *inode = ilookup5(sb, hashval, test, data);
 
 	if (!inode) {
-		struct inode *new = new_inode(sb);
+		struct inode *new = alloc_inode(sb);
 
 		if (new) {
 			inode = inode_insert5(new, hashval, test, set, data);
 			if (unlikely(inode != new))
-				iput(new);
+				destroy_inode(new);
 		}
 	}
 	return inode;
-- 
2.14.3

