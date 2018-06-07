Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id GyxuNnBIGVt+SAAAmS7hNA
	; Thu, 07 Jun 2018 15:01:49 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5ABC2608BA; Thu,  7 Jun 2018 15:01:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CB1B0601C3;
	Thu,  7 Jun 2018 15:01:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CB1B0601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964836AbeFGPBr (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:01:47 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41400 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934986AbeFGPBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:01:36 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbj-0005Zn-8y; Thu, 07 Jun 2018 15:09:43 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb5-0002yV-9l; Thu, 07 Jun 2018 15:09:03 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Liu Bo" <bo.li.liu@oracle.com>,
        "Josef Bacik" <jbacik@fb.com>, "David Sterba" <dsterba@suse.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.863556567@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 188/410] Btrfs: fix extent state leak from tree log
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

From: Liu Bo <bo.li.liu@oracle.com>

commit 55237a5f2431a72435e3ed39e4306e973c0446b7 upstream.

It's possible that btrfs_sync_log() bails out after one of the two
btrfs_write_marked_extents() which convert extent state's state bit into
EXTENT_NEED_WAIT from EXTENT_DIRTY/EXTENT_NEW, however only EXTENT_DIRTY
and EXTENT_NEW are searched by free_log_tree() so that those extent states
with EXTENT_NEED_WAIT lead to memory leak.

Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
Reviewed-by: Josef Bacik <jbacik@fb.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/btrfs/tree-log.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2731,13 +2731,14 @@ static void free_log_tree(struct btrfs_t
 
 	while (1) {
 		ret = find_first_extent_bit(&log->dirty_log_pages,
-				0, &start, &end, EXTENT_DIRTY | EXTENT_NEW,
+				0, &start, &end,
+				EXTENT_DIRTY | EXTENT_NEW | EXTENT_NEED_WAIT,
 				NULL);
 		if (ret)
 			break;
 
 		clear_extent_bits(&log->dirty_log_pages, start, end,
-				  EXTENT_DIRTY | EXTENT_NEW, GFP_NOFS);
+				  EXTENT_DIRTY | EXTENT_NEW | EXTENT_NEED_WAIT, GFP_NOFS);
 	}
 
 	/*
