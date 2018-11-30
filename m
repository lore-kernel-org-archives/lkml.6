Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6B2C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 21:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D019D20863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 21:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D019D20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbeLAIVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 03:21:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45276 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbeLAIVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 03:21:08 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A059A3082129;
        Fri, 30 Nov 2018 21:10:33 +0000 (UTC)
Received: from treble (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9726A1057072;
        Fri, 30 Nov 2018 21:10:31 +0000 (UTC)
Date:   Fri, 30 Nov 2018 15:10:29 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>, julia@ni.com, jeyu@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
Message-ID: <20181130211029.i5ngmbtpp7fhntfd@treble>
References: <CAHk-=wigLUgxDM6Dq2aS7efduffratP976Ggmpv4Ev4EOrJxyA@mail.gmail.com>
 <20181129134725.6d86ade6@gandalf.local.home>
 <CAHk-=wgbnQs4fpuHqT1jLkDnKcvTGS5EN8m=qy7oUE5n_fhOig@mail.gmail.com>
 <CAHk-=wjN=sow0F-UtA6DtHHT_CNUV7wYVe3cQ4E8GPp4LN32+Q@mail.gmail.com>
 <CALCETrVzFk2Yv8q54Xh6qOb45AKKrQhD5OkAuTsw9HaR3Wvy4Q@mail.gmail.com>
 <20181129202452.56f4j2wdct6qbaqo@treble>
 <CALCETrW1ju40hFrM3sr21tDTZ-m1=swHfD2cMiyYFJkgbb3cug@mail.gmail.com>
 <20181130183917.hxmti5josgq4clti@treble>
 <CAHk-=whx=Dme9q0k0pK7S_3YwuvdMw1yKxESSUhS+eEce8HTOQ@mail.gmail.com>
 <CALCETrVwdtLnnLR7Qb3LVCHDRpJ-cgU28jiGOQdaPFLVSvvZXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrVwdtLnnLR7Qb3LVCHDRpJ-cgU28jiGOQdaPFLVSvvZXA@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 30 Nov 2018 21:10:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 12:18:33PM -0800, Andy Lutomirski wrote:
> On Fri, Nov 30, 2018 at 11:51 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Fri, Nov 30, 2018 at 10:39 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > >
> > > AFAICT, all the other proposed options seem to have major issues.
> >
> > I still absolutely detest this patch, and in fact it got worse from
> > the test of the config variable.
> >
> > Honestly, the entry code being legible and simple is more important
> > than the extra cycle from branching to a trampoline for static calls.
> >
> > Just don't do the inline case if it causes this much confusion.

I *really* don't want to have to drop the inline feature.  The speedup
is measurable and not insignificant.  And out-of-line would be a
regression if we ported paravirt to use static calls.

> With my entry maintainer hat on, I don't mind it so much, although the
> implementation needs some work.  The #ifdef should just go away, and
> there should be another sanity check in the sanity check section.

Your suggested changes sound good to me.  I'll be gone next week, so
here's hoping you'll have this all figured out when I get back!

-- 
Josh
