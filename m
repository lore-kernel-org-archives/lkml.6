Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754578AbeE1KJX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:09:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935270AbeE1KJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:09:16 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 083/185] Btrfs: send, fix issuing write op when processing hole in no data mode
Date: Mon, 28 May 2018 12:02:04 +0200
Message-Id: <20180528100057.695555301@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100050.700971285@linuxfoundation.org>
References: <20180528100050.700971285@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit d4dfc0f4d39475ccbbac947880b5464a74c30b99 ]

When doing an incremental send of a filesystem with the no-holes feature
enabled, we end up issuing a write operation when using the no data mode
send flag, instead of issuing an update extent operation. Fix this by
issuing the update extent operation instead.

Trivial reproducer:

  $ mkfs.btrfs -f -O no-holes /dev/sdc
  $ mkfs.btrfs -f /dev/sdd
  $ mount /dev/sdc /mnt/sdc
  $ mount /dev/sdd /mnt/sdd

  $ xfs_io -f -c "pwrite -S 0xab 0 32K" /mnt/sdc/foobar
  $ btrfs subvolume snapshot -r /mnt/sdc /mnt/sdc/snap1

  $ xfs_io -c "fpunch 8K 8K" /mnt/sdc/foobar
  $ btrfs subvolume snapshot -r /mnt/sdc /mnt/sdc/snap2

  $ btrfs send /mnt/sdc/snap1 | btrfs receive /mnt/sdd
  $ btrfs send --no-data -p /mnt/sdc/snap1 /mnt/sdc/snap2 \
       | btrfs receive -vv /mnt/sdd

Before this change the output of the second receive command is:

  receiving snapshot snap2 uuid=f6922049-8c22-e544-9ff9-fc6755918447...
  utimes
  write foobar, offset 8192, len 8192
  utimes foobar
  BTRFS_IOC_SET_RECEIVED_SUBVOL uuid=f6922049-8c22-e544-9ff9-...

After this change it is:

  receiving snapshot snap2 uuid=564d36a3-ebc8-7343-aec9-bf6fda278e64...
  utimes
  update_extent foobar: offset=8192, len=8192
  utimes foobar
  BTRFS_IOC_SET_RECEIVED_SUBVOL uuid=564d36a3-ebc8-7343-aec9-bf6fda278e64...

Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/send.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4485,6 +4485,9 @@ static int send_hole(struct send_ctx *sc
 	u64 len;
 	int ret = 0;
 
+	if (sctx->flags & BTRFS_SEND_FLAG_NO_FILE_DATA)
+		return send_update_extent(sctx, offset, end - offset);
+
 	p = fs_path_alloc();
 	if (!p)
 		return -ENOMEM;
