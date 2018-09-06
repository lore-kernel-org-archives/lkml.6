Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39300C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA03D20652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA03D20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbeIFHaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 03:30:22 -0400
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:50538 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726059AbeIFHaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 03:30:22 -0400
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail06.adl2.internode.on.net with ESMTP; 06 Sep 2018 12:27:11 +0930
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1fxkTl-0004RP-Iy; Thu, 06 Sep 2018 12:57:09 +1000
Date:   Thu, 6 Sep 2018 12:57:09 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc:     Jeff Layton <jlayton@redhat.com>,
        =?utf-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>,
        bfields@fieldses.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: POSIX violation by writeback error
Message-ID: <20180906025709.GZ5631@dastard>
References: <82ffc434137c2ca47a8edefbe7007f5cbecd1cca.camel@redhat.com>
 <CAJDTihw7T8WLme09W8VHCRfiALq4fxg1ZsywcSjn6hXsAw5wRw@mail.gmail.com>
 <cd137e88c9e882200c08c7336aa7b5a1c84a7ba3.camel@redhat.com>
 <20180904161203.GD17478@fieldses.org>
 <20180904162348.GN17123@BitWizard.nl>
 <20180904185411.GA22166@fieldses.org>
 <a9d586a8c520e52bad2396b93f8d5cb8a9fd2071.camel@redhat.com>
 <CAJDTihxE07BuXMBmShXuj=TbJCK1mq3ZMFMxP1-T=xjhPF5ySw@mail.gmail.com>
 <09ba078797a1327713e5c2d3111641246451c06e.camel@redhat.com>
 <20180905120745.GP17123@BitWizard.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905120745.GP17123@BitWizard.nl>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 02:07:46PM +0200, Rogier Wolff wrote:
> On Wed, Sep 05, 2018 at 06:55:15AM -0400, Jeff Layton wrote:
> > There is no requirement for a filesystem to flush data on close().
> 
> And you can't start doing things like that.

Of course we can. And we do.

We've been doing targetted flush-on-close for years in some
filesystems because applications don't use fsync where they should
and users blame the filesystems for losing their data.

i.e. we do what the applications should have done but don't because
"fsync is slow".  Another common phrase I hear is "I don't need
fsync because I don't see any problems in my testing". They don't
see problems because appliation developers typically don't do power
fail testing of their applications and hence never trigger the
conditions needed to expose the bugs in their applications.

> In some weird cases, you
> might have an application open-write-close files at a much higher rate
> than what a harddisk can handle.

It's not a weird case - the kernel NFSD does this for every write
request it receives.

> And this has worked for years because
> the kernel caches stuff from inodes and data-blocks. If you suddenly
> write stuff to harddisk at 10ms for each seek between inode area and
> data-area..

You're assuming an awful lot about filesystem implementation here.
Neither ext4, btrfs or XFS issue physical IO like this when flushing
data.

> You end up limited to about 50 of these open-write-close
> cycles per second.

You're also conflating "flushing data" with "synchronous".

fsync() is a synchronous data flush because we have defined that way
- it has to wait for IO completion *after* flushing. However, we can
use other methods of flushing data that don't need to wait for
completion, or we can issue synchronous IOs concurrently (e.g. via
AIO or threads) so flushes don't block applications from doing
real work while waiting for IO.  Examples are below.

> My home system is now able make/write/close about 100000 files per
> second.
> 
> assurancetourix:~/testfiles> time ../a.out 100000 000
> 0.103u 0.999s 0:01.10 99.0%     0+0k 0+800000io 0pf+0w

Now you've written 100k files in a second into the cache, how long
do it take the system to flush them out to stable storage?  If the
data is truly so ephemeral it's going to be deleted before it's
written back, then why the hell write it to the filesystem in the
first place?

I use fsmark for open-write-close testing to drive through the
cache phase into sustained IO-at-resource-exhaustion behavour.  I
also use multiple threads to drive the system to being IO bound
before it runs out of CPU.

From one of my test scripts for creating 10 million 4k files to test
background writeback behaviour:

#  ./fs_mark  -D  10000  -S0  -n  10000  -s  4096  -L  120  -d  /mnt/scratch/0  -d  /mnt/scratch/1  -d  /mnt/scratch/2  -d  /mnt/scratch/3  -d  /mnt/scratch/4  -d  /mnt/scratch/5  -d  /mnt/scratch/6  -d  /mnt/scratch/7 
#       Version 3.3, 8 thread(s) starting at Thu Sep  6 09:37:52 2018
#       Sync method: NO SYNC: Test does not issue sync() or fsync() calls.
#       Directories:  Time based hash between directories across 10000 subdirectories with 1800 seconds per subdirectory.
#       File names: 40 bytes long, (16 initial bytes of time stamp with 24 random bytes at end of name)
#       Files info: size 4096 bytes, written with an IO size of 16384 bytes per write
#       App overhead is time in microseconds spent in the test not doing file writing related system calls.

FSUse%        Count         Size    Files/sec     App Overhead
     0        80000         4096      99066.0           545242
     0       160000         4096     100528.7           579256
     0       240000         4096      95789.6           600522
     0       320000         4096     102129.8           532474
     0       400000         4096      89551.3           581729

[skip rest of clean cache phase, dirty cache throttling begins an
 we enter the sustained IO performance phase]

     0      1360000         4096      32222.3           685659
     0      1440000         4096      35473.6           693983
     0      1520000         4096      34753.0           693478
     0      1600000         4096      35540.4           690363
....

So, I see 100k files/s on an idle page cache, and 35k files/s
(170MB/s at ~2000 IOPS) when background writeback kicks in
and it's essentially in a sustained IO bound state.

Turning that into open-write-fsync-close:

       -S Sync Method (0:No Sync, 1:fsyncBeforeClose,
....

Yeah, that sucks - it's about 1000 files/s (~5MB/s and 2000 IOPS),
because it's *synchronous* writeback and I'm only driving 8 threads.
Note that the number of IOPS is almost identical to the "no fsync"
case above - the disk utilisation is almost identical for the two
workloads.

HOwever, let's turn that into a open-write-flush-close operation by
using AIO and not waiting for the fsync to complete before closing
the file. I have this in fsmark, because lots of people with IO
intensive apps have been asking for it over the past 10 years.

        -A <use aio_fsync>

.....
FSUse%        Count         Size    Files/sec     App Overhead
     0        80000         4096      28770.5          1569090
     0       160000         4096      31340.7          1356595
     0       240000         4096      30803.0          1423583
     0       320000         4096      30404.5          1510099
     0       400000         4096      30961.2          1500736

Yup, it's pretty much the same throughput as background async
writeback.  It's a little slower - about 160MB/s and 2,500 IOPS -
due to the increase in overall journal writes caused by the fsync
calls.

What's clear, however, is that we're retiring 10 userspace fsync
operations for every physical disk IO here, as opposed to 2 IOs per
fsync in the above case.  Put simply, the assumption that
applications can't do more flush/fsync operations than disk IOs is
not valid, and that performance of open-write-flush-close workloads
on modern filesystems isn't anywhere near as bad as you think it is.

To mangle a common saying into storage speak:

	"Caches are for show, IO is for go"

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
