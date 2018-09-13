Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35B2C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C2720854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:04:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9C2720854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732137AbeIMTO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:14:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35422 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728565AbeIMTO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:14:27 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 12B3ED35;
        Thu, 13 Sep 2018 14:04:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 150/197] btrfs: reorder initialization before the mount locks uuid_mutex
Date:   Thu, 13 Sep 2018 15:31:39 +0200
Message-Id: <20180913131847.549276005@linuxfoundation.org>
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

[ Upstream commit 399f7f4c42e8a58c8456264d5112287aefe44cf4 ]

In preparation to take a big lock, move resource initialization before
the critical section. It's not obvious from the diff, the desired order
is:

- initialize mount security options
- allocate temporary fs_info
- allocate superblock buffers

Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/super.c |   30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1528,14 +1528,6 @@ static struct dentry *btrfs_mount_root(s
 	if (!(flags & SB_RDONLY))
 		mode |= FMODE_WRITE;
 
-	mutex_lock(&uuid_mutex);
-	error = btrfs_parse_early_options(data, mode, fs_type,
-					  &fs_devices);
-	mutex_unlock(&uuid_mutex);
-	if (error) {
-		return ERR_PTR(error);
-	}
-
 	security_init_mnt_opts(&new_sec_opts);
 	if (data) {
 		error = parse_security_options(data, &new_sec_opts);
@@ -1543,12 +1535,6 @@ static struct dentry *btrfs_mount_root(s
 			return ERR_PTR(error);
 	}
 
-	mutex_lock(&uuid_mutex);
-	error = btrfs_scan_one_device(device_name, mode, fs_type, &fs_devices);
-	mutex_unlock(&uuid_mutex);
-	if (error)
-		goto error_sec_opts;
-
 	/*
 	 * Setup a dummy root and fs_info for test/set super.  This is because
 	 * we don't actually fill this stuff out until open_ctree, but we need
@@ -1561,8 +1547,6 @@ static struct dentry *btrfs_mount_root(s
 		goto error_sec_opts;
 	}
 
-	fs_info->fs_devices = fs_devices;
-
 	fs_info->super_copy = kzalloc(BTRFS_SUPER_INFO_SIZE, GFP_KERNEL);
 	fs_info->super_for_commit = kzalloc(BTRFS_SUPER_INFO_SIZE, GFP_KERNEL);
 	security_init_mnt_opts(&fs_info->security_opts);
@@ -1572,6 +1556,20 @@ static struct dentry *btrfs_mount_root(s
 	}
 
 	mutex_lock(&uuid_mutex);
+	error = btrfs_parse_early_options(data, mode, fs_type, &fs_devices);
+	mutex_unlock(&uuid_mutex);
+	if (error)
+		goto error_fs_info;
+
+	mutex_lock(&uuid_mutex);
+	error = btrfs_scan_one_device(device_name, mode, fs_type, &fs_devices);
+	mutex_unlock(&uuid_mutex);
+	if (error)
+		goto error_fs_info;
+
+	fs_info->fs_devices = fs_devices;
+
+	mutex_lock(&uuid_mutex);
 	error = btrfs_open_devices(fs_devices, mode, fs_type);
 	mutex_unlock(&uuid_mutex);
 	if (error)


