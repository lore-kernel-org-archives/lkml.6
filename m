Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B251CC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8329B20665
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865686;
	bh=Qxj+cDy5dBkRdhrMyqYboqvzmVy/Kq7USLkaqsbirOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NmGjIMDe50fCn8AhpixHV9mjrWFgCGqzG5aMrMUy+zsohEkVyl3Lz/52C+4CYll+X
	 KH59ZgWu6wYD1E3pj4H+m1dC28XKrvO7SBJgALA2YzFPrf7fFvD3gk0+ZcQHZqkBLf
	 BjoM6k0oYa0jAEz3WN105p9XbsJoyCP35dhRdIlY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbfAGMyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:54:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:43448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727513AbfAGMyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:54:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1252120651;
        Mon,  7 Jan 2019 12:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865682;
        bh=Qxj+cDy5dBkRdhrMyqYboqvzmVy/Kq7USLkaqsbirOY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZszepKXkNXoFsNI3rQqvF6qx+gPnbCFdm0OLSZPRRDZV2xPDTkeOXV8Lty+rzMzR2
         /gUUgMaTv/oGYVR8kh9PiGBV9Jr1TlATCRybBuepvFbPckPLMD7YboS8R1z/tyitNh
         TuDSHQtHy0MZNFFq7YN26EU2tL0OzY60C3JiW6yQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        stable@kernel.org
Subject: [PATCH 4.19 113/170] ext4: force inode writes when nfsd calls commit_metadata()
Date:   Mon,  7 Jan 2019 13:32:20 +0100
Message-Id: <20190107104506.280188744@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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

From: Theodore Ts'o <tytso@mit.edu>

commit fde872682e175743e0c3ef939c89e3c6008a1529 upstream.

Some time back, nfsd switched from calling vfs_fsync() to using a new
commit_metadata() hook in export_operations().  If the file system did
not provide a commit_metadata() hook, it fell back to using
sync_inode_metadata().  Unfortunately doesn't work on all file
systems.  In particular, it doesn't work on ext4 due to how the inode
gets journalled --- the VFS writeback code will not always call
ext4_write_inode().

So we need to provide our own ext4_nfs_commit_metdata() method which
calls ext4_write_inode() directly.

Google-Bug-Id: 121195940
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/super.c             |   11 +++++++++++
 include/trace/events/ext4.h |   20 ++++++++++++++++++++
 2 files changed, 31 insertions(+)

--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1202,6 +1202,16 @@ static struct dentry *ext4_fh_to_parent(
 				    ext4_nfs_get_inode);
 }
 
+static int ext4_nfs_commit_metadata(struct inode *inode)
+{
+	struct writeback_control wbc = {
+		.sync_mode = WB_SYNC_ALL
+	};
+
+	trace_ext4_nfs_commit_metadata(inode);
+	return ext4_write_inode(inode, &wbc);
+}
+
 /*
  * Try to release metadata pages (indirect blocks, directories) which are
  * mapped via the block device.  Since these pages could have journal heads
@@ -1406,6 +1416,7 @@ static const struct export_operations ex
 	.fh_to_dentry = ext4_fh_to_dentry,
 	.fh_to_parent = ext4_fh_to_parent,
 	.get_parent = ext4_get_parent,
+	.commit_metadata = ext4_nfs_commit_metadata,
 };
 
 enum {
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -225,6 +225,26 @@ TRACE_EVENT(ext4_drop_inode,
 		  (unsigned long) __entry->ino, __entry->drop)
 );
 
+TRACE_EVENT(ext4_nfs_commit_metadata,
+	TP_PROTO(struct inode *inode),
+
+	TP_ARGS(inode),
+
+	TP_STRUCT__entry(
+		__field(	dev_t,	dev			)
+		__field(	ino_t,	ino			)
+	),
+
+	TP_fast_assign(
+		__entry->dev	= inode->i_sb->s_dev;
+		__entry->ino	= inode->i_ino;
+	),
+
+	TP_printk("dev %d,%d ino %lu",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  (unsigned long) __entry->ino)
+);
+
 TRACE_EVENT(ext4_mark_inode_dirty,
 	TP_PROTO(struct inode *inode, unsigned long IP),
 


