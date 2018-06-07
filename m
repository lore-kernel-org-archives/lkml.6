Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id BZyFMghaGVswDQAAmS7hNA
	; Thu, 07 Jun 2018 16:15:04 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B6715608C8; Thu,  7 Jun 2018 16:15:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 23BC660115;
	Thu,  7 Jun 2018 16:15:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 23BC660115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935238AbeFGQOr (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:14:47 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39120 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932925AbeFGOI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:08:58 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvay-0005a0-Kc; Thu, 07 Jun 2018 15:08:56 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvax-0002hS-Kg; Thu, 07 Jun 2018 15:08:55 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Theodore Ts'o" <tytso@mit.edu>,
        "Wen Xu" <wen.xu@gatech.edu>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.743043835@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 018/410] ext4: fail ext4_iget for root directory if
 unallocated
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 8e4b5eae5decd9dfe5a4ee369c22028f90ab4c44 upstream.

If the root directory has an i_links_count of zero, then when the file
system is mounted, then when ext4_fill_super() notices the problem and
tries to call iput() the root directory in the error return path,
ext4_evict_inode() will try to free the inode on disk, before all of
the file system structures are set up, and this will result in an OOPS
caused by a NULL pointer dereference.

This issue has been assigned CVE-2018-1092.

https://bugzilla.kernel.org/show_bug.cgi?id=199179
https://bugzilla.redhat.com/show_bug.cgi?id=1560777

Reported-by: Wen Xu <wen.xu@gatech.edu>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
[bwh: Backported to 3.16: use EIO instead of EFSCORRUPTED]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ext4/inode.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4198,6 +4198,12 @@ struct inode *ext4_iget(struct super_blo
 		goto bad_inode;
 	raw_inode = ext4_raw_inode(&iloc);
 
+	if ((ino == EXT4_ROOT_INO) && (raw_inode->i_links_count == 0)) {
+		EXT4_ERROR_INODE(inode, "root inode unallocated");
+		ret = -EIO;
+		goto bad_inode;
+	}
+
 	if (EXT4_INODE_SIZE(inode->i_sb) > EXT4_GOOD_OLD_INODE_SIZE) {
 		ei->i_extra_isize = le16_to_cpu(raw_inode->i_extra_isize);
 		if (EXT4_GOOD_OLD_INODE_SIZE + ei->i_extra_isize >
