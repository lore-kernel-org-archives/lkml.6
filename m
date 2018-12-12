Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D71FC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BDD52084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:29:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BDD52084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbeLLS3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:29:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33512 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727888AbeLLS3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:29:39 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CE0253154875;
        Wed, 12 Dec 2018 18:29:38 +0000 (UTC)
Received: from treble (ovpn-120-195.rdu2.redhat.com [10.10.120.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A16AD60C46;
        Wed, 12 Dec 2018 18:29:36 +0000 (UTC)
Date:   Wed, 12 Dec 2018 12:29:34 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, mhiramat@kernel.org,
        jbaron@akamai.com, Jiri Kosina <jkosina@suse.cz>,
        David.Laight@aculab.com, bp@alien8.de, julia@ni.com,
        jeyu@kernel.org, Peter Anvin <hpa@zytor.com>
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
Message-ID: <20181212182934.4dozqirmfpo3nbml@treble>
References: <20181129124404.2fe55dd0@gandalf.local.home>
 <CAHk-=wgnZobye-KNaBVO-SdqX-5Xkz+i=aJ_kOFZ4RpZFT0HqQ@mail.gmail.com>
 <20181129125857.75c55b96@gandalf.local.home>
 <CAHk-=wigLUgxDM6Dq2aS7efduffratP976Ggmpv4Ev4EOrJxyA@mail.gmail.com>
 <20181129134725.6d86ade6@gandalf.local.home>
 <CAHk-=wgbnQs4fpuHqT1jLkDnKcvTGS5EN8m=qy7oUE5n_fhOig@mail.gmail.com>
 <CAHk-=wjN=sow0F-UtA6DtHHT_CNUV7wYVe3cQ4E8GPp4LN32+Q@mail.gmail.com>
 <CALCETrVzFk2Yv8q54Xh6qOb45AKKrQhD5OkAuTsw9HaR3Wvy4Q@mail.gmail.com>
 <20181129202452.56f4j2wdct6qbaqo@treble>
 <CAHk-=wiO87jDPP8FZ7EfwfbFNQRdr64Pa+g33do7tKiTFYz8BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiO87jDPP8FZ7EfwfbFNQRdr64Pa+g33do7tKiTFYz8BA@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 12 Dec 2018 18:29:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 03:04:20PM -0800, Linus Torvalds wrote:
> On Thu, Nov 29, 2018 at 12:25 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > On Thu, Nov 29, 2018 at 11:27:00AM -0800, Andy Lutomirski wrote:
> > >
> > > I propose a different solution:
> > >
> > > As in this patch set, we have a direct and an indirect version.  The
> > > indirect version remains exactly the same as in this patch set.  The
> > > direct version just only does the patching when all seems well: the
> > > call instruction needs to be 0xe8, and we only do it when the thing
> > > doesn't cross a cache line.  Does that work?  In the rare case where
> > > the compiler generates something other than 0xe8 or crosses a cache
> > > line, then the thing just remains as a call to the out of line jmp
> > > trampoline.  Does that seem reasonable?  It's a very minor change to
> > > the patch set.
> >
> > Maybe that would be ok.  If my math is right, we would use the
> > out-of-line version almost 5% of the time due to cache misalignment of
> > the address.
> 
> Note that I don't think cache-line alignment is necessarily sufficient.
> 
> The I$ fetch from the cacheline can happen in smaller chunks, because
> the bus between the I$ and the instruction decode isn't a full
> cacheline (well, it is _now_ in modern big cores, but it hasn't always
> been).
> 
> So even if the cacheline is updated atomically, I could imagine seeing
> a partial fetch from the I$ (old values) and then a second partial
> fetch (new values).
> 
> It would be interesting to know what the exact fetch rules are.

So I fixed my test case to do 32-bit writes, and now the results are
making a lot more sense.  Now I only get crashes when writing across
cache lines.  So maybe we should just go with Andy's suggestion above.

It would be great if some CPU people could confirm that it's safe (for
x86-64 only), since it's not in the SDM.  Who can help answer that?

-- 
Josh
