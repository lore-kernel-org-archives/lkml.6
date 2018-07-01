Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3FAC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A49250DC
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:17:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A49250DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964853AbeGAQRm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:17:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:32858 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964830AbeGAQRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:17:39 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E64FF49B;
        Sun,  1 Jul 2018 16:17:38 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.4 061/105] Btrfs: fix clone vs chattr NODATASUM race
Date:   Sun,  1 Jul 2018 18:02:11 +0200
Message-Id: <20180701153153.923725936@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701153149.382300170@linuxfoundation.org>
References: <20180701153149.382300170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Omar Sandoval <osandov@fb.com>

commit b5c40d598f5408bd0ca22dfffa82f03cd9433f23 upstream.

In btrfs_clone_files(), we must check the NODATASUM flag while the
inodes are locked. Otherwise, it's possible that btrfs_ioctl_setflags()
will change the flags after we check and we can end up with a party
checksummed file.

The race window is only a few instructions in size, between the if and
the locks which is:

3834         if (S_ISDIR(src->i_mode) || S_ISDIR(inode->i_mode))
3835                 return -EISDIR;

where the setflags must be run and toggle the NODATASUM flag (provided
the file size is 0).  The clone will block on the inode lock, segflags
takes the inode lock, changes flags, releases log and clone continues.

Not impossible but still needs a lot of bad luck to hit unintentionally.

Fixes: 0e7b824c4ef9 ("Btrfs: don't make a file partly checksummed through file clone")
CC: stable@vger.kernel.org # 4.4+
Signed-off-by: Omar Sandoval <osandov@fb.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
[ update changelog ]
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ adjusted for 4.4 ]
Signed-off-by: Nikolay Borisov <nborisov@suse.com>

---
 fs/btrfs/ioctl.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3923,11 +3923,6 @@ static noinline long btrfs_ioctl_clone(s
 	if (!(src_file.file->f_mode & FMODE_READ))
 		goto out_fput;
 
-	/* don't make the dst file partly checksummed */
-	if ((BTRFS_I(src)->flags & BTRFS_INODE_NODATASUM) !=
-	    (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM))
-		goto out_fput;
-
 	ret = -EISDIR;
 	if (S_ISDIR(src->i_mode) || S_ISDIR(inode->i_mode))
 		goto out_fput;
@@ -3942,6 +3937,13 @@ static noinline long btrfs_ioctl_clone(s
 		mutex_lock(&src->i_mutex);
 	}
 
+	/* don't make the dst file partly checksummed */
+	if ((BTRFS_I(src)->flags & BTRFS_INODE_NODATASUM) !=
+	    (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
 	/* determine range to clone */
 	ret = -EINVAL;
 	if (off + len > src->i_size || off + len < off)


