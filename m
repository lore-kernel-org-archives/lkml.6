Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751439AbeFBLk7 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 07:40:59 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:46939 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750892AbeFBLk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 07:40:57 -0400
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: [kernel BUG at fs/fat/inode.c:162] when writing to a broken VFAT
References: <CAE5jQCdGVxnmDYhdEfLpMfeZRNQk19TAX=u9MFmobZ1RFx3z4A@mail.gmail.com>
Date: Sat, 02 Jun 2018 20:19:28 +0900
In-Reply-To: <CAE5jQCdGVxnmDYhdEfLpMfeZRNQk19TAX=u9MFmobZ1RFx3z4A@mail.gmail.com>
        (Anatoly Trosinenko's message of "Fri, 1 Jun 2018 12:45:14 +0300")
Message-ID: <874lilcu67.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anatoly Trosinenko <anatoly.trosinenko@gmail.com> writes:

> Description:
>
> Writing to some file on a broken VFAT partition causes kernel bug

Thanks. This patch should fix this issue.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


[PATCH] fat: Use fat_fs_error() instead of BUG_ON() in __fat_get_block()

If file size and FAT cluster chain is not matched (corrupted image),
we can hit BUG_ON(!phys) in __fat_get_block().

So, use fat_fs_error() instead.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/inode.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff -puN fs/fat/inode.c~vfat-dont-bugon fs/fat/inode.c
--- linux/fs/fat/inode.c~vfat-dont-bugon	2018-06-02 20:15:04.441920069 +0900
+++ linux-hirofumi/fs/fat/inode.c	2018-06-02 20:15:04.442920067 +0900
@@ -158,8 +158,13 @@ static inline int __fat_get_block(struct
 	err = fat_bmap(inode, iblock, &phys, &mapped_blocks, create, false);
 	if (err)
 		return err;
+	if (!phys) {
+		fat_fs_error(sb,
+			     "invalid FAT chain (i_pos %lld, last_block %ld)",
+			     MSDOS_I(inode)->i_pos, last_block);
+		return -EIO;
+	}
 
-	BUG_ON(!phys);
 	BUG_ON(*max_blocks != mapped_blocks);
 	set_buffer_new(bh_result);
 	map_bh(bh_result, sb, phys);
_
