Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69EFC07E85
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C136214DB
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PoxIbs58"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C136214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbeLDK7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:59:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:44034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbeLDK7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:59:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12311214DB;
        Tue,  4 Dec 2018 10:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921158;
        bh=d87MjXNQvtsyMJoDZJS69utd48fHo86s72Mxdi2q5bA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PoxIbs584KsRVfz/xEZWv+5ikHZzWxSjtW3CL8p5+bKWJYWhAzfWLaM3yk5gUVUot
         C+IhQBLDApVcpUiGXF7HkAagm9KqTdSVH9pFYfTwg9ahXvQZlo5plg5/SMk3GE7HL6
         Y6/fki5navaEhjlKN7FOxT+Y/ezeuhT3cNr4BcpY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 076/139] Btrfs: fix rare chances for data loss when doing a fast fsync
Date:   Tue,  4 Dec 2018 11:49:17 +0100
Message-Id: <20181204103653.251938373@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

commit aab15e8ec25765cf7968c72cbec7583acf99d8a4 upstream.

After the simplification of the fast fsync patch done recently by commit
b5e6c3e170b7 ("btrfs: always wait on ordered extents at fsync time") and
commit e7175a692765 ("btrfs: remove the wait ordered logic in the
log_one_extent path"), we got a very short time window where we can get
extents logged without writeback completing first or extents logged
without logging the respective data checksums. Both issues can only happen
when doing a non-full (fast) fsync.

As soon as we enter btrfs_sync_file() we trigger writeback, then lock the
inode and then wait for the writeback to complete before starting to log
the inode. However before we acquire the inode's lock and after we started
writeback, it's possible that more writes happened and dirtied more pages.
If that happened and those pages get writeback triggered while we are
logging the inode (for example, the VM subsystem triggering it due to
memory pressure, or another concurrent fsync), we end up seeing the
respective extent maps in the inode's list of modified extents and will
log matching file extent items without waiting for the respective
ordered extents to complete, meaning that either of the following will
happen:

1) We log an extent after its writeback finishes but before its checksums
   are added to the csum tree, leading to -EIO errors when attempting to
   read the extent after a log replay.

2) We log an extent before its writeback finishes.
   Therefore after the log replay we will have a file extent item pointing
   to an unwritten extent (and without the respective data checksums as
   well).

This could not happen before the fast fsync patch simplification, because
for any extent we found in the list of modified extents, we would wait for
its respective ordered extent to finish writeback or collect its checksums
for logging if it did not complete yet.

Fix this by triggering writeback again after acquiring the inode's lock
and before waiting for ordered extents to complete.

Fixes: e7175a692765 ("btrfs: remove the wait ordered logic in the log_one_extent path")
Fixes: b5e6c3e170b7 ("btrfs: always wait on ordered extents at fsync time")
CC: stable@vger.kernel.org # 4.19+
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/file.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2089,6 +2089,30 @@ int btrfs_sync_file(struct file *file, l
 	atomic_inc(&root->log_batch);
 
 	/*
+	 * Before we acquired the inode's lock, someone may have dirtied more
+	 * pages in the target range. We need to make sure that writeback for
+	 * any such pages does not start while we are logging the inode, because
+	 * if it does, any of the following might happen when we are not doing a
+	 * full inode sync:
+	 *
+	 * 1) We log an extent after its writeback finishes but before its
+	 *    checksums are added to the csum tree, leading to -EIO errors
+	 *    when attempting to read the extent after a log replay.
+	 *
+	 * 2) We can end up logging an extent before its writeback finishes.
+	 *    Therefore after the log replay we will have a file extent item
+	 *    pointing to an unwritten extent (and no data checksums as well).
+	 *
+	 * So trigger writeback for any eventual new dirty pages and then we
+	 * wait for all ordered extents to complete below.
+	 */
+	ret = start_ordered_ops(inode, start, end);
+	if (ret) {
+		inode_unlock(inode);
+		goto out;
+	}
+
+	/*
 	 * We have to do this here to avoid the priority inversion of waiting on
 	 * IO of a lower priority task while holding a transaciton open.
 	 */


