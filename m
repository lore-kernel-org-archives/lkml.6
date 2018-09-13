Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6BBC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E7CD20652
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:05:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E7CD20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732002AbeIMTPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:15:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35502 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731329AbeIMTPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:15:13 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CF96FD39;
        Thu, 13 Sep 2018 14:05:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 151/197] btrfs: fix mount and ioctl device scan ioctl race
Date:   Thu, 13 Sep 2018 15:31:40 +0200
Message-Id: <20180913131847.596642460@linuxfoundation.org>
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

[ Upstream commit 81ffd56b5745355b70d54ca4e1bdd0d64a66ff9f ]

Technically this extends the critical section covered by uuid_mutex to:

- parse early mount options -- here we can call device scan on paths
  that can be passed as 'device=/dev/...'

- scan the device passed to mount

- open the devices related to the fs_devices -- this increases
  fs_devices::opened

The race can happen when mount calls one of the scans and there's
another one called eg. by mkfs or 'btrfs dev scan':

Mount                                  Scan
-----                                  ----
scan_one_device (dev1, fsid1)
                                       scan_one_device (dev2, fsid1)
				           add the device
					   free stale devices
					       fsid1 fs_devices::opened == 0
					           find fsid1:dev1
					           free fsid1:dev1
					           if it's the last one,
					            free fs_devices of fsid1
						    too

open_devices (dev1, fsid1)
   dev1 not found

When fixed, the uuid mutex will make sure that mount will increase
fs_devices::opened and this will not be touched by the racing scan
ioctl.

Reported-and-tested-by: syzbot+909a5177749d7990ffa4@syzkaller.appspotmail.com
Reported-and-tested-by: syzbot+ceb2606025ec1cc3479c@syzkaller.appspotmail.com
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: David Sterba <dsterba@suse.com>

Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/super.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1557,19 +1557,19 @@ static struct dentry *btrfs_mount_root(s
 
 	mutex_lock(&uuid_mutex);
 	error = btrfs_parse_early_options(data, mode, fs_type, &fs_devices);
-	mutex_unlock(&uuid_mutex);
-	if (error)
+	if (error) {
+		mutex_unlock(&uuid_mutex);
 		goto error_fs_info;
+	}
 
-	mutex_lock(&uuid_mutex);
 	error = btrfs_scan_one_device(device_name, mode, fs_type, &fs_devices);
-	mutex_unlock(&uuid_mutex);
-	if (error)
+	if (error) {
+		mutex_unlock(&uuid_mutex);
 		goto error_fs_info;
+	}
 
 	fs_info->fs_devices = fs_devices;
 
-	mutex_lock(&uuid_mutex);
 	error = btrfs_open_devices(fs_devices, mode, fs_type);
 	mutex_unlock(&uuid_mutex);
 	if (error)


