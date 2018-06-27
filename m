Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064EAC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E92926314
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZK+zNSiD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E92926314
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933854AbeF0JAo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 05:00:44 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:52590 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932549AbeF0JAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 05:00:40 -0400
Received: by mail-it0-f65.google.com with SMTP id m194-v6so6422342itg.2;
        Wed, 27 Jun 2018 02:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Ey3ugGiXHuoel7OLyGYLZwypKtosZ8w7veCtZNLtQ/I=;
        b=ZK+zNSiD94i4cQzMsIwuiGaW3dMTyyOeBCKxIEWro8JNmyQUgVYdpFR9NeCavKxU0S
         ItMueNcFrAfKBWUrx40Az9duMhcH5a1l0t7kQPse8w8nm0hzf0bFZ8yrxceKcY2FsHDB
         0YbI9vB1htR6d/JfgZGZyS37jzdgt71RXzgmyPrmDkiOMsJRC2h/htlGakCZxYpI/9ly
         /GrEhJTslfHTi/AFapMjDjv9t1ABoL/LIbTKJLVkHgbpp+YAfeHKOew6a4Ih/MA92sh9
         LYTicFKpaNzAe/czQnzMb1vxJfy1KMbGu66Nwk4oh2MxpraZFIqVxTPGQPkjE3lYQuRX
         AbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Ey3ugGiXHuoel7OLyGYLZwypKtosZ8w7veCtZNLtQ/I=;
        b=IxS8ipsJtMAN5BYXiBQYHWNckp2/NzagrreJc4agB1W98tlqxr6/arWZM110S8l1Vp
         +TJxWqNmBLoM8S4ZYsimnoc6n1nvOV6ezDMXvajcoGjvOz2ogvJ6mDKZltDuPOmaeeLm
         q4UW4lo9c2ZgxGKIOkdVVPDgRgCTtY/DXiam5ImYPCxkukckN/xgvqlVa+MoSpGaozf2
         Th2I3+TotryAjrSlWK0XCtasqH4v66IcdJM1TDWdSYqZ1Sz/pTazjQ3O2M7UsJgBA+FL
         2PfVkZu8hWBGEVfcrr2bVbaZhNdqdCttkdPVhDDobZitMop4QBp92aaZW3B5y7kVYqXZ
         qeDQ==
X-Gm-Message-State: APt69E3k+aiRAcJpx+oFho2m0H6ZwjvAZuyA6zArCdHD3HyRxofIP4iG
        RK6eHkbsLAwi9GEHhywV4R9BxpDk
X-Google-Smtp-Source: AAOMgpe81VuVBRzr+cfY8kke1rNxymcOzHtGEBODkBGf2r7vqgQDi/Pcpu76XhNFHN70jtRZub5Klg==
X-Received: by 2002:a24:7591:: with SMTP id y139-v6mr4321009itc.31.1530090039975;
        Wed, 27 Jun 2018 02:00:39 -0700 (PDT)
Received: from [192.168.1.101] (222-154-41-72-adsl.bb.spark.co.nz. [222.154.41.72])
        by smtp.gmail.com with ESMTPSA id c98-v6sm2171413itd.3.2018.06.27.02.00.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 02:00:39 -0700 (PDT)
Subject: Re: moving affs + RDB partition support to staging?
To:     jdow <jdow@earthlink.net>
References: <20180425154602.GA8546@bombadil.infradead.org>
 <CAMuHMdXt11A-3wZ2uhxF9WE-3+=VV-AbQhpXrkxnV_nwa+E4tA@mail.gmail.com>
 <CAOmrzkKunsjZzwpj9gtovKwXVkj1kTt81ea1zmB7BCDtZz409g@mail.gmail.com>
 <1910962.ItDVNtUG5Q@merkaba>
 <c76b4e4d-7e8e-13ac-81e4-9132f4235eb8@earthlink.net>
 <CAOmrzk+CuuraUnWWKDKen9FV6=UcgKgc6+qJ3g-Fx+tkt5HHQw@mail.gmail.com>
 <45e05e92-e2b1-d46c-11fb-4bd75e793712@earthlink.net>
 <00416cde-ddda-a9e6-f4e8-ee424b2e2a1c@gmail.com>
 <8ef4bdc6-4ed0-675e-e26d-0b6e7ab4a00e@earthlink.net>
 <CAOmrzkKLJiWvDwsER0ca09UJbi57Rj6PUmdxizSNPXzZLMErOA@mail.gmail.com>
 <83f7c594-b24e-69f5-03fb-3c9229d15438@earthlink.net>
Cc:     Martin Steigerwald <martin@lichtvoll.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Sterba <dsterba@suse.cz>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <c5691a23-dc03-be49-6213-ee24afe72087@gmail.com>
Date:   Wed, 27 Jun 2018 21:00:29 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <83f7c594-b24e-69f5-03fb-3c9229d15438@earthlink.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joanne,

I'm not at all allergic to avoiding RDB at all cost for new disks. If 
AmigaOS 4.1 supports more recent partition formats, all the better. This 
is all about supporting use of legacy RDB disks on Linux (though 2 TB 
does stretch the definition of 'legacy' a little). My interest in this 
is to ensure we can continue to use RDB format disks on m68k Amiga 
computers which have no other way to boot Linux from disk.

Not proposing to change the RDB format at all, either. Just trying to 
make sure we translate RDB info into Linux 512-byte block offset and 
size numbers correctly. The kernel won't modify the RDB at all 
(intentionally, that is - with the correct choice of partition sizes, 
Martin might well have wiped out his RDB with the current version of the 
parser).

The choice of refusing to mount a disk (or mounting read-only) rests 
with the VFS drivers alone - AFFS in that case. Not touching any of 
that. At partition scan time, we only have the option of making the 
partition available (with a warning printed), or refusing to make it 
available to the kernel. Once it's made available, all bets are off.

 From what Martin writes, his test case RDB was valid and worked as 
expected on 32 bit AmigaOS (4.1). Apparently, that version has the 
necessary extensions to handle the large offsets resulting from 2 TB 
disks. Not sure what safeguards are in place when connecting such a disk 
to older versions of AmigaOS, but that is a different matter entirely.

The overflows in partition offset and size are the only ones I can see 
in the partition parser - there is no other overflow I've identified. I 
just stated that in order to place a partition towards the end of a 2 TB 
disk, the offset calculation will overflow regardless of what 
combination of rdb->rdb_BlockBytes and sector addresses stored in the 
RDB (in units of 512 byte blocks) we use:

         blksize = be32_to_cpu( rdb->rdb_BlockBytes ) / 512;


                 nr_sects = (be32_to_cpu(pb->pb_Environment[10]) + 1 -
                             be32_to_cpu(pb->pb_Environment[9])) *
                            be32_to_cpu(pb->pb_Environment[3]) *
                            be32_to_cpu(pb->pb_Environment[5]) *
                            blksize;
                 if (!nr_sects)
                         continue;
                 start_sect = be32_to_cpu(pb->pb_Environment[9]) *
                              be32_to_cpu(pb->pb_Environment[3]) *
                              be32_to_cpu(pb->pb_Environment[5]) *
                              blksize;

But in the interest of avoiding any accidental use of a RDB partition 
where calculations currently overflow, I'll make the default behaviour 
to bail out (instead of using wrong offset or size as we currently do). 
Given the 'eat_my_RDB_disk=1' boot option, the user may proceed at their 
own risk (though I still can't see what harm should result from now 
translating a well formed v4.1 2 TB disk RDB correctly for the first time).

Whether or not Linux correctly handles AFFS filesystems larger than 1 TB 
is a matter for VFS experts. Bailing out on nr_sects overflowing ought 
to prevent accidental use of AFFS filesystems on RDB disks which I 
suppose is the majority of use cases.

Bugs in partitioning tools on Linux are entirely out of scope - the 
partitioning tools bypass the partition structure discovered by the 
kernel, and work straight on the raw device. No protecting against that.

If you can point out a way to cause data loss with these precautions, 
for a disk 2 TB or larger that was partitioned and used on a recent 
version or AmigaOS supporting such large disks, I'd consider omitting 
the 'eat_my_RDB_disk' boot option, and just bail out as the only safe 
option.

Cheers,

	Michael


Am 27.06.2018 um 18:24 schrieb jdow:
> You allergic to using a GPT solution? It will get away from some of the
> evils that RDB has inherent in it because they are also features?
> (Loading a filesystem or DriveInit code from RDBs is just asking for a
> nearly impossible to remove malware infection.) Furthermore, any 32 bit
> system that sees an RDSK block is going to try to translate it. If you
> add a new RDB format you are going to get bizarre and probably quite
> destructive results from the mistake. Fail safe is a rather good notion,
> methinks.
>
> Personally I figure this is all rather surreal. 2TG of junk on an Amiga
> system seems utterly outlandish to me. You cited another overflow
> potential. There are at least three we've identified, I believe. Are you
> 100% sure there are no more? The specific one you mention of translating
> RDB to Linux has a proper solution in the RDB reader. It should recover
> such overflow errors in the RDB as it can with due care and polish. It
> should flag any other overflow error it detects within the RDBs and
> return an error such as to leave the disk unmounted or mounted read-only
> if you feel like messing up a poor sod's backups. The simple solution is
> to read each of the variables with the nominal RDB size and convert it
> to uint64_t before calculating byte indices.
>
> However, consider my inputs as advice from an adult who has seen the
> Amiga Elephant so to speak. I am not trying to assert any control. Do as
> you wish; but, I would plead with you to avoid ANY chance you can for
> the user to make a bonehead stupid move and lose all his treasured disk
> archives. Doing otherwise is very poor form.
>
> {o.o}   Joanne "Said enough, she has" Dow
>
> On 20180626 18:07, Michael Schmitz wrote:
>> Joanne,
>>
>> As far as I have been able to test, the change is backwards compatible
>> (RDB partitions from an old disk 80 GB disk are still recognized OK).
>> That"s only been done on an emulator though.
>>
>> Your advice about the dangers of using RDB disks that would have
>> failed the current Linux RDB parser on legacy 32 bit systems is well
>> taken though. Maybe Martin can clarify that for me - was the 2 TB disk
>> in question ever used on a 32 bit Amiga system?
>>
>> RDB disk format is meant for legacy use only, so I think we can get
>> away with printing a big fat warning during boot, advising the user
>> that the oversize RDB partition(s) scanned are not compatible with
>> legacy 32 bit AmigaOS. With the proposed fix they will work under both
>> AmigaOS 4.1 and Linux instead of truncating the first overflowing
>> partition at disk end and trashing valid partitions that overlap,
>> which is what Martin was after.
>>
>> If that still seems too risky, we can make the default behaviour to
>> bail out once a potential overflow is detected, and allow the user to
>> override that through a boot parameter. I'd leave that decision up for
>> the code review on linux-block.
>>
>> Two more comments: Linux uses 512 byte block sizes for the partition
>> start and size calculations, so a change of the RDB blocksize to
>> reduce the block counts stored in the RDB would still result in the
>> same overflow. And amiga-fdisk is indeed utterly broken and needs
>> updating (along with probably most legacy m68k partitioners). Adrian
>> has advertised parted as replacement for the old tools - maybe this
>> would make a nice test case for parted?
>>
>> Cheers,
>>
>>    Michael
>>
>>
>>
>> On Tue, Jun 26, 2018 at 9:45 PM, jdow <jdow@earthlink.net> wrote:
>>> If it is not backwards compatible I for one would refuse to use it.
>>> And if
>>> it still mattered that much to me I'd also generate a reasonable
>>> alternative. Modifying RDBs nay not be even an approximation of a
>>> good idea.
>>> You'd discover that as soon as an RDB uint64_t disk is tasted by a
>>> uint32_t
>>> only system. If it is for your personal use then you're entirely free to
>>> reject my advice and are probably smart enough to keep it working for
>>> yourself.
>>>
>>> GPT is probably the right way to go. Preserve the ability to read
>>> RDBs for
>>> legacy disks only.
>>>
>>> {^_^}
>>>
>>>
>>> On 20180626 01:31, Michael Schmitz wrote:
>>>>
>>>> Joanne,
>>>>
>>>> I think we all agree that doing 32 bit calculations on 512-byte block
>>>> addresses that overflow on disks 2 TB and larger is a bug, causing the
>>>> issues Martin reported. Your patch addresses that by using the correct
>>>> data type for the calculations (as do other partition parsers that may
>>>> have to deal with large disks) and fixes Martin's bug, so appears to be
>>>> the right thing to do.
>>>>
>>>> Using 64 bit data types for disks smaller than 2 TB where calculations
>>>> don't currently overflow is not expected to cause new issues, other
>>>> than
>>>> enabling use of disk and partitions larger than 2 TB (which may have
>>>> ramifications with filesystems on these partitions). So comptibility is
>>>> preserved.
>>>>
>>>> Forcing larger block sizes might be a good strategy to avoid overflow
>>>> issues in filesystems as well, but I can't see how the block size
>>>> stored
>>>> in the RDB would enforce use of the same block size in filesystems.
>>>> We'll have to rely on the filesystem tools to get that right, too.
>>>> Linux
>>>> AFFS does allow block sizes up to 4k (VFS limitation) so this should
>>>> allow partitions larger than 2 TB to work already (but I suspect Al
>>>> Viro
>>>> may have found a few issues when he looked at the AFFS code so I won't
>>>> say more). Anyway partitioning tools and filesystems are unrelated to
>>>> the Linux partition parser code which is all we aim to fix in this
>>>> patch.
>>>>
>>>> If you feel strongly about unknown ramifications of any filesystems on
>>>> partitions larger than 2 TB, say so and I'll have the kernel print a
>>>> warning about these partitions.
>>>>
>>>> I'll get this patch tested on Martin's test case image as well as on a
>>>> RDB image from a disk known to currently work under Linux (thanks Geert
>>>> for the losetup hint). Can't do much more without procuring a working
>>>> Amiga disk image to use with an emulator, sorry. The Amiga I plan to
>>>> use
>>>> for tests is a long way away from my home indeed.
>>>>
>>>> Cheers,
>>>>
>>>>       Michael
>>>>
>>>> Am 26.06.18 um 17:17 schrieb jdow:
>>>>>
>>>>> As long as it preserves compatibility it should be OK, I suppose.
>>>>> Personally I'd make any partitioning tool front end gently force the
>>>>> block size towards 8k as the disk size gets larger. The file systems
>>>>> may also run into 2TB issues that are not obvious. An unused blocks
>>>>> list will have to go beyond a uint32_t size, for example. But a block
>>>>> list (OFS for sure, don't remember for the newer AFS) uses a tad under
>>>>> 1% of the disk all by itself. A block bitmap is not quite so bad.
>>>>> {^_-}
>>>>>
>>>>> Just be sure you are aware of all the ramifications when you make a
>>>>> change. I remember thinking about this for awhile and then determining
>>>>> I REALLY did not want to think about it as my brain was getting tied
>>>>> into a gordian knot.
>>>>>
>>>>> {^_^}
>>>>>
>>>>> On 20180625 19:23, Michael Schmitz wrote:
>>>>>>
>>>>>> Joanne,
>>>>>>
>>>>>> Martin's boot log (including your patch) says:
>>>>>>
>>>>>> Jun 19 21:19:09 merkaba kernel: [ 7891.843284]  sdb: RDSK (512) sdb1
>>>>>> (LNX^@)(res 2 spb 1) sdb2 (JXF^D)(res 2 spb 1) sdb3 (DOS^C)(res 2 spb
>>>>>> 4)
>>>>>> Jun 19 21:19:09 merkaba kernel: [ 7891.844055] sd 7:0:0:0: [sdb]
>>>>>> Attached SCSI disk
>>>>>>
>>>>>> so it's indeed a case of self inflicted damage (RDSK (512) means 512
>>>>>> byte blocks) and can be worked around by using a different block
>>>>>> size.
>>>>>>
>>>>>> Your memory serves right indeed - blocksize is in 512 bytes units.
>>>>>> I'll still submit a patch to Jens anyway as this may bite others yet.
>>>>>>
>>>>>> Cheers,
>>>>>>
>>>>>>      Michael
>>>>>>
>>>>>>
>>>>>> On Sun, Jun 24, 2018 at 11:40 PM, jdow <jdow@earthlink.net> wrote:
>>>>>>>
>>>>>>> BTW - anybody who uses 512 byte blocks with an Amiga file system is
>>>>>>> a famn
>>>>>>> dool.
>>>>>>>
>>>>>>> If memory serves the RDBs think in blocks rather than bytes so it
>>>>>>> should
>>>>>>> work up to 2 gigablocks whatever your block size is. 512 blocks is
>>>>>>> 2199023255552 bytes. But that wastes just a WHOLE LOT of disk in
>>>>>>> block maps.
>>>>>>> Go up to 4096 or 8192. The latter is 35 TB.
>>>>>>>
>>>>>>> {^_^}
>>>>>>> On 20180624 02:06, Martin Steigerwald wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> Hi.
>>>>>>>>
>>>>>>>> Michael Schmitz - 27.04.18, 04:11:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> test results at https://bugzilla.kernel.org/show_bug.cgi?id=43511
>>>>>>>>> indicate the RDB parser bug is fixed by the patch given there,
>>>>>>>>> so if
>>>>>>>>> Martin now submits the patch, all should be well?
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> Ok, better be honest than having anyone waiting for it:
>>>>>>>>
>>>>>>>> I do not care enough about this, in order to motivate myself
>>>>>>>> preparing
>>>>>>>> the a patch from Joanne Dow´s fix.
>>>>>>>>
>>>>>>>> I am not even using my Amiga boxes anymore, not even the Sam440ep
>>>>>>>> which
>>>>>>>> I still have in my apartment.
>>>>>>>>
>>>>>>>> So RDB support in Linux it remains broken for disks larger 2 TB,
>>>>>>>> unless
>>>>>>>> someone else does.
>>>>>>>>
>>>>>>>> Thanks.
>>>>>>>>
>>>>>>> --
>>>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>>>> linux-m68k" in
>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>
>>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>> linux-m68k" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-m68k" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
