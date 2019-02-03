Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD2BC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96279218D8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbfBCN5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:57:31 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53908 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728387AbfBCNuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:50:02 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9p-0003tg-1A; Sun, 03 Feb 2019 13:50:01 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9k-0007Gi-Lg; Sun, 03 Feb 2019 14:49:56 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "David Sterba" <dsterba@suse.com>, "Qu Wenruo" <wqu@suse.com>,
        "Filipe Manana" <fdmanana@suse.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.742000628@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 222/305] Btrfs: fix race between enabling quotas and
 subvolume creation
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

commit 552f0329c75b3e1d7f9bb8c9e421d37403f192cd upstream.

We have a race between enabling quotas end subvolume creation that cause
subvolume creation to fail with -EINVAL, and the following diagram shows
how it happens:

              CPU 0                                          CPU 1

 btrfs_ioctl()
  btrfs_ioctl_quota_ctl()
   btrfs_quota_enable()
    mutex_lock(fs_info->qgroup_ioctl_lock)

                                                  btrfs_ioctl()
                                                   create_subvol()
                                                    btrfs_qgroup_inherit()
                                                     -> save fs_info->quota_root
                                                        into quota_root
                                                     -> stores a NULL value
                                                     -> tries to lock the mutex
                                                        qgroup_ioctl_lock
                                                        -> blocks waiting for
                                                           the task at CPU0

   -> sets BTRFS_FS_QUOTA_ENABLED in fs_info
   -> sets quota_root in fs_info->quota_root
      (non-NULL value)

   mutex_unlock(fs_info->qgroup_ioctl_lock)

                                                     -> checks quota enabled
                                                        flag is set
                                                     -> returns -EINVAL because
                                                        fs_info->quota_root was
                                                        NULL before it acquired
                                                        the mutex
                                                        qgroup_ioctl_lock
                                                   -> ioctl returns -EINVAL

Returning -EINVAL to user space will be confusing if all the arguments
passed to the subvolume creation ioctl were valid.

Fix it by grabbing the value from fs_info->quota_root after acquiring
the mutex.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/btrfs/qgroup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2024,7 +2024,7 @@ int btrfs_qgroup_inherit(struct btrfs_tr
 	int ret = 0;
 	int i;
 	u64 *i_qgroups;
-	struct btrfs_root *quota_root = fs_info->quota_root;
+	struct btrfs_root *quota_root;
 	struct btrfs_qgroup *srcgroup;
 	struct btrfs_qgroup *dstgroup;
 	u32 level_size = 0;
@@ -2034,6 +2034,7 @@ int btrfs_qgroup_inherit(struct btrfs_tr
 	if (!fs_info->quota_enabled)
 		goto out;
 
+	quota_root = fs_info->quota_root;
 	if (!quota_root) {
 		ret = -EINVAL;
 		goto out;

