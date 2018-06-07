Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id oQAnMDFJGVshTgAAmS7hNA
	; Thu, 07 Jun 2018 15:03:13 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B3CA1608BF; Thu,  7 Jun 2018 15:03:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 10B59601C3;
	Thu,  7 Jun 2018 15:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 10B59601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965049AbeFGPDK (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:03:10 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41474 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965004AbeFGPDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:03:04 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbj-0005Zl-8X; Thu, 07 Jun 2018 15:09:43 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb5-0002yL-6e; Thu, 07 Jun 2018 15:09:03 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David Sterba" <dsterba@suse.com>,
        "Liu Bo" <bo.li.liu@oracle.com>, "Josef Bacik" <jbacik@fb.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.991373183@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 186/410] Btrfs: fix deadlock in run_delalloc_nocow
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

commit e89166990f11c3f21e1649d760dd35f9e410321c upstream.

@cur_offset is not set back to what it should be (@cow_start) if
btrfs_next_leaf() returns something wrong, and the range [cow_start,
cur_offset) remains locked forever.

Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
Reviewed-by: Josef Bacik <jbacik@fb.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/btrfs/inode.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1235,8 +1235,11 @@ next_slot:
 		leaf = path->nodes[0];
 		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
 			ret = btrfs_next_leaf(root, path);
-			if (ret < 0)
+			if (ret < 0) {
+				if (cow_start != (u64)-1)
+					cur_offset = cow_start;
 				goto error;
+			}
 			if (ret > 0)
 				break;
 			leaf = path->nodes[0];
