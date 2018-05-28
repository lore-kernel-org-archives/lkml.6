Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424965AbeE1Lup (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:50:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:57904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423825AbeE1LJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:09:51 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 130/272] btrfs: fix null pointer deref when target device is missing
Date: Mon, 28 May 2018 12:02:43 +0200
Message-Id: <20180528100252.036428143@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anand Jain <anand.jain@oracle.com>

[ Upstream commit acf18c56fdcb952a06650282192e3b4ca1855c5e ]

The replace target device can be missing when mounted with -o degraded,
but we wont allocate a missing btrfs_device to it. So check the device
before accessing.

BUG: unable to handle kernel NULL pointer dereference at 00000000000000b0
IP: btrfs_destroy_dev_replace_tgtdev+0x43/0xf0 [btrfs]
Call Trace:
btrfs_dev_replace_cancel+0x15f/0x180 [btrfs]
btrfs_ioctl+0x2216/0x2590 [btrfs]
do_vfs_ioctl+0x625/0x650
SyS_ioctl+0x4e/0x80
do_syscall_64+0x5d/0x160
entry_SYSCALL64_slow_path+0x25/0x25

This patch has been moved in front of patch "btrfs: log, when replace,
is canceled by the user" that could reproduce the crash if the system
reboots inside btrfs_dev_replace_start before the
btrfs_dev_replace_finishing call.

 $ mkfs /dev/sda
 $ mount /dev/sda mnt
 $ btrfs replace start /dev/sda /dev/sdb
 <insert reboot>
 $ mount po degraded /dev/sdb mnt
 <crash>

Signed-off-by: Anand Jain <anand.jain@oracle.com>
[ added reproducer description from mail ]
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/dev-replace.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -307,7 +307,7 @@ void btrfs_after_dev_replace_commit(stru
 
 static char* btrfs_dev_name(struct btrfs_device *device)
 {
-	if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
+	if (!device || test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
 		return "<missing disk>";
 	else
 		return rcu_str_deref(device->name);
