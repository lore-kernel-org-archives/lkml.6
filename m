Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B767DC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 649A220841
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 649A220841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbeICGYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 02:24:16 -0400
Received: from gate.crashing.org ([63.228.1.57]:34807 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbeICGYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 02:24:15 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w830m6pG028765;
        Sun, 2 Sep 2018 19:48:07 -0500
Message-ID: <a1980256cf3d2ea8e91707fcda7cf141b27a212d.camel@kernel.crashing.org>
Subject: Re: Access to non-RAM pages
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jikos@kernel.org>
Cc:     =?ISO-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will.deacon@arm.com>
Date:   Mon, 03 Sep 2018 10:48:05 +1000
In-Reply-To: <CA+55aFyOSLEbiNvPoHkHe8WXae_aJiS+jsnubG8Xk0CYw8U4uw@mail.gmail.com>
References: <3009b28a-971c-920a-9184-900f1f3b2203@suse.com>
         <alpine.LRH.2.00.1808312312480.14475@gjva.wvxbf.pm>
         <CA+55aFyqpg_e8dXZWhdyVLa0xSYcK6iuRTKDXxnFLaFEcqZHkQ@mail.gmail.com>
         <CA+55aFyOSLEbiNvPoHkHe8WXae_aJiS+jsnubG8Xk0CYw8U4uw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-09-01 at 11:06 -0700, Linus Torvalds wrote:
> [ Adding a few new people the the cc.
> 
>   The issue is the worry about software-speculative accesses (ie
> things like CONFIG_DCACHE_WORD_ACCESS - not talking about the hw
> speculation now) accessing past RAM into possibly contiguous IO ]
> 
> On Sat, Sep 1, 2018 at 10:27 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > 
> > If you have a machine with RAM that touches IO, you need to disable
> > the last page, exactly the same way we disable and marked reserved the
> > first page at zero.

So I missed the departure of that train ... stupid question, with
CONFIG_DCACHE_WORD_ACCESS, if that can be unaligned (I assume it can),
what prevents it from crossing into a non-mapped page (not even IO) and
causing an oops ? Looking at a random user in fs/dcache.c its not a
uaccess-style read with recovery.... Or am I missing somethign obvious
here ?

IE, should we "reserve" the last page of any memory region (maybe mark
it read-only) to avoid this along with avoiding leakage into IO space ?

> > I thought we already did that.
> 
> We don't seem to do that.
> 
> And it's not just the last page, it's _any_ last page in a region that
> bumps up to IO. That's actually much more common in the low 4G area on
> PC's, I suspect, although the reserved BIOS ranges always tend to be
> there.

What makes IO more "wrong" than oopsing due to the page not being
mapped ?

> I suspect it should be trivial to do - maybe in
> e820__memblock_setup()? That's where we already trim partial pages
> etc.
>
> In fact, I think this might be done as an extension of commit
> 124049decbb1 ("x86/e820: put !E820_TYPE_RAM regions into
> memblock.reserved"), except making sure that non-RAM regions mark one
> page _previous_ as reserved too.
> 
> I assume memory hotplug might have the same issue, and checking
> whether ARM64 and powerpc perhaps might have already done something
> like this (or might need to add it).
> 
> We discussed long ago the case of user space mapping IO in user space,
> and decided we didn't care. But the kernel should probably explicitly
> make sure we don't either, even if I can't recall having ever seen a
> machine that actually maps IO contiguously to RAM. The layout always
> tends to end up having holes anyway.

Can't we put the safety in generic memblock ? IE, don't hand out an
allocation that contain the last page of a "block" and handle that last
page in the memblock->buddy transition rather than in arch specific
code ?

Cheers,
Ben.


