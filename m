Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F1AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54FA20840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TnhbWGzc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730727AbfAPVhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:37:17 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48178 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729361AbfAPVhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:37:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WElwlgattYoyktBhy+K/w+lEiDAr/L74bbJ6s/TGJko=; b=TnhbWGzcioiTXrxCV9HeTPY8Z
        7W10J4Y+hXWi3Oao3lDDNAImCE7cqCuFXNUvbHVgh6LQ6n0oPQPtHtp2+yVW+wz5OpUIE/CP+r83Y
        tg1qChi5OmqwKmTirtgTHuP6lsj5QTslnKQrQO+vkhCsd4L174ZwwZT7LkqUHRRYh29y6Ic/Nq4Cp
        kW4fOPikbvzV2lXRhvNaPwgr065HZnoQqSrviEIdeYB2V5V9W1dFHY87hMVYBLxaR4bywBJ86/LJy
        7dzR2DeV1SWHm/16aAopJKsVT2u03kvs9umOrGaaY1R+2tKOCVcwRB1YWkp7j3XLM1lZqHs1iBp9m
        Og/mjCY5Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gjss0-0007nl-U2; Wed, 16 Jan 2019 21:37:08 +0000
Date:   Wed, 16 Jan 2019 13:37:08 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Josh Snyder <joshs@netflix.com>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
Message-ID: <20190116213708.GN6310@bombadil.infradead.org>
References: <CAHk-=wip2CPrdOwgF0z4n2tsdW7uu+Egtcx9Mxxe3gPfPW_JmQ@mail.gmail.com>
 <5c3e7de6.1c69fb81.4aebb.3fec@mx.google.com>
 <CAHk-=wgF9p9xNzZei_-ejGLy1bJf4VS1C5E9_V0kCTEpCkpCTQ@mail.gmail.com>
 <9E337EA6-7CDA-457B-96C6-E91F83742587@amacapital.net>
 <CAHk-=wjqkbjL2_BwUYxJxJhdadiw6Zx-Yu_mK3E6P7kG3wSGcQ@mail.gmail.com>
 <20190116054613.GA11670@nautica>
 <CAHk-=wjVjecbGRcxZUSwoSgAq9ZbMxbA=MOiqDrPgx7_P3xGhg@mail.gmail.com>
 <nycvar.YFH.7.76.1901161710470.6626@cbobk.fhfr.pm>
 <CAHk-=wgsnWvSsMfoEYzOq6fpahkHWxF3aSJBbVqywLa34OXnLg@mail.gmail.com>
 <nycvar.YFH.7.76.1901162120000.6626@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1901162120000.6626@cbobk.fhfr.pm>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 09:23:04PM +0100, Jiri Kosina wrote:
> On Thu, 17 Jan 2019, Linus Torvalds wrote:
> > As I suggested earlier in the thread, the fix for RWF_NOWAIT might be
> > to just move the test down to after readahead.

Your patch 3/3 just removes the test.  Am I right in thinking that it
doesn't need to be *moved* because the existing test after !PageUptodate
catches it?

Of course, there aren't any tests for RWF_NOWAIT in xfstests.  Are there
any in LTP?

Some typos in the commit messages:

> Another aproach (checking file access permissions in order to decide
"approach"

> Subject: [PATCH 2/3] mm/mincore: make mincore() more conservative
> 
> The semantics of what mincore() considers to be resident is not completely
> clearar, but Linux has always (since 2.3.52, which is when mincore() was
"clear"

> initially done) treated it as "page is available in page cache".
> 
> That's potentially a problem, as that [in]directly exposes meta-information
> about pagecache / memory mapping state even about memory not strictly belonging
> to the process executing the syscall, opening possibilities for sidechannel
> attacks.
> 
> Change the semantics of mincore() so that it only reveals pagecache information
> for non-anonymous mappings that belog to files that the calling process could
"belong"

