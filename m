Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53926C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 17:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F366520837
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 17:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RruPOe50"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F366520837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeIAVmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 17:42:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727286AbeIAVmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 17:42:53 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03CA42084D
        for <linux-kernel@vger.kernel.org>; Sat,  1 Sep 2018 17:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535823011;
        bh=Rp8enPkcw/9tdfo1GtjDKCO4T9DZurgZGx/JqIeGyJ0=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=RruPOe50T2Q81hMpIQ0I7CqeJUpbGU9lFYRHLNSmvOf/sug5ytIF3NgglxPQLrwfC
         B8b2Ue0iDkG1Y+NLC8fYz+HIvXVpjhpCpUsGl1SRt6Qt5hHo4++CxjaWTlkcohsu9f
         PanmGOblPb/UcUs5rcIS8KAG8ESus8WWf1IaYb2Q=
Received: by mail-wr1-f46.google.com with SMTP id 20-v6so13941661wrb.12
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 10:30:10 -0700 (PDT)
X-Gm-Message-State: APzg51ByB7MEmhF+cG+rfjUV1px3VyIyZ+V1dV7jovQvhfrTxnJfetEA
        yOZR731URp/tG6saILLfepWq8HeB7jUoeFYE6Us8WQ==
X-Google-Smtp-Source: ANB0VdZWnwFWM2/z0jRcKmq7zn5USvS0JKxdZUOrnigwm0Hg9dOW4CFEcm1HwBpVkRrBeuW58dyOPuyql1btUuhNS6M=
X-Received: by 2002:adf:c554:: with SMTP id s20-v6mr13747019wrf.46.1535823009388;
 Sat, 01 Sep 2018 10:30:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:9045:0:0:0:0:0 with HTTP; Sat, 1 Sep 2018 10:29:48 -0700 (PDT)
In-Reply-To: <CA+55aFwOMt7Qw4HFyBiSNpHXoP3kGRsrQhi3LA_=uxwuNz8G0Q@mail.gmail.com>
References: <cover.1535753890.git.luto@kernel.org> <9d79fddf6bab2fc40c2472bdea47f864603c1bf4.1535753890.git.luto@kernel.org>
 <CA+55aFwOMt7Qw4HFyBiSNpHXoP3kGRsrQhi3LA_=uxwuNz8G0Q@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 1 Sep 2018 10:29:48 -0700
X-Gmail-Original-Message-ID: <CALCETrUvz-VWpLYsYoC-buKMUBPPTHdOj6OeRE7Vv+--eZPKAQ@mail.gmail.com>
Message-ID: <CALCETrUvz-VWpLYsYoC-buKMUBPPTHdOj6OeRE7Vv+--eZPKAQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] x86/entry/64: Use the TSS sp2 slot for rsp_scratch
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 1, 2018 at 9:33 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Aug 31, 2018 at 3:21 PM Andy Lutomirski <luto@kernel.org> wrote:
>>
>>  #ifdef CONFIG_X86_64
>>  # define cpu_current_top_of_stack (cpu_tss_rw + TSS_sp1)
>> +# define rsp_scratch (cpu_tss_rw + TSS_sp2)
>>  #endif
>
> Ugh. The above gets used by *assembler* code. I was really confused by how this:
>
>
>> --- a/arch/x86/kernel/process_64.c
>> +++ b/arch/x86/kernel/process_64.c
>> @@ -59,8 +59,6 @@
>>  #include <asm/unistd_32_ia32.h>
>>  #endif
>>
>> -__visible DEFINE_PER_CPU(unsigned long, rsp_scratch);
>> -
>
> could continue to work despite the accesses to "rsp_scratch" still
> remaining in the asm files.
>
> Can yu humor me, and just not do something quite that subtle. I must
> have missed this the first time around.
>
> Please get rid of the define, and just make the asm code spell out
> what it actually does.

Done for v2.

>
> We already do that for TSS_sp0 for the normal case:
>
>       movq    PER_CPU_VAR(cpu_tss_rw + TSS_sp0), %rsp
>
> so I think this should just change
>
> -     movq    %rsp, PER_CPU_VAR(rsp_scratch)
> +     movq    %rsp, PER_CPU_VAR(cpu_tss_rw + TSS_sp2)
>
> instead of having that subtle rsp_scratch thing.
>
> And honestly, I think we should strive to do the same thing with
> cpu_current_top_of_stack. There at least the #define currently makes
> sense (because on 32-bit, it's actually a percpu variable, on 64-bit
> it's that sp1 field).
>
> But wouldn't it be nice to just unify 32-bit and 64-bit in this
> respect, and get rid of that subtle difference?
>

Yes.  But ugh, the way that thing has worked has changed so many times
on 32-bit and 64-bit that I've lost track a little bit.  I'll put it
on my long list of things to clean up.
