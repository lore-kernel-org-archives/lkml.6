Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7D3C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 19:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3AA2176D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 19:30:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E3AA2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbeHCV2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 17:28:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38036 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728139AbeHCV2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 17:28:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D89B4BB428;
        Fri,  3 Aug 2018 19:30:37 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B6D402026D65;
        Fri,  3 Aug 2018 19:30:37 +0000 (UTC)
Date:   Fri, 3 Aug 2018 15:30:37 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Zdenek Kabelac <zkabelac@redhat.com>, wgh@torlan.ru,
        Ilya Dryomov <idryomov@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, dm-devel@redhat.com
Subject: Re: LVM snapshot broke between 4.14 and 4.16
Message-ID: <20180803193037.GA4581@redhat.com>
References: <CA+55aFyAox9BTDpRsqLXiROhHOX60aa45LEZ7Azteaumdu11Fw@mail.gmail.com>
 <CAOi1vP-SJO4AMK=XD3Lmja++2dQqoiw6Zn8Vgxf8OfvYgnuC6Q@mail.gmail.com>
 <CA+55aFy2DR9fxHhmGq+azSjX9D71YtLsuFKmoEuYW3uTAUYtJg@mail.gmail.com>
 <d76415de-2056-c7d6-cc88-b896deaa8ead@torlan.ru>
 <1ec0a220-d5b0-1c27-e63b-c4d3f4ce9d77@torlan.ru>
 <CA+55aFyPVQ5-gA93irsaxPC9BNQxnGWrDDHPMUYai2kxKiaKWQ@mail.gmail.com>
 <b2bbd8ec-ac5b-fa8a-d3f7-8615d87f73c3@redhat.com>
 <CA+55aFwWZX=CXmWDTkDGb36kf12XmTehmQjbiMPCqCRG2hi9kw@mail.gmail.com>
 <20180803185431.GB3258@redhat.com>
 <CA+55aFwDEY7B6OMh5xL2wc8BRj1KkzBHggNowAjbsWfma6H5Zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwDEY7B6OMh5xL2wc8BRj1KkzBHggNowAjbsWfma6H5Zg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 03 Aug 2018 19:30:37 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 03 Aug 2018 19:30:37 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'msnitzer@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03 2018 at  3:09pm -0400,
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, Aug 3, 2018 at 11:54 AM Mike Snitzer <snitzer@redhat.com> wrote:
> >
> >
> > As I explained to Ted in my previous reply to this thread: using an lvm2
> > that is of the same vintage of the kernel is generally going to provide
> > a more robust user experience
> 
> You said that yes.
> 
> And it is completely irrelevant.
> 
> The fact is, if you use an older lvm2, then a newer kernel still needs
> to work.  Your "more robust experience" argument has nothing
> what-so-ever to do with that.
> 
> Will you get new features from newer user land tools? Sure, usually.
> And entirely immaterial to a kernel regression.

I was merely giving context for the suggestion of keeping lvm2 updated.
Not saying it was relevant for this regression.
 
> Will newer user land tools hopefully fix other issues? You'd hope so,
> but again - immaterial.
> 
> So why are you bringing up a complete red herring? It's entirely
> immaterial to the actual issue at hand.

I was trying to give context for the "best to update lvm2 anyway"
disclaimer that was used.  Yeah, it was specious.

And Zdenek exposed way more surface area for you to attack with his
reply to this thread.  My initial response to this thread was far more
understated but was effectively: read-only dm-snapshot is rare, I'm
inclined to just let this be.

And yeah, that isn't a good excuse to ignore it but: dm-snapshot is a
steaming pile as compared to dm thin-provisioning so dm-snapshot users
who then go off the beaten path are already masochistic.  SO the 2 users
who noticed can cope..

But that too is a cop-out.

> I would _hope_ that other projects hjave the same "no regressions"
> rule that the kernel has, but I know many don't. But whatever other
> projects are out there, and whatever other rules _they_ have for their
> development is also entirely immaterial to the kernel.
> 
> The kernel has a simple rule: no user regressions.
> 
> Yes, we've had to break that rule very occasionally - when the
> semantics are a huge honking security issue and cannot possibly be
> hidden any other way, then we obviously have to break them.
> 
> So it has happened. It's happily quite rare.
>
> But in this case, the issue is that the block layer now enforces the
> read-only protection more. And it seems to be the case that the lvm
> tools set the read-only flag even when they then depended on being
> able to write to them, because we didn't use to.
> 
> So just judging from that description, I do suspect that "we can't
> depend on the lvm read-only flag", so a patch like
> 
>  "let's not turn DM_READONLY_FLAG into actually set_disk_ro(dm_disk(md), 1)"
> 
> makes sense.
> 
> Obviously, if we can limit that more, that would be lovely.
> 
> But dammit, NOBODY gets to say "oh, you should just update user land tools".

I'll have a closer look at all this.

Could be DM in general is lacking for read-only permissions when you
have complex stacking involved.

> Because when they do, I will explode. And I'm 1000% serious that I
> will refuse to work with people who continue to say that or continue
> to make excuses.
> 
> And user land developers should damn well know about this. The fact
> that they are apparently not clued in about kernel rules is what
> allowed this bug to go undiscovered and unreported for much too long.
> Apparently the lvm2 user land developers *did* notice the breakage,
> but instead of reporting it as a kernel bug, they worked around it.

Yeap, they did.. I was unaware myself.

> So user land developers should actually know that if the kernel stops
> working for them, they should *not* work around it. Sure, fix your
> program, but let the kernel people know.

Agreed.
 
> And kernel people should know that "oh, the user land people already
> changed their behavior" is *not* a "I don't need to care about it".
> Unless the user land fix was so long ago that nobody cares any more.

I never didn't care.  I just didn't care much.  Because "dm-snapshot".

Mike
