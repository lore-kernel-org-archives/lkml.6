Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423588AbeE1LIY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:08:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:55290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423522AbeE1LIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:08:02 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 091/272] Btrfs: fix copy_items() return value when logging an inode
Date: Mon, 28 May 2018 12:02:04 +0200
Message-Id: <20180528100248.811058484@linuxfoundation.org>
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

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 8434ec46c6e3232cebc25a910363b29f5c617820 ]

When logging an inode, at tree-log.c:copy_items(), if we call
btrfs_next_leaf() at the loop which checks for the need to log holes, we
need to make sure copy_items() returns the value 1 to its caller and
not 0 (on success). This is because the path the caller passed was
released and is now different from what is was before, and the caller
expects a return value of 0 to mean both success and that the path
has not changed, while a return value of 1 means both success and
signals the caller that it can not reuse the path, it has to perform
another tree search.

Even though this is a case that should not be triggered on normal
circumstances or very rare at least, its consequences can be very
unpredictable (especially when replaying a log tree).

Fixes: 16e7549f045d ("Btrfs: incompatible format change to remove hole extents")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/tree-log.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4005,6 +4005,7 @@ fill_holes:
 			ASSERT(ret == 0);
 			src = src_path->nodes[0];
 			i = 0;
+			need_find_last_extent = true;
 		}
 
 		btrfs_item_key_to_cpu(src, &key, i);
