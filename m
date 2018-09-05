Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7F4C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CB322073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CB322073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeIEPZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 11:25:00 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:34919 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbeIEPY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 11:24:59 -0400
Received: by mail-yb1-f195.google.com with SMTP id o17-v6so2501867yba.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 03:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7B2v2hHSg+KboroGP/trjmfTfA11ZB66khXAHYGBKPY=;
        b=BxzNp09qBAEuRGJ+XNLR8rmqpkYfEBT9fZ+UfDwpzmkzyvgpl39QLZo3xYDXVavPqx
         GMKGMt4bTvXTD7v+BzhXahiYkVwSk85RPFuNhDJP6zthVaGoX6F/+Rwvz9HGX8qrI0Vg
         Stwl2at7/6N2yb9mflz9cACr/WQv/l3TjuOh+fBFXW+sCP5k5JDkVQdJH5qiQWN/D4F6
         bk0GDJpwX6jGIC4+DeLlhS/hCQbLaLkQ0VUfGHRPrspGespuA0DthtVGmGqfyXvKgKb7
         Ls2xPzQxwUJQvqyvhhNLwfTdD3CH4T++M1yoax06hctK5u7ClmNWlNUqM49lizs+od1C
         Jq9A==
X-Gm-Message-State: APzg51B9DAMuIihyx7hSgDHklMzUB2jKedpznX0V4ut5jIMcn4XLP6g3
        OQAfjNR+hwjdZWvSX1qsJAYEnQ==
X-Google-Smtp-Source: ANB0VdalPRNATOGLBzliSEewvObeiiw41t7jE8EijYfe9SODpwyWacID+6LDTduZg541xyJbfGtBVA==
X-Received: by 2002:a25:945:: with SMTP id u5-v6mr13998401ybm.300.1536144917644;
        Wed, 05 Sep 2018 03:55:17 -0700 (PDT)
Received: from tleilax.poochiereds.net (cpe-2606-A000-1100-DB-0-0-0-E2E.dyn6.twc.com. [2606:a000:1100:db::e2e])
        by smtp.gmail.com with ESMTPSA id x133-v6sm527170ywg.49.2018.09.05.03.55.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 03:55:17 -0700 (PDT)
Message-ID: <09ba078797a1327713e5c2d3111641246451c06e.camel@redhat.com>
Subject: Re: POSIX violation by writeback error
From:   Jeff Layton <jlayton@redhat.com>
To:     =?UTF-8?Q?=E7=84=A6=E6=99=93=E5=86=AC?= <milestonejxd@gmail.com>
Cc:     bfields@fieldses.org, R.E.Wolff@bitwizard.nl,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 05 Sep 2018 06:55:15 -0400
In-Reply-To: <CAJDTihxE07BuXMBmShXuj=TbJCK1mq3ZMFMxP1-T=xjhPF5ySw@mail.gmail.com>
References: <CAJDTihz-rFb2SGaxZsQnXGnee_2qW_ynhPe=tZ4yzQBSV_KQ1g@mail.gmail.com>
         <20180904075347.GH11854@BitWizard.nl>
         <CAJDTihzqn3whQ47uUOxGYk4Je4S10ehNEQCtfb=j--iCsdDqgQ@mail.gmail.com>
         <82ffc434137c2ca47a8edefbe7007f5cbecd1cca.camel@redhat.com>
         <CAJDTihw7T8WLme09W8VHCRfiALq4fxg1ZsywcSjn6hXsAw5wRw@mail.gmail.com>
         <cd137e88c9e882200c08c7336aa7b5a1c84a7ba3.camel@redhat.com>
         <20180904161203.GD17478@fieldses.org> <20180904162348.GN17123@BitWizard.nl>
         <20180904185411.GA22166@fieldses.org>
         <a9d586a8c520e52bad2396b93f8d5cb8a9fd2071.camel@redhat.com>
         <CAJDTihxE07BuXMBmShXuj=TbJCK1mq3ZMFMxP1-T=xjhPF5ySw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-09-05 at 16:24 +0800, 焦晓冬 wrote:
> On Wed, Sep 5, 2018 at 4:18 AM Jeff Layton <jlayton@redhat.com> wrote:
> > 
> > On Tue, 2018-09-04 at 14:54 -0400, J. Bruce Fields wrote:
> > > On Tue, Sep 04, 2018 at 06:23:48PM +0200, Rogier Wolff wrote:
> > > > On Tue, Sep 04, 2018 at 12:12:03PM -0400, J. Bruce Fields wrote:
> > > > > Well, I think the point was that in the above examples you'd prefer that
> > > > > the read just fail--no need to keep the data.  A bit marking the file
> > > > > (or even the entire filesystem) unreadable would satisfy posix, I guess.
> > > > > Whether that's practical, I don't know.
> > > > 
> > > > When you would do it like that (mark the whole filesystem as "in
> > > > error") things go from bad to worse even faster. The Linux kernel
> > > > tries to keep the system up even in the face of errors.
> > > > 
> > > > With that suggestion, having one application run into a writeback
> > > > error would effectively crash the whole system because the filesystem
> > > > may be the root filesystem and stuff like "sshd" that you need to
> > > > diagnose the problem needs to be read from the disk....
> > > 
> > > Well, the absolutist position on posix compliance here would be that a
> > > crash is still preferable to returning the wrong data.  And for the
> > > cases 焦晓冬 gives, that sounds right?  Maybe it's the wrong balance in
> > > general, I don't know.  And we do already have filesystems with
> > > panic-on-error options, so if they aren't used maybe then maybe users
> > > have already voted against that level of strictness.
> > > 
> > 
> > Yeah, idk. The problem here is that this is squarely in the domain of
> > implementation defined behavior. I do think that the current "policy"
> > (if you call it that) of what to do after a wb error is weird and wrong.
> > What we probably ought to do is start considering how we'd like it to
> > behave.
> > 
> > How about something like this?
> > 
> > Mark the pages as "uncleanable" after a writeback error. We'll satisfy
> > reads from the cached data until someone calls fsync, at which point
> > we'd return the error and invalidate the uncleanable pages.
> 
> Totally agree with you.
> 
> > 
> > If no one calls fsync and scrapes the error, we'll hold on to it for as
> > long as we can (or up to some predefined limit) and then after that
> > we'll invalidate the uncleanable pages and start returning errors on
> > reads. If someone eventually calls fsync afterward, we can return to
> > normal operation.
> 
> Agree with you except that using fsync() as `clear_error_mark()` seems
> weird and counter-intuitive.
> 

That is essentially how fsync (and the errseq_t infrastructure) works. 

Once the kernel has hit a wb error, it reports that error to fsync
exactly once per fd. In practice, the errors are not "cleared", but it
appears that way to the fsync caller.

> > 
> > As always though...what about mmap? Would we need to SIGBUS at the point
> > where we'd start returning errors on read()?
> 
> I think SIGBUS to mmap() is the same thing as EIO to read().
> 
> > 
> > Would that approximate the current behavior enough and make sense?
> > Implementing it all sounds non-trivial though...
> 
> No.
> No problem is reported because nowadays we are relying on the
> underlying disk drives. They transparently redirect bad sectors and
> use S.M.A.R.T to waning us long before a real EIO could be seen.
> As to network filesystems, if I'm not wrong, close() op calls fsync()
> inside the implementation. So there is also no problem.

There is no requirement for a filesystem to flush data on close(). In
fact, most local filesystems do not. NFS does, but that's because it has
to in order to provide close-to-open cache consistency semantics.
-- 
Jeff Layton <jlayton@redhat.com>

