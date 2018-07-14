Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3632BECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 11:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E17E52083C
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 11:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E17E52083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbeGNLkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 07:40:12 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48511 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbeGNLkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 07:40:12 -0400
Received: from mail-oi0-f69.google.com ([209.85.218.69])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <dann.frazier@canonical.com>)
        id 1feIcB-00082t-6o
        for linux-kernel@vger.kernel.org; Sat, 14 Jul 2018 11:21:27 +0000
Received: by mail-oi0-f69.google.com with SMTP id w204-v6so47183643oib.9
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 04:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=PolphIcP6Ea6uQDWcoPGw9ax13kZQpvqs/9WdvOR3zE=;
        b=eiBXJRLR1Gu0R0UCvgipxT7gHJKNpnJ3eEVXri445qe4y6xawE79TzLzDyI8JInUTf
         Vpw8fyjc+MEV0wPcUA8EXtYl+lDH3VSfx3kYAyeIKT5DSarwvpgurqSrwXYwi5AplYXT
         627MwDaTu0lNG/4GW4jyB1QjOWXe0rPYGAwTIwsqtWJdJMFOxfFzKsNlyPcCrfbolmu/
         0cVX2PVWEufagiJTQvDBqsmVGe2Se3BK1o8osO2sUbWE3gQvePOtBBM7vovBvNIP2x2l
         Uifgz9odnXGYQV7ArxXqlwNHomWkoDqAel2YqtMMRpV67V5Niipy37eS+oRaITAouRS5
         8K/A==
X-Gm-Message-State: AOUpUlHhTaiP1bh+vDQ3GkPVXn4a3nxIDlljxGq/5aOCV03dr1Ik42mR
        1YknqBIZjxdd928KZjlcZcp7WSCxMlPGr5lrSP/cIQrCZSwVHBRDeNRqAQ5I6QceRNNU74ukhMX
        kqu0MQgnlEHUgAr/r1+2CjEwFxpbTKd9mMSXwQ6JzZZpiLftx/AB26uetjw==
X-Received: by 2002:aca:3357:: with SMTP id z84-v6mr11423987oiz.49.1531567285516;
        Sat, 14 Jul 2018 04:21:25 -0700 (PDT)
X-Google-Smtp-Source: AAOMgpeLQX4wCXkUOjh1L10Zd79TJPdbUCdQgKiV5duZH1PtkE2JSHiNX2Chn8nmaawHYh0BCY/v3j/L5E+AUdX74FM=
X-Received: by 2002:aca:3357:: with SMTP id z84-v6mr11423956oiz.49.1531567285033;
 Sat, 14 Jul 2018 04:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180706174324.GA3049@xps13.dannf> <20180707041018.GB3546@thunk.org>
 <20180710165143.GA20459@xps13.dannf> <20180710204329.GB20459@xps13.dannf>
 <b39169ad-2237-0a4f-e3d1-afc51ac10fa5@canonical.com> <20180712230826.GB28610@thunk.org>
In-Reply-To: <20180712230826.GB28610@thunk.org>
From:   dann frazier <dann.frazier@canonical.com>
Date:   Sat, 14 Jul 2018 05:21:14 -0600
Message-ID: <CALdTtns1yL6z3mvWF70bXvpB0hXFgfRxdTg+sBTMzJKG7L7prA@mail.gmail.com>
Subject: Re: [Bisect] ext4_validate_inode_bitmap:98: comm stress-ng: Corrupt
 inode bitmap
To:     tytso@mit.edu, Ike Pan <ike.pan@canonical.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        yanaijie@huawei.com, Colin King <colin.king@canonical.com>,
        Kamal Mostafa <kamal.mostafa@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 5:08 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> >
> > Review console log and on each run I have filesystem rebuild. The problem
> > is that mke2fs I am using is 1.44.3-rc2. I am now reseting the environment
> > and re-test.
> >
>
> Could it be that you saw the error in ext4_validate_block_bitmap()?

Looks like it. From Ike's report:

# grep EXT4 d05-4-ipmi.log
[ 26.215587] EXT4-fs (sdb2): mounted filesystem with ordered data
mode. Opts: (null)
[ 29.844105] EXT4-fs (sdb2): re-mounted. Opts: errors=remount-ro
[ 3586.211348] EXT4-fs error (device sda2):
ext4_validate_block_bitmap:383: comm stress-ng: bg 4705: bad block
bitmap checksum
[ 8254.776992] EXT4-fs error (device sda2):
ext4_validate_block_bitmap:383: comm stress-ng: bg 4193: bad block
bitmap checksum

I've ran my test case for several days w/ just the inode bitmap fix
and haven't been able to reproduce it - but perhaps that's just the
nature of the chdir test.

> The patch which I sent Dann only fixed the problem for inode bitmaps;
> I noticed today that we need to fix it for block allocation bitmaps as
> well.

I've also now ran several iterations w/ the block bitmap fix as well,
and still no problems, so:

Tested-by: dann frazier <dann.frazier@canonical.com>

> commit 8d5a803c6a6ce4ec258e31f76059ea5153ba46ef
> Author: Theodore Ts'o <tytso@mit.edu>
> Date:   Thu Jul 12 19:08:05 2018 -0400
>
>     ext4: check for allocation block validity with block group locked
>
>     With commit 044e6e3d74a3: "ext4: don't update checksum of new
>     initialized bitmaps" the buffer valid bit will get set without
>     actually setting up the checksum for the allocation bitmap, since the
>     checksum will get calculated once we actually allocate an inode or
>     block.
>
>     If we are doing this, then we need to (re-)check the verified bit
>     after we take the block group lock.  Otherwise, we could race with
>     another process reading and verifying the bitmap, which would then
>     complain about the checksum being invalid.
>
>     https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1780137
>
>     Signed-off-by: Theodore Ts'o <tytso@mit.edu>
>     Cc: stable@kernel.org

Would it also make sense to add the following?

Fixes: 044e6e3d74a3 ("ext4: don't update checksum of new initialized bitmaps")

  -dann

> diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
> index e68cefe08261..aa52d87985aa 100644
> --- a/fs/ext4/balloc.c
> +++ b/fs/ext4/balloc.c
> @@ -368,6 +368,8 @@ static int ext4_validate_block_bitmap(struct super_block *sb,
>                 return -EFSCORRUPTED;
>
>         ext4_lock_group(sb, block_group);
> +       if (buffer_verified(bh))
> +               goto verified;
>         if (unlikely(!ext4_block_bitmap_csum_verify(sb, block_group,
>                         desc, bh))) {
>                 ext4_unlock_group(sb, block_group);
> @@ -386,6 +388,7 @@ static int ext4_validate_block_bitmap(struct super_block *sb,
>                 return -EFSCORRUPTED;
>         }
>         set_buffer_verified(bh);
> +verified:
>         ext4_unlock_group(sb, block_group);
>         return 0;
>  }
> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
> index fb83750c1a14..e9d8e2667ab5 100644
> --- a/fs/ext4/ialloc.c
> +++ b/fs/ext4/ialloc.c
> @@ -90,6 +90,8 @@ static int ext4_validate_inode_bitmap(struct super_block *sb,
>                 return -EFSCORRUPTED;
>
>         ext4_lock_group(sb, block_group);
> +       if (buffer_verified(bh))
> +               goto verified;
>         blk = ext4_inode_bitmap(sb, desc);
>         if (!ext4_inode_bitmap_csum_verify(sb, block_group, desc, bh,
>                                            EXT4_INODES_PER_GROUP(sb) / 8)) {
> @@ -101,6 +103,7 @@ static int ext4_validate_inode_bitmap(struct super_block *sb,
>                 return -EFSBADCRC;
>         }
>         set_buffer_verified(bh);
> +verified:
>         ext4_unlock_group(sb, block_group);
>         return 0;
>  }
