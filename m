Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F28C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA6324F6D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BA6324F6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752269AbeFXPZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:25:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58650 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752236AbeFXPZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:25:44 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4FB3B2C;
        Sun, 24 Jun 2018 15:25:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger@dilger.ca>, stable@kernel.org
Subject: [PATCH 4.14 16/52] ext4: bubble errors from ext4_find_inline_data_nolock() up to ext4_iget()
Date:   Sun, 24 Jun 2018 23:21:09 +0800
Message-Id: <20180624142745.432886365@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624142744.234164867@linuxfoundation.org>
References: <20180624142744.234164867@linuxfoundation.org>
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

From: Theodore Ts'o <tytso@mit.edu>

commit eb9b5f01c33adebc31cbc236c02695f605b0e417 upstream.

If ext4_find_inline_data_nolock() returns an error it needs to get
reflected up to ext4_iget().  In order to fix this,
ext4_iget_extra_inode() needs to return an error (and not return
void).

This is related to "ext4: do not allow external inodes for inline
data" (which fixes CVE-2018-11412) in that in the errors=continue
case, it would be useful to for userspace to receive an error
indicating that file system is corrupted.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/inode.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4634,19 +4634,21 @@ static blkcnt_t ext4_inode_blocks(struct
 	}
 }
 
-static inline void ext4_iget_extra_inode(struct inode *inode,
+static inline int ext4_iget_extra_inode(struct inode *inode,
 					 struct ext4_inode *raw_inode,
 					 struct ext4_inode_info *ei)
 {
 	__le32 *magic = (void *)raw_inode +
 			EXT4_GOOD_OLD_INODE_SIZE + ei->i_extra_isize;
+
 	if (EXT4_GOOD_OLD_INODE_SIZE + ei->i_extra_isize + sizeof(__le32) <=
 	    EXT4_INODE_SIZE(inode->i_sb) &&
 	    *magic == cpu_to_le32(EXT4_XATTR_MAGIC)) {
 		ext4_set_inode_state(inode, EXT4_STATE_XATTR);
-		ext4_find_inline_data_nolock(inode);
+		return ext4_find_inline_data_nolock(inode);
 	} else
 		EXT4_I(inode)->i_inline_off = 0;
+	return 0;
 }
 
 int ext4_get_projid(struct inode *inode, kprojid_t *projid)
@@ -4826,7 +4828,9 @@ struct inode *ext4_iget(struct super_blo
 			ei->i_extra_isize = sizeof(struct ext4_inode) -
 					    EXT4_GOOD_OLD_INODE_SIZE;
 		} else {
-			ext4_iget_extra_inode(inode, raw_inode, ei);
+			ret = ext4_iget_extra_inode(inode, raw_inode, ei);
+			if (ret)
+				goto bad_inode;
 		}
 	}
 


