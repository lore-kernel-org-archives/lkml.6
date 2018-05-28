Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162416AbeE1ONC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:13:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:57668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162297AbeE1KhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:37:03 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Liu Bo <bo.liu@linux.alibaba.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 241/329] Btrfs: fix NULL pointer dereference in log_dir_items
Date: Mon, 28 May 2018 12:02:50 +0200
Message-Id: <20180528100302.075696689@linuxfoundation.org>
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

From: Liu Bo <bo.liu@linux.alibaba.com>

[ Upstream commit 80c0b4210a963e31529e15bf90519708ec947596 ]

0, 1 and <0 can be returned by btrfs_next_leaf(), and when <0 is
returned, path->nodes[0] could be NULL, log_dir_items lacks such a
check for <0 and we may run into a null pointer dereference panic.

Fixes: e02119d5a7b4 ("Btrfs: Add a write ahead tree log to optimize synchronous operations")
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/tree-log.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3399,8 +3399,11 @@ static noinline int log_dir_items(struct
 		 * from this directory and from this transaction
 		 */
 		ret = btrfs_next_leaf(root, path);
-		if (ret == 1) {
-			last_offset = (u64)-1;
+		if (ret) {
+			if (ret == 1)
+				last_offset = (u64)-1;
+			else
+				err = ret;
 			goto done;
 		}
 		btrfs_item_key_to_cpu(path->nodes[0], &tmp, path->slots[0]);
