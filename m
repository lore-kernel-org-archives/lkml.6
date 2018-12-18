Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00192C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C23D4214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbeLRAGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 19:06:19 -0500
Received: from mga14.intel.com ([192.55.52.115]:4520 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbeLRAGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 19:06:19 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2018 16:06:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,366,1539673200"; 
   d="scan'208";a="102286185"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga008.jf.intel.com with ESMTP; 17 Dec 2018 16:06:18 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 1F92B300B49; Mon, 17 Dec 2018 16:06:18 -0800 (PST)
Date:   Mon, 17 Dec 2018 16:06:18 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: objtool warnings for kernel/trace/trace_selftest_dynamic.o
Message-ID: <20181218000618.GA25620@tassilo.jf.intel.com>
References: <CAK8P3a2K1K21ePBFbApaTKPCk+=Bqj0LyWoK1MdFb1s9ZwjfPg@mail.gmail.com>
 <20181217173900.ygifx7khwmzn2gv2@treble>
 <20181217180434.GS25620@tassilo.jf.intel.com>
 <20181217181638.dfexg6mkmbfyzfli@treble>
 <20181217192938.GF2218@hirez.programming.kicks-ass.net>
 <20181217213126.lsqhyszoulel6uq6@treble>
 <20181217173644.391c2070@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217173644.391c2070@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

It should not be touched for now, until it is properly debugged.

IMHO Josh's explanation doesn't make much sense and there
was a lot of handwaving 

And just fixing one case isn't good enough because there are other
noclone functions in the tree.

It the problem is the plugin the plugin needs to be fixed.

If the problem is gcc we need a gcc test case and bug, with 
some analysis, and then based on that select the proper workaround.


-Andi
