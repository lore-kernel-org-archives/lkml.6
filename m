Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46596C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C3DB2133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbeLRJ27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 04:28:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:52928 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726364AbeLRJ27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 04:28:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0C103AC3C;
        Tue, 18 Dec 2018 09:28:57 +0000 (UTC)
Date:   Tue, 18 Dec 2018 10:28:56 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     Andi Kleen <ak@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>, mjambor@suse.cz
Subject: Re: objtool warnings for kernel/trace/trace_selftest_dynamic.o
In-Reply-To: <20181218024916.vmfnyqzouhfxhyvc@treble>
Message-ID: <alpine.LSU.2.21.1812181022570.9644@pobox.suse.cz>
References: <CAK8P3a2K1K21ePBFbApaTKPCk+=Bqj0LyWoK1MdFb1s9ZwjfPg@mail.gmail.com> <20181217173900.ygifx7khwmzn2gv2@treble> <20181217180434.GS25620@tassilo.jf.intel.com> <20181217181638.dfexg6mkmbfyzfli@treble> <20181217192938.GF2218@hirez.programming.kicks-ass.net>
 <20181217213126.lsqhyszoulel6uq6@treble> <20181217173644.391c2070@gandalf.local.home> <20181218000618.GA25620@tassilo.jf.intel.com> <20181218024916.vmfnyqzouhfxhyvc@treble>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018, Josh Poimboeuf wrote:

> On Mon, Dec 17, 2018 at 04:06:18PM -0800, Andi Kleen wrote:
> > On Mon, Dec 17, 2018 at 05:36:44PM -0500, Steven Rostedt wrote:
> > > On Mon, 17 Dec 2018 15:31:26 -0600
> > > Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > > 
> > > > On Mon, Dec 17, 2018 at 08:29:38PM +0100, Peter Zijlstra wrote:
> > > > > On Mon, Dec 17, 2018 at 12:16:38PM -0600, Josh Poimboeuf wrote:
> > > > >   
> > > > > > > Yes LTO causes the to be treated like static functions.
> > > > > > > 
> > > > > > > I guess noclone is unlikely to be really needed here because these
> > > > > > > functions are unlikely to be cloned.
> > > > > > > 
> > > > > > > So as a workaround it could be removed.
> > > > > > > 
> > > > > > > But note we have other noclone functions in the tree (like in KVM)
> > > > > > > which actually need it.  
> > > > > > 
> > > > > > How about we just use the __used attribute then?  It seems to have the
> > > > > > same result of preventing IPA optimizations (without the weird side
> > > > > > effect of missing frame pointers).  
> > > > > 
> > > > > AFAIK we don't have any in-tree LTO, so it can all go in the bin.
> > > > > 
> > > > > When/if we get the LTO trainwreck sorted -- which very much includes
> > > > > getting that memory-order-consume fixed -- we can revisit all that.  
> > > > 
> > > > Ok, then if there are no objections I'll just send a revert of:
> > > > 
> > > >   dd3dad0d716d ("ftrace: Mark function tracer test functions noinline/noclone")
> 
> Sorry for suggesting this prematurely, my email client stopped syncing
> and I missed your later replies to Peter about this.
> 
> > > Should it be reverted, or just remove the noclone, and keep the
> > > noinline?
> > 
> > It should not be touched for now, until it is properly debugged.
> > 
> > IMHO Josh's explanation doesn't make much sense and there
> > was a lot of handwaving 
> > 
> > And just fixing one case isn't good enough because there are other
> > noclone functions in the tree.
> > 
> > It the problem is the plugin the plugin needs to be fixed.
> > 
> > If the problem is gcc we need a gcc test case and bug, with 
> > some analysis, and then based on that select the proper workaround.
> 
> The plugin is only used for older versions of GCC.  Newer versions have
> the same functionality builtin with -fsanitize-coverage=trace-pc.
> 
> So the problem is GCC.  We're using a function attribute which at least
> oneGCC developer doesn't recommend.  If you want to keep the LTO support
> then '__used' seems like a much better choice.

Martin added to CC.

Martin, the thread starts here 
http://lkml.kernel.org/r/CAK8P3a2K1K21ePBFbApaTKPCk+=Bqj0LyWoK1MdFb1s9ZwjfPg@mail.gmail.com

Can you explain the background of noclone vs. used attributes, please? 
We discussed it yesterday and I understood that maybe we should not rely 
on noclone that much. However it is used in the kernel. Should we avoid 
it in general and replace it with something else (used)? 

It definitely makes sense in our livepatching samples which Josh mentioned 
previously in the thread.

Thanks,
Miroslav
