Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53636C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD1E20652
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:02:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FD1E20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731980AbeIMTMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:12:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35248 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731126AbeIMTMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:12:13 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 786A5D2F;
        Thu, 13 Sep 2018 14:02:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 148/197] btrfs: lift uuid_mutex to callers of btrfs_scan_one_device
Date:   Thu, 13 Sep 2018 15:31:37 +0200
Message-Id: <20180913131847.474140772@linuxfoundation.org>
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

From: David Sterba <dsterba@suse.com>

[ Upstream commit 899f9307c33ce4758c30a076b10ed54d5c91c6e7 ]

Prepartory work to fix race between mount and device scan.

The callers will have to manage the critical section, eg. mount wants to
scan and then call btrfs_open_devices without the ioctl scan walking in
and modifying the fs devices in the meantime.

Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/super.c   |   12 +++++++++++-
 fs/btrfs/volumes.c |    4 ++--
 2 files changed, 13 insertions(+), 3 deletions(-)

--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -917,8 +917,10 @@ static int btrfs_parse_early_options(con
 				error = -ENOMEM;
 				goto out;
 			}
+			mutex_lock(&uuid_mutex);
 			error = btrfs_scan_one_device(device_name,
 					flags, holder, fs_devices);
+			mutex_unlock(&uuid_mutex);
 			kfree(device_name);
 			if (error)
 				goto out;
@@ -1539,7 +1541,9 @@ static struct dentry *btrfs_mount_root(s
 			return ERR_PTR(error);
 	}
 
+	mutex_lock(&uuid_mutex);
 	error = btrfs_scan_one_device(device_name, mode, fs_type, &fs_devices);
+	mutex_unlock(&uuid_mutex);
 	if (error)
 		goto error_sec_opts;
 
@@ -2236,15 +2240,21 @@ static long btrfs_control_ioctl(struct f
 
 	switch (cmd) {
 	case BTRFS_IOC_SCAN_DEV:
+		mutex_lock(&uuid_mutex);
 		ret = btrfs_scan_one_device(vol->name, FMODE_READ,
 					    &btrfs_root_fs_type, &fs_devices);
+		mutex_unlock(&uuid_mutex);
 		break;
 	case BTRFS_IOC_DEVICES_READY:
+		mutex_lock(&uuid_mutex);
 		ret = btrfs_scan_one_device(vol->name, FMODE_READ,
 					    &btrfs_root_fs_type, &fs_devices);
-		if (ret)
+		if (ret) {
+			mutex_unlock(&uuid_mutex);
 			break;
+		}
 		ret = !(fs_devices->num_devices == fs_devices->total_devices);
+		mutex_unlock(&uuid_mutex);
 		break;
 	case BTRFS_IOC_GET_SUPPORTED_FEATURES:
 		ret = btrfs_ioctl_get_supported_features((void __user*)arg);
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1241,6 +1241,8 @@ int btrfs_scan_one_device(const char *pa
 	int ret = 0;
 	u64 bytenr;
 
+	lockdep_assert_held(&uuid_mutex);
+
 	/*
 	 * we would like to check all the supers, but that would make
 	 * a btrfs mount succeed after a mkfs from a different FS.
@@ -1259,7 +1261,6 @@ int btrfs_scan_one_device(const char *pa
 		goto error_bdev_put;
 	}
 
-	mutex_lock(&uuid_mutex);
 	device = device_list_add(path, disk_super, &new_device_added);
 	if (IS_ERR(device)) {
 		ret = PTR_ERR(device);
@@ -1268,7 +1269,6 @@ int btrfs_scan_one_device(const char *pa
 		if (new_device_added)
 			btrfs_free_stale_devices(path, device);
 	}
-	mutex_unlock(&uuid_mutex);
 
 	btrfs_release_disk_super(page);
 


