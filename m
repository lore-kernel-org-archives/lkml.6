Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53E2C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A6BF218D8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbfBCNuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:50:25 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53446 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728197AbfBCNtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:49:52 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9f-0003th-7V; Sun, 03 Feb 2019 13:49:51 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9b-00074b-SO; Sun, 03 Feb 2019 14:49:47 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Filipe Manana" <fdmanana@suse.com>,
        "David Sterba" <dsterba@suse.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.445364758@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 146/305] Btrfs: fix data corruption due to cloning of
 eof block
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

commit ac765f83f1397646c11092a032d4f62c3d478b81 upstream.

We currently allow cloning a range from a file which includes the last
block of the file even if the file's size is not aligned to the block
size. This is fine and useful when the destination file has the same size,
but when it does not and the range ends somewhere in the middle of the
destination file, it leads to corruption because the bytes between the EOF
and the end of the block have undefined data (when there is support for
discard/trimming they have a value of 0x00).

Example:

 $ mkfs.btrfs -f /dev/sdb
 $ mount /dev/sdb /mnt

 $ export foo_size=$((256 * 1024 + 100))
 $ xfs_io -f -c "pwrite -S 0x3c 0 $foo_size" /mnt/foo
 $ xfs_io -f -c "pwrite -S 0xb5 0 1M" /mnt/bar

 $ xfs_io -c "reflink /mnt/foo 0 512K $foo_size" /mnt/bar

 $ od -A d -t x1 /mnt/bar
 0000000 b5 b5 b5 b5 b5 b5 b5 b5 b5 b5 b5 b5 b5 b5 b5 b5
 *
 0524288 3c 3c 3c 3c 3c 3c 3c 3c 3c 3c 3c 3c 3c 3c 3c 3c
 *
 0786528 3c 3c 3c 3c 00 00 00 00 00 00 00 00 00 00 00 00
 0786544 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 *
 0790528 b5 b5 b5 b5 b5 b5 b5 b5 b5 b5 b5 b5 b5 b5 b5 b5
 *
 1048576

The bytes in the range from 786532 (512Kb + 256Kb + 100 bytes) to 790527
(512Kb + 256Kb + 4Kb - 1) got corrupted, having now a value of 0x00 instead
of 0xb5.

This is similar to the problem we had for deduplication that got recently
fixed by commit de02b9f6bb65 ("Btrfs: fix data corruption when
deduplicating between different files").

Fix this by not allowing such operations to be performed and return the
errno -EINVAL to user space. This is what XFS is doing as well at the VFS
level. This change however now makes us return -EINVAL instead of
-EOPNOTSUPP for cases where the source range maps to an inline extent and
the destination range's end is smaller then the destination file's size,
since the detection of inline extents is done during the actual process of
dropping file extent items (at __btrfs_drop_extents()). Returning the
-EINVAL error is done early on and solely based on the input parameters
(offsets and length) and destination file's size. This makes us consistent
with XFS and anyone else supporting cloning since this case is now checked
at a higher level in the VFS and is where the -EINVAL will be returned
from starting with kernel 4.20 (the VFS changed was introduced in 4.20-rc1
by commit 07d19dc9fbe9 ("vfs: avoid problematic remapping requests into
partial EOF block"). So this change is more geared towards stable kernels,
as it's unlikely the new VFS checks get removed intentionally.

A test case for fstests follows soon, as well as an update to filter
existing tests that expect -EOPNOTSUPP to accept -EINVAL as well.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/btrfs/ioctl.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3806,9 +3806,17 @@ static noinline long btrfs_ioctl_clone(s
 		goto out_unlock;
 	if (len == 0)
 		olen = len = src->i_size - off;
-	/* if we extend to eof, continue to block boundary */
-	if (off + len == src->i_size)
+	/*
+	 * If we extend to eof, continue to block boundary if and only if the
+	 * destination end offset matches the destination file's size, otherwise
+	 * we would be corrupting data by placing the eof block into the middle
+	 * of a file.
+	 */
+	if (off + len == src->i_size) {
+		if (!IS_ALIGNED(len, bs) && destoff + len < inode->i_size)
+			goto out_unlock;
 		len = ALIGN(src->i_size, bs) - off;
+	}
 
 	if (len == 0) {
 		ret = 0;

