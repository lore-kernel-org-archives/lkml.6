Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033468AbeE1KWE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:22:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:41240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033383AbeE1KVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:21:45 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 171/268] btrfs: Fix possible softlock on single core machines
Date: Mon, 28 May 2018 12:02:25 +0200
Message-Id: <20180528100221.790975719@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikolay Borisov <nborisov@suse.com>

[ Upstream commit 1e1c50a929bc9e49bc3f9935b92450d9e69f8158 ]

do_chunk_alloc implements a loop checking whether there is a pending
chunk allocation and if so causes the caller do loop. Generally this
loop is executed only once, however testing with btrfs/072 on a single
core vm machines uncovered an extreme case where the system could loop
indefinitely. This is due to a missing cond_resched when loop which
doesn't give a chance to the previous chunk allocator finish its job.

The fix is to simply add the missing cond_resched.

Fixes: 6d74119f1a3e ("Btrfs: avoid taking the chunk_mutex in do_chunk_alloc")
Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/extent-tree.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4392,6 +4392,7 @@ again:
 	if (wait_for_alloc) {
 		mutex_unlock(&fs_info->chunk_mutex);
 		wait_for_alloc = 0;
+		cond_resched();
 		goto again;
 	}
 
