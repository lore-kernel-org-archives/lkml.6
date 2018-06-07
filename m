Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Mn9eBO5WGVuUdAAAmS7hNA
	; Thu, 07 Jun 2018 16:03:01 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C08C1608BA; Thu,  7 Jun 2018 16:03:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1CFF96074D;
	Thu,  7 Jun 2018 16:03:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1CFF96074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935402AbeFGQAg (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:00:36 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39341 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933047AbeFGOJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:07 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb7-0005Zl-Jk; Thu, 07 Jun 2018 15:09:05 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb3-0002vg-T5; Thu, 07 Jun 2018 15:09:01 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Qu Wenruo" <wqu@suse.com>,
        "Nikolay Borisov" <nborisov@suse.com>,
        "David Sterba" <dsterba@suse.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.951567564@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 159/410] btrfs: Handle btrfs_set_extent_delalloc
 failure in fixup worker
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

From: Nikolay Borisov <nborisov@suse.com>

commit f3038ee3a3f1017a1cbe9907e31fa12d366c5dcb upstream.

This function was introduced by 247e743cbe6e ("Btrfs: Use async helpers
to deal with pages that have been improperly dirtied") and it didn't do
any error handling then. This function might very well fail in ENOMEM
situation, yet it's not handled, this could lead to inconsistent state.
So let's handle the failure by setting the mapping error bit.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/btrfs/inode.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1847,7 +1847,15 @@ again:
 		goto out;
 	 }
 
-	btrfs_set_extent_delalloc(inode, page_start, page_end, &cached_state);
+	ret = btrfs_set_extent_delalloc(inode, page_start, page_end,
+					&cached_state);
+	if (ret) {
+		mapping_set_error(page->mapping, ret);
+		end_extent_writepage(page, ret, page_start, page_end);
+		ClearPageChecked(page);
+		goto out;
+	}
+
 	ClearPageChecked(page);
 	set_page_dirty(page);
 out:
