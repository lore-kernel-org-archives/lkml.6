Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F68C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 05:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04015216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 05:31:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04015216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731084AbeKLPWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 10:22:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46514 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727297AbeKLPWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 10:22:36 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 94D9DC058CAD;
        Mon, 12 Nov 2018 05:31:00 +0000 (UTC)
Received: from treble (ovpn-121-1.rdu2.redhat.com [10.10.121.1])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D57425D968;
        Mon, 12 Nov 2018 05:30:57 +0000 (UTC)
Date:   Sun, 11 Nov 2018 23:30:55 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>, Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH RFC 0/3] Static calls
Message-ID: <20181112053055.hdcv5x7md47ehunv@treble>
References: <cover.1541711457.git.jpoimboe@redhat.com>
 <20181109072811.GB86700@gmail.com>
 <20181109144501.aqhcv3vdjuqlp7pz@treble>
 <20181112050241.GB28219@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181112050241.GB28219@gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 12 Nov 2018 05:31:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 06:02:41AM +0100, Ingo Molnar wrote:
> 
> * Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> 
> > On Fri, Nov 09, 2018 at 08:28:11AM +0100, Ingo Molnar wrote:
> > > > - I'm not sure about the objtool approach.  Objtool is (currently)
> > > >   x86-64 only, which means we have to use the "unoptimized" version
> > > >   everywhere else.  I may experiment with a GCC plugin instead.
> > > 
> > > I'd prefer the objtool approach. It's a pretty reliable first-principles 
> > > approach while GCC plugin would have to be replicated for Clang and any 
> > > other compilers, etc.
> > 
> > The benefit of a plugin is that we'd only need two of them: GCC and
> > Clang.  And presumably, they'd share a lot of code.
> > 
> > The prospect of porting objtool to all architectures is going to be much
> > more of a daunting task (though we are at least already considering it
> > for some arches).
> 
> Which architectures would benefit from ORC support the most?

According to my (limited and potentially flawed) knowledge, I think
arm64 would benefit the most performance-wise, whereas powerpc and s390
gains would be quite a bit less.

We may have to port objtool to arm64 anyway, for live patching.  But
that will be a lot more work than it took for Ard to write a GCC plugin.

> I really think that hard reliance on GCC plugins is foolish

Funny, I feel the same way about hard reliance on objtool :-)

> - but maybe Clang's plugin infrastructure is a guarantee that it
> remains a sane and usable interface.

Hopefully so.  If it breaks, we could always write another tool, as the
work is straightforward.  Or we could make it an objtool subcommand
which works on all arches.

> > > All other usecases are bonus, but it would certainly be interesting to 
> > > investigate the impact of using these APIs for tracing: that too is a 
> > > feature enabled everywhere but utilized only by a small fraction of Linux 
> > > users - so literally every single cycle or instruction saved or hot-path 
> > > shortened is a major win.
> > 
> > With retpolines, and with tracepoints enabled, it's definitely a major
> > win.  Steve measured an 8.9% general slowdown on hackbench caused by
> > retpolines.
> 
> How much of that slowdown is reversed?

In theory, it should reverse all of the slowdown, and actually may even
speed it up a little.  Steve is working on measuring that now.

-- 
Josh
