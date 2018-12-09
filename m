Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73833C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 414FC20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 414FC20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbeLIWG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:06:26 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37062 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727724AbeLIWGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:06:14 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73I-0002io-Jk; Sun, 09 Dec 2018 21:55:52 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72c-0003Lw-Ai; Sun, 09 Dec 2018 21:55:10 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Ethan Lien" <ethanlien@synology.com>,
        "David Sterba" <dsterba@suse.com>,
        "Nikolay Borisov" <nborisov@suse.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.988994940@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 109/328] btrfs: use correct compare function of
 dirty_metadata_bytes
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Ethan Lien <ethanlien@synology.com>

commit d814a49198eafa6163698bdd93961302f3a877a4 upstream.

We use customized, nodesize batch value to update dirty_metadata_bytes.
We should also use batch version of compare function or we will easily
goto fast path and get false result from percpu_counter_compare().

Fixes: e2d845211eda ("Btrfs: use percpu counter for dirty metadata count")
Signed-off-by: Ethan Lien <ethanlien@synology.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[bwh: Backported to 3.16: In __btrfs_btree_balance_dirty(), use
 root->fs_info instead of fs_info]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/btrfs/disk-io.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -991,8 +991,9 @@ static int btree_writepages(struct addre
 
 		fs_info = BTRFS_I(mapping->host)->root->fs_info;
 		/* this is a bit racy, but that's ok */
-		ret = percpu_counter_compare(&fs_info->dirty_metadata_bytes,
-					     BTRFS_DIRTY_METADATA_THRESH);
+		ret = __percpu_counter_compare(&fs_info->dirty_metadata_bytes,
+					     BTRFS_DIRTY_METADATA_THRESH,
+					     fs_info->dirty_metadata_batch);
 		if (ret < 0)
 			return 0;
 	}
@@ -3793,8 +3794,9 @@ static void __btrfs_btree_balance_dirty(
 	if (flush_delayed)
 		btrfs_balance_delayed_items(root);
 
-	ret = percpu_counter_compare(&root->fs_info->dirty_metadata_bytes,
-				     BTRFS_DIRTY_METADATA_THRESH);
+	ret = __percpu_counter_compare(&root->fs_info->dirty_metadata_bytes,
+				     BTRFS_DIRTY_METADATA_THRESH,
+				     root->fs_info->dirty_metadata_batch);
 	if (ret > 0) {
 		balance_dirty_pages_ratelimited(
 				   root->fs_info->btree_inode->i_mapping);

