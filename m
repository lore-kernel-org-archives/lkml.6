Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C4EC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 18:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A69A12089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 18:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A69A12089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbeJDBFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 21:05:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40208 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbeJDBFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 21:05:43 -0400
Received: from localhost (unknown [104.132.0.111])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 00CA2AB2;
        Wed,  3 Oct 2018 18:16:12 +0000 (UTC)
Date:   Wed, 3 Oct 2018 11:16:12 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: Re: [GIT PULL] parisc fixes for kernel v4.19
Message-ID: <20181003181612.GB28575@kroah.com>
References: <20181002210213.GA17826@ls3530.fritz.box>
 <20181002211645.GA6454@kroah.com>
 <ad45f249-e064-d5a4-c658-eaa03bb3a04a@gmx.de>
 <20181002222452.GB11788@kroah.com>
 <dbfa0162-8ed1-b16e-a418-da3b92c76230@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbfa0162-8ed1-b16e-a418-da3b92c76230@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Arnd as he wrote the patch in question here...

On Wed, Oct 03, 2018 at 04:47:30PM +0200, Helge Deller wrote:
> On 03.10.2018 00:24, Greg Kroah-Hartman wrote:
> > On Tue, Oct 02, 2018 at 11:46:11PM +0200, Helge Deller wrote:
> >> Hi Greg,
> >>
> >> On 02.10.2018 23:16, Greg Kroah-Hartman wrote:
> >>> On Tue, Oct 02, 2018 at 11:02:13PM +0200, Helge Deller wrote:
> >>>> please pull a last set of fixes for the parisc architecture for kernel 4.19 from:
> >>>>
> >>>>   git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-4.19-3
> >>>>
> >>>> The major change is for parisc64 to use a 64-bit suseconds_t type to
> >>>> match what glibc expects for 64-bit userspace. It's an ABI change, but
> >>>> since we don't have a 64-bit userspace on parisc yet, it won't introduce
> >>>> a breakage.
> >>>
> >>> Isn't it a bit "late" in the release cycle for such a change?  Why not
> >>> do this on the -rc1 release?
> >>
> >> I've tagged it for stable release.
> >> So, it can go in now, or just wait until -rc1 and go in later.
> > 
> > Why is a major API change a viable stable change?
> 
> Of course it's not.
> Esp. not if an API has been used already.
> IMHO, this case is really different though... 
> 
> > What bugfix does it provide?
> 
> It fixes that code in stable kernels which would return wrong
> time values *if* someone would create a libc for 64-bit parisc
> and would run it with those "stable" kernels.
> Fixing it now has no side-effects, the change is a trivial
> 2-line-removal patch, would bring the code in sync with
> newer kernel source code, and it really fixes existing code. 
> 
> I still believe that this justifies for a backport.
> 
> Nevertheless, if you really disagree, I'm fine dropping the 
> backport to stable and will only push it in the next
> merge window for v4.20.

To clarify, you have no users of this api anywhere (hopefully), and so
the patch in question prevents anyone from using the api in the future.
This makes the suseconds_t handling easier for some reason because only
sparc32 is a "problem" now, right?

So I don't see the "bug" that is being fixed here.  I would have pushed
back on the submission for this for the stable trees as well, this isn't
anything that anyone is using, so there's nothing to "fix" that I can
tell.

Yes, doing it in the "future" is fine, to prevent anyone from making
this mistake (are new machines even being made for this arch?)  But I
don't see how this is a -stable issue.

In this series, only the first patch, would seem to be a real fix, but
even that one isn't.  You are just using a #define for a magic number,
one that will never change either way (the define will never change.) So
that too isn't really a fix, just a code cleanup.

So I am strongly inclined to just not take any of these right now.

thanks,

greg k-h
