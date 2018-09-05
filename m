Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D982C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A1BD2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A1BD2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeIEMGV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 08:06:21 -0400
Received: from mondschein.lichtvoll.de ([194.150.191.11]:40439 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbeIEMGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 08:06:21 -0400
Authentication-Results: auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id C58AD3A2B49;
        Wed,  5 Sep 2018 09:37:25 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Jeff Layton <jlayton@redhat.com>
Cc:     =?utf-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>,
        R.E.Wolff@bitwizard.nl, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: POSIX violation by writeback error
Date:   Wed, 05 Sep 2018 09:37:25 +0200
Message-ID: <1959947.mKHFU3S0Eq@merkaba>
In-Reply-To: <cd137e88c9e882200c08c7336aa7b5a1c84a7ba3.camel@redhat.com>
References: <CAJDTihz-rFb2SGaxZsQnXGnee_2qW_ynhPe=tZ4yzQBSV_KQ1g@mail.gmail.com> <CAJDTihw7T8WLme09W8VHCRfiALq4fxg1ZsywcSjn6hXsAw5wRw@mail.gmail.com> <cd137e88c9e882200c08c7336aa7b5a1c84a7ba3.camel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Layton - 04.09.18, 17:44:
> > - If the following read() could be served by a page in memory, just
> > returns the data. If the following read() could not be served by a
> > page in memory and the inode/address_space has a writeback error
> > mark, returns EIO. If there is a writeback error on the file, and
> > the request data could not be served
> > by a page in memory, it means we are reading a (partically)
> > corrupted
> > (out-of-data)
> > file. Receiving an EIO is expected.
> 
> No, an error on read is not expected there. Consider this:
> 
> Suppose the backend filesystem (maybe an NFSv3 export) is really r/o,
> but was mounted r/w. An application queues up a bunch of writes that
> of course can't be written back (they get EROFS or something when
> they're flushed back to the server), but that application never calls
> fsync.
> 
> A completely unrelated application is running as a user that can open
> the file for read, but not r/w. It then goes to open and read the file
> and then gets EIO back or maybe even EROFS.
> 
> Why should that application (which did zero writes) have any reason to
> think that the error was due to prior writeback failure by a
> completely separate process? Does EROFS make sense when you're
> attempting to do a read anyway?
> 
> Moreover, what is that application's remedy in this case? It just
> wants to read the file, but may not be able to even open it for write
> to issue an fsync to "clear" the error. How do we get things moving
> again so it can do what it wants?
> 
> I think your suggestion would open the floodgates for local DoS
> attacks.

I wonder whether a new error for reporting writeback errors like this 
could help out of the situation. But from all I read here so far, this 
is a really challenging situation to deal with.

I still remember how AmigaOS dealt with this case and from an usability 
point of view it was close to ideal: If a disk was removed, like a 
floppy disk, a network disk provided by Envoy or even a hard disk, it 
pops up a dialog "You MUST insert volume <name of volume> again". And if 
you did, it continued writing. That worked even with networked devices. 
I tested it. I unplugged the ethernet cable and replugged it and it 
continued writing.

I can imagine that this would be quite challenging to implement within 
Linux. I remember there has been a Google Summer of Code project for 
NetBSD at least been offered to implement this, but I never got to know 
whether it was taken or even implemented. If so it might serve as an 
inspiration. Anyway AmigaOS did this even for stationary hard disks. I 
had the issue of a flaky connection through IDE to SCSI and then SCSI to 
UWSCSI adapter. And when the hard disk had connection issues that dialog 
popped up, with the name of the operating system volume for example.

Every access to it was blocked then. It simply blocked all processes 
that accessed it till it became available again (usually I rebooted  in 
case of stationary device cause I had to open case or no hot plug 
available or working). 

But AFAIR AmigaOS also did not have a notion of caching writes for 
longer than maybe a few seconds or so and I think just within the device 
driver. Writes were (almost) immediate. There have been some 
asynchronous I/O libraries and I would expect an delay in the dialog 
popping up in that case.

It would be challenging to implement for Linux even just for removable 
devices. You have page dirtying and delayed writeback – which is still 
an performance issue with NFS of 1 GBit, rsync from local storage that 
is faster than 1 GBit and huge files, reducing dirty memory ratio may 
help to halve the time needed to complete the rsync copy operation. And 
you would need to communicate all the way to userspace to let the user 
know about the issue.

Still, at least for removable media, this would be almost the most 
usability friendly approach. With robust filesystems (Amiga Old 
Filesystem and Fast Filesystem was not robust in case of sudden write 
interruption, so the "MUST" was mean that way) one may even offer 
"Please insert device <name of device> again to write out unwritten data 
or choose to discard that data" in a dialog. And for removable media it 
may even work as blocking processes that access it usually would not 
block the whole system. But for the operating system disk? I know how 
Plasma desktop behaves during massive I/O operations. It usually just 
completely stalls to a halt. It seems to me that its processes do some 
I/O almost all of the time … or that the Linux kernel blocks other 
syscalls too during heavy I/O load.

I just liked to mention it as another crazy idea. But I bet it would 
practically need to rewrite the I/O subsystem in Linux to a great 
extent, probably diminishing its performance in situations of write 
pressure. Or maybe a genius finds a way to implement both. :)

What I do think tough is that the dirty page caching of Linux with its 
current standard settings is excessive. 5% / 10% of available memory 
often is a lot these days. There has been a discussion reducing the 
default, but AFAIK it was never done. Linus suggested in that discussion 
to about what the storage can write out in 3 to 5 seconds. That may even 
help with error reporting as reducing dirty memory ratio will reduce the 
memory pressure and so you may choose to add some memory allocations for 
error handling. And the time till you know its not working may be less.

Thanks,
-- 
Martin


