Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A14C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ADE320652
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:01:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ADE320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731891AbeIMTL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:11:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35100 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731650AbeIMTL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:11:28 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 52B2CD1C;
        Thu, 13 Sep 2018 14:01:49 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 144/197] btrfs: do btrfs_free_stale_devices outside of device_list_add
Date:   Thu, 13 Sep 2018 15:31:33 +0200
Message-Id: <20180913131847.320795388@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anand Jain <anand.jain@oracle.com>

[ Upstream commit 4306a97449f9a0f9e5229af7889d4401315355aa ]

btrfs_free_stale_devices() looks for device path reused for another
filesystem, and deletes the older fs_devices::device entry.

In preparation to handle locking in device_list_add, move
btrfs_free_stale_devices outside as these two functions serve a
different purpose.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/volumes.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -750,7 +750,8 @@ error_brelse:
  * error pointer when failed
  */
 static noinline struct btrfs_device *device_list_add(const char *path,
-			   struct btrfs_super_block *disk_super)
+			   struct btrfs_super_block *disk_super,
+			   bool *new_device_added)
 {
 	struct btrfs_device *device;
 	struct btrfs_fs_devices *fs_devices;
@@ -796,7 +797,7 @@ static noinline struct btrfs_device *dev
 		mutex_unlock(&fs_devices->device_list_mutex);
 
 		device->fs_devices = fs_devices;
-		btrfs_free_stale_devices(path, device);
+		*new_device_added = true;
 
 		if (disk_super->label[0])
 			pr_info("BTRFS: device label %s devid %llu transid %llu %s\n",
@@ -1221,6 +1222,7 @@ int btrfs_scan_one_device(const char *pa
 			  struct btrfs_fs_devices **fs_devices_ret)
 {
 	struct btrfs_super_block *disk_super;
+	bool new_device_added = false;
 	struct btrfs_device *device;
 	struct block_device *bdev;
 	struct page *page;
@@ -1246,11 +1248,14 @@ int btrfs_scan_one_device(const char *pa
 	}
 
 	mutex_lock(&uuid_mutex);
-	device = device_list_add(path, disk_super);
-	if (IS_ERR(device))
+	device = device_list_add(path, disk_super, &new_device_added);
+	if (IS_ERR(device)) {
 		ret = PTR_ERR(device);
-	else
+	} else {
 		*fs_devices_ret = device->fs_devices;
+		if (new_device_added)
+			btrfs_free_stale_devices(path, device);
+	}
 	mutex_unlock(&uuid_mutex);
 
 	btrfs_release_disk_super(page);


