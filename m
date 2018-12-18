Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC8EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7410E217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbeLRVUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:20:43 -0500
Received: from mga03.intel.com ([134.134.136.65]:53759 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726570AbeLRVUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:20:42 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2018 13:20:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,370,1539673200"; 
   d="scan'208";a="284727344"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga005.jf.intel.com with ESMTP; 18 Dec 2018 13:20:42 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 52A20300B49; Tue, 18 Dec 2018 13:20:42 -0800 (PST)
Date:   Tue, 18 Dec 2018 13:20:42 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Martin Jambor <mjambor@suse.cz>, Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: objtool warnings for kernel/trace/trace_selftest_dynamic.o
Message-ID: <20181218212042.GE25620@tassilo.jf.intel.com>
References: <20181217180434.GS25620@tassilo.jf.intel.com>
 <20181217181638.dfexg6mkmbfyzfli@treble>
 <20181217192938.GF2218@hirez.programming.kicks-ass.net>
 <20181217213126.lsqhyszoulel6uq6@treble>
 <20181217173644.391c2070@gandalf.local.home>
 <20181218000618.GA25620@tassilo.jf.intel.com>
 <20181218024916.vmfnyqzouhfxhyvc@treble>
 <alpine.LSU.2.21.1812181022570.9644@pobox.suse.cz>
 <ri6h8fbqbdf.fsf@suse.cz>
 <20181218140105.ajuiglkpvstt3qxs@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218140105.ajuiglkpvstt3qxs@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I whittled it down to a small test case.  It turns out the problem is
> caused by the "__optimize__("no-tracer")" atribute, which is used by our
> __noclone macro:
> 
> 
> # if __has_attribute(__optimize__)
> #  define __noclone                     __attribute__((__noclone__, __optimize__("no-tracer")))
> # else
> #  define __noclone                     __attribute__((__noclone__))
> # endif

Ah interesting. That makes sense. Thanks for tracking that down.

> 
> commit 95272c29378ee7dc15f43fa2758cb28a5913a06d
> Author: Paolo Bonzini <pbonzini@redhat.com>
> Date:   Thu Mar 31 09:38:51 2016 +0200
> 
>     compiler-gcc: disable -ftracer for __noclone functions
> 
>     -ftracer can duplicate asm blocks causing compilation to fail in
>     noclone functions.  For example, KVM declares a global variable
>     in an asm like
> 
>         asm("2: ... \n
>              .pushsection data \n
>              .global vmx_return \n
>              vmx_return: .long 2b");
> 
>     and -ftracer causes a double declaration.

Ok. So the real solution would be to add a no tracer to the KVM
function only.

But of course it will drop its frame pointer. So if you rely on
frame pointer for live patching you would still have a problem.

Just fixing the ftrace case independently may not be useful?

ftrace here really not interesting at all for live patching because
the ftracing self test only happens at boot, when there is no live patching.
Likely it's even in __init code.

KVM on the other hand is quite important and actually happens at boot.

So I would concentrate on fixing that one instead, but leave ftrace
alone.

My suggestion to fix KVM would be to drop the inline assembler
and use out of line assembler in a separate file. Then disabling
the tracer wouldn't be needed.

VM entries are very expensive anyways, I doubt avoiding a single call/ret
makes any difference at all.

-Andi

