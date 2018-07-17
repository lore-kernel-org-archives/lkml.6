Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25D0ECDFB4
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D2E20693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="mC662TQS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D2E20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730821AbeGQVqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:46:39 -0400
Received: from imap.thunk.org ([74.207.234.97]:53832 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729728AbeGQVqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=aR8IN/I9vH6lZ4h6A4eIkZqJQ04pImcCd8A1opg9Pus=; b=mC662TQSPOtNHPxRnrnNuW2olj
        08eV1PgxBX2618dTye+7SGMtEa3czgKHFjH035EfBZ0gub3Z73FzeapXZNzunSVSRWv44vRE0az6t
        DeNvMb6D6/UEjjF5lxuSCjtQhGzzNCkHlpaUPN69S6htifUxZfkEYjp26Eqq91LTUwmA=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1ffXGP-0007Sl-Ps; Tue, 17 Jul 2018 21:12:06 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 590A57A63EE; Tue, 17 Jul 2018 16:26:35 -0400 (EDT)
Date:   Tue, 17 Jul 2018 16:26:35 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>, tcharding <me@tobin.cc>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eric Biggers <ebiggers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] random: fix rdrand mix-in
Message-ID: <20180717202635.GA3489@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>, tcharding <me@tobin.cc>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eric Biggers <ebiggers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180717135307.3713325-1-arnd@arndb.de>
 <CA+55aFxjx+naf3vQ++kqxBNS=dvevPebcKOzA=OYWfMJZ2CrzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFxjx+naf3vQ++kqxBNS=dvevPebcKOzA=OYWfMJZ2CrzA@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 09:26:00AM -0700, Linus Torvalds wrote:
> On Tue, Jul 17, 2018 at 6:54 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > The newly added arch_get_random_int() call was done incorrectly,
> > using the output only if rdrand hardware was /not/ available. The
> > compiler points out that the data is uninitialized in this case:

Yeah, oops.  I had sent it for review to linux-crypto two days ago,
and no one had caught it there --- so thanks so much for catching it,
Arnd!  I'm going to fold this into the existing patch so it's easier
to get this sent to stable.

> >                 for (b = bytes ; b > 0 ; b -= sizeof(__u32), i++) {
> > -                       if (arch_get_random_int(&t))
> > +                       if (!arch_get_random_int(&t))
> >                                 continue;
> >                         buf[i] ^= t;
> >                 }
> 
> Why not just make that "continue" be a "break"? If you fail once, you
> will fail the next time too (whether the arch just doesn't support it
> at all, or whether the HW entropy is just temporarily exhausted).

I wasn't sure how quickly the HW entropy would replenish itself; I
know that on first RDRAND platforms it would effectively never fail
(as in if six of the eight cores were calling RDRAND in a tight loop
_maybe_ you could exhaust the HW entropy).  But on more modern systems
with a huge number of cores (say, a 96 core Xeon) HW entropy running
out was much more of a thing.  My impression was it could replenish
itself fairly quickly, so my thinking was continue was better than
break.

The other thing that was a factor in my thinking was this was getting
called from process context, and the process would be burning CPU time
running "Jitterentropy", so it didn't seem like we would be wasting
*that* much CPU time.

It's big deal either way, so I can make it be a break if you think
that's better.

					- Ted
