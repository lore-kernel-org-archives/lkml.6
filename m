Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D7EC6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B71327D8E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:39:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B71327D8E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937280AbeF2TjW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 15:39:22 -0400
Received: from mga06.intel.com ([134.134.136.31]:57709 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932405AbeF2TjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 15:39:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 12:39:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,287,1526367600"; 
   d="scan'208";a="63263208"
Received: from unknown (HELO localhost.localdomain) ([10.232.117.195])
  by orsmga003.jf.intel.com with ESMTP; 29 Jun 2018 12:38:55 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        <linux-kernel@vger.kernel.org>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH] ext4: Check superblock mapped prior to committing
Date:   Fri, 29 Jun 2018 13:36:35 -0600
Message-Id: <1530300995-25583-1-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch attempts to close a hole leading to a BUG seen with hot
removals during writes [1].

A block device (NVME namespace in this test case) is formatted to EXT4
without partitions. It's mounted and write I/O is run to a file, then
the device is hot removed from the slot. The superblock attempts to be
written to the drive which is no longer present.

The typical chain of events leading to the BUG:
ext4_commit_super()
  __sync_dirty_buffer()
    submit_bh()
      submit_bh_wbc()
        BUG_ON(!buffer_mapped(bh));

This fix checks for the superblock's buffer head being mapped prior to
syncing.

[1] https://www.spinics.net/lists/linux-ext4/msg56527.html

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 fs/ext4/super.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 0c4c220..ee33233 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4736,6 +4736,14 @@ static int ext4_commit_super(struct super_block *sb, int sync)
 
 	if (!sbh || block_device_ejected(sb))
 		return error;
+
+	/*
+	 * The superblock bh should be mapped, but it might not be if the
+	 * device was hot-removed. Not much we can do but fail the I/O.
+	 */
+	if (!buffer_mapped(sbh))
+		return error;
+
 	/*
 	 * If the file system is mounted read-only, don't update the
 	 * superblock write time.  This avoids updating the superblock
-- 
2.7.4

