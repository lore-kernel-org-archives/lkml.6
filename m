Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0BDFC6183
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641592083A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:51:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 641592083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbeINUGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 16:06:13 -0400
Received: from g9t5009.houston.hpe.com ([15.241.48.73]:49406 "EHLO
        g9t5009.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbeINUGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 16:06:13 -0400
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g9t5009.houston.hpe.com (Postfix) with ESMTP id EAF4051;
        Fri, 14 Sep 2018 14:51:20 +0000 (UTC)
Received: from misato.americas.hpqcorp.net (unknown [10.34.81.122])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id 3E1C547;
        Fri, 14 Sep 2018 14:51:20 +0000 (UTC)
From:   Toshi Kani <toshi.kani@hpe.com>
To:     jack@suse.cz, dan.j.williams@intel.com
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, Toshi Kani <toshi.kani@hpe.com>,
        stable@vger.kernel.org
Subject: [PATCH v2 3/3] ext2, dax: set ext2_dax_aops for dax files
Date:   Fri, 14 Sep 2018 08:51:14 -0600
Message-Id: <20180914145114.11122-4-toshi.kani@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180914145114.11122-1-toshi.kani@hpe.com>
References: <20180914145114.11122-1-toshi.kani@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sync syscall to DAX file needs to flush processor cache, but it
currently does not flush to existing DAX files.  This is because
'ext2_da_aops' is set to address_space_operations of existing DAX
files, instead of 'ext2_dax_aops', since S_DAX flag is set after
ext2_set_aops() in the open path.

Similar to ext4, change ext2_iget() to initialize i_flags before
ext2_set_aops().

Fixes: fb094c90748f ("ext2, dax: introduce ext2_dax_aops")
Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Suggested-by: Jan Kara <jack@suse.cz>
Cc: Jan Kara <jack@suse.cz>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Cc: <stable@vger.kernel.org>
---
 fs/ext2/inode.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 7f7ee18fe179..e4bb9386c045 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1448,6 +1448,7 @@ struct inode *ext2_iget (struct super_block *sb, unsigned long ino)
 	}
 	inode->i_blocks = le32_to_cpu(raw_inode->i_blocks);
 	ei->i_flags = le32_to_cpu(raw_inode->i_flags);
+	ext2_set_inode_flags(inode);
 	ei->i_faddr = le32_to_cpu(raw_inode->i_faddr);
 	ei->i_frag_no = raw_inode->i_frag;
 	ei->i_frag_size = raw_inode->i_fsize;
@@ -1517,7 +1518,6 @@ struct inode *ext2_iget (struct super_block *sb, unsigned long ino)
 			   new_decode_dev(le32_to_cpu(raw_inode->i_block[1])));
 	}
 	brelse (bh);
-	ext2_set_inode_flags(inode);
 	unlock_new_inode(inode);
 	return inode;
 	
