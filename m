Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937202AbeE1K2g (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:28:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:47922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936991AbeE1K2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:28:31 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
        Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 053/329] btrfs: fail mount when sb flag is not in BTRFS_SUPER_FLAG_SUPP
Date: Mon, 28 May 2018 11:59:42 +0200
Message-Id: <20180528100246.970100297@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anand Jain <Anand.Jain@oracle.com>

[ Upstream commit 6f794e3c5c8f8fdd3b5bb20d9ded894e685b5bbe ]

It appears from the original commit [1] that there isn't any design
specific reason not to fail the mount instead of just warning. This
patch will change it to fail.

[1]
 commit 319e4d0661e5323c9f9945f0f8fb5905e5fe74c3
    btrfs: Enhance super validation check

Fixes: 319e4d0661e5323 ("btrfs: Enhance super validation check")
Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/disk-io.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4142,9 +4142,11 @@ static int btrfs_check_super_valid(struc
 		btrfs_err(fs_info, "no valid FS found");
 		ret = -EINVAL;
 	}
-	if (btrfs_super_flags(sb) & ~BTRFS_SUPER_FLAG_SUPP)
-		btrfs_warn(fs_info, "unrecognized super flag: %llu",
+	if (btrfs_super_flags(sb) & ~BTRFS_SUPER_FLAG_SUPP) {
+		btrfs_err(fs_info, "unrecognized or unsupported super flag: %llu",
 				btrfs_super_flags(sb) & ~BTRFS_SUPER_FLAG_SUPP);
+		ret = -EINVAL;
+	}
 	if (btrfs_super_root_level(sb) >= BTRFS_MAX_LEVEL) {
 		btrfs_err(fs_info, "tree_root level too big: %d >= %d",
 				btrfs_super_root_level(sb), BTRFS_MAX_LEVEL);
