Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240BDC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E9E222F7
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546720986;
	bh=GAwvUo+YWcN7/DvGRXgyekMJvJmRr9k1wmPOILrwkD8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=ViF5LS2P3oppMXild2LKwNVYXLDLhzLCh1JOodRkTwI+Pen9gIEfk2+dDnMZv/CQn
	 s6hgrGdtJtt2IPjLfzfEZue05nI170umQ7jZ2H4/VVmCsqLwM4A4rj33Pr/0ch4sMl
	 REXyJpMxn7nZWTdKdEmb6nIhtJX16i8FvvJDt5QY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfAEUnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 15:43:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:39632 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726267AbfAEUnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 15:43:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 92417AF64;
        Sat,  5 Jan 2019 20:43:03 +0000 (UTC)
Date:   Sat, 5 Jan 2019 21:43:02 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
In-Reply-To: <CAHk-=whGmE4QVr6NbgHnrVGVENfM3s1y6GNbsfh8PcOg=6bpqw@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.1901052131480.16954@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm> <CAHk-=wicks2BEwm1BhdvEj_P3yawmvQuG3NOnjhdrUDEtTGizw@mail.gmail.com> <nycvar.YFH.7.76.1901052108390.16954@cbobk.fhfr.pm> <CAHk-=whGmE4QVr6NbgHnrVGVENfM3s1y6GNbsfh8PcOg=6bpqw@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Jan 2019, Linus Torvalds wrote:

> > I am still not completely sure what to return in such cases though; we can
> > either blatantly lie and always pretend that the pages are resident
> 
> That's what my untested patch did. Or maybe just claim they are all
> not present?

Thinking about it a little bit more, I believe Vlastimil has a good point 
with 'non present' potentially causing more bogus activity in userspace in 
response (in an effort to actually make them present, and failing 
indefinitely).

IOW, I think it's a reasonable expectation that the common scenario is 
"check if it's present, and if not, try to fault it in" instead of "check 
if it's present, and if it is, try to evict it".

> And again, that patch was entirely untested, so it may be garbage and 
> have some fundamental problem. 

I will be travelling for next ~24 hours, but I have just asked our QA guys 
to run it through some basic battery of testing (which will probably 
happen on monday anyway).

> I also don't know exactly what rule might make most sense, but "you can 
> write to the file" certainly to me implies that you also could know what 
> parts of it are in-core.

I think it's reasonable; I can't really imagine any sidechannel to a 
global state be possibly mounted on valid R/W mappings. I'd guess that 
probably the most interesting here are the code segments of shared 
libraries, allowing to trace victim's execution.

> Who actually _uses_ mincore()? That's probably the best guide to what
> we should do. Maybe they open the file read-only even if they are the
> owner, and we really should look at file ownership instead.

Yeah, well

	https://codesearch.debian.net/search?q=mincore

is a bit too much mess to get some idea quickly I am afraid.

-- 
Jiri Kosina
SUSE Labs

