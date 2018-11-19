Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20974C04EBA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7C821707
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2CLZOMzJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA7C821707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405197AbeKTDYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:24:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:36328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404390AbeKTDYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:24:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F27A721582;
        Mon, 19 Nov 2018 16:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646790;
        bh=9TM6fTcgyujrbLa7e6bjApQTRJdk6fmwrfsMndsWMNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2CLZOMzJyNdbVtOUQnuZ1p4dkOXT3zQKCXQPSNEEUlMvIGMP5gSP9OM4XuCXkN3OE
         38xhP6TeLyjBe/J4FiSMVDSIgu8jjL/Is5JxXdF1yktUB1OYbUNw/okWEEHuL+qaFp
         wBf/sXsJVV+uc1ZNETpXqBlSHUCPrPKLSCOz+hNQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.4 091/160] Btrfs: fix wrong dentries after fsync of file that got its parent replaced
Date:   Mon, 19 Nov 2018 17:28:50 +0100
Message-Id: <20181119162640.060269598@linuxfoundation.org>
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

commit 0f375eed92b5a407657532637ed9652611a682f5 upstream.

In a scenario like the following:

  mkdir /mnt/A               # inode 258
  mkdir /mnt/B               # inode 259
  touch /mnt/B/bar           # inode 260

  sync

  mv /mnt/B/bar /mnt/A/bar
  mv -T /mnt/A /mnt/B
  fsync /mnt/B/bar

  <power fail>

After replaying the log we end up with file bar having 2 hard links, both
with the name 'bar' and one in the directory with inode number 258 and the
other in the directory with inode number 259. Also, we end up with the
directory inode 259 still existing and with the directory inode 258 still
named as 'A', instead of 'B'. In this scenario, file 'bar' should only
have one hard link, located at directory inode 258, the directory inode
259 should not exist anymore and the name for directory inode 258 should
be 'B'.

This incorrect behaviour happens because when attempting to log the old
parents of an inode, we skip any parents that no longer exist. Fix this
by forcing a full commit if an old parent no longer exists.

A test case for fstests follows soon.

CC: stable@vger.kernel.org # 4.4+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/tree-log.c |   30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5240,9 +5240,33 @@ static int btrfs_log_all_parents(struct
 
 			dir_inode = btrfs_iget(root->fs_info->sb, &inode_key,
 					       root, NULL);
-			/* If parent inode was deleted, skip it. */
-			if (IS_ERR(dir_inode))
-				continue;
+			/*
+			 * If the parent inode was deleted, return an error to
+			 * fallback to a transaction commit. This is to prevent
+			 * getting an inode that was moved from one parent A to
+			 * a parent B, got its former parent A deleted and then
+			 * it got fsync'ed, from existing at both parents after
+			 * a log replay (and the old parent still existing).
+			 * Example:
+			 *
+			 * mkdir /mnt/A
+			 * mkdir /mnt/B
+			 * touch /mnt/B/bar
+			 * sync
+			 * mv /mnt/B/bar /mnt/A/bar
+			 * mv -T /mnt/A /mnt/B
+			 * fsync /mnt/B/bar
+			 * <power fail>
+			 *
+			 * If we ignore the old parent B which got deleted,
+			 * after a log replay we would have file bar linked
+			 * at both parents and the old parent B would still
+			 * exist.
+			 */
+			if (IS_ERR(dir_inode)) {
+				ret = PTR_ERR(dir_inode);
+				goto out;
+			}
 
 			ret = btrfs_log_inode(trans, root, dir_inode,
 					      LOG_INODE_ALL, 0, LLONG_MAX, ctx);


