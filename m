Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7526BC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C04920661
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:12:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C04920661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fieldses.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbeIDUhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:37:51 -0400
Received: from fieldses.org ([173.255.197.46]:56328 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbeIDUhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:37:51 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 596301DCB; Tue,  4 Sep 2018 12:12:03 -0400 (EDT)
Date:   Tue, 4 Sep 2018 12:12:03 -0400
To:     Jeff Layton <jlayton@redhat.com>
Cc:     =?utf-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>,
        R.E.Wolff@bitwizard.nl, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: POSIX violation by writeback error
Message-ID: <20180904161203.GD17478@fieldses.org>
References: <CAJDTihz-rFb2SGaxZsQnXGnee_2qW_ynhPe=tZ4yzQBSV_KQ1g@mail.gmail.com>
 <20180904075347.GH11854@BitWizard.nl>
 <CAJDTihzqn3whQ47uUOxGYk4Je4S10ehNEQCtfb=j--iCsdDqgQ@mail.gmail.com>
 <82ffc434137c2ca47a8edefbe7007f5cbecd1cca.camel@redhat.com>
 <CAJDTihw7T8WLme09W8VHCRfiALq4fxg1ZsywcSjn6hXsAw5wRw@mail.gmail.com>
 <cd137e88c9e882200c08c7336aa7b5a1c84a7ba3.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd137e88c9e882200c08c7336aa7b5a1c84a7ba3.camel@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 11:44:20AM -0400, Jeff Layton wrote:
> On Tue, 2018-09-04 at 22:56 +0800, 焦晓冬 wrote:
> > A practical and concrete example may be,
> > A disk cleaner program that first searches for garbage files that won't be used
> > anymore and save the list in a file (open()-write()-close()) and wait for the
> > user to confirm the list of files to be removed.  A writeback error occurs
> > and the related page/inode/address_space gets evicted while the user is
> > taking a long thought about it. Finally, the user hits enter and the
> > cleaner begin
> > to open() read() the list again. But what gets removed is the old list
> > of files that
> > was generated several months ago...
> > 
> > Another example may be,
> > An email editor and a busy mail sender. A well written mail to my boss is
> > composed by this email editor and is saved in a file (open()-write()-close()).
> > The mail sender gets notified with the path of the mail file to queue it and
> > send it later. A writeback error occurs and the related
> > page/inode/address_space gets evicted while the mail is still waiting in the
> > queue of the mail sender. Finally, the mail file is open() read() by the sender,
> > but what is sent is the mail to my girlfriend that was composed yesterday...
> > 
> > In both cases, the files are not meant to be persisted onto the disk.
> > So, fsync()
> > is not likely to be called.
> > 
> 
> So at what point are you going to give up on keeping the data? The
> fundamental problem here is an open-ended commitment. We (justifiably)
> avoid those in kernel development because it might leave the system
> without a way out of a resource crunch.

Well, I think the point was that in the above examples you'd prefer that
the read just fail--no need to keep the data.  A bit marking the file
(or even the entire filesystem) unreadable would satisfy posix, I guess.
Whether that's practical, I don't know.

> > - If the following read() could be served by a page in memory, just returns the
> > data. If the following read() could not be served by a page in memory and the
> > inode/address_space has a writeback error mark, returns EIO.
> > If there is a writeback error on the file, and the request data could
> > not be served
> > by a page in memory, it means we are reading a (partically) corrupted
> > (out-of-data)
> > file. Receiving an EIO is expected.
> > 
> 
> No, an error on read is not expected there. Consider this:
> 
> Suppose the backend filesystem (maybe an NFSv3 export) is really r/o,
> but was mounted r/w. An application queues up a bunch of writes that of
> course can't be written back (they get EROFS or something when they're
> flushed back to the server), but that application never calls fsync.
> 
> A completely unrelated application is running as a user that can open
> the file for read, but not r/w. It then goes to open and read the file
> and then gets EIO back or maybe even EROFS.
> 
> Why should that application (which did zero writes) have any reason to
> think that the error was due to prior writeback failure by a completely
> separate process? Does EROFS make sense when you're attempting to do a
> read anyway?
> 
> Moreover, what is that application's remedy in this case? It just wants
> to read the file, but may not be able to even open it for write to issue
> an fsync to "clear" the error. How do we get things moving again so it
> can do what it wants?
> 
> I think your suggestion would open the floodgates for local DoS attacks.

Do we really care about processes with write permissions (even only
local client-side write permissions) being able to DoS readers?  In
general readers kinda have to trust writers.

--b.
