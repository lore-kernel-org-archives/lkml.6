Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205FDC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4B42086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD4B42086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbeKJAZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 19:25:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38165 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbeKJAZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 19:25:59 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 82100308FB90;
        Fri,  9 Nov 2018 14:45:05 +0000 (UTC)
Received: from treble (ovpn-124-61.rdu2.redhat.com [10.10.124.61])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B3591608C2;
        Fri,  9 Nov 2018 14:45:03 +0000 (UTC)
Date:   Fri, 9 Nov 2018 08:45:01 -0600
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
Message-ID: <20181109144501.aqhcv3vdjuqlp7pz@treble>
References: <cover.1541711457.git.jpoimboe@redhat.com>
 <20181109072811.GB86700@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181109072811.GB86700@gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 09 Nov 2018 14:45:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 08:28:11AM +0100, Ingo Molnar wrote:
> > - I'm not sure about the objtool approach.  Objtool is (currently)
> >   x86-64 only, which means we have to use the "unoptimized" version
> >   everywhere else.  I may experiment with a GCC plugin instead.
> 
> I'd prefer the objtool approach. It's a pretty reliable first-principles 
> approach while GCC plugin would have to be replicated for Clang and any 
> other compilers, etc.

The benefit of a plugin is that we'd only need two of them: GCC and
Clang.  And presumably, they'd share a lot of code.

The prospect of porting objtool to all architectures is going to be much
more of a daunting task (though we are at least already considering it
for some arches).

> > - Does this feature have much value without retpolines?  If not, should
> >   we make it depend on retpolines somehow?
> 
> Paravirt patching, as you mention in your later reply?
> 
> > - Find some actual users of the interfaces (tracepoints? crypto?)
> 
> I'd be very happy with a demonstrated paravirt optimization already - 
> i.e. seeing the before/after effect on the vmlinux with an x86 distro 
> config.
> 
> All major Linux distributions enable CONFIG_PARAVIRT=y and 
> CONFIG_PARAVIRT_XXL=y on x86 at the moment, so optimizing it away as much 
> as possible in the 99.999% cases where it's not used is a primary 
> concern.

For paravirt, I was thinking of it as more of a cleanup than an
optimization.  The paravirt patching code already replaces indirect
branches with direct ones -- see paravirt_patch_default().

Though it *would* reduce the instruction footprint a bit, as the 7-byte
indirect calls (later patched to 5-byte direct + 2-byte nop) would
instead be 5-byte direct calls to begin with.

> All other usecases are bonus, but it would certainly be interesting to 
> investigate the impact of using these APIs for tracing: that too is a 
> feature enabled everywhere but utilized only by a small fraction of Linux 
> users - so literally every single cycle or instruction saved or hot-path 
> shortened is a major win.

With retpolines, and with tracepoints enabled, it's definitely a major
win.  Steve measured an 8.9% general slowdown on hackbench caused by
retpolines.

But with tracepoints disabled, I believe static jumps are used, which
already minimizes the impact on hot paths.

-- 
Josh
