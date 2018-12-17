Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164B0C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29D320874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389458AbeLQVbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 16:31:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47158 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726943AbeLQVba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 16:31:30 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BC3BEC062EDC;
        Mon, 17 Dec 2018 21:31:30 +0000 (UTC)
Received: from treble (ovpn-120-179.rdu2.redhat.com [10.10.120.179])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4140810018F9;
        Mon, 17 Dec 2018 21:31:29 +0000 (UTC)
Date:   Mon, 17 Dec 2018 15:31:26 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: objtool warnings for kernel/trace/trace_selftest_dynamic.o
Message-ID: <20181217213126.lsqhyszoulel6uq6@treble>
References: <CAK8P3a2K1K21ePBFbApaTKPCk+=Bqj0LyWoK1MdFb1s9ZwjfPg@mail.gmail.com>
 <20181217173900.ygifx7khwmzn2gv2@treble>
 <20181217180434.GS25620@tassilo.jf.intel.com>
 <20181217181638.dfexg6mkmbfyzfli@treble>
 <20181217192938.GF2218@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181217192938.GF2218@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 17 Dec 2018 21:31:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 08:29:38PM +0100, Peter Zijlstra wrote:
> On Mon, Dec 17, 2018 at 12:16:38PM -0600, Josh Poimboeuf wrote:
> 
> > > Yes LTO causes the to be treated like static functions.
> > > 
> > > I guess noclone is unlikely to be really needed here because these
> > > functions are unlikely to be cloned.
> > > 
> > > So as a workaround it could be removed.
> > > 
> > > But note we have other noclone functions in the tree (like in KVM)
> > > which actually need it.
> > 
> > How about we just use the __used attribute then?  It seems to have the
> > same result of preventing IPA optimizations (without the weird side
> > effect of missing frame pointers).
> 
> AFAIK we don't have any in-tree LTO, so it can all go in the bin.
> 
> When/if we get the LTO trainwreck sorted -- which very much includes
> getting that memory-order-consume fixed -- we can revisit all that.

Ok, then if there are no objections I'll just send a revert of:

  dd3dad0d716d ("ftrace: Mark function tracer test functions noinline/noclone")

-- 
Josh
