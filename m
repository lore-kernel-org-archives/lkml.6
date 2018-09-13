Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADED7C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6B520652
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E6B520652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731903AbeIMTLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:11:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35112 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731895AbeIMTLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:11:31 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 81B8AD27;
        Thu, 13 Sep 2018 14:01:52 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 145/197] btrfs: extend locked section when adding a new device in device_list_add
Date:   Thu, 13 Sep 2018 15:31:34 +0200
Message-Id: <20180913131847.356027895@linuxfoundation.org>
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

[ Upstream commit 9c6d173ea6e4c8c939ae6c257c7fc18f7b320316 ]

Make sure the device_list_lock is held the whole time:

* when the device is being looked up
* new device is initialized and put to the list
* the list counters are updated (fs_devices::opened, fs_devices::total_devices)

Signed-off-by: Anand Jain <anand.jain@oracle.com>
[ update changelog ]
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/volumes.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -765,21 +765,26 @@ static noinline struct btrfs_device *dev
 		if (IS_ERR(fs_devices))
 			return ERR_CAST(fs_devices);
 
+		mutex_lock(&fs_devices->device_list_mutex);
 		list_add(&fs_devices->fs_list, &fs_uuids);
 
 		device = NULL;
 	} else {
+		mutex_lock(&fs_devices->device_list_mutex);
 		device = find_device(fs_devices, devid,
 				disk_super->dev_item.uuid);
 	}
 
 	if (!device) {
-		if (fs_devices->opened)
+		if (fs_devices->opened) {
+			mutex_unlock(&fs_devices->device_list_mutex);
 			return ERR_PTR(-EBUSY);
+		}
 
 		device = btrfs_alloc_device(NULL, &devid,
 					    disk_super->dev_item.uuid);
 		if (IS_ERR(device)) {
+			mutex_unlock(&fs_devices->device_list_mutex);
 			/* we can safely leave the fs_devices entry around */
 			return device;
 		}
@@ -787,14 +792,13 @@ static noinline struct btrfs_device *dev
 		name = rcu_string_strdup(path, GFP_NOFS);
 		if (!name) {
 			btrfs_free_device(device);
+			mutex_unlock(&fs_devices->device_list_mutex);
 			return ERR_PTR(-ENOMEM);
 		}
 		rcu_assign_pointer(device->name, name);
 
-		mutex_lock(&fs_devices->device_list_mutex);
 		list_add_rcu(&device->dev_list, &fs_devices->devices);
 		fs_devices->num_devices++;
-		mutex_unlock(&fs_devices->device_list_mutex);
 
 		device->fs_devices = fs_devices;
 		*new_device_added = true;
@@ -841,12 +845,15 @@ static noinline struct btrfs_device *dev
 			 * with larger generation number or the last-in if
 			 * generation are equal.
 			 */
+			mutex_unlock(&fs_devices->device_list_mutex);
 			return ERR_PTR(-EEXIST);
 		}
 
 		name = rcu_string_strdup(path, GFP_NOFS);
-		if (!name)
+		if (!name) {
+			mutex_unlock(&fs_devices->device_list_mutex);
 			return ERR_PTR(-ENOMEM);
+		}
 		rcu_string_free(device->name);
 		rcu_assign_pointer(device->name, name);
 		if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state)) {
@@ -866,6 +873,7 @@ static noinline struct btrfs_device *dev
 
 	fs_devices->total_devices = btrfs_super_num_devices(disk_super);
 
+	mutex_unlock(&fs_devices->device_list_mutex);
 	return device;
 }
 


