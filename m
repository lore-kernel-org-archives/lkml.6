Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B37C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 547CB217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbeLSRi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 12:38:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:52256 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727652AbeLSRi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 12:38:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "Cc"
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 24CDAAEB0;
        Wed, 19 Dec 2018 17:38:56 +0000 (UTC)
From:   Martin Jambor <mjambor@suse.cz>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch\/x86 maintainers" <x86@kernel.org>
Subject: Re: objtool warnings for kernel/trace/trace_selftest_dynamic.o
In-Reply-To: <20181218211501.GD25620@tassilo.jf.intel.com>
References: <20181217173900.ygifx7khwmzn2gv2@treble> <20181217180434.GS25620@tassilo.jf.intel.com> <20181217181638.dfexg6mkmbfyzfli@treble> <20181217192938.GF2218@hirez.programming.kicks-ass.net> <20181217213126.lsqhyszoulel6uq6@treble> <20181217173644.391c2070@gandalf.local.home> <20181218000618.GA25620@tassilo.jf.intel.com> <20181218024916.vmfnyqzouhfxhyvc@treble> <alpine.LSU.2.21.1812181022570.9644@pobox.suse.cz> <ri6h8fbqbdf.fsf@suse.cz> <20181218211501.GD25620@tassilo.jf.intel.com>
User-Agent: Notmuch/0.26 (https://notmuchmail.org) Emacs/26.1 (x86_64-suse-linux-gnu)
Date:   Wed, 19 Dec 2018 18:38:55 +0100
Message-ID: <ri6va3po1qo.fsf@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 18 2018, Andi Kleen wrote:
>> OK, I have read through it and with the caveats that I don't quite
>> understand what the failure is, that also believe attribute noclone
>> should not affect frame pointer generation, and that I don't quite get
>> how LTO comes into play, my comments are the following:
>
>> 
>> I am the developer who introduced attribute noclone to GCC and also the
>> one who advises against using it :-) ...at least without also using the
>> noinline attribute, the combination means "
>
> The function in question uses noinline too.
>
>> I want only one or zero
>> copies of this function in the compiled assembly" which you might need
>> if you do fancy stuff in inline assembly, for example.
>
> For this case we only want one non inlined copy because it is used as a
> test case for a function tracer.
>
> LTO comes into play because it originally relied on being in a separate
> file, so it would not be inlined, but with LTO that doesn't work.
>
>> 
>> I believe that when people use noclone on its own, in 99 out 100 cases
>> they actually want something else.  Usually there is something that
>
> AFAIK there is no noclone without noinline in the kernel tree.
>
>
>> references the function from code (such as assembly) or a tool that the
>> compiler does know about and then they should use the "used" attribute.
>
> Neither in the ftrace case, nor in the KVM case (another user which
> has fancy inline assembly that cannot be duplicated) that's the case.
> It's just about having exactly one out of line instance.
>
> So based on that I think noclone is fine. Of course there 
> is still the open question why exactly the frame pointer disappears.

I agree, I originally thought the problem was something else.

Thanks for the clarification,

Martin
