Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191A8C4151A
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBBE7218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732165AbfAaKrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:47:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49062 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbfAaKrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:47:31 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0AD4C1393E0;
        Thu, 31 Jan 2019 10:47:31 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-50.ams2.redhat.com [10.36.116.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AAC2A608E5;
        Thu, 31 Jan 2019 10:47:26 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Chinner <david@fromorbit.com>,
        Kevin Easton <kevin@guarana.org>,
        Matthew Wilcox <willy@infradead.org>,
        Cyril Hrubis <chrubis@suse.cz>, Tejun Heo <tj@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Daniel Gruss <daniel@gruss.cc>
Subject: Re: [PATCH 2/3] mm/filemap: initiate readahead even if IOCB_NOWAIT is set for the I/O
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm>
        <20190130124420.1834-1-vbabka@suse.cz>
        <20190130124420.1834-3-vbabka@suse.cz>
        <87munii3uj.fsf@oldenburg2.str.redhat.com>
        <nycvar.YFH.7.76.1901301614501.6626@cbobk.fhfr.pm>
Date:   Thu, 31 Jan 2019 11:47:24 +0100
In-Reply-To: <nycvar.YFH.7.76.1901301614501.6626@cbobk.fhfr.pm> (Jiri Kosina's
        message of "Wed, 30 Jan 2019 16:15:55 +0100 (CET)")
Message-ID: <87imy5f6ir.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 31 Jan 2019 10:47:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Jiri Kosina:

> On Wed, 30 Jan 2019, Florian Weimer wrote:
>
>> > preadv2(RWF_NOWAIT) can be used to open a side-channel to pagecache
>> > contents, as it reveals metadata about residency of pages in
>> > pagecache.
>> >
>> > If preadv2(RWF_NOWAIT) returns immediately, it provides a clear "page
>> > not resident" information, and vice versa.
>> >
>> > Close that sidechannel by always initiating readahead on the cache if
>> > we encounter a cache miss for preadv2(RWF_NOWAIT); with that in place,
>> > probing the pagecache residency itself will actually populate the
>> > cache, making the sidechannel useless.
>> 
>> I think this needs to use a different flag because the semantics are so
>> much different.  If I understand this change correctly, previously,
>> RWF_NOWAIT essentially avoided any I/O, and now it does not.
>
> It still avoid synchronous I/O, due to this code still being in place:
>
>                 if (!PageUptodate(page)) {
>                         if (iocb->ki_flags & IOCB_NOWAIT) {
>                                 put_page(page);
>                                 goto would_block;
>                         }
>
> but goes the would_block path only after initiating asynchronous 
> readahead.

But it wouldn't schedule asynchronous readahead before?

I'm worried that something, say PostgreSQL doing a sequential scan,
would implement a two-pass approach, first using RWF_NOWAIT to process
what's in the kernel page cache, and then read the rest without it.  If
RWF_NOWAIT is treated as a prefetch hint, there could be much more read
activity, and a lot of it would be pointless because the data might have
to be evicted before userspace can use it.

Thanks,
Florian
