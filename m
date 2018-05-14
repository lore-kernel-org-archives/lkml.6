Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752069AbeENDq5 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 23:46:57 -0400
Received: from imap.thunk.org ([74.207.234.97]:50406 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751976AbeENDq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 23:46:56 -0400
Date: Sun, 13 May 2018 23:46:52 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jaegeuk Kim <jaegeuk@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3] ext4: handle errors on ext4_commit_super
Message-ID: <20180514034652.GM14763@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
References: <20180330014429.27824-1-jaegeuk@kernel.org>
 <20180419155957.GB81439@jaegeuk-macbookpro.roam.corp.google.com>
 <20180423144626.GA31757@jaegeuk-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423144626.GA31757@jaegeuk-macbookpro.roam.corp.google.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 08:46:26AM -0600, Jaegeuk Kim wrote:
> When remounting ext4 from ro to rw, currently it allows its transition,
> even if ext4_commit_super() returns EIO. Even worse thing is, after that,
> fs/buffer complains buffer dirty bits like:
> 
>  Call trace:
>  [<ffffff9750c259dc>] mark_buffer_dirty+0x184/0x1a4
>  [<ffffff9750cb398c>] __ext4_handle_dirty_super+0x4c/0xfc
>  [<ffffff9750c7a9fc>] ext4_file_open+0x154/0x1c0
>  [<ffffff9750bea51c>] do_dentry_open+0x114/0x2d0
>  [<ffffff9750bea75c>] vfs_open+0x5c/0x94
>  [<ffffff9750bf879c>] path_openat+0x668/0xfe8
>  [<ffffff9750bf8088>] do_filp_open+0x74/0x120
>  [<ffffff9750beac98>] do_sys_open+0x148/0x254
>  [<ffffff9750beade0>] SyS_openat+0x10/0x18
>  [<ffffff9750a83ab0>] el0_svc_naked+0x24/0x28
>  EXT4-fs (dm-1): previous I/O error to superblock detected
>  Buffer I/O error on dev dm-1, logical block 0, lost sync page write
>  EXT4-fs (dm-1): re-mounted. Opts: (null)
>  Buffer I/O error on dev dm-1, logical block 80, lost async page write
> 
> Cc: "Theodore Ts'o" <tytso@mit.edu>
> Cc: Andreas Dilger <adilger.kernel@dilger.ca>
> Cc: linux-ext4@vger.kernel.org
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Jaegeuk Kim <jaegeuk@google.com>

Applied with a fix up to ext4_fill_super() when it calls
ext4_setup_super() with the changed error return semantics.

		   	    - Ted

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index aac33c155363..1388e56bb3f5 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4254,8 +4254,12 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		goto failed_mount4;
 	}
 
-	if (ext4_setup_super(sb, es, sb_rdonly(sb)))
+	ret = ext4_setup_super(sb, es, sb_rdonly(sb));
+	if (ret == -EROFS) {
 		sb->s_flags |= SB_RDONLY;
+		ret = 0;
+	} else if (ret)
+		goto failed_mount4a;
 
 	/* determine the minimum size of new large inodes, if present */
 	if (sbi->s_inode_size > EXT4_GOOD_OLD_INODE_SIZE &&
