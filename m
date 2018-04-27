Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932405AbeD0IuG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 04:50:06 -0400
Received: from elasmtp-dupuy.atl.sa.earthlink.net ([209.86.89.62]:44810 "EHLO
        elasmtp-dupuy.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932366AbeD0IuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 04:50:03 -0400
Subject: Re: moving affs + RDB partition support to staging?
To: Finn Thain <fthain@telegraphics.com.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Martin Steigerwald <martin@lichtvoll.de>,
        Matthew Wilcox <willy@infradead.org>, David Sterba <dsterba@suse.cz>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-m68k <linux-m68k@vger.kernel.org>
References: <20180425154602.GA8546@bombadil.infradead.org>
 <20180425203029.GQ21272@twin.jikos.cz>
 <20180426025717.GA32430@bombadil.infradead.org> <1613268.lKBQxPXt8J@merkaba>
 <CAMuHMdXt11A-3wZ2uhxF9WE-3+=VV-AbQhpXrkxnV_nwa+E4tA@mail.gmail.com>
 <alpine.LNX.2.21.1804270939470.8@nippy.intranet>
From: jdow <jdow@earthlink.net>
Message-ID: <0d06450e-b589-a794-9f5f-ee1c511e668c@earthlink.net>
Date: Thu, 26 Apr 2018 18:43:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.21.1804270939470.8@nippy.intranet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ELNK-Trace: bb89ecdb26a8f9f24d2b10475b57112003f01058fceb61e7e311c192ab679a963f4ab28b94bf857b350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 68.183.100.23
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20180426 16:56, Finn Thain wrote:
> On Thu, 26 Apr 2018, Geert Uytterhoeven wrote:
> 
>>
>> While non-native Linux filesystem support (e.g. affs/isofs/...) could be
>> handled by FUSE
> 
> Moving to FUSE is a great divide-and-conquer strategy for those who just
> want the code to die and don't care about any of the data in that format.
> 
> If there is a maintainence burden that can be shared then it should be
> shared -- until it can be established that there is no data of value in
> that format.
> 
>> moving RDB partition support to staging is not an option, as it is the
>> only partitioning scheme that Amigas can boot from.
>>
> 
> Whether or not the original hardware is in use is mostly irrelevant.
> 
> As long as the old format is accessible using current hardware, the data
> in that format remains accessible (to archivists, to curators, to your
> decendents, etc).
> 
>> If there are bugs in the RDB parser that people run into, they should be
>> fixed. If there are limitations in the RDB format on large disks, that's
>> still not a reason to move it to staging (hi msdos partitioning!).
>>

This intrepid cyberunit is inclined to suggest that understanding the RDBs can 
go a long way towards defining if there is a bug somewhere and whether it is in 
the RDB description or its misuse.

There are some things RDBs can do that REALLY REALLY don't make sense until you 
run across the situation which called for it creation. There are two variables 
that suggest some blocks at the beginning and the end, respectively, of a 
partition are not accessible by the OS. I have used these facilities to 
"interleave" partitions and RDBs. I have built a disk which reserved about 128 
512 byte blocks for RDBs plus filesystem code (which probably should be 
abandoned) which embedded the RDBs describing the partition within the 
partition. Then I reserved space at the end of the partition and embedded a 
second partition in that space. As absurd as it sounds this had at one time a 
decent use case. Disk space was an expensive premium in those days so wasting 
space to get nice integer numbers in the disk description, which was phony for a 
hard disk in any case, we allowed any numbers and if that went past the end of 
the disk we reserved the necessary space so that it would never be used. The 
space at the beginning of a partition was needed in any case because a one block 
partition signature needed space at the start of the partition. It held the 
filesystem's signature, OFS, AFS, SFS, etc.

There is also a good reason for allowing the anchor for the RDBs to start in any 
of the first 16 blocks with a recommendation not to use block 0 as other FSs 
used that. And we wanted to accommodate at least two different partition 
description technologies to work on the disk. My code always placed the RDBs at 
block 3.

I hope passing along some of this history will mitigate some fo the feelings 
that RDBs are inherently flawed or full of bugs or whatnot. (Full pf security 
holes is another story. DriveInit code and filesystem code have worried me from 
day one.)

{^_^}   Joanne
