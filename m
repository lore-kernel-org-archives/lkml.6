Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64D3C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E8E2430D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:53:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80E8E2430D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934493AbeFXPxu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:53:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33694 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933919AbeFXPxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:53:47 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EDE9B2C;
        Sun, 24 Jun 2018 15:53:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Su Yue <suy.fnst@cn.fujitsu.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.9 25/39] Btrfs: fix memory and mount leak in btrfs_ioctl_rm_dev_v2()
Date:   Sun, 24 Jun 2018 23:24:12 +0800
Message-Id: <20180624152354.825828413@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624152352.038950449@linuxfoundation.org>
References: <20180624152352.038950449@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Omar Sandoval <osandov@fb.com>

commit fd4e994bd1f9dc9628e168a7f619bf69f6984635 upstream.

If we have invalid flags set, when we error out we must drop our writer
counter and free the buffer we allocated for the arguments. This bug is
trivially reproduced with the following program on 4.7+:

	#include <fcntl.h>
	#include <stdint.h>
	#include <stdio.h>
	#include <stdlib.h>
	#include <unistd.h>
	#include <sys/ioctl.h>
	#include <sys/stat.h>
	#include <sys/types.h>
	#include <linux/btrfs.h>
	#include <linux/btrfs_tree.h>

	int main(int argc, char **argv)
	{
		struct btrfs_ioctl_vol_args_v2 vol_args = {
			.flags = UINT64_MAX,
		};
		int ret;
		int fd;

		if (argc != 2) {
			fprintf(stderr, "usage: %s PATH\n", argv[0]);
			return EXIT_FAILURE;
		}

		fd = open(argv[1], O_WRONLY);
		if (fd == -1) {
			perror("open");
			return EXIT_FAILURE;
		}

		ret = ioctl(fd, BTRFS_IOC_RM_DEV_V2, &vol_args);
		if (ret == -1)
			perror("ioctl");

		close(fd);
		return EXIT_SUCCESS;
	}

When unmounting the filesystem, we'll hit the
WARN_ON(mnt_get_writers(mnt)) in cleanup_mnt() and also may prevent the
filesystem to be remounted read-only as the writer count will stay
lifted.

Fixes: 6b526ed70cf1 ("btrfs: introduce device delete by devid")
CC: stable@vger.kernel.org # 4.9+
Signed-off-by: Omar Sandoval <osandov@fb.com>
Reviewed-by: Su Yue <suy.fnst@cn.fujitsu.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/ioctl.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2708,8 +2708,10 @@ static long btrfs_ioctl_rm_dev_v2(struct
 	}
 
 	/* Check for compatibility reject unknown flags */
-	if (vol_args->flags & ~BTRFS_VOL_ARG_V2_FLAGS_SUPPORTED)
-		return -EOPNOTSUPP;
+	if (vol_args->flags & ~BTRFS_VOL_ARG_V2_FLAGS_SUPPORTED) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
 
 	if (atomic_xchg(&root->fs_info->mutually_exclusive_operation_running,
 			1)) {


