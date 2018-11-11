Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9390AC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 11:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F0B820871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 11:11:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F0B820871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbeKKVAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 16:00:11 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:41866 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727440AbeKKVAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 16:00:11 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id wABBBhdp004380;
        Sun, 11 Nov 2018 12:11:43 +0100
Date:   Sun, 11 Nov 2018 12:11:43 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Daniel Colascione <dancol@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Florian Weimer <fweimer@redhat.com>,
        "Carlos O'Donell" <carlos@redhat.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>
Subject: Re: Official Linux system wrapper library?
Message-ID: <20181111111143.GB4189@1wt.eu>
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
 <bbc12da5-830e-99a7-95e3-d9da42947dc9@gmail.com>
 <20181111081725.GA30248@1wt.eu>
 <3664a508-ca74-4ff0-39a6-34543194a24e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3664a508-ca74-4ff0-39a6-34543194a24e@gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 11:53:54AM +0100, Michael Kerrisk (man-pages) wrote:
> I'm not sure I'd view the glibc position quite so harshly (although 
> it is disappointing to me that bug 6399 remains open). I think they
> are simply short of people to work on this task.

I think so as well and really have great respect for this limitation,
which differs from the technical arguments on the bugzilla trying to
find every single good reason why using this syscall was wrong.

(...)
> A converse question that one could ask is: why did a culture
> evolve whereby kernel developers don't take responsibility for
> working with the major libc to ensure that wrappers are added as
> part of the job of adding each new system call? Yes, I know, there
> are some historical reasons (and even today, IMO, they do 
> themselves no favors by requiring a CLA), but glibc really is 
> a different place today, compared to where it was a few years 
> ago.

I think the issue is a bit more complex :
  - linux doesn't support a single libc
  - glibc doesn't support a single OS

In practice we all know (believe?) that both statements above are
true but in practice 99% of the time there's a 1:1 relation between
these two components. What we'd really need would be to have the libc
interface as part of the operating system itself. I'm perfectly fine
with glibc providing all the "high-level" stuff like strcpy(), FILE*
operations etc, and all this probably is mostly system-independent.
But the system interface could possibly be handled easier in the
system itself, which would also provide a smoother adoption of new
syscalls and API updates. It would also limit the hassle required to
provide new syscalls, as if you start to have to contribute to two
projects at once for a single syscall, it becomes really painful.

But I don't know what changes that would require and it could really
turn out that in the end I'm totally wrong about the expected benefits.

Cheers,
Willy
