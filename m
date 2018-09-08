Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F42DC4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 04:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C2C20861
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 04:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKvtyOuc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5C2C20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbeIHJUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 05:20:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:37738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbeIHJUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 05:20:36 -0400
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA2082087A
        for <linux-kernel@vger.kernel.org>; Sat,  8 Sep 2018 04:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536381377;
        bh=LXsXy+TcqjToJsbqE727kDipz19PFsi6ymkjPNq1Mic=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=NKvtyOucSPdCi6fcBqB/AluRmeFK1lxZ8daNf89EqxtKA82UGgoVVfFp2zL4ZbxJR
         s31OWAqcAipTtXa/Vxk0/mljmdbr/r/1ubKuEIIvRUs5CWDlXznjxjjqC3t2qVRrJ4
         2+Tu+RlFTcOuQhxdjiuuaZesn04wWgrYmULAJLvk=
Received: by mail-wm0-f51.google.com with SMTP id r1-v6so982260wmh.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 21:36:16 -0700 (PDT)
X-Gm-Message-State: APzg51DPf3tPYk4vWEylhg7u20pa4vq0PsOfTixP2QTINAEEo8TiXywq
        cJhbcYqcAgveQTjAfuez0Gk+Wu31lxveHLZJyxSKrg==
X-Google-Smtp-Source: ANB0VdYBhMh0yvBxh46C7U7g98R/AgNlMzvLody4jSkU74TpnX26xH+SKvWKG1AsmU8JMU56wX/9WsWuPHn2q/U02mc=
X-Received: by 2002:a1c:8313:: with SMTP id f19-v6mr6477791wmd.144.1536381375231;
 Fri, 07 Sep 2018 21:36:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:7810:0:0:0:0:0 with HTTP; Fri, 7 Sep 2018 21:35:54 -0700 (PDT)
In-Reply-To: <20180907164014.g6logz3piqptaj2s@treble>
References: <cover.1536015544.git.luto@kernel.org> <8c7c6e483612c3e4e10ca89495dc160b1aa66878.1536015544.git.luto@kernel.org>
 <20180907164014.g6logz3piqptaj2s@treble>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 7 Sep 2018 21:35:54 -0700
X-Gmail-Original-Message-ID: <CALCETrXwhYBZa_CrPZcGQTJEnhbVv+fMm34dPaQ8axTSF0T-pg@mail.gmail.com>
Message-ID: <CALCETrXwhYBZa_CrPZcGQTJEnhbVv+fMm34dPaQ8axTSF0T-pg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] x86/pti/64: Remove the SYSCALL64 entry trampoline
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 7, 2018 at 9:40 AM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
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
>>
>> Signed-off-by: Andy Lutomirski <luto@kernel.org>
>
> The following commit should also be reverted:
>
>   4d99e4136580 ("perf machine: Workaround missing maps for x86 PTI entry trampolines")

I think we shouldn't, since the perf folks want new perf versions to
be fully functional on older kernels.  My plan was to let the perf
crew do whatever reversions they felt appropriate.
