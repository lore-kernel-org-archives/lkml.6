Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755084AbeDZLIq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:08:46 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:41152 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754094AbeDZLIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:08:43 -0400
X-Google-Smtp-Source: AIpwx4+dIvjW1vQAY8A8baPZOO43ke4PXLePkU4kgrE8OStn+cOwW9tYVEHOdugNoXAuOKfgTJA3ozJXkAQzrCxmMw0=
MIME-Version: 1.0
In-Reply-To: <1613268.lKBQxPXt8J@merkaba>
References: <20180425154602.GA8546@bombadil.infradead.org> <20180425203029.GQ21272@twin.jikos.cz>
 <20180426025717.GA32430@bombadil.infradead.org> <1613268.lKBQxPXt8J@merkaba>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 26 Apr 2018 13:08:41 +0200
X-Google-Sender-Auth: BQCAAFo7wuVYXuiPlDrH_p9ZnZM
Message-ID: <CAMuHMdXt11A-3wZ2uhxF9WE-3+=VV-AbQhpXrkxnV_nwa+E4tA@mail.gmail.com>
Subject: Re: moving affs + RDB partition support to staging? (was: Re: Moving
 unmaintained filesystems to staging)
To: Martin Steigerwald <martin@lichtvoll.de>
Cc: Matthew Wilcox <willy@infradead.org>, David Sterba <dsterba@suse.cz>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-m68k <linux-m68k@vger.kernel.org>,
        Joanne Dow <jdow@earthlink.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3QB8pA1023773

Hi Martin,

CC jdow

On Thu, Apr 26, 2018 at 12:28 PM, Martin Steigerwald
<martin@lichtvoll.de> wrote:
> You probably put your stick into a cave with ancient sleeping dragons :)
>
> Added in linux-m68k mailing list, as they likely have an opinion on how
> to treat affs + RDB partition support. Also added in Jens Axboe about
> patching that RDB support broken with 2 TB or larger harddisks issue
> which had been in Linux kernel for 6 years while a patch exists that to
> my testing back then solves the issue.

While non-native Linux filesystem support (e.g. affs/isofs/...) could be
handled by FUSE, moving RDB partition support to staging is not an option,
as it is the only partitioning scheme that Amigas can boot from.

If there are bugs in the RDB parser that people run into, they should
be fixed.
If there are limitations in the RDB format on large disks, that's still not
a reason to move it to staging (hi msdos partitioning!).

> Matthew Wilcox - 26.04.18, 04:57:
>> On Wed, Apr 25, 2018 at 10:30:29PM +0200, David Sterba wrote:
>> > I had similar toughts some time ago while browsing the fs/
>> > directory.
>> > Access to the filesystem images can be reimplemented in FUSE, but
>> > other than that, I don't think the in-kernel code would be missed.
>> >
>> > It's hard to know how many users are there. I was curious eg. about
>> > bfs, befs, coda or feevxfs, looked at the last commits and searched
>> > around web if there are any mentions or user community. But as long
>> > as there's somebody listed in MAINTAINERS, the above are not
>> > candidates for moving to staging or deletion.
>>
>> Yeah, it's pretty sad how few commits some of these filesystems have
>> had in recent years.  One can argue that they're stable and don't need
>> to be fixed because they aren't broken, but I find it hard to believe
>> that any of them were better-implemented than ext2 which still sees
>> regular bugfixes.
>
> Regarding affs there is a severe issue which is not in affs itself but
> in the handling of Rigid Disk Block (RDB) partitions, the Amiga
> partitioning standard, which is far more advanced than MBR: It overruns
> for 2 TB or larger drives and then wraps over to the beginning of the
> drive – I bet you can imagine what happens if you write to an area
> larger than 2 TB. I learned this with an external 2TB RDB partitioned
> harddisk back then, which I used for Sam440ep (a kind of successor for
> old, classic Amiga hardware) backup + some Linux related stuff in
> another partition.
>
> Joanne Dow, a developer who developed hdwrench.library which HDToolBox
> uses for partitioning in AmigaOS 3.5/3.9, provided a patch back then,
> but never officially put it officially through upstreaming as I offered
> to make a good description and upstream it through Jens Axboe.
>
> I may take this as a reason to… actually follow through this time,
> hopefully remembering all the details in order to provide a meaningful
> patch description – but I think mostly I can do just careful copy and
> paste. Even tough I believe Joanne Dow´s fix only fixed my bug report
> 43511, but not 43511 which is more about a safeguarding issue in case of
> future overflows, I still think it would be good to go in in case affs +
> RDB stays in their current places.
>
> However, in case you move affs to staging, I may be less motivated to do
> so, but then I suggest you also move RDB partitioning support to
> staging, cause this is the one that is known to be dangerously badly for
> 2 TB or larger disks. And yeah, I admit I did not follow through with
> having that patch upstreamed. Probably I did not want to be responsible
> in case my description would not have been absolutely accurate or the
> patch breaks something else. I do not have that 2 TB drive anymore and
> don´t feel like setting one up in a suitable way in order to go about
> this patch, but my testing back then was quite elaborate and I still
> feel pretty confident about it.
>
> I totally get your motivation, but I would find it somewhat sad to see
> the filesystems you mentioned go into staging. However, as I just shown
> clearly, for the user it may be better, cause there may be unfixed
> dangerous bugs. FUSE might be an interesting approach, but I bet it will
> not solve the maintenance issue. If there is no one maintaining it in
> the kernel, I think its unlikely to find someone adapting it to be a
> FUSE filesystem and maintaining it. And then I am not aware of FUSE
> based partitioning support. (And I think think ideally we´d had a
> microkernel and run all filesystems in userspace processes with a
> defined set of privileges, but that is simply not Linux as it is.)
>
> Partitions: Amiga RDB partition on 2 TB disk way too big, while OK in
> AmigaOS 4.1
> https://lkml.org/lkml/2012/6/17/6
>
> Bug 43521 - Amiga RDB partitions: truncates miscalculated partition size
> instead of refusing to use it
> https://bugzilla.kernel.org/show_bug.cgi?id=43521
>
> Bug 43511 - Partitions: Amiga RDB partition on 2 TB disk way too big,
> while OK in AmigaOS 4.1
> https://bugzilla.kernel.org/show_bug.cgi?id=43511
>
> I forward the relevant mail of Joanne, in
>
> https://bugzilla.kernel.org/show_bug.cgi?id=43511#c7
>
> I even have the patch in diff format. And I just checked, the issue is
> still unpatched as of 4.16.3.
>
> ----------  Weitergeleitete Nachricht  ----------
>
> Betreff: Re: Partitions: Amiga RDB partition on 2 TB disk way too big,
> while OK in AmigaOS 4.1
> Datum: Montag, 18. Juni 2012, 03:28:48 CEST
> Von: jdow <jdow@earthlink.net>
> An: Martin Steigerwald <Martin@lichtvoll.de>
> Kopie: Geert Uytterhoeven <geert@linux-m68k.org>, linux-
> kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, linux-
> m68k@vger.kernel.org
>
> On 2012/06/17 14:20, Martin Steigerwald wrote:
>> Am Sonntag, 17. Juni 2012 schrieb jdow:
>>> On 2012/06/17 09:36, Geert Uytterhoeven wrote:
>>>> On Sun, Jun 17, 2012 at 2:58 PM, Martin Steigerwald
>> <Martin@lichtvoll.de> wrote:
>>>>> Am Sonntag, 17. Juni 2012 schrieb jdow:
>>>>> | JXFS 64 bit file system
>>>>> |
>>>>> | With AmigaOS 4.x a new file system has been introduced called
>>>>> | JXFS. It is a totally new 64 bit file system that supports
>>>>> | partitions up to 16 TB in size. It is a modern journalling file
>>>>> | system, which means that it reduces data loss if data writes to
>>>>> | the disk are interrupted. It is the fastest and most reliable
>>>>> | file system ever created for AmigaOS.
>>>>>
>>>>> http://www.amigaos.net/content/1/features
>>>>>
>>>>> Well I asked AmigaOS 4 developers about this issue as well. Lets
> see
>>>>> what they say about 2 TB limits.
>>>>
>>>> 16 TB = 2 TB * 8. Perhaps they increased the block size from 512 to
>>>> 4096?
>>>>
>>>> block/partitions/amiga.c reads the block size from
>>>> RigidDiskBlock.rdb_BlockBytes,
>>>> but after conversion to 512-byte blocks, all further calculations
> are
>>>> done on "int", so it will overflow for disks larger than 2 TiB.
>>>>
>>>> Note that in your profile-binary.img, the field is 0x200, i.e. 512
>>>> bytes per block,
>>>> so I'll have to get a deeper look into your RDB first...
>> […]
>>> Note that the work I did on the Linux RDB code eons ago took full
>>> cognizance of the physical and virtual block sizes.
>> […]
>>> I've asked Martin for a digital copy of his RDBs and what he thinks
> the
>>> partition(s) should look like. I should also be told whether the disk
>>> is supposed to be solely Amiga OSs or not. I gather it's not.
>>
>> Its all in the bug report. profile-binary.img should be it.
>>
>> Its small so I attach it.
>>
>> Meanwhile I try to get the currently supported maximum disk size out
> from
>> the OS 4 developers. Maybe JXFS is playing tricks that other
> filesystems do
>> not play or simply has a different implementation.
>>
>> Thanks,
>
> I've sent Jens a proposed fix changing these lines in amiga.c.
> ===8<--- was
>          struct PartitionBlock *pb;
>          int start_sect, nr_sects, blk, part, res = 0;
>          int blksize = 1;        /* Multiplier for disk block size */
> ===8<--- becomes changing line 338 into lines 338-339
>          struct PartitionBlock *pb;
>          sector_t start_sect, nr_sects;
>          int blk, part, res = 0;
>          int blksize = 1;        /* Multiplier for disk block size */
> ===8<---
>
> (I'm working without proper tools at the moment or I'd make a real diff.
> Sorry.)
>
> This fix may not be complete. The RDBs contain provisions for describing
> the physical disk block size and how many physical blocks are used in a
> file system's logical blocks. This MAY not work quite right large
> physical
> block sizes.
>
> {^_^}   Joanne Dow
> --
> To unsubscribe from this list: send the line "unsubscribe linux-m68k" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> -------------------------------------------------------------
> […]
>
>> As long as there's someone who can be pestered with bugs, I don't see
>> the need to push their baby out of the tree.  I'm a bit more nervous
>> about hfsplus; if it has users and no maintainer, those users are at
>> risk.
>>
>> Perhaps we could advertise on Craigslist or something ... maintainer
>> wanted for LTR.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
