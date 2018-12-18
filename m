Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B7DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61507217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbeLRMPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 07:15:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:58514 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726370AbeLRMPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 07:15:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "Cc"
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 73305ACEA;
        Tue, 18 Dec 2018 12:15:41 +0000 (UTC)
From:   Martin Jambor <mjambor@suse.cz>
To:     Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch\/x86 maintainers" <x86@kernel.org>
Subject: Re: objtool warnings for kernel/trace/trace_selftest_dynamic.o
In-Reply-To: <alpine.LSU.2.21.1812181022570.9644@pobox.suse.cz>
References: <CAK8P3a2K1K21ePBFbApaTKPCk+=Bqj0LyWoK1MdFb1s9ZwjfPg@mail.gmail.com> <20181217173900.ygifx7khwmzn2gv2@treble> <20181217180434.GS25620@tassilo.jf.intel.com> <20181217181638.dfexg6mkmbfyzfli@treble> <20181217192938.GF2218@hirez.programming.kicks-ass.net> <20181217213126.lsqhyszoulel6uq6@treble> <20181217173644.391c2070@gandalf.local.home> <20181218000618.GA25620@tassilo.jf.intel.com> <20181218024916.vmfnyqzouhfxhyvc@treble> <alpine.LSU.2.21.1812181022570.9644@pobox.suse.cz>
User-Agent: Notmuch/0.26 (https://notmuchmail.org) Emacs/26.1 (x86_64-suse-linux-gnu)
Date:   Tue, 18 Dec 2018 13:15:40 +0100
Message-ID: <ri6h8fbqbdf.fsf@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 18 2018, Miroslav Benes wrote:
>> Sorry for suggesting this prematurely, my email client stopped syncing
>> and I missed your later replies to Peter about this.
>> 
>> > > Should it be reverted, or just remove the noclone, and keep the
>> > > noinline?
>> > 
>> > It should not be touched for now, until it is properly debugged.
>> > 
>> > IMHO Josh's explanation doesn't make much sense and there
>> > was a lot of handwaving 
>> > 
>> > And just fixing one case isn't good enough because there are other
>> > noclone functions in the tree.
>> > 
>> > It the problem is the plugin the plugin needs to be fixed.
>> > 
>> > If the problem is gcc we need a gcc test case and bug, with 
>> > some analysis, and then based on that select the proper workaround.
>> 
>> The plugin is only used for older versions of GCC.  Newer versions have
>> the same functionality builtin with -fsanitize-coverage=trace-pc.
>> 
>> So the problem is GCC.

That's a little bit harsh :-)

>> We're using a function attribute which at least
>> oneGCC developer doesn't recommend.  If you want to keep the LTO support
>> then '__used' seems like a much better choice.
>
> Martin added to CC.
>
> Martin, the thread starts here 
> http://lkml.kernel.org/r/CAK8P3a2K1K21ePBFbApaTKPCk+=Bqj0LyWoK1MdFb1s9ZwjfPg@mail.gmail.com
>
> Can you explain the background of noclone vs. used attributes, please? 
> We discussed it yesterday and I understood that maybe we should not rely 
> on noclone that much. However it is used in the kernel. Should we avoid 
> it in general and replace it with something else (used)?

OK, I have read through it and with the caveats that I don't quite
understand what the failure is, that also believe attribute noclone
should not affect frame pointer generation, and that I don't quite get
how LTO comes into play, my comments are the following:

I am the developer who introduced attribute noclone to GCC and also the
one who advises against using it :-) ...at least without also using the
noinline attribute, the combination means "I want only one or zero
copies of this function in the compiled assembly" which you might need
if you do fancy stuff in inline assembly, for example.

I believe that when people use noclone on its own, in 99 out 100 cases
they actually want something else.  Usually there is something that
references the function from code (such as assembly) or a tool that the
compiler does know about and then they should use the "used" attribute.
That is what I understood to be the use case here and therefore I
recommended it.  In other cases people want all inter-procedural (IPA)
analyses to stay away from a function and then they should use attribute
noipa (or in older GCCs, the combination of noinline and noclone).

The attribute was introduced because it is useful in GCC testsuite, and
although I think occasions when it is useful on its own elsewhere are
very rare and quite obscure, they can happen.  But it really only means
you want only one or zero *non-inlined* copies of the function.  For
example if you have an asm in it that must appear in the compiled
assembly only once but you are confident it will be optimized out in
inlined instances.  Or if you play games with __builtin_return_address()
and somehow have a very clear idea what the return values should be.

I'm afraid I cannot give an opinion what you should do in this case
without understanding the problem better.  If you can isolate the case
where noclone behaves weirdly into a self-contained testcase, I'd be
happy to have a look at it.

Martin
