Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D81CC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D8420936
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3D8420936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390167AbeGJShP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:37:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50060 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389912AbeGJShO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:37:14 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 14840ACC;
        Tue, 10 Jul 2018 18:36:59 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jon Derrick <jonathan.derrick@intel.com>,
        Theodore Tso <tytso@mit.edu>, stable@kernel.org
Subject: [PATCH 4.17 40/56] ext4: check superblock mapped prior to committing
Date:   Tue, 10 Jul 2018 20:25:22 +0200
Message-Id: <20180710182505.499799121@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182503.544433950@linuxfoundation.org>
References: <20180710182503.544433950@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jon Derrick <jonathan.derrick@intel.com>

commit a17712c8e4be4fa5404d20e9cd3b2b21eae7bc56 upstream.

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
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/super.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4763,6 +4763,14 @@ static int ext4_commit_super(struct supe
 
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


