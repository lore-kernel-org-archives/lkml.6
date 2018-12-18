Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9185BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 546C2218A4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbeLRVPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:15:03 -0500
Received: from mga09.intel.com ([134.134.136.24]:63187 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbeLRVPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:15:02 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2018 13:15:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,370,1539673200"; 
   d="scan'208";a="119358924"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga002.jf.intel.com with ESMTP; 18 Dec 2018 13:15:01 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id C4992300B49; Tue, 18 Dec 2018 13:15:01 -0800 (PST)
Date:   Tue, 18 Dec 2018 13:15:01 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Martin Jambor <mjambor@suse.cz>
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: objtool warnings for kernel/trace/trace_selftest_dynamic.o
Message-ID: <20181218211501.GD25620@tassilo.jf.intel.com>
References: <20181217173900.ygifx7khwmzn2gv2@treble>
 <20181217180434.GS25620@tassilo.jf.intel.com>
 <20181217181638.dfexg6mkmbfyzfli@treble>
 <20181217192938.GF2218@hirez.programming.kicks-ass.net>
 <20181217213126.lsqhyszoulel6uq6@treble>
 <20181217173644.391c2070@gandalf.local.home>
 <20181218000618.GA25620@tassilo.jf.intel.com>
 <20181218024916.vmfnyqzouhfxhyvc@treble>
 <alpine.LSU.2.21.1812181022570.9644@pobox.suse.cz>
 <ri6h8fbqbdf.fsf@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ri6h8fbqbdf.fsf@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> OK, I have read through it and with the caveats that I don't quite
> understand what the failure is, that also believe attribute noclone
> should not affect frame pointer generation, and that I don't quite get
> how LTO comes into play, my comments are the following:



> 
> I am the developer who introduced attribute noclone to GCC and also the
> one who advises against using it :-) ...at least without also using the
> noinline attribute, the combination means "

The function in question uses noinline too.

> I want only one or zero
> copies of this function in the compiled assembly" which you might need
> if you do fancy stuff in inline assembly, for example.

For this case we only want one non inlined copy because it is used as a
test case for a function tracer.

LTO comes into play because it originally relied on being in a separate
file, so it would not be inlined, but with LTO that doesn't work.

> 
> I believe that when people use noclone on its own, in 99 out 100 cases
> they actually want something else.  Usually there is something that

AFAIK there is no noclone without noinline in the kernel tree.


> references the function from code (such as assembly) or a tool that the
> compiler does know about and then they should use the "used" attribute.

Neither in the ftrace case, nor in the KVM case (another user which
has fancy inline assembly that cannot be duplicated) that's the case.
It's just about having exactly one out of line instance.

So based on that I think noclone is fine. Of course there 
is still the open question why exactly the frame pointer disappears.

-Andi
