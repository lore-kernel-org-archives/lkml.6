Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA92C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D10C0206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D10C0206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbeIDUKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:10:03 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:35940 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbeIDUKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:10:03 -0400
Received: by mail-yw1-f65.google.com with SMTP id w202-v6so1434487yww.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 08:44:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KtHWMX+XASDDF6hviKVt78sVblGkBa70upHpsYA6L0w=;
        b=O5yM6XBRkvghgX5tOrtt1ytXHgkIiAId+MIGQMe+9OfM+eDcoyph9KwFPSWkkIU3u+
         BcandExbVxm/kmAQG/F9O1y0+wwwQGwuPplqXHgAMaMxyZOzcjKlSX36As0HAwftYBor
         eplWNo3YwwYKywTeoBOXAn1iprt59ACEu5LW56A8kF9DVdKHLJsSeZ8QhsT2ap1xGyNx
         TrvV6yoquuptTqMCGevYgyEd3VYrJinOBLrypeU8sTI0GTbARgjN4Gf49OtKHNgAVTMw
         sZfDm74Vrnw0mY9QPFvLUEy3SIW7NAUvgqdbL4KZ8XP3sEoLoCd34AQwtXmF47gKi48Z
         8DEw==
X-Gm-Message-State: APzg51AeuPYun8UEqOG317FsGDo708Q/tD1k/vy4USr9t2HMx9/pBz76
        qGlKMf5O8d0ycK8TEk853XFEdg==
X-Google-Smtp-Source: ANB0VdZnll9LpyPqyHpBhBlhq2q7mx4IuqGvZ1li2zzeAM0ZTNs7dPBhqJ07gjAquemFm72hzqabgg==
X-Received: by 2002:a0d:df83:: with SMTP id i125-v6mr18485014ywe.151.1536075862257;
        Tue, 04 Sep 2018 08:44:22 -0700 (PDT)
Received: from tleilax.poochiereds.net (cpe-2606-A000-1100-DB-0-0-0-161.dyn6.twc.com. [2606:a000:1100:db::161])
        by smtp.gmail.com with ESMTPSA id h68-v6sm8976958ywc.7.2018.09.04.08.44.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 08:44:21 -0700 (PDT)
Message-ID: <cd137e88c9e882200c08c7336aa7b5a1c84a7ba3.camel@redhat.com>
Subject: Re: POSIX violation by writeback error
From:   Jeff Layton <jlayton@redhat.com>
To:     =?UTF-8?Q?=E7=84=A6=E6=99=93=E5=86=AC?= <milestonejxd@gmail.com>
Cc:     R.E.Wolff@bitwizard.nl, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 04 Sep 2018 11:44:20 -0400
In-Reply-To: <CAJDTihw7T8WLme09W8VHCRfiALq4fxg1ZsywcSjn6hXsAw5wRw@mail.gmail.com>
References: <CAJDTihz-rFb2SGaxZsQnXGnee_2qW_ynhPe=tZ4yzQBSV_KQ1g@mail.gmail.com>
         <20180904075347.GH11854@BitWizard.nl>
         <CAJDTihzqn3whQ47uUOxGYk4Je4S10ehNEQCtfb=j--iCsdDqgQ@mail.gmail.com>
         <82ffc434137c2ca47a8edefbe7007f5cbecd1cca.camel@redhat.com>
         <CAJDTihw7T8WLme09W8VHCRfiALq4fxg1ZsywcSjn6hXsAw5wRw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-09-04 at 22:56 +0800, 焦晓冬 wrote:
> On Tue, Sep 4, 2018 at 7:09 PM Jeff Layton <jlayton@redhat.com> wrote:
> > 
> > On Tue, 2018-09-04 at 16:58 +0800, Trol wrote:
> > > On Tue, Sep 4, 2018 at 3:53 PM Rogier Wolff <R.E.Wolff@bitwizard.nl> wrote:
> > > 
> > > ...
> > > > > 
> > > > > Jlayton's patch is simple but wonderful idea towards correct error
> > > > > reporting. It seems one crucial thing is still here to be fixed. Does
> > > > > anyone have some idea?
> > > > > 
> > > > > The crucial thing may be that a read() after a successful
> > > > > open()-write()-close() may return old data.
> > > > > 
> > > > > That may happen where an async writeback error occurs after close()
> > > > > and the inode/mapping get evicted before read().
> > > > 
> > > > Suppose I have 1Gb of RAM. Suppose I open a file, write 0.5Gb to it
> > > > and then close it. Then I repeat this 9 times.
> > > > 
> > > > Now, when writing those files to storage fails, there is 5Gb of data
> > > > to remember and only 1Gb of RAM.
> > > > 
> > > > I can choose any part of that 5Gb and try to read it.
> > > > 
> > > > Please make a suggestion about where we should store that data?
> > > 
> > > That is certainly not possible to be done. But at least, shall we report
> > > error on read()? Silently returning wrong data may cause further damage,
> > > such as removing wrong files since it was marked as garbage in the old file.
> > > 
> > 
> > Is the data wrong though? You tried to write and then that failed.
> > Eventually we want to be able to get at the data that's actually in the
> > file -- what is that point?
> 
> The point is silently data corruption is dangerous. I would prefer getting an
> error back to receive wrong data.
> 

Well, _you_ might like that, but there are whole piles of applications
that may fall over completely in this situation. Legacy usage matters
here.

> A practical and concrete example may be,
> A disk cleaner program that first searches for garbage files that won't be used
> anymore and save the list in a file (open()-write()-close()) and wait for the
> user to confirm the list of files to be removed.  A writeback error occurs
> and the related page/inode/address_space gets evicted while the user is
> taking a long thought about it. Finally, the user hits enter and the
> cleaner begin
> to open() read() the list again. But what gets removed is the old list
> of files that
> was generated several months ago...
> 
> Another example may be,
> An email editor and a busy mail sender. A well written mail to my boss is
> composed by this email editor and is saved in a file (open()-write()-close()).
> The mail sender gets notified with the path of the mail file to queue it and
> send it later. A writeback error occurs and the related
> page/inode/address_space gets evicted while the mail is still waiting in the
> queue of the mail sender. Finally, the mail file is open() read() by the sender,
> but what is sent is the mail to my girlfriend that was composed yesterday...
> 
> In both cases, the files are not meant to be persisted onto the disk.
> So, fsync()
> is not likely to be called.
> 

So at what point are you going to give up on keeping the data? The
fundamental problem here is an open-ended commitment. We (justifiably)
avoid those in kernel development because it might leave the system
without a way out of a resource crunch.

> > 
> > If I get an error back on a read, why should I think that it has
> > anything at all to do with writes that previously failed? It may even
> > have been written by a completely separate process that I had nothing at
> > all to do with.
> > 
> > > As I can see, that is all about error reporting.
> > > 
> > > As for suggestion, maybe the error flag of inode/mapping, or the entire inode
> > > should not be evicted if there was an error. That hopefully won't take much
> > > memory. On extreme conditions, where too much error inode requires staying
> > > in memory, maybe we should panic rather then spread the error.
> > > 
> > > > 
> > > > In the easy case, where the data easily fits in RAM, you COULD write a
> > > > solution. But when the hardware fails, the SYSTEM will not be able to
> > > > follow the posix rules.
> > > 
> > > Nope, we are able to follow the rules. The above is one way that follows the
> > > POSIX rules.
> > > 
> > 
> > This is something we discussed at LSF this year.
> > 
> > We could attempt to keep dirty data around for a little while, at least
> > long enough to ensure that reads reflect earlier writes until the errors
> > can be scraped out by fsync. That would sort of redefine fsync from
> > being "ensure that my writes are flushed" to "synchronize my cache with
> > the current state of the file".
> > 
> > The problem of course is that applications are not required to do fsync
> > at all. At what point do we give up on it, and toss out the pages that
> > can't be cleaned?
> > 
> > We could allow for a tunable that does a kernel panic if writebacks fail
> > and the errors are never fetched via fsync, and we run out of memory. I
> > don't think that is something most users would want though.
> > 
> > Another thought: maybe we could OOM kill any process that has the file
> > open and then toss out the page data in that situation?
> > 
> > I'm wide open to (good) ideas here.
> 
> As I said above, silently data corruption is dangerous and maybe we really
> should report errors to user space even in desperate cases.
> 
> One possible approach may be:
> 
> - When a writeback error occurs, mark the page clean and remember the error
> in the inode/address_space of the file.
> I think that is what the kernel is doing currently.
> 

Yes.

> - If the following read() could be served by a page in memory, just returns the
> data. If the following read() could not be served by a page in memory and the
> inode/address_space has a writeback error mark, returns EIO.
> If there is a writeback error on the file, and the request data could
> not be served
> by a page in memory, it means we are reading a (partically) corrupted
> (out-of-data)
> file. Receiving an EIO is expected.
> 

No, an error on read is not expected there. Consider this:

Suppose the backend filesystem (maybe an NFSv3 export) is really r/o,
but was mounted r/w. An application queues up a bunch of writes that of
course can't be written back (they get EROFS or something when they're
flushed back to the server), but that application never calls fsync.

A completely unrelated application is running as a user that can open
the file for read, but not r/w. It then goes to open and read the file
and then gets EIO back or maybe even EROFS.

Why should that application (which did zero writes) have any reason to
think that the error was due to prior writeback failure by a completely
separate process? Does EROFS make sense when you're attempting to do a
read anyway?

Moreover, what is that application's remedy in this case? It just wants
to read the file, but may not be able to even open it for write to issue
an fsync to "clear" the error. How do we get things moving again so it
can do what it wants?

I think your suggestion would open the floodgates for local DoS attacks.

> - We refuse to evict inodes/address_spaces that is writeback error marked. If
> the number of writeback error marked inodes reaches a limit, we shall
> just refuse
> to open new files (or refuse to open new files for writing) .
> That would NOT take as much memory as retaining the pages themselves as
> it is per file/inode rather than per byte of the file. Limiting the
> number of writeback
> error marked inodes is just like limiting the number of open files
> we're currently
> doing
> 

This was one of the suggestions at LSF this year.

That said, we can't just refuse to evict those inodes, as we may
eventually need the memory. We may have to settle for prioritizing
inodes that can be cleaned for eviction, and only evict the ones that
can't when we have no other choice.

Denying new opens is also a potentially helpful for someone wanting to
do a local DoS attack.

> - Finally, after the system reboots, programs could see (partially)
> corrupted (out-of-data) files. Since user space programs didn't mean to
> persist these files (didn't call fsync()), that is fairly reasonable.

-- 
Jeff Layton <jlayton@redhat.com>

