Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75877C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B74F20652
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B74F20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731914AbeIMTLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:11:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35120 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731505AbeIMTLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:11:34 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 43C49D28;
        Thu, 13 Sep 2018 14:01:56 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 146/197] btrfs: rename local devices for fs_devices in btrfs_free_stale_devices(
Date:   Thu, 13 Sep 2018 15:31:35 +0200
Message-Id: <20180913131847.397320096@linuxfoundation.org>
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

[ Upstream commit fa6d2ae540a200a17bb7ee769f9df22d411c9404 ]

Over the years we named %fs_devices and %devices to represent the
struct btrfs_fs_devices and the struct btrfs_device. So follow the same
scheme here too. No functional changes.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/volumes.c |   35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -634,43 +634,42 @@ static void pending_bios_fn(struct btrfs
  *		devices.
  */
 static void btrfs_free_stale_devices(const char *path,
-				     struct btrfs_device *skip_dev)
+				     struct btrfs_device *skip_device)
 {
-	struct btrfs_fs_devices *fs_devs, *tmp_fs_devs;
-	struct btrfs_device *dev, *tmp_dev;
+	struct btrfs_fs_devices *fs_devices, *tmp_fs_devices;
+	struct btrfs_device *device, *tmp_device;
 
-	list_for_each_entry_safe(fs_devs, tmp_fs_devs, &fs_uuids, fs_list) {
-
-		if (fs_devs->opened)
+	list_for_each_entry_safe(fs_devices, tmp_fs_devices, &fs_uuids, fs_list) {
+		if (fs_devices->opened)
 			continue;
 
-		list_for_each_entry_safe(dev, tmp_dev,
-					 &fs_devs->devices, dev_list) {
+		list_for_each_entry_safe(device, tmp_device,
+					 &fs_devices->devices, dev_list) {
 			int not_found = 0;
 
-			if (skip_dev && skip_dev == dev)
+			if (skip_device && skip_device == device)
 				continue;
-			if (path && !dev->name)
+			if (path && !device->name)
 				continue;
 
 			rcu_read_lock();
 			if (path)
-				not_found = strcmp(rcu_str_deref(dev->name),
+				not_found = strcmp(rcu_str_deref(device->name),
 						   path);
 			rcu_read_unlock();
 			if (not_found)
 				continue;
 
 			/* delete the stale device */
-			if (fs_devs->num_devices == 1) {
-				btrfs_sysfs_remove_fsid(fs_devs);
-				list_del(&fs_devs->fs_list);
-				free_fs_devices(fs_devs);
+			if (fs_devices->num_devices == 1) {
+				btrfs_sysfs_remove_fsid(fs_devices);
+				list_del(&fs_devices->fs_list);
+				free_fs_devices(fs_devices);
 				break;
 			} else {
-				fs_devs->num_devices--;
-				list_del(&dev->dev_list);
-				btrfs_free_device(dev);
+				fs_devices->num_devices--;
+				list_del(&device->dev_list);
+				btrfs_free_device(device);
 			}
 		}
 	}


