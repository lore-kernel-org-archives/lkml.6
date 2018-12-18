Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE7EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 02:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F14672145D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 02:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbeLRCtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 21:49:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54984 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbeLRCtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 21:49:21 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 73F87DD9C0;
        Tue, 18 Dec 2018 02:49:20 +0000 (UTC)
Received: from treble (ovpn-120-179.rdu2.redhat.com [10.10.120.179])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1660351F26;
        Tue, 18 Dec 2018 02:49:18 +0000 (UTC)
Date:   Mon, 17 Dec 2018 20:49:16 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: objtool warnings for kernel/trace/trace_selftest_dynamic.o
Message-ID: <20181218024916.vmfnyqzouhfxhyvc@treble>
References: <CAK8P3a2K1K21ePBFbApaTKPCk+=Bqj0LyWoK1MdFb1s9ZwjfPg@mail.gmail.com>
 <20181217173900.ygifx7khwmzn2gv2@treble>
 <20181217180434.GS25620@tassilo.jf.intel.com>
 <20181217181638.dfexg6mkmbfyzfli@treble>
 <20181217192938.GF2218@hirez.programming.kicks-ass.net>
 <20181217213126.lsqhyszoulel6uq6@treble>
 <20181217173644.391c2070@gandalf.local.home>
 <20181218000618.GA25620@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181218000618.GA25620@tassilo.jf.intel.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 18 Dec 2018 02:49:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 04:06:18PM -0800, Andi Kleen wrote:
> On Mon, Dec 17, 2018 at 05:36:44PM -0500, Steven Rostedt wrote:
> > On Mon, 17 Dec 2018 15:31:26 -0600
> > Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > 
> > > On Mon, Dec 17, 2018 at 08:29:38PM +0100, Peter Zijlstra wrote:
> > > > On Mon, Dec 17, 2018 at 12:16:38PM -0600, Josh Poimboeuf wrote:
> > > >   
> > > > > > Yes LTO causes the to be treated like static functions.
> > > > > > 
> > > > > > I guess noclone is unlikely to be really needed here because these
> > > > > > functions are unlikely to be cloned.
> > > > > > 
> > > > > > So as a workaround it could be removed.
> > > > > > 
> > > > > > But note we have other noclone functions in the tree (like in KVM)
> > > > > > which actually need it.  
> > > > > 
> > > > > How about we just use the __used attribute then?  It seems to have the
> > > > > same result of preventing IPA optimizations (without the weird side
> > > > > effect of missing frame pointers).  
> > > > 
> > > > AFAIK we don't have any in-tree LTO, so it can all go in the bin.
> > > > 
> > > > When/if we get the LTO trainwreck sorted -- which very much includes
> > > > getting that memory-order-consume fixed -- we can revisit all that.  
> > > 
> > > Ok, then if there are no objections I'll just send a revert of:
> > > 
> > >   dd3dad0d716d ("ftrace: Mark function tracer test functions noinline/noclone")

Sorry for suggesting this prematurely, my email client stopped syncing
and I missed your later replies to Peter about this.

> > Should it be reverted, or just remove the noclone, and keep the
> > noinline?
> 
> It should not be touched for now, until it is properly debugged.
> 
> IMHO Josh's explanation doesn't make much sense and there
> was a lot of handwaving 
> 
> And just fixing one case isn't good enough because there are other
> noclone functions in the tree.
> 
> It the problem is the plugin the plugin needs to be fixed.
> 
> If the problem is gcc we need a gcc test case and bug, with 
> some analysis, and then based on that select the proper workaround.

The plugin is only used for older versions of GCC.  Newer versions have
the same functionality builtin with -fsanitize-coverage=trace-pc.

So the problem is GCC.  We're using a function attribute which at least
oneGCC developer doesn't recommend.  If you want to keep the LTO support
then '__used' seems like a much better choice.

-- 
Josh
