Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032876AbeBNQnX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:43:23 -0500
Received: from mail-ot0-f178.google.com ([74.125.82.178]:34555 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032509AbeBNQnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:43:20 -0500
X-Google-Smtp-Source: AH8x227uwzxs8A3jdNiW7Gi5ZJtWX/6QPy1TAePZiWFeMHdBQr9S1Ossd7HphhECrAt5HF4s2G7lJ+89M74tIY/NzWg=
MIME-Version: 1.0
In-Reply-To: <20180131171653.7C66C49841@fruggeri-Arora18_1.sjc.aristanetworks.com>
References: <20180131171653.7C66C49841@fruggeri-Arora18_1.sjc.aristanetworks.com>
From: Francesco Ruggeri <fruggeri@arista.com>
Date: Wed, 14 Feb 2018 08:43:18 -0800
Message-ID: <CA+HUmGiJorL_T7j6B9KHbk96H4MvrCCd-W7CZsBd8RbeMJ7zXQ@mail.gmail.com>
Subject: Re: mount stuck in infinite loop
To: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc: Francesco Ruggeri <fruggeri@arista.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Does anybody have any opinions about this?

Thanks,
Francesco Ruggeri

On Wed, Jan 31, 2018 at 9:16 AM, Francesco Ruggeri <fruggeri@arista.com> wrote:
> I had a few cases of mount getting stuck in an infinite loop.
> This happens when bdev->bd_inode->i_blkbits gets modified (for
> example by bd_set_size()) while *_fill_super() is between
> sb_min_blocksize() and sb_bread(), and the new value is inconsistent
> with the block size used in fill_super().
> When this happens one can get into an infinite loop in
> __getblk_slow(), if grow_buffers() allocates/finds a page with a
> given index, but __find_get_block{_slow}() looks for (and does not
> find) a page with a different index.
>
> I can reproduce it in 4.14.15 with the following script.
> I can also reproduce it in 4.9 and 3.18.
>
> FILE=/tmp/fsfile
> MNT=/tmp/fsmnt
> LOOP=`losetup -f`
>
> rm -rf $FILE $MNT
>
> mkdir $MNT
> dd if=/dev/zero of=$FILE count=32 bs=1MiB
> losetup $LOOP $FILE
> mkfs -t ext4 $LOOP
> while true; do losetup -D $LOOP; losetup $LOOP $FILE; done \
>         2>/dev/null >/dev/null &
> for ((i=0; i<100; i++)); do echo ================== $i; \
>         mount $LOOP $MNT; umount $MNT; done
>
> The issue is that __find_get_block_slow() and grow_buffers() compute
> the page index in different ways.
> I am not sure what the correct solution should be here.
>
> Thanks,
> Francesco Ruggeri
>
