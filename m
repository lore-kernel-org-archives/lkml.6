Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB6DC43610
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D882243B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnVdFAK5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7D882243B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405756AbeKTD0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:26:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:39454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404876AbeKTD0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:26:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F16A3223D8;
        Mon, 19 Nov 2018 17:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646906;
        bh=muhf99+GR5ZkHE2gV50qzg1cEVJh0tW3JgApA+td0sk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CnVdFAK5DuSL4OkDssMWttjBzGFwxOVvphipvEZ/FwYRbmEoGmENZPxPppwpuHmdc
         VsMRRULmBGv6ZHi8o6W627D5wKHXQ3v1NgRMkV3qS7eEjDa//6AyifSXxm+ifuJWo2
         rYDjz+Utk5bWQ4WYXRexpFUDdsH7Es1Znn+siEs0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.4 135/160] Btrfs: fix data corruption due to cloning of eof block
Date:   Mon, 19 Nov 2018 17:29:34 +0100
Message-Id: <20181119162643.264100287@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162630.031306128@linuxfoundation.org>
References: <20181119162630.031306128@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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

CC: <stable@vger.kernel.org> # 4.4+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/ioctl.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3950,9 +3950,17 @@ static noinline long btrfs_ioctl_clone(s
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


