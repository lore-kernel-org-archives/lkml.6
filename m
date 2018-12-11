Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A86C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A752086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:19:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A752086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbeLKRTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:19:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46550 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbeLKRTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 12:19:13 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4D880307EA99;
        Tue, 11 Dec 2018 17:19:12 +0000 (UTC)
Received: from treble (ovpn-122-18.rdu2.redhat.com [10.10.122.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2049B600CC;
        Tue, 11 Dec 2018 17:19:10 +0000 (UTC)
Date:   Tue, 11 Dec 2018 11:19:04 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "jbaron@akamai.com" <jbaron@akamai.com>,
        Jiri Kosina <jkosina@suse.cz>, "bp@alien8.de" <bp@alien8.de>,
        "julia@ni.com" <julia@ni.com>, "jeyu@kernel.org" <jeyu@kernel.org>,
        Peter Anvin <hpa@zytor.com>
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
Message-ID: <20181211171904.urcsux6ttp2yfunm@treble>
References: <20181129125857.75c55b96@gandalf.local.home>
 <CAHk-=wigLUgxDM6Dq2aS7efduffratP976Ggmpv4Ev4EOrJxyA@mail.gmail.com>
 <20181129134725.6d86ade6@gandalf.local.home>
 <CAHk-=wgbnQs4fpuHqT1jLkDnKcvTGS5EN8m=qy7oUE5n_fhOig@mail.gmail.com>
 <CAHk-=wjN=sow0F-UtA6DtHHT_CNUV7wYVe3cQ4E8GPp4LN32+Q@mail.gmail.com>
 <CALCETrVzFk2Yv8q54Xh6qOb45AKKrQhD5OkAuTsw9HaR3Wvy4Q@mail.gmail.com>
 <20181129202452.56f4j2wdct6qbaqo@treble>
 <CAHk-=wiO87jDPP8FZ7EfwfbFNQRdr64Pa+g33do7tKiTFYz8BA@mail.gmail.com>
 <20181130162713.uoeyfau66buntyse@treble>
 <9fe3867d8f06424681ec2e75d8c6a7dd@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9fe3867d8f06424681ec2e75d8c6a7dd@AcuMS.aculab.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 11 Dec 2018 17:19:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 09:41:37AM +0000, David Laight wrote:
> From: Josh Poimboeuf
> > Sent: 30 November 2018 16:27
> > 
> > On Thu, Nov 29, 2018 at 03:04:20PM -0800, Linus Torvalds wrote:
> > > On Thu, Nov 29, 2018 at 12:25 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> ...
> > > > Maybe that would be ok.  If my math is right, we would use the
> > > > out-of-line version almost 5% of the time due to cache misalignment of
> > > > the address.
> > >
> > > Note that I don't think cache-line alignment is necessarily sufficient.
> > >
> > > The I$ fetch from the cacheline can happen in smaller chunks, because
> > > the bus between the I$ and the instruction decode isn't a full
> > > cacheline (well, it is _now_ in modern big cores, but it hasn't always
> > > been).
> > >
> > > So even if the cacheline is updated atomically, I could imagine seeing
> > > a partial fetch from the I$ (old values) and then a second partial
> > > fetch (new values).
> > >
> > > It would be interesting to know what the exact fetch rules are.
> > 
> > I've been doing  some cross-modifying code experiments on Nehalem, with
> > one CPU writing call destinations while the other CPUs are executing
> > them.  Reliably, one of the readers goes off into the weeds within a few
> > seconds.
> > 
> > The writing was done with just text_poke(), no #BP.
> > 
> > I wasn't able to figure out the pattern in the addresses of the
> > corrupted call sites.  It wasn't cache line.
> > 
> > That was on Nehalem.  Skylake didn't crash at all.
> 
> Interesting thought?
> 
> If it is possible to add a prefix that can be overwritten by an int3
> is it also possible to add something that the assembler will use
> to align the instruction so that a write to the 4 byte offset
> will be atomic?
> 
> I'd guess that avoiding 8 byte granularity would be sufficient.
> So you'd need a 1, 2 or 3 byte nop depending on the actual
> alignment - although a 3 byte one would always do.

The problem is that the call is done in C code, and we don't have a
feasible way to use inline asm to call functions with more than five
arguments.

BTW, my original experiments (mentioned above) were a bit... flawed.  I
used text_poke(), which does memcpy(), which writes one byte at a time.
No wonder it wasn't atomic.

I'll need to do some more experiments.

-- 
Josh
