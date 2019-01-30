Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E4DC282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39CA120989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548861362;
	bh=3nU+HDU+TGFuihRYoI1wkrgpbvVZG5+rRPSKd7ajSow=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=Gb6Z39RClwbSZbuKKFNuOoyfufjR3Hp4kf5dRf8han6toJud21qlLXs+dHDvkL137
	 ipTL72vM9N5ewIJ8TPC+1FCHFpESYMoZhUcIiZSoWkXll9HpRkNenPsKfykYc3lL/C
	 dDeShaGfEInOY8t2xq/oRRlGVLdlnTq14LL7irgU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731523AbfA3PQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:16:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:43112 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726332AbfA3PQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:16:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 74A5AAF1C;
        Wed, 30 Jan 2019 15:15:58 +0000 (UTC)
Date:   Wed, 30 Jan 2019 16:15:55 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Florian Weimer <fweimer@redhat.com>
cc:     Vlastimil Babka <vbabka@suse.cz>,
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
Subject: Re: [PATCH 2/3] mm/filemap: initiate readahead even if IOCB_NOWAIT
 is set for the I/O
In-Reply-To: <87munii3uj.fsf@oldenburg2.str.redhat.com>
Message-ID: <nycvar.YFH.7.76.1901301614501.6626@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm> <20190130124420.1834-1-vbabka@suse.cz> <20190130124420.1834-3-vbabka@suse.cz> <87munii3uj.fsf@oldenburg2.str.redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019, Florian Weimer wrote:

> > preadv2(RWF_NOWAIT) can be used to open a side-channel to pagecache
> > contents, as it reveals metadata about residency of pages in
> > pagecache.
> >
> > If preadv2(RWF_NOWAIT) returns immediately, it provides a clear "page
> > not resident" information, and vice versa.
> >
> > Close that sidechannel by always initiating readahead on the cache if
> > we encounter a cache miss for preadv2(RWF_NOWAIT); with that in place,
> > probing the pagecache residency itself will actually populate the
> > cache, making the sidechannel useless.
> 
> I think this needs to use a different flag because the semantics are so
> much different.  If I understand this change correctly, previously,
> RWF_NOWAIT essentially avoided any I/O, and now it does not.

It still avoid synchronous I/O, due to this code still being in place:

                if (!PageUptodate(page)) {
                        if (iocb->ki_flags & IOCB_NOWAIT) {
                                put_page(page);
                                goto would_block;
                        }

but goes the would_block path only after initiating asynchronous 
readahead.

-- 
Jiri Kosina
SUSE Labs

