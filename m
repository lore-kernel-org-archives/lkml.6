Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837F6C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 380DD21904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfBGO7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 09:59:03 -0500
Received: from foss.arm.com ([217.140.101.70]:38298 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfBGO7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 09:59:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D6C0EBD;
        Thu,  7 Feb 2019 06:59:02 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA5433F719;
        Thu,  7 Feb 2019 06:58:59 -0800 (PST)
Subject: Re: [PATCH v7 2/3] arm64: implement ftrace with regs
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Torsten Duwe <duwe@lst.de>, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
References: <20190118163736.6A99268CEB@newverein.lst.de>
 <20190118163908.E338E68D93@newverein.lst.de>
 <e206e229-7813-2d37-d5c6-7a9785e311c9@arm.com>
 <20190206150524.GA28892@lst.de>
 <198550d8-78d4-6e30-0179-b5e07dd140f8@arm.com>
 <20190207095157.3dea1086@gandalf.local.home>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <5efd27b1-81b5-267a-9fe8-67bb084d56eb@arm.com>
Date:   Thu, 7 Feb 2019 14:58:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190207095157.3dea1086@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/02/2019 14:51, Steven Rostedt wrote:
> On Thu, 7 Feb 2019 10:33:50 +0000
> Julien Thierry <julien.thierry@arm.com> wrote:
> 
>> I don't see really much documentation on that function. As far as I can
>> tell it is only called once for each site (and if it didn't, we'd always
>> be placing the same instruction, but I agree it wouldn't be nice). It
>> could depend on how far you can expand the notion of "adjusting" :) .
>>
>> Steven, do you have an opinion on whether it would be acceptable to
>> modify function entry code in ftrace_call_adjust() ?
> 
> Just to make sure I'm on the same page as you are. You want to modify
> the function entry code at the time of the ftrace_call_adjust()?
> 

Yes, that was the intention, the reason being that we want to have an
instruction that is just patched once on each entry for initialization.

> I would update the rec->ip to the offset you want at
> ftrace_call_adjust() but not do any modifications. It really isn't safe
> to do it there. But right after that is called, you will have the arch
> specific call of ftrace_make_nop() called with MCOUNT_ADDR as the
> second parameter to let you know that this is the first time the call
> is made at this address. This is where you can do that initial
> modifications.

Yes, this is was the current version of this patch is doing, I was just
wondering whether we could clean things up a little (i.e. have
ftrace_make_nop() not generate a non-nop instruction :) ).

But we're not going to hack through the API if this is definitely not
what it's intended for. We'll keep it as is and just update the rec->ip
with ftrace_call_adjust().

If we really want to clean things up, we could look into patching this
at instruction at build time. But if it's not trivial I guess we can
keep that for a later time.

Thanks,

-- 
Julien Thierry
