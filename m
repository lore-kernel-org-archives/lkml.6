Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164601AbeE1K4z (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:56:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:44966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164543AbeE1K4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:56:39 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Liu Bo <bo.liu@linux.alibaba.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 338/496] Btrfs: bail out on error during replay_dir_deletes
Date: Mon, 28 May 2018 12:02:03 +0200
Message-Id: <20180528100334.067680104@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liu Bo <bo.liu@linux.alibaba.com>

[ Upstream commit b98def7ca6e152ee55e36863dddf6f41f12d1dc6 ]

If errors were returned by btrfs_next_leaf(), replay_dir_deletes needs
to bail out, otherwise @ret would be forced to be 0 after 'break;' and
the caller won't be aware of it.

Fixes: e02119d5a7b4 ("Btrfs: Add a write ahead tree log to optimize synchronous operations")
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/tree-log.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2272,8 +2272,10 @@ again:
 			nritems = btrfs_header_nritems(path->nodes[0]);
 			if (path->slots[0] >= nritems) {
 				ret = btrfs_next_leaf(root, path);
-				if (ret)
+				if (ret == 1)
 					break;
+				else if (ret < 0)
+					goto out;
 			}
 			btrfs_item_key_to_cpu(path->nodes[0], &found_key,
 					      path->slots[0]);
