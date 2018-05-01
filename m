Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754819AbeEAKpf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 06:45:35 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43175 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754623AbeEAKpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 06:45:34 -0400
X-Google-Smtp-Source: AB8JxZrOlRjo6zGuXkBe3XT+qUy47SKxZQIltZbf1Lb/5BAtRhpeoyAkVHS8JHLfk4T5qoPA1gJlliSmVekXBg0e2Eo=
MIME-Version: 1.0
In-Reply-To: <32e853dd-3340-653e-a876-dce5de44d990@I-love.SAKURA.ne.jp>
References: <0000000000001f05330568a6b369@google.com> <32e853dd-3340-653e-a876-dce5de44d990@I-love.SAKURA.ne.jp>
From: Tigran Aivazian <aivazian.tigran@gmail.com>
Date: Tue, 1 May 2018 11:45:32 +0100
Message-ID: <CAK+_RLn7S5MyUUgvGeXxtks2bJcZse=QVzBkEQynjOXcDMTrRw@mail.gmail.com>
Subject: Re: WARNING: kmalloc bug in bfs_fill_super
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: syzbot <syzbot+71c6b5d68e91149fc8a4@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good to me, thank you.

On 1 May 2018 at 11:01, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> From 247cae4da0490c2e285e0a99e630ef963fabb6d5 Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Tue, 1 May 2018 14:15:19 +0900
> Subject: [PATCH] bfs: add sanity check at bfs_fill_super().
>
> syzbot is reporting too large memory allocation at bfs_fill_super() [1].
> Since file system image is corrupted such that bfs_sb->s_start == 0,
> bfs_fill_super() is trying to allocate 8MB of continuous memory. Fix this
> by adding a sanity check on bfs_sb->s_start, __GFP_NOWARN and printf().
>
> [1] https://syzkaller.appspot.com/bug?id=16a87c236b951351374a84c8a32f40edbc034e96
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Reported-by: syzbot <syzbot+71c6b5d68e91149fc8a4@syzkaller.appspotmail.com>
> Cc: Tigran A. Aivazian <aivazian.tigran@gmail.com>
> ---
>  fs/bfs/inode.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
> index 9a69392..d81c148 100644
> --- a/fs/bfs/inode.c
> +++ b/fs/bfs/inode.c
> @@ -350,7 +350,8 @@ static int bfs_fill_super(struct super_block *s, void *data, int silent)
>
>         s->s_magic = BFS_MAGIC;
>
> -       if (le32_to_cpu(bfs_sb->s_start) > le32_to_cpu(bfs_sb->s_end)) {
> +       if (le32_to_cpu(bfs_sb->s_start) > le32_to_cpu(bfs_sb->s_end) ||
> +           le32_to_cpu(bfs_sb->s_start) < BFS_BSIZE) {
>                 printf("Superblock is corrupted\n");
>                 goto out1;
>         }
> @@ -359,9 +360,11 @@ static int bfs_fill_super(struct super_block *s, void *data, int silent)
>                                         sizeof(struct bfs_inode)
>                                         + BFS_ROOT_INO - 1;
>         imap_len = (info->si_lasti / 8) + 1;
> -       info->si_imap = kzalloc(imap_len, GFP_KERNEL);
> -       if (!info->si_imap)
> +       info->si_imap = kzalloc(imap_len, GFP_KERNEL | __GFP_NOWARN);
> +       if (!info->si_imap) {
> +               printf("Cannot allocate %u bytes\n", imap_len);
>                 goto out1;
> +       }
>         for (i = 0; i < BFS_ROOT_INO; i++)
>                 set_bit(i, info->si_imap);
>
> --
> 1.8.3.1
>
