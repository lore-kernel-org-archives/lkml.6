Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57F9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3663214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3663214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbeJJQmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 12:42:46 -0400
Received: from gate.crashing.org ([63.228.1.57]:33183 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbeJJQmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 12:42:45 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w9A83Vtm025917;
        Wed, 10 Oct 2018 03:03:32 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id w9A83QM4025857;
        Wed, 10 Oct 2018 03:03:26 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 10 Oct 2018 03:03:25 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Richard Biener <rguenther@suse.de>, Michael Matz <matz@suse.de>,
        Borislav Petkov <bp@alien8.de>, gcc@gcc.gnu.org,
        Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Alok Kataria <akataria@vmware.com>,
        Christopher Li <sparse@chrisli.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-sparse@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Message-ID: <20181010080324.GV29268@gate.crashing.org>
References: <20181003213100.189959-1-namit@vmware.com> <20181007091805.GA30687@zn.tnic> <20181007132228.GJ29268@gate.crashing.org> <alpine.LSU.2.21.1810071534220.7867@wotan.suse.de> <20181008073128.GL29268@gate.crashing.org> <alpine.LSU.2.20.1810081105350.16707@zhemvz.fhfr.qr> <20181009145330.GT29268@gate.crashing.org> <alpine.LSU.2.20.1810100909140.16707@zhemvz.fhfr.qr> <20181010072240.GB103159@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010072240.GB103159@gmail.com>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 09:22:40AM +0200, Ingo Molnar wrote:
> * Richard Biener <rguenther@suse.de> wrote:
> > Can kernel folks give this a second and third thought please so we
> > don't implement sth that in the end won't satisfy you guys?
> 
> So this basically passes '0 size' to the inliner, which should be better
> than passing in the explicit size, as we'd inevitably get it wrong
> in cases.

The code immediately after this makes it size 1, even for things like
asm(""), I suppose this works better for the inliner.  But that's a detail
(and it might change); the description says "consider this asm as minimum
length and cost for inlining decisions", which works for either 0 or 1.

> I also like 'size 0' for the reason that we tend to write assembly code
> and mark it 'inline' if we really think it matters to performance,
> so making it more likely to be inlined when used within another inline
> function is a plus as well.

You can think of it as meaning "we want this asm inlined always", and then
whether that actually happens depends on if the function around it is
inlined or not.


Segher
