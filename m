Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDB0C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5AD420651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WKlxAEXz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392770AbfAPMgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 07:36:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39368 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390065AbfAPMgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 07:36:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/lZp/LiztmwJqQc2EnDobX8v8UA9Y/6UeG0tcWzhA7o=; b=WKlxAEXzMYkrZBynkoizTbbmK
        CS3lD8KnOKnPCmoc1P0PbUy1WNx6QVAq3t4WPtBL22w0njy7+hios7Cv9JqpYTWKjznixRGtiMlMv
        3J2lAYVUD7tK2yaYAPUytJIUCXB7RKI7PSt9o9N60TutaIAhsIg7i8Iri3xLAY41teUio+hEFOOkT
        PTFV2H8h8mZ5lYeDavWv+3G523MUs5CDrpW5230JPBbduIFY8+ytJ1TaylOXkjoHR6MZUux1zRKrw
        CuX3koOjuGDYZudCByMlLMlLhYdwvVB8WDJV2x1cv5Xm1BAWC+At4ClOQP1hEZV0WWhtP7+nHJg+Y
        /GnpXcL+g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gjkQS-0006GZ-4h; Wed, 16 Jan 2019 12:36:08 +0000
Date:   Wed, 16 Jan 2019 04:36:07 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Josh Snyder <joshs@netflix.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Dave Chinner <david@fromorbit.com>,
        Jiri Kosina <jikos@kernel.org>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
Message-ID: <20190116123607.GG6310@bombadil.infradead.org>
References: <20190109043906.GF27534@dastard>
 <CAHk-=wic28fSkwmPbBHZcJ3BGbiftprNy861M53k+=OAB9n0=w@mail.gmail.com>
 <20190110004424.GH27534@dastard>
 <CAHk-=wg1jSQ-gq-M3+HeTBbDs1VCjyiwF4gqnnBhHeWizyrigg@mail.gmail.com>
 <20190110070355.GJ27534@dastard>
 <CAHk-=wigwXV_G-V1VxLs6BAvVkvW5=Oj+xrNHxE_7yxEVwoe3w@mail.gmail.com>
 <20190110122442.GA21216@nautica>
 <CAHk-=wip2CPrdOwgF0z4n2tsdW7uu+Egtcx9Mxxe3gPfPW_JmQ@mail.gmail.com>
 <5c3e7de6.1c69fb81.4aebb.3fec@mx.google.com>
 <CAHk-=wgF9p9xNzZei_-ejGLy1bJf4VS1C5E9_V0kCTEpCkpCTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgF9p9xNzZei_-ejGLy1bJf4VS1C5E9_V0kCTEpCkpCTQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 05:00:25PM +1200, Linus Torvalds wrote:
> And if you're not the owner of the file, do you have another
> suggestion for that "Yes, I have the right to see what's in-core for
> this file". Because the problem is literally that if it's some random
> read-only system file, the kernel shouldn't leak access patterns to
> it..

This probably isn't a good heuristic, but thought I'd mention it
anyway ...  if the file is executable and you're not the owner, mincore
always/never says its pages are resident.  That'd fix all library leaks,
but then there's probably a smart way of figuring out something from
access patterns to a data file of some kind (/etc/passwd?)
