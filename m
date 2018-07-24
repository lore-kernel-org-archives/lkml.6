Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED1FC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1030720874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:02:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1030720874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388386AbeGXOI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 10:08:26 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54825 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388302AbeGXOIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 10:08:25 -0400
Received: by mail-wm0-f68.google.com with SMTP id c14-v6so2439662wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 06:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3BgljC+3PT0Ic4dJXbKfRELkvUnoZrlTurBgY1AEfa0=;
        b=W7Cp76Lq6Zc/RLjjNl+LcQZQ63NkODfPP8/aJ2mUo27lshJUnQtt/aaYH1UPE4Ltph
         OqITstqKvRKl9U1zwBP9bkeSH9SV2wyBWi7vHPZ+EXD9uRelVwSZivYWnCz/g3JoytfT
         P1WJpLN+LH5b/Rb0dBwavnPEtgxGPxTxiJ/SIGPYbhb7cCHh3i5ejHStRV0QSBfE3Jni
         d1ElMqc3Lo3c750fkDwarhwJ7x36hM2c/qD9ZwpDd9xN4I/6bAYqZy+agTsEya3pC9jK
         pLag2x3dG89bvrO0dFzC6dQtol8lOgmvpTfS/kim8E6QKnYJ2O1kTCSYoXECc/ROXSXu
         Sy2A==
X-Gm-Message-State: AOUpUlHdIJxKm6LNmh3avw/lckXILStc5fQPoEm/rVYLrFGbNGy0UXt0
        8+0+ABW5OxVyvZ5T7Kg0w2OLSp+Z2DY=
X-Google-Smtp-Source: AAOMgpdZLDRjUaCiyl5k4X8a8ayBtWRoKnUAu6A6sH3GFZB1OgUiu2gKtWxK2A0o+VGmFsNKdaY5gA==
X-Received: by 2002:a1c:7506:: with SMTP id o6-v6mr1945308wmc.60.1532437320892;
        Tue, 24 Jul 2018 06:02:00 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id f20-v6sm1993358wmd.3.2018.07.24.06.01.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 06:02:00 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3] vfs: don't evict uninitialized inode
Date:   Tue, 24 Jul 2018 15:01:55 +0200
Message-Id: <20180724130155.20641-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180724064929.GD19722@shao2-debian>
References: <20180724064929.GD19722@shao2-debian>
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
 fs/inode.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 04dd7e0d5142..0aa5b29b6f87 100644
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
 
@@ -1117,12 +1120,13 @@ struct inode *iget5_locked(struct super_block *sb, unsigned long hashval,
 	struct inode *inode = ilookup5(sb, hashval, test, data);
 
 	if (!inode) {
-		struct inode *new = new_inode(sb);
+		struct inode *new = alloc_inode(sb);
 
 		if (new) {
+			new->i_state = 0;
 			inode = inode_insert5(new, hashval, test, set, data);
 			if (unlikely(inode != new))
-				iput(new);
+				destroy_inode(new);
 		}
 	}
 	return inode;
-- 
2.14.3

