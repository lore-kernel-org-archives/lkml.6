Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896FAC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5151A206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dV1Xoi1Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5151A206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389721AbeKLIWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:22:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:54450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730604AbeKLIWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:48 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E422221707;
        Sun, 11 Nov 2018 22:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975571;
        bh=DGk8MpVHuVTKonMg+F94KNZTpiHUh8yBPCzrJRFFBJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dV1Xoi1ZrR2Dk+LDshhxUYX621hBx/5gGMxjfCBxw1O0psVblu9w3j7EpNfUL/YK9
         2fJZEF8NVGp6qfPZ4byQFzVvqN9n7aKKsOHRLWQZhd0S0vvEvaAv+57Fom5dkzV5AD
         r8WyE2O1Wet3dPWrMz7ClzpOHvkUjGxKWKHv4jlk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wang Shilong <wshilong@ddn.com>,
        Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger@dilger.ca>, stable@kernel.org
Subject: [PATCH 4.14 138/222] ext4: fix setattr project check in fssetxattr ioctl
Date:   Sun, 11 Nov 2018 14:23:55 -0800
Message-Id: <20181111221659.882764894@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wang Shilong <wangshilong1991@gmail.com>

commit dc7ac6c4cae3b58724c2f1e21a7c05ce19ecd5a8 upstream.

Currently, project quota could be changed by fssetxattr
ioctl, and existed permission check inode_owner_or_capable()
is obviously not enough, just think that common users could
change project id of file, that could make users to
break project quota easily.

This patch try to follow same regular of xfs project
quota:

"Project Quota ID state is only allowed to change from
within the init namespace. Enforce that restriction only
if we are trying to change the quota ID state.
Everything else is allowed in user namespaces."

Besides that, check and set project id'state should
be an atomic operation, protect whole operation with
inode lock, ext4_ioctl_setproject() is only used for
ioctl EXT4_IOC_FSSETXATTR, we have held mnt_want_write_file()
before ext4_ioctl_setflags(), and ext4_ioctl_setproject()
is called after ext4_ioctl_setflags(), we could share
codes, so remove it inside ext4_ioctl_setproject().

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/ioctl.c |   60 ++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 23 deletions(-)

--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -344,19 +344,14 @@ static int ext4_ioctl_setproject(struct
 	if (projid_eq(kprojid, EXT4_I(inode)->i_projid))
 		return 0;
 
-	err = mnt_want_write_file(filp);
-	if (err)
-		return err;
-
 	err = -EPERM;
-	inode_lock(inode);
 	/* Is it quota file? Do not allow user to mess with it */
 	if (ext4_is_quota_file(inode))
-		goto out_unlock;
+		return err;
 
 	err = ext4_get_inode_loc(inode, &iloc);
 	if (err)
-		goto out_unlock;
+		return err;
 
 	raw_inode = ext4_raw_inode(&iloc);
 	if (!EXT4_FITS_IN_INODE(raw_inode, ei, i_projid)) {
@@ -364,7 +359,7 @@ static int ext4_ioctl_setproject(struct
 					      EXT4_SB(sb)->s_want_extra_isize,
 					      &iloc);
 		if (err)
-			goto out_unlock;
+			return err;
 	} else {
 		brelse(iloc.bh);
 	}
@@ -374,10 +369,8 @@ static int ext4_ioctl_setproject(struct
 	handle = ext4_journal_start(inode, EXT4_HT_QUOTA,
 		EXT4_QUOTA_INIT_BLOCKS(sb) +
 		EXT4_QUOTA_DEL_BLOCKS(sb) + 3);
-	if (IS_ERR(handle)) {
-		err = PTR_ERR(handle);
-		goto out_unlock;
-	}
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
 
 	err = ext4_reserve_inode_write(handle, inode, &iloc);
 	if (err)
@@ -405,9 +398,6 @@ out_dirty:
 		err = rc;
 out_stop:
 	ext4_journal_stop(handle);
-out_unlock:
-	inode_unlock(inode);
-	mnt_drop_write_file(filp);
 	return err;
 }
 #else
@@ -592,6 +582,30 @@ static int ext4_ioc_getfsmap(struct supe
 	return 0;
 }
 
+static int ext4_ioctl_check_project(struct inode *inode, struct fsxattr *fa)
+{
+	/*
+	 * Project Quota ID state is only allowed to change from within the init
+	 * namespace. Enforce that restriction only if we are trying to change
+	 * the quota ID state. Everything else is allowed in user namespaces.
+	 */
+	if (current_user_ns() == &init_user_ns)
+		return 0;
+
+	if (__kprojid_val(EXT4_I(inode)->i_projid) != fa->fsx_projid)
+		return -EINVAL;
+
+	if (ext4_test_inode_flag(inode, EXT4_INODE_PROJINHERIT)) {
+		if (!(fa->fsx_xflags & FS_XFLAG_PROJINHERIT))
+			return -EINVAL;
+	} else {
+		if (fa->fsx_xflags & FS_XFLAG_PROJINHERIT)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
@@ -1029,19 +1043,19 @@ resizefs_out:
 			return err;
 
 		inode_lock(inode);
+		err = ext4_ioctl_check_project(inode, &fa);
+		if (err)
+			goto out;
 		flags = (ei->i_flags & ~EXT4_FL_XFLAG_VISIBLE) |
 			 (flags & EXT4_FL_XFLAG_VISIBLE);
 		err = ext4_ioctl_setflags(inode, flags);
-		inode_unlock(inode);
-		mnt_drop_write_file(filp);
 		if (err)
-			return err;
-
+			goto out;
 		err = ext4_ioctl_setproject(filp, fa.fsx_projid);
-		if (err)
-			return err;
-
-		return 0;
+out:
+		inode_unlock(inode);
+		mnt_drop_write_file(filp);
+		return err;
 	}
 	case EXT4_IOC_SHUTDOWN:
 		return ext4_shutdown(sb, arg);


