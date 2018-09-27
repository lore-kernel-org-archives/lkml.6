Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A627C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E8BD2156B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:15:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E8BD2156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbeI0Pcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:32:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55600 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbeI0Pct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:32:49 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C5FD11117;
        Thu, 27 Sep 2018 09:15:32 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Toshi Kani <toshi.kani@hpe.com>,
        Theodore Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Subject: [PATCH 4.18 85/88] ext4, dax: set ext4_dax_aops for dax files
Date:   Thu, 27 Sep 2018 11:04:06 +0200
Message-Id: <20180927090310.902544713@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090300.631426620@linuxfoundation.org>
References: <20180927090300.631426620@linuxfoundation.org>
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

From: Toshi Kani <toshi.kani@hpe.com>

commit cce6c9f7e6029caee45c459db5b3e78fec6973cb upstream.

Sync syscall to DAX file needs to flush processor cache, but it
currently does not flush to existing DAX files.  This is because
'ext4_da_aops' is set to address_space_operations of existing DAX
files, instead of 'ext4_dax_aops', since S_DAX flag is set after
ext4_set_aops() in the open path.

  New file
  --------
  lookup_open
    ext4_create
      __ext4_new_inode
        ext4_set_inode_flags   // Set S_DAX flag
      ext4_set_aops            // Set aops to ext4_dax_aops

  Existing file
  -------------
  lookup_open
    ext4_lookup
      ext4_iget
        ext4_set_aops          // Set aops to ext4_da_aops
        ext4_set_inode_flags   // Set S_DAX flag

Change ext4_iget() to initialize i_flags before ext4_set_aops().

Fixes: 5f0663bb4a64 ("ext4, dax: introduce ext4_dax_aops")
Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Suggested-by: Jan Kara <jack@suse.cz>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/inode.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4861,6 +4861,7 @@ struct inode *ext4_iget(struct super_blo
 		 * not initialized on a new filesystem. */
 	}
 	ei->i_flags = le32_to_cpu(raw_inode->i_flags);
+	ext4_set_inode_flags(inode);
 	inode->i_blocks = ext4_inode_blocks(raw_inode, ei);
 	ei->i_file_acl = le32_to_cpu(raw_inode->i_file_acl_lo);
 	if (ext4_has_feature_64bit(sb))
@@ -5010,7 +5011,6 @@ struct inode *ext4_iget(struct super_blo
 		goto bad_inode;
 	}
 	brelse(iloc.bh);
-	ext4_set_inode_flags(inode);
 
 	unlock_new_inode(inode);
 	return inode;


