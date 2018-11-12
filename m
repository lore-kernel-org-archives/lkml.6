Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E112C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58EE522510
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:23:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58EE522510
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730650AbeKMISI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 03:18:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51362 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727847AbeKMISI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 03:18:08 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7408D3DDB8;
        Mon, 12 Nov 2018 22:22:59 +0000 (UTC)
Received: from treble (ovpn-121-1.rdu2.redhat.com [10.10.121.1])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DDE1F6090A;
        Mon, 12 Nov 2018 22:22:52 +0000 (UTC)
Date:   Mon, 12 Nov 2018 16:22:50 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 00/12] locking/lockdep: Add a new class of terminal
 locks
Message-ID: <20181112222250.h37hkrj6warqewkd@treble>
References: <1541709268-3766-1-git-send-email-longman@redhat.com>
 <20181109080412.GC86700@gmail.com>
 <20181110141045.GD3339@worktop.programming.kicks-ass.net>
 <dfa0a2fa-0094-3ae0-4f27-2930233132a3@redhat.com>
 <20181112051033.GA123204@gmail.com>
 <20181112055324.f7div2ahx5emkbbe@treble>
 <20181112063050.GB61749@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181112063050.GB61749@gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 12 Nov 2018 22:22:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 07:30:50AM +0100, Ingo Molnar wrote:
> 
> * Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> 
> > On Mon, Nov 12, 2018 at 06:10:33AM +0100, Ingo Molnar wrote:
> > > 
> > > * Waiman Long <longman@redhat.com> wrote:
> > > 
> > > > On 11/10/2018 09:10 AM, Peter Zijlstra wrote:
> > > > > On Fri, Nov 09, 2018 at 09:04:12AM +0100, Ingo Molnar wrote:
> > > > >> BTW., if you are interested in more radical approaches to optimize 
> > > > >> lockdep, we could also add a static checker via objtool driven call graph 
> > > > >> analysis, and mark those locks terminal that we can prove are terminal.
> > > > >>
> > > > >> This would require the unified call graph of the kernel image and of all 
> > > > >> modules to be examined in a final pass, but that's within the principal 
> > > > >> scope of objtool. (This 'final pass' could also be done during bootup, at 
> > > > >> least in initial versions.)
> > > > >
> > > > > Something like this is needed for objtool LTO support as well. I just
> > > > > dread the build time 'regressions' this will introduce :/
> > > > >
> > > > > The final link pass is already by far the most expensive part (as
> > > > > measured in wall-time) of building a kernel, adding more work there
> > > > > would really suck :/
> > > > 
> > > > I think the idea is to make objtool have the capability to do that. It
> > > > doesn't mean we need to turn it on by default in every build.
> > > 
> > > Yeah.
> > > 
> > > Also note that much of the objtool legwork would be on a per file basis 
> > > which is reasonably parallelized already. On x86 it's also already done 
> > > for every ORC build i.e. every distro build and the incremental overhead 
> > > from also extracting locking dependencies should be reasonably small.
> > > 
> > > The final search of the global graph would be serialized but still 
> > > reasonably fast as these are all 'class' level dependencies which are 
> > > much less numerous than runtime dependencies.
> > > 
> > > I.e. I think we are talking about tens of thousands of dependencies, not 
> > > tens of millions.
> > > 
> > > At least in theory. ;-)
> > 
> > Generating a unified call graph sounds very expensive (and very far
> > beyond what objtool can do today).
> 
> Well, objtool already goes through the instruction stream and recognizes 
> function calls - so it can in effect generate a stream of "function x 
> called by function y" data, correct?

Yeah, though it would be quite simple to get the same data with a simple
awk script at link time.

> >  Also, what about function pointers?
> 
> So maybe it's possible to enumerate all potential values for function 
> pointers with a reasonably simple compiler plugin and work from there?

I think this would be somewhere between very difficult and impossible to
do properly.  I can't even imagine how this would be implemented in a
compiler plugin.  But I'd love to be proven wrong on that.

> One complication would be function pointers encoded as opaque data 
> types...
> 
> > BTW there's another kernel static analysis tool which attempts to 
> > create such a call graph already: smatch.
> 
> It's not included in the kernel tree though and I'd expect tight coupling 
> (or at least lock-step improvements) between tooling and lockdep here.

Fair enough.  Smatch's call tree isn't perfect anyway, but I don't think
perfect is attainable.

-- 
Josh
