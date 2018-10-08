Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AACC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94AC8204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GP28VLer"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94AC8204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732840AbeJICHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:07:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727670AbeJICHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:07:03 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A9002087D;
        Mon,  8 Oct 2018 18:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024834;
        bh=9RUqfFoHl1DiWW0TuhcOObT0fweYzo+aXSPH206eO3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GP28VLerEpa/aJX7r+QGMV7rfjjtnn8Uk0KeOMiSD2V1WcmY7YzBoU3jDJvbB3Oby
         z95MYtLDKpt0kuIs0WaO4Chgs9awr2vvjnwQPedaxgCvv1i6nOitBAFbk0xZAXAef2
         Pt1TKlg5FoZBE21VRMIMlZ1IQUkb/FkFrhnE6MUE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH 4.18 145/168] vfs: dont evict uninitialized inode
Date:   Mon,  8 Oct 2018 20:32:05 +0200
Message-Id: <20181008175625.543394600@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miklos Szeredi <mszeredi@redhat.com>

commit e950564b97fd0f541b02eb207685d0746f5ecf29 upstream.

iput() ends up calling ->evict() on new inode, which is not yet initialized
by owning fs.  So use destroy_inode() instead.

Add to sb->s_inodes list only if inode is not in I_CREATING state (meaning
that it wasn't allocated with new_inode(), which already does the
insertion).

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Fixes: 80ea09a002bf ("vfs: factor out inode_insert5()")
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Cc: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/inode.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1050,6 +1050,7 @@ struct inode *inode_insert5(struct inode
 {
 	struct hlist_head *head = inode_hashtable + hash(inode->i_sb, hashval);
 	struct inode *old;
+	bool creating = inode->i_state & I_CREATING;
 
 again:
 	spin_lock(&inode_hash_lock);
@@ -1083,6 +1084,8 @@ again:
 	inode->i_state |= I_NEW;
 	hlist_add_head(&inode->i_hash, head);
 	spin_unlock(&inode->i_lock);
+	if (!creating)
+		inode_sb_list_add(inode);
 unlock:
 	spin_unlock(&inode_hash_lock);
 
@@ -1117,12 +1120,13 @@ struct inode *iget5_locked(struct super_
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


