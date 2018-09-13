Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32BFC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B1320652
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66B1320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732059AbeIMTN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:13:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35334 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbeIMTN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:13:27 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6DDD2D2E;
        Thu, 13 Sep 2018 14:03:48 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 149/197] btrfs: lift uuid_mutex to callers of btrfs_parse_early_options
Date:   Thu, 13 Sep 2018 15:31:38 +0200
Message-Id: <20180913131847.511999376@linuxfoundation.org>
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

[ Upstream commit 5139cff598d42b1e531f40c84691a7e945f04553 ]

Prepartory work to fix race between mount and device scan.

btrfs_parse_early_options calls the device scan from mount and we'll
need to let mount completely manage the critical section.

Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/super.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -892,6 +892,8 @@ static int btrfs_parse_early_options(con
 	char *device_name, *opts, *orig, *p;
 	int error = 0;
 
+	lockdep_assert_held(&uuid_mutex);
+
 	if (!options)
 		return 0;
 
@@ -917,10 +919,8 @@ static int btrfs_parse_early_options(con
 				error = -ENOMEM;
 				goto out;
 			}
-			mutex_lock(&uuid_mutex);
 			error = btrfs_scan_one_device(device_name,
 					flags, holder, fs_devices);
-			mutex_unlock(&uuid_mutex);
 			kfree(device_name);
 			if (error)
 				goto out;
@@ -1528,8 +1528,10 @@ static struct dentry *btrfs_mount_root(s
 	if (!(flags & SB_RDONLY))
 		mode |= FMODE_WRITE;
 
+	mutex_lock(&uuid_mutex);
 	error = btrfs_parse_early_options(data, mode, fs_type,
 					  &fs_devices);
+	mutex_unlock(&uuid_mutex);
 	if (error) {
 		return ERR_PTR(error);
 	}


