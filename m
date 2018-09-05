Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F6AC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF9B20659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxiN7csp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DF9B20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeIFCDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:03:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbeIFCDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:03:54 -0400
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C0FE2083D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Sep 2018 21:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536183110;
        bh=LzfNpR4eMoKy28v1gN3arblecNY/tzLOmmFtnXcdPzs=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=VxiN7csp4udW8UYcdtXJXY8W4N1LnWS+VxqbfU5EkPCz31jMAvrT00nCQwqlwyyBN
         VmtB+Ae7AGQ3pC0qOtWwB2c3aAo8co9wDMw+pxat8c/DqHp/Ygj8aosdQMneIoQMdZ
         4heJdmr4f0XI2hDt+xDKiMHzpA82OXRuXePKXDtg=
Received: by mail-wm0-f52.google.com with SMTP id 207-v6so9096724wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 14:31:50 -0700 (PDT)
X-Gm-Message-State: APzg51CWViBBN7Y1btVxHN1Q4DWx4T46SmfU44ivMNNSZSWD1AV+MSN4
        4T10/M3CJjjCuH1PhSrvnWghSD/hfykPuhKxwUavIg==
X-Google-Smtp-Source: ANB0VdZWEOimacuK2QkDoAObEJk5RAl/4J1c88XsLNKbs4l57X3ogf4VZhGQ0Tpz+4h4OJmqnnvIdPzlWs81/nYCOk4=
X-Received: by 2002:a1c:3413:: with SMTP id b19-v6mr171641wma.21.1536183108849;
 Wed, 05 Sep 2018 14:31:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:7810:0:0:0:0:0 with HTTP; Wed, 5 Sep 2018 14:31:28 -0700 (PDT)
In-Reply-To: <20180904070455.GX24124@hirez.programming.kicks-ass.net>
References: <cover.1536015544.git.luto@kernel.org> <8c7c6e483612c3e4e10ca89495dc160b1aa66878.1536015544.git.luto@kernel.org>
 <20180904070455.GX24124@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 5 Sep 2018 14:31:28 -0700
X-Gmail-Original-Message-ID: <CALCETrUZm3KsonYVd5sn=LhoGZ2ciO7xT_Fz=jD_HZ04tB9o=Q@mail.gmail.com>
Message-ID: <CALCETrUZm3KsonYVd5sn=LhoGZ2ciO7xT_Fz=jD_HZ04tB9o=Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] x86/pti/64: Remove the SYSCALL64 entry trampoline
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 12:04 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, Sep 03, 2018 at 03:59:44PM -0700, Andy Lutomirski wrote:
>> The SYSCALL64 trampoline has a couple of nice properties:
>>
>>  - The usual sequence of SWAPGS followed by two GS-relative accesses to
>>    set up RSP is somewhat slow because the GS-relative accesses need
>>    to wait for SWAPGS to finish.  The trampoline approach allows
>>    RIP-relative accesses to set up RSP, which avoids the stall.
>>
>>  - The trampoline avoids any percpu access before CR3 is set up,
>>    which means that no percpu memory needs to be mapped in the user
>>    page tables.  This prevents using Meltdown to read any percpu memory
>>    outside the cpu_entry_area and prevents using timing leaks
>>    to directly locate the percpu areas.
>>
>> The downsides of using a trampoline may outweigh the upsides, however.
>> It adds an extra non-contiguous I$ cache line to system calls, and it
>> forces an indirect jump to transfer control back to the normal kernel
>> text after CR3 is set up.  The latter is because x86 lacks a 64-bit
>> direct jump instruction that could jump from the trampoline to the entry
>> text.  With retpolines enabled, the indirect jump is extremely slow.
>>
>> This patch changes the code to map the percpu TSS into the user page
>> tables to allow the non-trampoline SYSCALL64 path to work under PTI.
>> This does not add a new direct information leak, since the TSS is
>> readable by Meltdown from the cpu_entry_area alias regardless.  It
>> does allow a timing attack to locate the percpu area, but KASLR is
>> more or less a lost cause against local attack on CPUs vulnerable to
>> Meltdown regardless.  As far as I'm concerned, on current hardware,
>> KASLR is only useful to mitigate remote attacks that try to attack
>> the kernel without first gaining RCE against a vulnerable user
>> process.
>>
>> On Skylake, with CONFIG_RETPOLINE=y and KPTI on, this reduces
>> syscall overhead from ~237ns to ~228ns.
>>
>> There is a possible alternative approach: we could instead move the
>> trampoline within 2G of the entry text and make a separate copy for
>> each CPU.  Then we could use a direct jump to rejoin the normal
>> entry path.
>
> Can we have a few words on why this solution and not this alternative? I
> mean, you raise the possibility, but then surely you chose not to
> implement that. Might as well share that with us.

I can give some pros and cons.  With the other approach:

 - We avoid a pipeline stall.
 - We execute from an extra page and read from another extra page
during the syscall.  (The latter is because we need to use a relative
addressing mode to find sp1 -- it's the same *cacheline* we'd use
anyway, but we're accessing it using an alias, so it's an extra TLB
entry.)
 - We use more memory.  This would be one page per CPU for a simple
implementation and 64-ish bytes per CPU or one page per node for a
more complex implementation.
 - More code complexity.

I'm not convinced this is a good tradeoff.
