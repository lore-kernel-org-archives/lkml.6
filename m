Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2135C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712102081F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 712102081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbeLIWLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:11:17 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37668 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728215AbeLIWLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:11:15 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73I-0002po-JN; Sun, 09 Dec 2018 21:55:52 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72c-0003M6-Dm; Sun, 09 Dec 2018 21:55:10 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Anand Jain" <anand.jain@oracle.com>,
        "Chris Mason" <clm@fb.com>, "David Sterba" <dsterba@suse.cz>,
        "Anand Jain" <Anand.Jain@oracle.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.294270090@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 111/328] btrfs: rename total_bytes to avoid confusion
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

From: Anand Jain <Anand.Jain@oracle.com>

commit 3c1dbdf54a31f4f049a33214c3096595988786bf upstream.

we are assigning number_devices to the total_bytes,
that's very confusing for a moment

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.cz>
Signed-off-by: Chris Mason <clm@fb.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/btrfs/volumes.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2039,7 +2039,7 @@ int btrfs_init_new_device(struct btrfs_r
 	struct list_head *devices;
 	struct super_block *sb = root->fs_info->sb;
 	struct rcu_string *name;
-	u64 total_bytes;
+	u64 tmp;
 	int seeding_dev = 0;
 	int ret = 0;
 
@@ -2142,13 +2142,13 @@ int btrfs_init_new_device(struct btrfs_r
 	if (!blk_queue_nonrot(bdev_get_queue(bdev)))
 		root->fs_info->fs_devices->rotating = 1;
 
-	total_bytes = btrfs_super_total_bytes(root->fs_info->super_copy);
+	tmp = btrfs_super_total_bytes(root->fs_info->super_copy);
 	btrfs_set_super_total_bytes(root->fs_info->super_copy,
-				    total_bytes + device->total_bytes);
+				    tmp + device->total_bytes);
 
-	total_bytes = btrfs_super_num_devices(root->fs_info->super_copy);
+	tmp = btrfs_super_num_devices(root->fs_info->super_copy);
 	btrfs_set_super_num_devices(root->fs_info->super_copy,
-				    total_bytes + 1);
+				    tmp + 1);
 
 	/* add sysfs device entry */
 	btrfs_kobj_add_device(root->fs_info, device);

