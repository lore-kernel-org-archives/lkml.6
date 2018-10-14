Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACD5C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4985D20835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4985D20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbeJNXQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:16:19 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36609 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727809AbeJNXQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:16:19 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiMF-0004cF-Ra; Sun, 14 Oct 2018 16:31:07 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLO-0000C8-Kl; Sun, 14 Oct 2018 16:30:14 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Jan Kara" <jack@suse.cz>,
        "Eryu Guan" <guaneryu@gmail.com>, "Theodore Ts'o" <tytso@mit.edu>
Date:   Sun, 14 Oct 2018 16:25:40 +0100
Message-ID: <lsq.1539530740.678899079@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 045/366] ext4: protect i_disksize update by
 i_data_sem in direct write path
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Eryu Guan <guaneryu@gmail.com>

commit 73fdad00b208b139cf43f3163fbc0f67e4c6047c upstream.

i_disksize update should be protected by i_data_sem, by either taking
the lock explicitly or by using ext4_update_i_disksize() helper. But the
i_disksize updates in ext4_direct_IO_write() are not protected at all,
which may be racing with i_disksize updates in writeback path in
delalloc buffer write path.

This is found by code inspection, and I didn't hit any i_disksize
corruption due to this bug. Thanks to Jan Kara for catching this bug and
suggesting the fix!

Reported-by: Jan Kara <jack@suse.cz>
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Eryu Guan <guaneryu@gmail.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
[bwh: Backported to 3.16: The relevant code is in ext4_ind_direct_IO()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -649,7 +649,6 @@ ssize_t ext4_ind_direct_IO(int rw, struc
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_mapping->host;
-	struct ext4_inode_info *ei = EXT4_I(inode);
 	handle_t *handle;
 	ssize_t ret;
 	int orphan = 0;
@@ -672,7 +671,7 @@ ssize_t ext4_ind_direct_IO(int rw, struc
 				goto out;
 			}
 			orphan = 1;
-			ei->i_disksize = inode->i_size;
+			ext4_update_i_disksize(inode, inode->i_size);
 			ext4_journal_stop(handle);
 		}
 	}
@@ -731,7 +730,7 @@ locked:
 		if (ret > 0) {
 			loff_t end = offset + ret;
 			if (end > inode->i_size) {
-				ei->i_disksize = end;
+				ext4_update_i_disksize(inode, end);
 				i_size_write(inode, end);
 				/*
 				 * We're going to return a positive `ret'

