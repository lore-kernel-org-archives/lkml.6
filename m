Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755498AbeDZKpq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 06:45:46 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:54237 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754958AbeDZKpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 06:45:44 -0400
Subject: Re: moving affs + RDB partition support to staging?
To: Martin Steigerwald <martin@lichtvoll.de>,
        Matthew Wilcox <willy@infradead.org>
Cc: dsterba@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-m68k@vger.kernel.org, Debian m68k <debian-68k@lists.debian.org>
References: <20180425154602.GA8546@bombadil.infradead.org>
 <20180425203029.GQ21272@twin.jikos.cz>
 <20180426025717.GA32430@bombadil.infradead.org> <1613268.lKBQxPXt8J@merkaba>
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <76ca15e2-7b43-8b02-43e1-9ee65ab85356@physik.fu-berlin.de>
Date: Thu, 26 Apr 2018 12:45:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1613268.lKBQxPXt8J@merkaba>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: 87.77.146.231
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(adding debian-68k)

Hi Matthew!

On 04/26/2018 12:28 PM, Martin Steigerwald wrote:
> You probably put your stick into a cave with ancient sleeping dragons :)

Indeed.

> Added in linux-m68k mailing list, as they likely have an opinion on how
> to treat affs + RDB partition support. Also added in Jens Axboe about
> patching that RDB support broken with 2 TB or larger harddisks issue
> which had been in Linux kernel for 6 years while a patch exists that to
> my testing back then solves the issue.

The answer is that we are still very much actively using RDB and AFFS
supoort in the Linux kernel and if you were to remove it, you would
directly hit users.

I know it may sound crazy, but the Linux/m68k port (Atari, Mac, Amiga etc)
is a very actively used and maintained port which just recently received
three new drivers:

> https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git/commit/?h=4.18/scsi-queue&id=3109e5ae0311e937d49a5325134e50b742ac5f4a
> https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/commit/?id=861928f4e60e826cd8871c0c37f4b3d825b8d81d
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/ata/pata_gayle.c?id=9ab27d1d35fda0c5fce624083e92546a8545e7e5

The community around the m68k CPU is constantly developing new hardware
(new accelerator boards, networking cards, IDE controllers etc for the
Amiga and so on). So, the community and the port are anything but dead.

>> Yeah, it's pretty sad how few commits some of these filesystems have
>> had in recent years.  One can argue that they're stable and don't need
>> to be fixed because they aren't broken, but I find it hard to believe
>> that any of them were better-implemented than ext2 which still sees
>> regular bugfixes.

Exactly. It works fine as is:

root@elgar:~> uname -a
Linux elgar 4.16.0-rc2-amiga-16784-ga8917fc #650 Mon Mar 5 15:32:52 NZDT 2018 m68k GNU/Linux
root@elgar:~> mount /dev/sda1 /mnt -taffs
root@elgar:~> ls -l /mnt | head
total 0
drwx------ 1 root root      0 Mar 30  2001 Alt
-rw------- 1 root root   1352 Mar 27  1997 Alt.info
drwx------ 1 root root      0 Nov 16 14:39 C
drwx------ 1 root root      0 Mar 27  1997 CS_Fonts
drwx------ 1 root root      0 Mar 27  1997 Classes
-rwx------ 1 root root   1132 Aug 14  1996 Classes.info
drwx------ 1 root root      0 Feb 10  2004 Commodities
-rw------- 1 root root    628 Jan 14  2002 Commodities.info
drwx------ 1 root root      0 Apr 10  1999 CyberTools
root@elgar:~> mount |grep affs
/dev/sda1 on /mnt type affs (rw,relatime,bs=512,volume=:)
root@elgar:~>

There is nothing at the moment that needs fixing.

> Regarding affs there is a severe issue which is not in affs itself but
> in the handling of Rigid Disk Block (RDB) partitions, the Amiga
> partitioning standard, which is far more advanced than MBR: It overruns
> for 2 TB or larger drives and then wraps over to the beginning of the
> drive – I bet you can imagine what happens if you write to an area
> larger than 2 TB. I learned this with an external 2TB RDB partitioned
> harddisk back then, which I used for Sam440ep (a kind of successor for
> old, classic Amiga hardware) backup + some Linux related stuff in
> another partition.

The usecase for RDB-partitioned disks larger than 2 TiB is rather
obscure, so I don't really consider this a problem. Amigas running
Linux can use GPT for the other disks.

> Joanne Dow, a developer who developed hdwrench.library which HDToolBox
> uses for partitioning in AmigaOS 3.5/3.9, provided a patch back then,
> but never officially put it officially through upstreaming as I offered
> to make a good description and upstream it through Jens Axboe.

Could be an idea to do that.

> I may take this as a reason to… actually follow through this time,
> hopefully remembering all the details in order to provide a meaningful
> patch description – but I think mostly I can do just careful copy and
> paste. Even tough I believe Joanne Dow´s fix only fixed my bug report
> 43511, but not 43511 which is more about a safeguarding issue in case of
> future overflows, I still think it would be good to go in in case affs +
> RDB stays in their current places.

That would be cool. Let me know whether you need real Amiga hardware
for testing. We have plenty available.

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

I wholeheartedly object to move RDB and AFFS to staging and I guess
the Linux/m68k and Debian/m68k community agrees.

> I totally get your motivation, but I would find it somewhat sad to see
> the filesystems you mentioned go into staging. However, as I just shown
> clearly, for the user it may be better, cause there may be unfixed
> dangerous bugs.

No, it's not better for the user if you take something away which
works for 99% of us just fine.

> FUSE might be an interesting approach, but I bet it will
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

Adrian

-- 
  .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
