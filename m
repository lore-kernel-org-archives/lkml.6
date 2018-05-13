Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751313AbeEMKUh (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 06:20:37 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:60827 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbeEMKUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 06:20:36 -0400
To: dvyukov@google.com,
        syzbot+3417712847e7219a60ee@syzkaller.appspotmail.com,
        miklos@szeredi.hu
Cc: akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        hmclauchlan@fb.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        pombredanne@nexb.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Subject: Re: KASAN: use-after-free Read in corrupted
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <000000000000eec34b056c128997@google.com>
        <CACT4Y+aRyMWXS0K0bqAVgBOTh=vXEY0dwM91vdSkJ75zgy+k-A@mail.gmail.com>
In-Reply-To: <CACT4Y+aRyMWXS0K0bqAVgBOTh=vXEY0dwM91vdSkJ75zgy+k-A@mail.gmail.com>
Message-Id: <201805131920.GJJ58398.OHFVOOSQtLMJFF@I-love.SAKURA.ne.jp>
X-Mailer: Winbiff [Version 2.51 PL2]
X-Accept-Language: ja,en,zh
Date: Sun, 13 May 2018 19:20:32 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov wrote:
> This looks very similar to "KASAN: use-after-free Read in fuse_kill_sb_blk":
> https://groups.google.com/d/msg/syzkaller-bugs/4C4oiBX8vZ0/0NTQRcUYBgAJ
> 
> which you fixed with "fuse: don't keep dead fuse_conn at fuse_fill_super().":
> https://groups.google.com/d/msg/syzkaller-bugs/4C4oiBX8vZ0/W6pi8NdbBgAJ
> 
> However, here we have use-after-free in fuse_kill_sb_anon instead of
> use_kill_sb_blk. Do you think your patch will fix this as well?

Yes, for fuse_kill_sb_anon() and fuse_kill_sb_blk() are symmetrical.
I'm waiting for Miklos Szeredi to apply that patch.

static inline struct fuse_conn *get_fuse_conn_super(struct super_block *sb)
{
	return sb->s_fs_info;
}

static struct file_system_type fuse_fs_type = {
	.owner          = THIS_MODULE,
	.name           = "fuse",
	.fs_flags       = FS_HAS_SUBTYPE,
	.mount          = fuse_mount,
	.kill_sb        = fuse_kill_sb_anon,
};

static struct file_system_type fuseblk_fs_type = {
	.owner          = THIS_MODULE,
	.name           = "fuseblk",
	.mount          = fuse_mount_blk,
	.kill_sb        = fuse_kill_sb_blk,
	.fs_flags       = FS_REQUIRES_DEV | FS_HAS_SUBTYPE,
};

static void fuse_kill_sb_anon(struct super_block *sb)
{
	struct fuse_conn *fc = get_fuse_conn_super(sb);

	if (fc) {
		down_write(&fc->killsb);
		fc->sb = NULL;
		up_write(&fc->killsb);
	}

	kill_anon_super(sb);
}

static void fuse_kill_sb_blk(struct super_block *sb)
{
	struct fuse_conn *fc = get_fuse_conn_super(sb);

	if (fc) {
		down_write(&fc->killsb);
		fc->sb = NULL;
		up_write(&fc->killsb);
	}

	kill_block_super(sb);
}
