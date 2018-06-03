Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751369AbeFCNqk (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 09:46:40 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:40181 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbeFCNqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 09:46:39 -0400
X-Google-Smtp-Source: ADUXVKL/IhOCCV9fDbzbWaYI9Nony6pp9ETYhWoGWHp6Tz5aA/jread82LDfv6z7jeOOu0zd0RXK5g3ESj2IKlmfrV0=
MIME-Version: 1.0
References: <CAE5jQCdGVxnmDYhdEfLpMfeZRNQk19TAX=u9MFmobZ1RFx3z4A@mail.gmail.com>
 <874lilcu67.fsf@mail.parknet.co.jp>
In-Reply-To: <874lilcu67.fsf@mail.parknet.co.jp>
From: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Date: Sun, 3 Jun 2018 16:46:27 +0300
Message-ID: <CAE5jQCfu4i5OQbgE-szs8bGzYoTg2VfOeKKh8+R8yKEfxww=6Q@mail.gmail.com>
Subject: Re: PROBLEM: [kernel BUG at fs/fat/inode.c:162] when writing to a
 broken VFAT
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w53DkvI5022300

Thank you, it works!

сб, 2 июн. 2018 г. в 14:19, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>:
>
> Anatoly Trosinenko <anatoly.trosinenko@gmail.com> writes:
>
> > Description:
> >
> > Writing to some file on a broken VFAT partition causes kernel bug
>
> Thanks. This patch should fix this issue.
> --
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
>
>
> [PATCH] fat: Use fat_fs_error() instead of BUG_ON() in __fat_get_block()
>
> If file size and FAT cluster chain is not matched (corrupted image),
> we can hit BUG_ON(!phys) in __fat_get_block().
>
> So, use fat_fs_error() instead.
>
> Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> ---
>
>  fs/fat/inode.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff -puN fs/fat/inode.c~vfat-dont-bugon fs/fat/inode.c
> --- linux/fs/fat/inode.c~vfat-dont-bugon        2018-06-02 20:15:04.441920069 +0900
> +++ linux-hirofumi/fs/fat/inode.c       2018-06-02 20:15:04.442920067 +0900
> @@ -158,8 +158,13 @@ static inline int __fat_get_block(struct
>         err = fat_bmap(inode, iblock, &phys, &mapped_blocks, create, false);
>         if (err)
>                 return err;
> +       if (!phys) {
> +               fat_fs_error(sb,
> +                            "invalid FAT chain (i_pos %lld, last_block %ld)",
> +                            MSDOS_I(inode)->i_pos, last_block);
> +               return -EIO;
> +       }
>
> -       BUG_ON(!phys);
>         BUG_ON(*max_blocks != mapped_blocks);
>         set_buffer_new(bh_result);
>         map_bh(bh_result, sb, phys);
> _

-- 
Anatoly
