Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6084C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C492177B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SUCuwoWE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbfAJOrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 09:47:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47496 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbfAJOrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 09:47:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ANYXKevTAinQDIHwIVYZJui5pV72A9ueV8/mDNkD+pg=; b=SUCuwoWEFo94cxwC+gtxmafZv
        3MdF5HmXFjSUUvdC/nOyvh24C2iLWjVxYFRFl/IAUy1M01/1BS1i6ycRAQqmdhn7kAG7ynm7DHfc+
        TpNxWYpxqQnoXpqRcAP75p5EqBLp3uz7DX7bZNiTaG3oJJ6dBw5lkbT1Su5fn1qOc/ILOo0JXsfTr
        uW0lDMJGFFhff+N1y/HDpXEVHTFbHS88ZrDNDw6zfwkJ3iMBZTAabxVIJHEPVOxSwkcToF/uB3O+j
        H7UWsBsuIX/TfF3aPFv8ChvU77DftooWpoRYnvKF0u5U3RMQ6+jfA6kgy3m7DmznCXl1RVr31n6T9
        yTD3kT3Xg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ghbbz-0007H9-E4; Thu, 10 Jan 2019 14:47:11 +0000
Date:   Thu, 10 Jan 2019 06:47:11 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Jiri Kosina <jikos@kernel.org>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
Message-ID: <20190110144711.GV6310@bombadil.infradead.org>
References: <CAHk-=wiqbKEC5jUXr3ax+oUuiRrp=QMv_ZnUfO-SPv=UNJ-OTw@mail.gmail.com>
 <20190108044336.GB27534@dastard>
 <CAHk-=wjvzEFQcTGJFh9cyV_MPQftNrjOLon8YMMxaX0G1TLqkg@mail.gmail.com>
 <20190109022430.GE27534@dastard>
 <nycvar.YFH.7.76.1901090326460.16954@cbobk.fhfr.pm>
 <20190109043906.GF27534@dastard>
 <CAHk-=wic28fSkwmPbBHZcJ3BGbiftprNy861M53k+=OAB9n0=w@mail.gmail.com>
 <20190110004424.GH27534@dastard>
 <CAHk-=wg1jSQ-gq-M3+HeTBbDs1VCjyiwF4gqnnBhHeWizyrigg@mail.gmail.com>
 <CALCETrWxwaBUYMg=aLySJByMgXzuzV4gHS0n6O6Oet2Jm6SAbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWxwaBUYMg=aLySJByMgXzuzV4gHS0n6O6Oet2Jm6SAbw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 09:26:41PM -0800, Andy Lutomirski wrote:
> Since direct IO has been brought up, I have a question.  I've wondered
> for years why direct IO works the way it does.  If I were implementing
> it from scratch, my first inclination would be to use the page cache
> instead of fighting it.  To do a single-page direct read, I would look
> that page up in the page cache (i.e. i_pages these days).  If the page
> is there, I would do a normal buffered read.  If the page is not
> there, I would insert a record into i_pages indicating that direct IO
> is in progress and then I would do the IO into the destination page.
> If any other read, direct or otherwise, sees a record saying "under
> direct IO", it would wait.

OK, you're in the same ballpark I am ;-)  Kent Overstreet pointed out
that what you want to do here is great for the mixed case, but it's
pretty inefficient for IOs to files which are wholly uncached.

So what I'm currently thinking about is an rwsem which works like this:

O_DIRECT task:
if i_pages is empty, take rwsem for read, recheck i_pages is empty, do IO,
drop rwsem.
if i_pages is not empty, insert XA_LOCK_ENTRY, when IO complete, wake waitqueue for that (mapping, index).

buffered IO:
if i_pages is empty, take rwsem for write, allocate page, insert page, drop rwsem.
if i_pages is not empty, look up index, if entry is XA_LOCK_ENTRY sleep on
waitqueue. otherwise proceed as now.

