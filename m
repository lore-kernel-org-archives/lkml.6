Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AA6C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1BCB20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:06:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1BCB20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731858AbeIMTP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:15:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35568 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729111AbeIMTPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:15:55 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 64F9FD36;
        Thu, 13 Sep 2018 14:06:15 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 147/197] btrfs: use device_list_mutex when removing stale devices
Date:   Thu, 13 Sep 2018 15:31:36 +0200
Message-Id: <20180913131847.435319298@linuxfoundation.org>
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

[ Upstream commit 7bcb8164ad9435068d9bc3b83b8a002c64d63ff6 ]

btrfs_free_stale_devices() finds a stale (not opened) device matching
path in the fs_uuid list. We are already under uuid_mutex so when we
check for each fs_devices, hold the device_list_mutex too.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/volumes.c |   25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -640,8 +640,11 @@ static void btrfs_free_stale_devices(con
 	struct btrfs_device *device, *tmp_device;
 
 	list_for_each_entry_safe(fs_devices, tmp_fs_devices, &fs_uuids, fs_list) {
-		if (fs_devices->opened)
+		mutex_lock(&fs_devices->device_list_mutex);
+		if (fs_devices->opened) {
+			mutex_unlock(&fs_devices->device_list_mutex);
 			continue;
+		}
 
 		list_for_each_entry_safe(device, tmp_device,
 					 &fs_devices->devices, dev_list) {
@@ -661,16 +664,18 @@ static void btrfs_free_stale_devices(con
 				continue;
 
 			/* delete the stale device */
-			if (fs_devices->num_devices == 1) {
-				btrfs_sysfs_remove_fsid(fs_devices);
-				list_del(&fs_devices->fs_list);
-				free_fs_devices(fs_devices);
+			fs_devices->num_devices--;
+			list_del(&device->dev_list);
+			btrfs_free_device(device);
+
+			if (fs_devices->num_devices == 0)
 				break;
-			} else {
-				fs_devices->num_devices--;
-				list_del(&device->dev_list);
-				btrfs_free_device(device);
-			}
+		}
+		mutex_unlock(&fs_devices->device_list_mutex);
+		if (fs_devices->num_devices == 0) {
+			btrfs_sysfs_remove_fsid(fs_devices);
+			list_del(&fs_devices->fs_list);
+			free_fs_devices(fs_devices);
 		}
 	}
 }


