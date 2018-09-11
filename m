Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992EBC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E0F22086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E0F22086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbeIKVD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 17:03:26 -0400
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:10480 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbeIKVDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 17:03:24 -0400
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g9t1613g.houston.hpe.com (Postfix) with ESMTPS id 9B1F861149;
        Tue, 11 Sep 2018 16:03:26 +0000 (UTC)
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2352.austin.hpe.com (Postfix) with ESMTP id E7A91B1;
        Tue, 11 Sep 2018 16:03:25 +0000 (UTC)
Received: from misato.americas.hpqcorp.net (unknown [10.34.81.122])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 79EBE36;
        Tue, 11 Sep 2018 16:03:25 +0000 (UTC)
From:   Toshi Kani <toshi.kani@hpe.com>
To:     jack@suse.cz, dan.j.williams@intel.com
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, Toshi Kani <toshi.kani@hpe.com>
Subject: [PATCH 1/2] ext4, dax: update dax check to skip journal inode
Date:   Tue, 11 Sep 2018 09:42:45 -0600
Message-Id: <20180911154246.6844-2-toshi.kani@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180911154246.6844-1-toshi.kani@hpe.com>
References: <20180911154246.6844-1-toshi.kani@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ext4 mount path calls ext4_iget() to obtain the journal inode.  This
inode does not support DAX, and 'ext4_da_aops' needs to be set.  It
currently works for the DAX mount case because ext4_iget() always set
'ext4_da_aops' to any regular files.

  ext4_fill_super
    ext4_load_journal
      ext4_get_journal_inode
        ext4_iget

In preparation to fix ext4_iget() to set 'ext4_dax_aops' for DAX files,
update ext4_should_use_dax() to return false for the journal inode.

Fixes: 5f0663bb4a64f588f0a2dd6d1be68d40f9af0086
Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
---
 fs/ext4/ext4_jbd2.h |    8 ++++++++
 fs/ext4/inode.c     |    2 ++
 2 files changed, 10 insertions(+)

diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 15b6dd733780..9847dc980a0d 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -437,6 +437,14 @@ static inline int ext4_should_writeback_data(struct inode *inode)
 	return ext4_inode_journal_mode(inode) & EXT4_INODE_WRITEBACK_DATA_MODE;
 }
 
+static inline int ext4_is_journal_inode(struct inode *inode)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	unsigned int journal_inum = le32_to_cpu(sbi->s_es->s_journal_inum);
+
+	return journal_inum && (journal_inum == inode->i_ino);
+}
+
 /*
  * This function controls whether or not we should try to go down the
  * dioread_nolock code paths, which makes it safe to avoid taking
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d0dd585add6a..775cd9b4af55 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4686,6 +4686,8 @@ static bool ext4_should_use_dax(struct inode *inode)
 		return false;
 	if (ext4_should_journal_data(inode))
 		return false;
+	if (ext4_is_journal_inode(inode))
+		return false;
 	if (ext4_has_inline_data(inode))
 		return false;
 	if (ext4_encrypted_inode(inode))
