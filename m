Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9936AC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C08A2089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:03:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C08A2089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbeJBUqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:46:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33208 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728626AbeJBUNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:13:04 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 35D6CBF0;
        Tue,  2 Oct 2018 13:29:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Toshi Kani <toshi.kani@hpe.com>,
        Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        "Theodore Tso" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: [PATCH 4.18 158/228] ext2, dax: set ext2_dax_aops for dax files
Date:   Tue,  2 Oct 2018 06:24:15 -0700
Message-Id: <20181002132509.607306230@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
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

commit 9e796c9db93b4840d1b00e550eea26db7cb741e2 upstream.

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
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext2/inode.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1448,6 +1448,7 @@ struct inode *ext2_iget (struct super_bl
 	}
 	inode->i_blocks = le32_to_cpu(raw_inode->i_blocks);
 	ei->i_flags = le32_to_cpu(raw_inode->i_flags);
+	ext2_set_inode_flags(inode);
 	ei->i_faddr = le32_to_cpu(raw_inode->i_faddr);
 	ei->i_frag_no = raw_inode->i_frag;
 	ei->i_frag_size = raw_inode->i_fsize;
@@ -1517,7 +1518,6 @@ struct inode *ext2_iget (struct super_bl
 			   new_decode_dev(le32_to_cpu(raw_inode->i_block[1])));
 	}
 	brelse (bh);
-	ext2_set_inode_flags(inode);
 	unlock_new_inode(inode);
 	return inode;
 	


