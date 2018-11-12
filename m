Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAA0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 05:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E096821722
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 05:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E096821722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731607AbeKLPpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 10:45:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36864 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728269AbeKLPpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 10:45:13 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F04743083392;
        Mon, 12 Nov 2018 05:53:31 +0000 (UTC)
Received: from treble (ovpn-121-1.rdu2.redhat.com [10.10.121.1])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A97EA1019626;
        Mon, 12 Nov 2018 05:53:26 +0000 (UTC)
Date:   Sun, 11 Nov 2018 23:53:24 -0600
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
Message-ID: <20181112055324.f7div2ahx5emkbbe@treble>
References: <1541709268-3766-1-git-send-email-longman@redhat.com>
 <20181109080412.GC86700@gmail.com>
 <20181110141045.GD3339@worktop.programming.kicks-ass.net>
 <dfa0a2fa-0094-3ae0-4f27-2930233132a3@redhat.com>
 <20181112051033.GA123204@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181112051033.GA123204@gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 12 Nov 2018 05:53:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 06:10:33AM +0100, Ingo Molnar wrote:
> 
> * Waiman Long <longman@redhat.com> wrote:
> 
> > On 11/10/2018 09:10 AM, Peter Zijlstra wrote:
> > > On Fri, Nov 09, 2018 at 09:04:12AM +0100, Ingo Molnar wrote:
> > >> BTW., if you are interested in more radical approaches to optimize 
> > >> lockdep, we could also add a static checker via objtool driven call graph 
> > >> analysis, and mark those locks terminal that we can prove are terminal.
> > >>
> > >> This would require the unified call graph of the kernel image and of all 
> > >> modules to be examined in a final pass, but that's within the principal 
> > >> scope of objtool. (This 'final pass' could also be done during bootup, at 
> > >> least in initial versions.)
> > >
> > > Something like this is needed for objtool LTO support as well. I just
> > > dread the build time 'regressions' this will introduce :/
> > >
> > > The final link pass is already by far the most expensive part (as
> > > measured in wall-time) of building a kernel, adding more work there
> > > would really suck :/
> > 
> > I think the idea is to make objtool have the capability to do that. It
> > doesn't mean we need to turn it on by default in every build.
> 
> Yeah.
> 
> Also note that much of the objtool legwork would be on a per file basis 
> which is reasonably parallelized already. On x86 it's also already done 
> for every ORC build i.e. every distro build and the incremental overhead 
> from also extracting locking dependencies should be reasonably small.
> 
> The final search of the global graph would be serialized but still 
> reasonably fast as these are all 'class' level dependencies which are 
> much less numerous than runtime dependencies.
> 
> I.e. I think we are talking about tens of thousands of dependencies, not 
> tens of millions.
> 
> At least in theory. ;-)

Generating a unified call graph sounds very expensive (and very far
beyond what objtool can do today).  Also, what about function pointers?

BTW there's another kernel static analysis tool which attempts to create
such a call graph already: smatch.

-- 
Josh
