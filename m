Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF56C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 04:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 866782070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 04:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfAGEcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 23:32:45 -0500
Received: from nautica.notk.org ([91.121.71.147]:45534 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbfAGEcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 23:32:45 -0500
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 44190C009; Mon,  7 Jan 2019 05:32:42 +0100 (CET)
Date:   Mon, 7 Jan 2019 05:32:27 +0100
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Jann Horn <jannh@google.com>,
        Jiri Kosina <jikos@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
Message-ID: <20190107043227.GA3325@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiT=ov+6zYcnw_64ihYf74Amzqs67iVGtJMQq65PxiVYw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote on Sat, Jan 05, 2019:
> But I think my patch to just rip out all that page lookup, and just
> base it on the page table state has the fundamental advantage that it
> gets rid of code. Maybe I should jst commit it, and see if anything
> breaks? We do have options in case things break, and then we'd at
> least know who cares (and perhaps a lot more information of _why_ they
> care).

There actually are many tools like fincore which depend on mincore to
try to tell whether a file is "loaded in cache" or not (I personally use
vmtouch[1], but I know of at least nocache[2] uses it as well to only
try to evict used pages)

[1] https://hoytech.com/vmtouch/
[2] https://github.com/Feh/nocache


I mostly use these to either fadvise(POSIX_FADV_DONTNEED) or
prefetch/lock whole files so my "production" use-cases don't actually
rely on the mincore part of them; but when playing with these actions
it's actually fairly useful to be able to visualize which part of a file
ended in cache or monitor how a file's content evolve in cache...

There are various non-obvious behaviours where being able to poke around
is enlightening (e.g. fadvise dontneed is actually a hint, so even if
nothing uses the file linux sometimes keep the data around if it thinks
that would be useful and nocache has a mode to call fadvise multiple
times and things like that...)


Anyway, I agree the use of mincore for this is rather ugly, and
frankly some "cache management API" might be better in the long run if
only for performance reason (don't try these tools on a hundred TB
sparse file...), but until that pipe dream comes true I think mincore as
it was is useful for system admins.



Linus Torvalds wrote on Sun, Jan 06, 2019:
> I decided to just apply that patch. It is *not* marked for stable,
> very intentionally, because I expect that we will need to wait and see
> if there are issues with it, and whether we might have to do something
> entirely different (more like the traditional behavior with some extra
> "only for owner" logic).

FWIW I personally don't care much about "only for owner" or depending on
mmap options; I don't understand much of the security implications
honestly so I'm not sure how these limitations actually help.
On the other hand, a simple CAP_SYS_ADMIN check making the call take
either behaviour should be safe and would cover what I described above.


(by the way, while we are discussing permissions, a regular user can use
fadvise dontneed on files it doesn't own as well as long as it can open
them for reading; I'm not sure if that would need restricting as well in
the context of the security issue. Frankly even with mincore someone
could likely tell the difference through timing, if they just do it a
few times. Do magic, probe, flush out, repeat until satisfied.)


Thanks,
-- 
Dominique Martinet | Asmadeus
