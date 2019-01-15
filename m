Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D055FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9487420675
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570757;
	bh=7EinwiCHwBsQSCv4hDzw8KdoHLP5va2mqbwLxzSLmIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gaGTpyzVIlFWDeu7ALDFQvPw4Iymn0X3DiE7E1HPFFLPkVUUlVGCEwN9W8mBm+B++
	 yMN9HNEblwrNO5m0ShYkIZXZXlWPXOP7FTeuTYHE5CwV42fI3E7cQ/0ro+rCjz8tHB
	 ogGm5lMBSd8SNsotqq30zsP8NZ13oUwlk0oxpQqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387884AbfAOQp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:45:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:35536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387859AbfAOQpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:45:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1090F20859;
        Tue, 15 Jan 2019 16:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570748;
        bh=7EinwiCHwBsQSCv4hDzw8KdoHLP5va2mqbwLxzSLmIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sMa7M2RmE8hXjc+ORe+HdcyyrTfvr33lScND/nCWEubbcYZgP4QkxrgHDAb9nuGoH
         0JOcZZx5RgNSjsXxYaCFpBr/kEzvryCxzUBmwrRjZRrbSOPNYL1x3vsRV60eL2kBvx
         u1gnZdDUBEZCOnzheYtaQE6TYi8VO1KEfYghSJLY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.20 56/57] Btrfs: fix deadlock when enabling quotas due to concurrent snapshot creation
Date:   Tue, 15 Jan 2019 17:36:37 +0100
Message-Id: <20190115154914.150419825@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154910.734892368@linuxfoundation.org>
References: <20190115154910.734892368@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

commit 9a6f209e36500efac51528132a3e3083586eda5f upstream.

If the quota enable and snapshot creation ioctls are called concurrently
we can get into a deadlock where the task enabling quotas will deadlock
on the fs_info->qgroup_ioctl_lock mutex because it attempts to lock it
twice, or the task creating a snapshot tries to commit the transaction
while the task enabling quota waits for the former task to commit the
transaction while holding the mutex. The following time diagrams show how
both cases happen.

First scenario:

           CPU 0                                    CPU 1

 btrfs_ioctl()
  btrfs_ioctl_quota_ctl()
   btrfs_quota_enable()
    mutex_lock(fs_info->qgroup_ioctl_lock)
    btrfs_start_transaction()

                                             btrfs_ioctl()
                                              btrfs_ioctl_snap_create_v2
                                               create_snapshot()
                                                --> adds snapshot to the
                                                    list pending_snapshots
                                                    of the current
                                                    transaction

    btrfs_commit_transaction()
     create_pending_snapshots()
       create_pending_snapshot()
        qgroup_account_snapshot()
         btrfs_qgroup_inherit()
	   mutex_lock(fs_info->qgroup_ioctl_lock)
	    --> deadlock, mutex already locked
	        by this task at
		btrfs_quota_enable()

Second scenario:

           CPU 0                                    CPU 1

 btrfs_ioctl()
  btrfs_ioctl_quota_ctl()
   btrfs_quota_enable()
    mutex_lock(fs_info->qgroup_ioctl_lock)
    btrfs_start_transaction()

                                             btrfs_ioctl()
                                              btrfs_ioctl_snap_create_v2
                                               create_snapshot()
                                                --> adds snapshot to the
                                                    list pending_snapshots
                                                    of the current
                                                    transaction

                                                btrfs_commit_transaction()
                                                 --> waits for task at
                                                     CPU 0 to release
                                                     its transaction
                                                     handle

    btrfs_commit_transaction()
     --> sees another task started
         the transaction commit first
     --> releases its transaction
         handle
     --> waits for the transaction
         commit to be completed by
         the task at CPU 1

                                                 create_pending_snapshot()
                                                  qgroup_account_snapshot()
                                                   btrfs_qgroup_inherit()
                                                    mutex_lock(fs_info->qgroup_ioctl_lock)
                                                     --> deadlock, task at CPU 0
                                                         has the mutex locked but
                                                         it is waiting for us to
                                                         finish the transaction
                                                         commit

So fix this by setting the quota enabled flag in fs_info after committing
the transaction at btrfs_quota_enable(). This ends up serializing quota
enable and snapshot creation as if the snapshot creation happened just
before the quota enable request. The quota rescan task, scheduled after
committing the transaction in btrfs_quote_enable(), will do the accounting.

Fixes: 6426c7ad697d ("btrfs: qgroup: Fix qgroup accounting when creating snapshot")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/qgroup.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1013,16 +1013,22 @@ out_add_root:
 		btrfs_abort_transaction(trans, ret);
 		goto out_free_path;
 	}
-	spin_lock(&fs_info->qgroup_lock);
-	fs_info->quota_root = quota_root;
-	set_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
-	spin_unlock(&fs_info->qgroup_lock);
 
 	ret = btrfs_commit_transaction(trans);
 	trans = NULL;
 	if (ret)
 		goto out_free_path;
 
+	/*
+	 * Set quota enabled flag after committing the transaction, to avoid
+	 * deadlocks on fs_info->qgroup_ioctl_lock with concurrent snapshot
+	 * creation.
+	 */
+	spin_lock(&fs_info->qgroup_lock);
+	fs_info->quota_root = quota_root;
+	set_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
+	spin_unlock(&fs_info->qgroup_lock);
+
 	ret = qgroup_rescan_init(fs_info, 0, 1);
 	if (!ret) {
 	        qgroup_rescan_zero_tracking(fs_info);


