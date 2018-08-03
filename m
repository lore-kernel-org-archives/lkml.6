Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7DEC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 18:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E682178F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 18:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E682178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731946AbeHCUwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 16:52:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51532 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728246AbeHCUwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 16:52:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D75DD401EF09;
        Fri,  3 Aug 2018 18:54:31 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A77802142F20;
        Fri,  3 Aug 2018 18:54:31 +0000 (UTC)
Date:   Fri, 3 Aug 2018 14:54:31 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Zdenek Kabelac <zkabelac@redhat.com>, wgh@torlan.ru,
        Ilya Dryomov <idryomov@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, dm-devel@redhat.com
Subject: Re: LVM snapshot broke between 4.14 and 4.16
Message-ID: <20180803185431.GB3258@redhat.com>
References: <CAOi1vP_tYG77e71CdDiOcszSSEWrp9Vfi+KB7yFAXVQChkjP5A@mail.gmail.com>
 <93bff248-6897-4867-841b-2dace11597de@torlan.ru>
 <CA+55aFyAox9BTDpRsqLXiROhHOX60aa45LEZ7Azteaumdu11Fw@mail.gmail.com>
 <CAOi1vP-SJO4AMK=XD3Lmja++2dQqoiw6Zn8Vgxf8OfvYgnuC6Q@mail.gmail.com>
 <CA+55aFy2DR9fxHhmGq+azSjX9D71YtLsuFKmoEuYW3uTAUYtJg@mail.gmail.com>
 <d76415de-2056-c7d6-cc88-b896deaa8ead@torlan.ru>
 <1ec0a220-d5b0-1c27-e63b-c4d3f4ce9d77@torlan.ru>
 <CA+55aFyPVQ5-gA93irsaxPC9BNQxnGWrDDHPMUYai2kxKiaKWQ@mail.gmail.com>
 <b2bbd8ec-ac5b-fa8a-d3f7-8615d87f73c3@redhat.com>
 <CA+55aFwWZX=CXmWDTkDGb36kf12XmTehmQjbiMPCqCRG2hi9kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwWZX=CXmWDTkDGb36kf12XmTehmQjbiMPCqCRG2hi9kw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 03 Aug 2018 18:54:31 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 03 Aug 2018 18:54:31 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'msnitzer@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03 2018 at 12:37pm -0400,
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> [ Dammit. I haven't had to shout and curse at people for a while, but
> this is ABSOLUTELY THE MOST IMPORTANT THING IN THE UNIVERSE WHEN IT
> COMES TO SOFTWARE DEVELOPMENT ]
> 
> On Fri, Aug 3, 2018 at 6:31 AM Zdenek Kabelac <zkabelac@redhat.com> wrote:
> >
> > IMHO (as the author of fixing lvm2 patch) user should not be upgrading kernels
> > and keep running older lvm2 user-land tool (and there are very good reasons
> > for this).
> 
> Yeah, HELL NO!
> 
> Guess what? You're wrong. YOU ARE MISSING THE #1 KERNEL RULE.

Nobody ever said there wasn't breakage.  And yes, Zdenek papered over
the regression introduced by commit 721c7fc701c71 in userspace (lvm2)
rather than sound the alarm that the kernel regressed.

> We do not regress, and we do not regress exactly because your are 100% wrong.

We clearly _do_ regress.  Hence this thread.

> And the reason you state for your opinion is in fact exactly *WHY* you
> are wrong.
> 
> Your "good reasons" are pure and utter garbage.
> 
> The whole point of "we do not regress" is so that people can upgrade
> the kernel and never have to worry about it.
> 
> > Kernel had a bug which has been fixed
> 
> That is *ENTIRELY* immaterial.
> 
> Guys, whether something was buggy or not DOES NOT MATTER.
> 
> Why?
> 
> Bugs happen. That's a fact of life. Arguing that "we had to break
> something because we were fixing a bug" is completely insane. We fix
> tens of bugs every single day, thinking that "fixing a bug" means that
> we can break something is simply NOT TRUE.
> 
> So bugs simply aren't even relevant to the discussion. They happen,
> they get found, they get fixed, and it has nothing to do with "we
> break users".
> 
> Because the only thing that matters IS THE USER.
> 
> How hard is that to understand?

It isn't.

But you're tearing the head off of a userspace developer (Zdenek).

> Anybody who uses "but it was buggy" as an argument is entirely missing
> the point. As far as the USER was concerned, it wasn't buggy - it
> worked for him/her.
> 
> Maybe it worked *because* the user had taken the bug into account,
> maybe it worked because the user didn't notice - again, it doesn't
> matter. It worked for the user.
> 
> Breaking a user workflow for a "bug" is absolutely the WORST reason
> for breakage you can imagine.
> 
> It's basically saying "I took something that worked, and I broke it,
> but now it's better". Do you not see how f*cking insane that statement
> is?
> 
> And without users, your program is not a program, it's a pointless
> piece of code that you might as well throw away.
> 
> Seriously. This is *why* the #1 rule for kernel development is "we
> don't break users". Because "I fixed a bug" is absolutely NOT AN
> ARGUMENT if that bug fix broke a user setup. You actually introduced a
> MUCH BIGGER bug by "fixing" something that the user clearly didn't
> even care about.
> 
> And dammit, we upgrade the kernel ALL THE TIME without upgrading any
> other programs at all. It is absolutely required, because flag-days
> and dependencies are horribly bad.
> 
> And it is also required simply because I as a kernel developer do not
> upgrade random other tools that I don't even care about as I develop
> the kernel, and I want any of my users to feel safe doing the same
> time.
> 
> So no. Your rule is COMPLETELY wrong. If you cannot upgrade a kernel
> without upgrading some other random binary, then we have a problem.

As I explained to Ted in my previous reply to this thread: using an lvm2
that is of the same vintage of the kernel is generally going to provide
a more robust user experience (fixes, features, etc have been
introduced).  But both lvm2 and dm strive to never break users -- just
like the rest of Linux.

Anyway, what would you like done about this block regression?  The
dm-snapshot use-case isn't compelling because it impacts 2 users (that
we know of) but there could be other scenarios (outside of DM) that
could impact more -- though you'd think we'd have heard about them by
now.

Do you want to revert 4.16's commit 721c7fc701c71 ?

Mike
