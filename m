Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89ECFC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49BA120652
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49BA120652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731836AbeIMTLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:11:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35044 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730449AbeIMTLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:11:06 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EC129D20;
        Thu, 13 Sep 2018 14:01:28 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 139/197] btrfs: lift uuid_mutex to callers of btrfs_open_devices
Date:   Thu, 13 Sep 2018 15:31:28 +0200
Message-Id: <20180913131847.114986271@linuxfoundation.org>
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

[ Upstream commit f5194e34cabaddd348a90f950e0a8188dd26cdc0 ]

Prepartory work to fix race between mount and device scan.

The callers will have to manage the critical section, eg. mount wants to
scan and then call btrfs_open_devices without the ioctl scan walking in
and modifying the fs devices in the meantime.

Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/super.c   |    2 ++
 fs/btrfs/volumes.c |    4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1565,7 +1565,9 @@ static struct dentry *btrfs_mount_root(s
 		goto error_fs_info;
 	}
 
+	mutex_lock(&uuid_mutex);
 	error = btrfs_open_devices(fs_devices, mode, fs_type);
+	mutex_unlock(&uuid_mutex);
 	if (error)
 		goto error_fs_info;
 
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1146,7 +1146,8 @@ int btrfs_open_devices(struct btrfs_fs_d
 {
 	int ret;
 
-	mutex_lock(&uuid_mutex);
+	lockdep_assert_held(&uuid_mutex);
+
 	mutex_lock(&fs_devices->device_list_mutex);
 	if (fs_devices->opened) {
 		fs_devices->opened++;
@@ -1156,7 +1157,6 @@ int btrfs_open_devices(struct btrfs_fs_d
 		ret = open_fs_devices(fs_devices, flags, holder);
 	}
 	mutex_unlock(&fs_devices->device_list_mutex);
-	mutex_unlock(&uuid_mutex);
 
 	return ret;
 }


