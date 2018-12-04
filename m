Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90751C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53DC42146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLohTg0O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53DC42146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbeLDL0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:26:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:44688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727166AbeLDK7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:59:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 691012087F;
        Tue,  4 Dec 2018 10:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921181;
        bh=seDYJtr5bJpUEzg7YnGW6ML+9BhaqsNVTJJDjvRTs/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mLohTg0OqFUiAlxg7bpB5lNO4d+7v53Pu/SAoBI2s/S374Ir0szbu7jZFO/e8Alff
         VnPGDwV5LNZW7LiZZHUPOPSOuAStCTAvBuCf/E/4fAxJJj20b+4/RZNWjSTiSYsvCC
         96riwnDKXGbCIW8jR3lKM+d7xrv7naeRFSTao81g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 077/139] Btrfs: fix race between enabling quotas and subvolume creation
Date:   Tue,  4 Dec 2018 11:49:18 +0100
Message-Id: <20181204103653.312216806@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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

CC: stable@vger.kernel.org # 4.4+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/qgroup.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2244,7 +2244,7 @@ int btrfs_qgroup_inherit(struct btrfs_tr
 	int i;
 	u64 *i_qgroups;
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_root *quota_root = fs_info->quota_root;
+	struct btrfs_root *quota_root;
 	struct btrfs_qgroup *srcgroup;
 	struct btrfs_qgroup *dstgroup;
 	u32 level_size = 0;
@@ -2254,6 +2254,7 @@ int btrfs_qgroup_inherit(struct btrfs_tr
 	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
 		goto out;
 
+	quota_root = fs_info->quota_root;
 	if (!quota_root) {
 		ret = -EINVAL;
 		goto out;


