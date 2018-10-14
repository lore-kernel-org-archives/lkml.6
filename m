Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9CCC71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B8020645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:45:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22B8020645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbeJNX0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:26:54 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37141 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728683AbeJNX0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:26:53 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiMB-0004cH-Ue; Sun, 14 Oct 2018 16:31:04 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLP-0000F9-W2; Sun, 14 Oct 2018 16:30:15 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David Sterba" <dsterba@suse.com>,
        "Nikolay Borisov" <nborisov@suse.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.534005325@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 081/366] btrfs: Handle error from btrfs_uuid_tree_rem
 call in _btrfs_ioctl_set_received_subvol
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

From: Nikolay Borisov <nborisov@suse.com>

commit d87ff75863e92a500538ab53318c5740f196631e upstream.

As with every function which deals with modifying the btree
btrfs_uuid_tree_rem can fail for any number of reasons (ie. EIO/ENOMEM).
Handle return error value from this function gracefully by aborting the
transaction.

Fixes: dd5f9615fc5c ("Btrfs: maintain subvolume items in the UUID tree")
Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[bwh: Backported to 3.16:
 - btrfs_{abort,end}_transaction() take a pointer to btrfs_root
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -5051,11 +5051,17 @@ static long _btrfs_ioctl_set_received_su
 	received_uuid_changed = memcmp(root_item->received_uuid, sa->uuid,
 				       BTRFS_UUID_SIZE);
 	if (received_uuid_changed &&
-	    !btrfs_is_empty_uuid(root_item->received_uuid))
-		btrfs_uuid_tree_rem(trans, root->fs_info->uuid_root,
-				    root_item->received_uuid,
-				    BTRFS_UUID_KEY_RECEIVED_SUBVOL,
-				    root->root_key.objectid);
+	    !btrfs_is_empty_uuid(root_item->received_uuid)) {
+		ret = btrfs_uuid_tree_rem(trans, root->fs_info->uuid_root,
+					  root_item->received_uuid,
+					  BTRFS_UUID_KEY_RECEIVED_SUBVOL,
+					  root->root_key.objectid);
+		if (ret && ret != -ENOENT) {
+			btrfs_abort_transaction(trans, root, ret);
+		        btrfs_end_transaction(trans, root);
+		        goto out;
+		}
+	}
 	memcpy(root_item->received_uuid, sa->uuid, BTRFS_UUID_SIZE);
 	btrfs_set_root_stransid(root_item, sa->stransid);
 	btrfs_set_root_rtransid(root_item, sa->rtransid);

