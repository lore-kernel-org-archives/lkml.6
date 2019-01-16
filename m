Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB81C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F5D9206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547655151;
	bh=C5QzI+TAn+Ecv52G7Baz+D59cyiUAwsWHP7bZWhgN2s=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=uJL/hJF6AE5733PZE5BiGiHL3pZbDteBZ0fwGlTCAmleSVI6B+TwVb0T/J2mNvYr6
	 eRGX3ldi1nqgkt2vXtOFow2kYCJpu90WBqR8vz/ULRNc0jz4ry4bVruQrudPufKg8M
	 nrq85WIi+ppQJqjK4wxO4e/yT1l08S3TfYj02eMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405336AbfAPQM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:12:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:37634 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727988AbfAPQM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:12:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9553FADC5;
        Wed, 16 Jan 2019 16:12:26 +0000 (UTC)
Date:   Wed, 16 Jan 2019 17:12:24 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Josh Snyder <joshs@netflix.com>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
In-Reply-To: <CAHk-=wjVjecbGRcxZUSwoSgAq9ZbMxbA=MOiqDrPgx7_P3xGhg@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.1901161710470.6626@cbobk.fhfr.pm>
References: <20190110004424.GH27534@dastard> <CAHk-=wg1jSQ-gq-M3+HeTBbDs1VCjyiwF4gqnnBhHeWizyrigg@mail.gmail.com> <20190110070355.GJ27534@dastard> <CAHk-=wigwXV_G-V1VxLs6BAvVkvW5=Oj+xrNHxE_7yxEVwoe3w@mail.gmail.com> <20190110122442.GA21216@nautica>
 <CAHk-=wip2CPrdOwgF0z4n2tsdW7uu+Egtcx9Mxxe3gPfPW_JmQ@mail.gmail.com> <5c3e7de6.1c69fb81.4aebb.3fec@mx.google.com> <CAHk-=wgF9p9xNzZei_-ejGLy1bJf4VS1C5E9_V0kCTEpCkpCTQ@mail.gmail.com> <9E337EA6-7CDA-457B-96C6-E91F83742587@amacapital.net>
 <CAHk-=wjqkbjL2_BwUYxJxJhdadiw6Zx-Yu_mK3E6P7kG3wSGcQ@mail.gmail.com> <20190116054613.GA11670@nautica> <CAHk-=wjVjecbGRcxZUSwoSgAq9ZbMxbA=MOiqDrPgx7_P3xGhg@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2019, Linus Torvalds wrote:

> > "Being owner or has cap" (whichever cap) is probably OK. On the other 
> > hand, writeability check makes more sense in general - could we 
> > somehow check if the user has write access to the file instead of 
> > checking if it currently is opened read-write?
> 
> That's likely the best option. We could say "is it open for write, or
> _could_ we open it for writing?"
> 
> It's a slightly annoying special case, and I'd have preferred to avoid
> it, but it doesn't sound *compilcated*.
> 
> I'm on the road, but I did send out this:
> 
>     https://lore.kernel.org/lkml/CAHk-=wif_9nvNHJiyxHzJ80_WUb0P7CXNBvXkjZz-r1u0ozp7g@mail.gmail.com/
> 
> originally. The "let's try to only do the mmap residency" was the
> optimistic "maybe we can just get rid of this complexity entirely"
> version..
> 
> Anybody willing to test the above patch instead? And replace the
> 
>    || capable(CAP_SYS_ADMIN)
> 
> check with something like
> 
>    || inode_permission(inode, MAY_WRITE) == 0
> 
> instead?
> 
> (This is obviously after you've reverted the "only check mmap
> residency" patch..)

So that seems to deal with mincore() in a reasonable way indeed.

It doesn't unfortunately really solve the preadv2(RWF_NOWAIT), nor does it 
provide any good answer what to do about it, does it?

Thanks,

-- 
Jiri Kosina
SUSE Labs

