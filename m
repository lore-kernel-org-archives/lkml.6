Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E03DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14C620868
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E14C620868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeICSRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 14:17:06 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43324 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbeICSRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 14:17:06 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fwpLI-0005Ai-Uk; Mon, 03 Sep 2018 13:56:37 +0000
Date:   Mon, 3 Sep 2018 14:56:36 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-doc@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>
Subject: Re: [PATCH v6 11/11] arm64: annotate user pointers casts detected by
 sparse
Message-ID: <20180903135636.GL19965@ZenIV.linux.org.uk>
References: <cover.1535629099.git.andreyknvl@google.com>
 <5d54526e5ff2e5ad63d0dfdd9ab17cf359afa4f2.1535629099.git.andreyknvl@google.com>
 <20180831081123.6mo62xnk54pvlxmc@ltop.local>
 <20180831134244.GB19965@ZenIV.linux.org.uk>
 <CAAeHK+w86m6YztnTGhuZPKRczb-+znZ1hiJskPXeQok4SgcaOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+w86m6YztnTGhuZPKRczb-+znZ1hiJskPXeQok4SgcaOw@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 02:34:27PM +0200, Andrey Konovalov wrote:

> > Al, very annoyed by that kind of information-hiding crap...
> 
> This patch only adds __force to hide the reports I've looked at and
> decided that the code does the right thing. The cases where this is
> not the case are handled by the previous patches in the patchset. I'll
> this to the patch description as well. Is that OK?

I don't know about you, but personally I've run into "I've looked,
I'm sure it's OK here" -> (a year or so later) "why is it OK, again?
Oh, bugger..." quite a few times.  Some, but not all, hadn't been
OK all along, some used to be but got quietly broken by subsequent
changes by people who had no idea that some property of implementation
was critical for correctness in the place in question, some (even
more embarrassingly) were broken by a patch of my own.

It happens.  "Looked in there, decided that the warning was bogus and
quietly shut it up" has turned out to be a source of trouble down the
road a lot of times.  If you are forcibly removing a warning (not by
reorganizing the logics and annotations, that is - by force-cast, or
something similar to it), leave behind something more useful than
"On $DATE I've decided it was OK" (and even that - only accessible via
git blame/git show).  As a hint for yourself, if nothing else - you
might end up asking yourself the same question a year or two (or twenty,
for that matter) later while looking for likely source of odd breakage
and trying to narrow the search down.

Force-cast conflates a *lot* of situations together - it's pretty much
"fuck off, I know what's going on here, it's OK" and no more than that;
hell, even the warning it removes would've carried more information...

That kind of "these are false positives, let's turn them off to search for
real problems" patches is fine when developing a branch like that; it's
leaving them in for posterity that tends to cause PITA...

I'm not attacking you, BTW - it's really a generic point re force-casts.
There had been some really outrageous cases lately[1] and I think that
this point does need to be made.  Unexplained force-cast is worse than
leaving a warning in.

[1] with, if my reading of the situation is correct,
	newbie asking maintainers if dealing with endianness warnings in
a certain driver would be useful
	newbie getting told (perhaps by maintainers, perhaps by somebody else)
that those were all noise, the driver's correct and the most useful thing to
be done with them would be to make them STFU
	force-cast-laden patch from said newbie doing just that picked by said
maintainers, "cleaning up" the warnings.  And committed with authorship pinned
to the newbie ;-/
Not nice, seeing that the code in driver is *not* correct, despite the high-handed
"shut that noise off, everything's fine there" commit - undoing that "cleanup" and
trying to redo annotations properly starts to converge on absolutely real bugs on
b-e hosts in about 10 minutes.  In PCIe driver, with devices existing as separate
cards, not just something always embedded into x86 or arm motherboard...
