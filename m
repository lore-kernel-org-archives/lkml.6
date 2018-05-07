Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751920AbeEGCkI (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 22:40:08 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:38198 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751831AbeEGCkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 22:40:07 -0400
X-Google-Smtp-Source: AB8JxZoJn+xYhdjBtrgMetMbFlZeaOUfS26XvFpfIgULuTW/Besf/qUxT8CETl9XuIUPvSy2RfEqybaYg15lXZEP51Y=
MIME-Version: 1.0
In-Reply-To: <20180507021554.GN30522@ZenIV.linux.org.uk>
References: <20180425154602.GA8546@bombadil.infradead.org> <20180425203029.GQ21272@twin.jikos.cz>
 <20180426025717.GA32430@bombadil.infradead.org> <1613268.lKBQxPXt8J@merkaba>
 <76ca15e2-7b43-8b02-43e1-9ee65ab85356@physik.fu-berlin.de>
 <20180506005946.GI30522@ZenIV.linux.org.uk> <20180506073955.GJ30522@ZenIV.linux.org.uk>
 <20180506204622.GL30522@ZenIV.linux.org.uk> <20180506213247.GM30522@ZenIV.linux.org.uk>
 <20180507021554.GN30522@ZenIV.linux.org.uk>
From: Michael Schmitz <schmitzmic@gmail.com>
Date: Mon, 7 May 2018 14:40:06 +1200
Message-ID: <CAOmrzkLAm99UTkzV0n+rtLg4XTrxHrCkR1ccitsyhf6XLztkpA@mail.gmail.com>
Subject: Re: moving affs + RDB partition support to staging?
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Martin Steigerwald <martin@lichtvoll.de>,
        Matthew Wilcox <willy@infradead.org>, David Sterba <dsterba@suse.cz>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Debian m68k <debian-68k@lists.debian.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al,

I don't think there is USB sticks with affs on them as yet. There
isn't even USB host controller support for Amiga hardware (yet).

Last I tried USB on m68k (Atari, 060 accelerator) the desktop
experience was such that I'd rather not repeat that in a hurry (and
that was a simple FAT USB stick).

I see your point regarding the immense practical joke value on any
desktop PC ... my work desktop has the affs module present. Happy to
try this out if someone can provide a sample disk image suitable for
USB flash media.

Cheers,

  Michael


On Mon, May 7, 2018 at 2:15 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Sun, May 06, 2018 at 10:32:47PM +0100, Al Viro wrote:
>> On Sun, May 06, 2018 at 09:46:23PM +0100, Al Viro wrote:
>>
>> >     I'm fixing that pile of crap (along with the NFS exports
>> > one and, hopefully, rename mess as well).  HOWEVER, I am not going
>> > to take over the damn thing - David has violated the 11th
>> > commandment (Thou Shalt Never Volunteer), so he gets to joy of
>> > learning that codebase and taking care of it from now on.
>>
>>       Same scenario on link(2) ends up with
>> * ST_LINKFILE created, inserted into the link chain and left around,
>> without being present in any hash chain
>> * target becoming positive hashed dentry, as if link(2) has succeeded,
>> so dcache lookups will be finding it (for a while)
>> * unlink(2) on source will have very interesting effects, what with
>> the attempts to move ST_FILE entry into the directory presumed to
>> contain ST_LINKFILE one, removing ST_LINKFILE from it at the same time.
>
> Oh, lovely...  Looks like that thing wants the hash chains sorted by
> block number.  affs_insert_hash() doesn't give a toss - it always
> adds to the very end of chain.
>
> Maintaining that requirement (and I can understand the rationale -
> they don't want too many back-and-forth seeks on directory lookups)
> is going to be great fun on rename(), especially for the case when
> the target of rename happens to be a primary name for a file with
> additional hardlinks.
>
> I think I see how to deal with that sanely, but... ouch.
>
> Incidentally, we'd better verify that hash chains are not looped - as it
> is, there's no checks whatsoever, and it *will* happily loop if you
> feed it an image with such braindamage.  I really hope that no fan of
> desktop experience has set the things up for e.g. USB sticks with
> that on them being recognized and automounted on insertion...
> --
> To unsubscribe from this list: send the line "unsubscribe linux-m68k" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
