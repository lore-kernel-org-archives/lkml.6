Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733EDECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38FB12083A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38FB12083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbeINUGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 16:06:11 -0400
Received: from g9t5008.houston.hpe.com ([15.241.48.72]:50334 "EHLO
        g9t5008.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbeINUGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 16:06:10 -0400
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id 0A0A356;
        Fri, 14 Sep 2018 14:51:18 +0000 (UTC)
Received: from misato.americas.hpqcorp.net (unknown [10.34.81.122])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id 6E93545;
        Fri, 14 Sep 2018 14:51:17 +0000 (UTC)
From:   Toshi Kani <toshi.kani@hpe.com>
To:     jack@suse.cz, dan.j.williams@intel.com
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, Toshi Kani <toshi.kani@hpe.com>,
        stable@vger.kernel.org
Subject: [PATCH v2 1/3] ext4, dax: add ext4_bmap to ext4_dax_aops
Date:   Fri, 14 Sep 2018 08:51:12 -0600
Message-Id: <20180914145114.11122-2-toshi.kani@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180914145114.11122-1-toshi.kani@hpe.com>
References: <20180914145114.11122-1-toshi.kani@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ext4 mount path calls .bmap to the journal inode. This currently
works for the DAX mount case because ext4_iget() always set
'ext4_da_aops' to any regular files.

In preparation to fix ext4_iget() to set 'ext4_dax_aops' for ext4
DAX files, add ext4_bmap() to 'ext4_dax_aops'. .bmap works for
DAX inodes. [1]

[1]: https://lkml.org/lkml/2018/9/12/803
Fixes: 5f0663bb4a64 ("ext4, dax: introduce ext4_dax_aops")
Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Suggested-by: Jan Kara <jack@suse.cz>
Cc: Jan Kara <jack@suse.cz>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Cc: <stable@vger.kernel.org>
---
 fs/ext4/inode.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d0dd585add6a..e4acaa980467 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3948,6 +3948,7 @@ static const struct address_space_operations ext4_dax_aops = {
 	.writepages		= ext4_dax_writepages,
 	.direct_IO		= noop_direct_IO,
 	.set_page_dirty		= noop_set_page_dirty,
+	.bmap			= ext4_bmap,
 	.invalidatepage		= noop_invalidatepage,
 };
 
