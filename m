Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43460C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 127E520659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfANKXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:23:44 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:38404 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbfANKXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 05:23:43 -0500
Received: by mail-ua1-f66.google.com with SMTP id p9so6865009uaa.5;
        Mon, 14 Jan 2019 02:23:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ftr3ho5g2SH93QR9dEHmihHBvfo/NmbS/pC9RbN78Os=;
        b=S0CSXImFTUkcjy+OZSl33WBnL4enRlr0PFk6lsu4EGCDOqcsI4m445+kuRJ3zZTTs9
         Mr4/Oa4asqi+ypBseuWMJsLVrbxNpFOYIvr4I5hhPo6AFN8kd28jtm5BJinaPsXQt1g0
         dca3FC6DrDxFk7Vlwi3w7tjboo7IZJMVgxP3ePZZ9yDWzLwoUqIO4R5zMIG4EVs+NhQD
         NnUXSglbj1jp+mxsRr64tb3ZhGwSoEp8xpGDlKs8gTtdHdNcjsvjvQt+jQG4DR/xIO2o
         duV0yFnMAnXJv1dRPLsqHEZrNReAioW0ilA/OJfb6UHMYrmvHMoTsFceVG/gJtA94+5S
         OXUQ==
X-Gm-Message-State: AJcUukdzfdJH8qa/gYa56Yw56WH4bMfhEY1FjJKEGhTAAi3BY6nLyhmB
        0haR6QApcAadXFqUyuyWYVmXR8bVjkuqw1ku3xF5wBvbzjw=
X-Google-Smtp-Source: ALg8bN6wpVg/TZxWBXr33RFKIkdcJNrYzBppXuc2SpkokohcHFAVA99Q3Y4BlI8myvDfmVb4lCer/Zkjpl0SFrNy764=
X-Received: by 2002:ab0:216:: with SMTP id 22mr9019734uas.28.1547461421871;
 Mon, 14 Jan 2019 02:23:41 -0800 (PST)
MIME-Version: 1.0
References: <CAMuHMdULrGHfgF+RRGf5gXAc=V3KaB4549NezxEc3CvfsKWOyA@mail.gmail.com>
 <3A06C183-19FF-48B3-9C49-60353BEC9DB8@dilger.ca>
In-Reply-To: <3A06C183-19FF-48B3-9C49-60353BEC9DB8@dilger.ca>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 14 Jan 2019 11:23:30 +0100
Message-ID: <CAMuHMdWt+6Aeius=PFr9vQgF7LGde78f9nyai4m1P8QL+oqY0A@mail.gmail.com>
Subject: Re: Preserving a rev 0.0 ext2 filesystem
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Jan Kara <jack@suse.com>, Theodore Tso <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Sun, Jan 13, 2019 at 1:20 AM Andreas Dilger <adilger@dilger.ca> wrote:
> On Jan 12, 2019, at 2:43 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > I'm still regularly using a Linux rev 0.0 ext2 filesystem as a  ramdisk
> > on m68k, containing mid-90's binaries, from right after the a.out-to-ELF
> > transition, so I notice if someone breaks old syscall support.
> >
> > Recently I wanted to change /dev/console on that ramdisk from a symlink
> > to chardev 5 0.  Unfortunately I cannot mount it, without it being
> > upgraded automatically to a rev 1.0 ext2 filesystem.  Apparently the
> > kernel has been doing that upgrade for ages.
> >
> > Do you have a suggestion how to make that change, while preserving the
> > ext2 revision?
>
> It looks like there is a "gratuitous" call to ext4_update_dynamic_rev() in the
> mount path that is left over from when ext3 always set the INCOMPAT_RECOVER and
> COMPAT_HAS_JOURNAL features on every mount.  With the "nojournal" mount option
> these are no longer needed.  You could probably just remove this call with no ill
> effects, or better yet apply the patch that I'll push shortly to this effect.
> It's been there since the start of git history (2.6.12-rc2) in the ext3 code
> that was later copied to become ext4, but digging through my email archives it
> looks like adding the call to "ext3_update_fs_rev()" was actually one of my first
> patches against the original ext3 code "[Ext2-devel] Re: RECOVER INCOMPAT flag",
> dated Nov 18, 2000.
>
> The only thing ext4_update_dynamic_rev() does is update s_rev_level, and set
> s_first_ino and s_inode_size on disk to the values that the kernel already
> assumes to be true (newer kernels can use different values).  Those fields are
> also set in memory later during the mount, so the rest of the code should work
> OK (I haven't tested). This will probably only affect your filesysem (everything
> else in the last 20 years uses EXT2_DYNAMIC_REV) so it won't be much of a change.

JFYI, this is what was changed by mounting and unmounting the filesystem
using the ext4 driver (with a modified version of your patch applied):

--- ramdisk.orig 2019-01-14 09:23:15.578434706 +0100
+++ ramdisk.mounted-by-ext4 2019-01-14 09:23:15.966434482 +0100
@@ -2,16 +2,19 @@
 *
 00000400  f8 00 00 00 78 05 00 00  00 00 00 00 20 00 00 00  |....x....... ...|
 00000410  09 00 00 00 01 00 00 00  00 00 00 00 00 00 00 00  |................|
-00000420  00 20 00 00 00 20 00 00  f8 00 00 00 f7 5e a3 32  |. ... .......^.2|
-00000430  9e 5e a3 32 03 00 14 00  53 ef 01 00 01 00 00 00  |.^.2....S.......|
+00000420  00 20 00 00 00 20 00 00  f8 00 00 00 26 44 3c 5c  |. ... ......&D<\|
+00000430  33 44 3c 5c 04 00 14 00  53 ef 01 00 01 00 00 00  |3D<\....S.......|

Which is just the last mount and last write time, and mount count, as
expected.

00000440  53 5d a3 32 00 4e ed 00  00 00 00 00 00 00 00 00  |S].2.N..........|
 00000450  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
 00000460  00 00 00 00 00 00 00 00  87 6b 6d 86 4c 96 11 d0  |.........km.L...|
 00000470  90 2d 00 60 30 00 02 1a  00 00 00 00 00 00 00 00  |.-.`0...........|
 00000480  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
 *
+00000570  00 00 00 00 00 00 00 00  02 00 00 00 00 00 00 00  |................|

s_kbytes_written was updated, although this field does not exist, and is
reserved, on ext2.

+00000580  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
 00000800  03 00 00 00 04 00 00 00  05 00 00 00 20 00 09 00  |............ ...|
-00000810  0c 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00000810  0c 00 04 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|

Is this bg_flags being set to EXT4_BG_INODE_ZEROED?

 00000820  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
 *
 00000c00  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|

> The "real" ext2 code looks like it does not call ext2_update_dynamic_rev() for
> every filesystem during mount, only if you write a file > 2GB in size, so it would
> also be possible to mount with the ext2.ko driver (if your kernel provides it).
> There looks like a minor bug in ext2 that it doesn't call ext2_update_dynamic_rev()
> if an xattr is stored on the filesystem and it sets EXT2_FEATURE_COMPAT_EXT_ATTR
> in ext2_xattr_update_super_block().  However, nobody noticed in since xattrs landed.

Thanks, since ext2 also has the ext2_update_dynamic_rev() function, I
assumed it would be called as well.  But indeed, mounting the old file system
using the real ext2 driver retains its revision.

JFYI, this is what was changed by mounting and unmounting it using the
ext2 driver:

--- ramdisk.orig 2019-01-14 09:23:15.578434706 +0100
+++ ramdisk.mounted-by-ext2 2019-01-14 09:23:16.362434253 +0100
@@ -3,7 +3,7 @@
 00000400  f8 00 00 00 78 05 00 00  00 00 00 00 20 00 00 00  |....x....... ...|
 00000410  09 00 00 00 01 00 00 00  00 00 00 00 00 00 00 00  |................|
 00000420  00 20 00 00 00 20 00 00  f8 00 00 00 f7 5e a3 32  |. ... .......^.2|
-00000430  9e 5e a3 32 03 00 14 00  53 ef 01 00 01 00 00 00  |.^.2....S.......|
+00000430  84 46 3c 5c 04 00 14 00  53 ef 01 00 01 00 00 00  |.F<\....S.......|
 00000440  53 5d a3 32 00 4e ed 00  00 00 00 00 00 00 00 00  |S].2.N..........|
 00000450  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
 00000460  00 00 00 00 00 00 00 00  87 6b 6d 86 4c 96 11 d0  |.........km.L...|

Which is just the last write time, and mount count, as expected.
Interestingly, the last mount time was not updated.

> In any case, it would be fun to give my patch a try to see if it allows your old
> filesystem to be mounted and modified with a modern kernel and then mounted on
> the old kernel again, as a testament to ext2/ext4 feature compatibility.

The oldest kernel image binary I still have lying around is 2.0.28, and it
groks a ramdisk modified by a v5.0-rc1 ext4 driver just fine.

Thanks!

Gr{oetje,eeting}s,


                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
