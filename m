Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3995FC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 077032081B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896473;
	bh=A0EQBWxc2hsjEA6TLwLgY/FwBayOJ2qlqbRlUQM1sjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uh7nwtOUCrLWVpLFfnb4m4c6cXqHC5Dxpm5ydUjfh5W63RjYAJgH0Yhl/NzOvtdcp
	 R+xmFcyD9Jwki5xhsLdeaULXgsU9OWSls8toHPN3EaTKCv36MXjHSPa7Ok3f+44YRb
	 wG249x6PI9wZPjXAoIJ+6cTJ0pkmDpOo5V3NEJW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387593AbfBKOrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:47:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:32936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387581AbfBKOrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:47:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 583E0206BA;
        Mon, 11 Feb 2019 14:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896466;
        bh=A0EQBWxc2hsjEA6TLwLgY/FwBayOJ2qlqbRlUQM1sjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jPyeIvwMceK9J5YD5qtdHRzb3+U1h4GT05GAaG920L+1upOMl2LP3wpXK0u60e7dk
         3bFzgd++iefb2qb9syyLaxmei4tHNF3Jo8ZMvPe5qvnRMrey2nIrHe2GI2/fredPrL
         cHzhLKDOBa9ojUbXwlLWQQvqcXs8I2t3cTgU/SxY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 152/313] btrfs: harden agaist duplicate fsid on scanned devices
Date:   Mon, 11 Feb 2019 15:17:12 +0100
Message-Id: <20190211141903.700518620@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

[ Upstream commit a9261d4125c97ce8624e9941b75dee1b43ad5df9 ]

It's not that impossible to imagine that a device OR a btrfs image is
copied just by using the dd or the cp command. Which in case both the
copies of the btrfs will have the same fsid. If on the system with
automount enabled, the copied FS gets scanned.

We have a known bug in btrfs, that we let the device path be changed
after the device has been mounted. So using this loop hole the new
copied device would appears as if its mounted immediately after it's
been copied.

For example:

Initially.. /dev/mmcblk0p4 is mounted as /

  $ lsblk
  NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
  mmcblk0     179:0    0 29.2G  0 disk
  |-mmcblk0p4 179:4    0    4G  0 part /
  |-mmcblk0p2 179:2    0  500M  0 part /boot
  |-mmcblk0p3 179:3    0  256M  0 part [SWAP]
  `-mmcblk0p1 179:1    0  256M  0 part /boot/efi

  $ btrfs fi show
     Label: none  uuid: 07892354-ddaa-4443-90ea-f76a06accaba
     Total devices 1 FS bytes used 1.40GiB
     devid    1 size 4.00GiB used 3.00GiB path /dev/mmcblk0p4

Copy mmcblk0 to sda

  $ dd if=/dev/mmcblk0 of=/dev/sda

And immediately after the copy completes the change in the device
superblock is notified which the automount scans using btrfs device scan
and the new device sda becomes the mounted root device.

  $ lsblk
  NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
  sda           8:0    1 14.9G  0 disk
  |-sda4        8:4    1    4G  0 part /
  |-sda2        8:2    1  500M  0 part
  |-sda3        8:3    1  256M  0 part
  `-sda1        8:1    1  256M  0 part
  mmcblk0     179:0    0 29.2G  0 disk
  |-mmcblk0p4 179:4    0    4G  0 part
  |-mmcblk0p2 179:2    0  500M  0 part /boot
  |-mmcblk0p3 179:3    0  256M  0 part [SWAP]
  `-mmcblk0p1 179:1    0  256M  0 part /boot/efi

  $ btrfs fi show /
    Label: none  uuid: 07892354-ddaa-4443-90ea-f76a06accaba
    Total devices 1 FS bytes used 1.40GiB
    devid    1 size 4.00GiB used 3.00GiB path /dev/sda4

The bug is quite nasty that you can't either unmount /dev/sda4 or
/dev/mmcblk0p4. And the problem does not get solved until you take sda
out of the system on to another system to change its fsid using the
'btrfstune -u' command.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/volumes.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 0ee1cd4b56fb..285f64f2de5f 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -850,6 +850,35 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 			return ERR_PTR(-EEXIST);
 		}
 
+		/*
+		 * We are going to replace the device path for a given devid,
+		 * make sure it's the same device if the device is mounted
+		 */
+		if (device->bdev) {
+			struct block_device *path_bdev;
+
+			path_bdev = lookup_bdev(path);
+			if (IS_ERR(path_bdev)) {
+				mutex_unlock(&fs_devices->device_list_mutex);
+				return ERR_CAST(path_bdev);
+			}
+
+			if (device->bdev != path_bdev) {
+				bdput(path_bdev);
+				mutex_unlock(&fs_devices->device_list_mutex);
+				btrfs_warn_in_rcu(device->fs_info,
+			"duplicate device fsid:devid for %pU:%llu old:%s new:%s",
+					disk_super->fsid, devid,
+					rcu_str_deref(device->name), path);
+				return ERR_PTR(-EEXIST);
+			}
+			bdput(path_bdev);
+			btrfs_info_in_rcu(device->fs_info,
+				"device fsid %pU devid %llu moved old:%s new:%s",
+				disk_super->fsid, devid,
+				rcu_str_deref(device->name), path);
+		}
+
 		name = rcu_string_strdup(path, GFP_NOFS);
 		if (!name) {
 			mutex_unlock(&fs_devices->device_list_mutex);
-- 
2.19.1



