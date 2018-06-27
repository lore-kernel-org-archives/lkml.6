Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C17C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CBE826838
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CBE826838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933035AbeF0H6A convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 03:58:00 -0400
Received: from mondschein.lichtvoll.de ([194.150.191.11]:55443 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752453AbeF0H55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 03:57:57 -0400
Authentication-Results: auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id CDDF03515A3;
        Wed, 27 Jun 2018 09:57:54 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     jdow <jdow@earthlink.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Sterba <dsterba@suse.cz>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: moving affs + RDB partition support to staging?
Date:   Wed, 27 Jun 2018 09:57:54 +0200
Message-ID: <6247961.nY8s5dWVsg@merkaba>
In-Reply-To: <CAOmrzkKLJiWvDwsER0ca09UJbi57Rj6PUmdxizSNPXzZLMErOA@mail.gmail.com>
References: <20180425154602.GA8546@bombadil.infradead.org> <8ef4bdc6-4ed0-675e-e26d-0b6e7ab4a00e@earthlink.net> <CAOmrzkKLJiWvDwsER0ca09UJbi57Rj6PUmdxizSNPXzZLMErOA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Schmitz - 27.06.18, 03:07:
> Joanne,
> 
> As far as I have been able to test, the change is backwards compatible
> (RDB partitions from an old disk 80 GB disk are still recognized OK).
> That"s only been done on an emulator though.
> 
> Your advice about the dangers of using RDB disks that would have
> failed the current Linux RDB parser on legacy 32 bit systems is well
> taken though. Maybe Martin can clarify that for me - was the 2 TB disk
> in question ever used on a 32 bit Amiga system?

Sure! Are there actually *any* 64 bit Amiga systems? I am not completely 
sure architecture-wise, but the operating system is still just 32-Bit.

However, on AmigaOS officially since at least 3.5/3.9 there are various 
mechanisms to handle 64-bit block numbers for disk devices, called 
NSD64, TD64 and scsi direct¹. One of them, NSD 64 in AmigaOS 3.5/3.9, is 
part of the operating system. First via SetPatch based update to 
Kickstart ROM, but with AmigaOS 4.x its just included.

[1] http://www.amigawiki.de/doku.php?id=de:system:filesystems_limits 

(I do not agree with maximum filesystem size limits stated there for 
Amiga Fast Filesystem (FFS), but well, for early FFS versions they could 
have been true, I am pretty sure that at least with higher block sizes 
you can have FFS > 2 GiB in size. And I remember having had JFXS and I 
think also SFS2 partitions in AmigaOS 4 with more than 100 GiB.)

> RDB disk format is meant for legacy use only, so I think we can get
> away with printing a big fat warning during boot, advising the user
> that the oversize RDB partition(s) scanned are not compatible with
> legacy 32 bit AmigaOS. With the proposed fix they will work under both
> AmigaOS 4.1 and Linux instead of truncating the first overflowing
> partition at disk end and trashing valid partitions that overlap,
> which is what Martin was after.

They are compatible. For AmigaOS 4.x I am completely sure, cause I 
installed and used the disk there. That was the original motivation for 
my Linux bug report back then: I used the disk in AmigaOS 4 *just fine* 
and it broke in Linux. I used Media Toolbox in order to create the RDB I 
posted back then.

Its difficult to find proof for my claims online, but here is an 
official one:

http://wiki.amigaos.net/wiki/RDB

Limits of filesystem sizes may of course be different, but here we are 
talking about RDB.

Also this confirms that RDB only uses 512 byte block size on AmigaOS 4.

Hmmm, I even created the page back then. Interestingly at about the same 
time I made the bug report about the Linux issue. The calculations in 
there are not really from me. I bet I copied them over from what other 
AmigaOS developers wrote on development mailing lists, at that time. 
With their agreement. I think I started my research back then due by my 
own question on: Will such a large disk actually work in AmigaOS?

It is all a long time ago…

> If that still seems too risky, we can make the default behaviour to
> bail out once a potential overflow is detected, and allow the user to
> override that through a boot parameter. I'd leave that decision up for
> the code review on linux-block.
> 
> Two more comments: Linux uses 512 byte block sizes for the partition
> start and size calculations, so a change of the RDB blocksize to
> reduce the block counts stored in the RDB would still result in the
> same overflow. And amiga-fdisk is indeed utterly broken and needs
> updating (along with probably most legacy m68k partitioners). Adrian
> has advertised parted as replacement for the old tools - maybe this
> would make a nice test case for parted?

I always used AmigaOS based tools to partition in RDB format, cause I 
never trusted amiga-fdisk :).

> On Tue, Jun 26, 2018 at 9:45 PM, jdow <jdow@earthlink.net> wrote:
> > If it is not backwards compatible I for one would refuse to use it.
> > And if it still mattered that much to me I'd also generate a
> > reasonable alternative. Modifying RDBs nay not be even an
> > approximation of a good idea. You'd discover that as soon as an RDB
> > uint64_t disk is tasted by a uint32_t only system. If it is for
> > your personal use then you're entirely free to reject my advice and
> > are probably smart enough to keep it working for yourself.
> > 
> > GPT is probably the right way to go. Preserve the ability to read
> > RDBs for legacy disks only.
> > 
> > {^_^}
> > 
> > On 20180626 01:31, Michael Schmitz wrote:
> >> Joanne,
> >> 
> >> I think we all agree that doing 32 bit calculations on 512-byte
> >> block
> >> addresses that overflow on disks 2 TB and larger is a bug, causing
> >> the issues Martin reported. Your patch addresses that by using the
> >> correct data type for the calculations (as do other partition
> >> parsers that may have to deal with large disks) and fixes Martin's
> >> bug, so appears to be the right thing to do.
> >> 
> >> Using 64 bit data types for disks smaller than 2 TB where
> >> calculations don't currently overflow is not expected to cause new
> >> issues, other than enabling use of disk and partitions larger than
> >> 2 TB (which may have ramifications with filesystems on these
> >> partitions). So comptibility is preserved.
> >> 
> >> Forcing larger block sizes might be a good strategy to avoid
> >> overflow
> >> issues in filesystems as well, but I can't see how the block size
> >> stored in the RDB would enforce use of the same block size in
> >> filesystems. We'll have to rely on the filesystem tools to get
> >> that right, too. Linux AFFS does allow block sizes up to 4k (VFS
> >> limitation) so this should allow partitions larger than 2 TB to
> >> work already (but I suspect Al Viro may have found a few issues
> >> when he looked at the AFFS code so I won't say more). Anyway
> >> partitioning tools and filesystems are unrelated to the Linux
> >> partition parser code which is all we aim to fix in this patch.
> >> 
> >> If you feel strongly about unknown ramifications of any filesystems
> >> on partitions larger than 2 TB, say so and I'll have the kernel
> >> print a warning about these partitions.
> >> 
> >> I'll get this patch tested on Martin's test case image as well as
> >> on a RDB image from a disk known to currently work under Linux
> >> (thanks Geert for the losetup hint). Can't do much more without
> >> procuring a working Amiga disk image to use with an emulator,
> >> sorry. The Amiga I plan to use for tests is a long way away from
> >> my home indeed.
> >> 
> >> Cheers,
> >> 
> >>      Michael
> >> 
> >> Am 26.06.18 um 17:17 schrieb jdow:
> >>> As long as it preserves compatibility it should be OK, I suppose.
> >>> Personally I'd make any partitioning tool front end gently force
> >>> the
> >>> block size towards 8k as the disk size gets larger. The file
> >>> systems
> >>> may also run into 2TB issues that are not obvious. An unused
> >>> blocks
> >>> list will have to go beyond a uint32_t size, for example. But a
> >>> block
> >>> list (OFS for sure, don't remember for the newer AFS) uses a tad
> >>> under 1% of the disk all by itself. A block bitmap is not quite
> >>> so bad. {^_-}
> >>> 
> >>> Just be sure you are aware of all the ramifications when you make
> >>> a
> >>> change. I remember thinking about this for awhile and then
> >>> determining I REALLY did not want to think about it as my brain
> >>> was getting tied into a gordian knot.
> >>> 
> >>> {^_^}
> >>> 
> >>> On 20180625 19:23, Michael Schmitz wrote:
> >>>> Joanne,
> >>>> 
> >>>> Martin's boot log (including your patch) says:
> >>>> 
> >>>> Jun 19 21:19:09 merkaba kernel: [ 7891.843284]  sdb: RDSK (512)
> >>>> sdb1
> >>>> (LNX^@)(res 2 spb 1) sdb2 (JXF^D)(res 2 spb 1) sdb3 (DOS^C)(res 2
> >>>> spb
> >>>> 4)
> >>>> Jun 19 21:19:09 merkaba kernel: [ 7891.844055] sd 7:0:0:0: [sdb]
> >>>> Attached SCSI disk
> >>>> 
> >>>> so it's indeed a case of self inflicted damage (RDSK (512) means
> >>>> 512
> >>>> byte blocks) and can be worked around by using a different block
> >>>> size.
> >>>> 
> >>>> Your memory serves right indeed - blocksize is in 512 bytes
> >>>> units.
> >>>> I'll still submit a patch to Jens anyway as this may bite others
> >>>> yet.
> >>>> 
> >>>> Cheers,
> >>>> 
> >>>>     Michael
> >>>> 
> >>>> On Sun, Jun 24, 2018 at 11:40 PM, jdow <jdow@earthlink.net> 
wrote:
> >>>>> BTW - anybody who uses 512 byte blocks with an Amiga file system
> >>>>> is
> >>>>> a famn
> >>>>> dool.
> >>>>> 
> >>>>> If memory serves the RDBs think in blocks rather than bytes so
> >>>>> it
> >>>>> should
> >>>>> work up to 2 gigablocks whatever your block size is. 512 blocks
> >>>>> is
> >>>>> 2199023255552 bytes. But that wastes just a WHOLE LOT of disk in
> >>>>> block maps.
> >>>>> Go up to 4096 or 8192. The latter is 35 TB.
> >>>>> 
> >>>>> {^_^}
> >>>>> 
> >>>>> On 20180624 02:06, Martin Steigerwald wrote:
> >>>>>> Hi.
> >>>>>> 
> >>>>>> Michael Schmitz - 27.04.18, 04:11:
> >>>>>>> test results at
> >>>>>>> https://bugzilla.kernel.org/show_bug.cgi?id=43511
> >>>>>>> indicate the RDB parser bug is fixed by the patch given there,
> >>>>>>> so if
> >>>>>>> Martin now submits the patch, all should be well?
> >>>>>> 
> >>>>>> Ok, better be honest than having anyone waiting for it:
> >>>>>> 
> >>>>>> I do not care enough about this, in order to motivate myself
> >>>>>> preparing the a patch from Joanne Dow´s fix.
> >>>>>> 
> >>>>>> I am not even using my Amiga boxes anymore, not even the
> >>>>>> Sam440ep
> >>>>>> which
> >>>>>> I still have in my apartment.
> >>>>>> 
> >>>>>> So RDB support in Linux it remains broken for disks larger 2
> >>>>>> TB,
> >>>>>> unless
> >>>>>> someone else does.
> >>>>>> 
> >>>>>> Thanks.
> >>>>> 
> >>>>> --
> >>>>> To unsubscribe from this list: send the line "unsubscribe
> >>>>> linux-m68k" in
> >>>>> the body of a message to majordomo@vger.kernel.org
> >>>>> More majordomo info at 
> >>>>> http://vger.kernel.org/majordomo-info.html
> >>> 
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe
> >>> linux-m68k" in the body of a message to majordomo@vger.kernel.org
> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-m68k" in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Martin


