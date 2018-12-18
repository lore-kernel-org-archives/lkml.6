Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF76C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 656CB20874
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbeLRDFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 22:05:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:25485 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbeLRDFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 22:05:54 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6893692A6F;
        Tue, 18 Dec 2018 03:05:54 +0000 (UTC)
Received: from treble (ovpn-120-179.rdu2.redhat.com [10.10.120.179])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 936AC5D6A6;
        Tue, 18 Dec 2018 03:05:52 +0000 (UTC)
Date:   Mon, 17 Dec 2018 21:05:50 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: objtool warnings for kernel/trace/trace_selftest_dynamic.o
Message-ID: <20181218030550.5yxvn6yfwvpmm6ev@treble>
References: <CAK8P3a2K1K21ePBFbApaTKPCk+=Bqj0LyWoK1MdFb1s9ZwjfPg@mail.gmail.com>
 <20181217173900.ygifx7khwmzn2gv2@treble>
 <20181217180434.GS25620@tassilo.jf.intel.com>
 <20181217181638.dfexg6mkmbfyzfli@treble>
 <20181217192938.GF2218@hirez.programming.kicks-ass.net>
 <20181217213126.lsqhyszoulel6uq6@treble>
 <20181217173644.391c2070@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181217173644.391c2070@gandalf.local.home>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 18 Dec 2018 03:05:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 05:36:44PM -0500, Steven Rostedt wrote:
> On Mon, 17 Dec 2018 15:31:26 -0600
> Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> 
> > On Mon, Dec 17, 2018 at 08:29:38PM +0100, Peter Zijlstra wrote:
> > > On Mon, Dec 17, 2018 at 12:16:38PM -0600, Josh Poimboeuf wrote:
> > >   
> > > > > Yes LTO causes the to be treated like static functions.
> > > > > 
> > > > > I guess noclone is unlikely to be really needed here because these
> > > > > functions are unlikely to be cloned.
> > > > > 
> > > > > So as a workaround it could be removed.
> > > > > 
> > > > > But note we have other noclone functions in the tree (like in KVM)
> > > > > which actually need it.  
> > > > 
> > > > How about we just use the __used attribute then?  It seems to have the
> > > > same result of preventing IPA optimizations (without the weird side
> > > > effect of missing frame pointers).  
> > > 
> > > AFAIK we don't have any in-tree LTO, so it can all go in the bin.
> > > 
> > > When/if we get the LTO trainwreck sorted -- which very much includes
> > > getting that memory-order-consume fixed -- we can revisit all that.  
> > 
> > Ok, then if there are no objections I'll just send a revert of:
> > 
> >   dd3dad0d716d ("ftrace: Mark function tracer test functions noinline/noclone")
> > 
> 
> Should it be reverted, or just remove the noclone, and keep the
> noinline?

If we want to support out-of-tree LTO, then it should only need "used",
because wouldn't that imply noinline?

If we *don't* want to support out-of-tree LTO, then it shouldn't need
any special attributes, because the functions aren't static so GCC won't
mess with their ABI.

-- 
Josh
