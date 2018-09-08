Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC18C43143
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 04:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0E320855
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 04:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zC+hQoE3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA0E320855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbeIHJRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 05:17:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:34898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbeIHJRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 05:17:36 -0400
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com [74.125.82.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D2C12086C
        for <linux-kernel@vger.kernel.org>; Sat,  8 Sep 2018 04:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536381197;
        bh=hA5j9bNFbyhEK4bOiJ5kZOzOMMLl4T/axPLrTgN92W8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=zC+hQoE3J4IY4YlWnFkwvsUGWfpSXAts5oNH0oI9uN4GQyZ66Se6K7rG9/1O3i/ND
         Xi2OROPtgFRD+MJiayLZqk7j3CFRZYfaxVoci3IkfHsYC1SH2OUOq/SfxbIMB6U0Xk
         w+mR5mHYIGbheZMmVkGgL6XNSDke73eT+KZk6W94=
Received: by mail-wm0-f47.google.com with SMTP id s12-v6so16450325wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 21:33:16 -0700 (PDT)
X-Gm-Message-State: APzg51CbqS8YG0gEHJVtmdn5FeVdWWVZJy8XJ6Jma3Sfj0KEPO6eRW1Q
        RfujLSIZ5/482DzPWtRHxC/fqR6teRA3cOV+No7qQw==
X-Google-Smtp-Source: ANB0VdaFdxZfDTqBFQQutEwkJL+OzJSNZt7FT5wA88kOefAwBTM4hIOkJurgfl9VFY5Mrifd6wrrgEFpOGFXRAcpKb0=
X-Received: by 2002:a1c:3503:: with SMTP id c3-v6mr6582716wma.46.1536381195416;
 Fri, 07 Sep 2018 21:33:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:7810:0:0:0:0:0 with HTTP; Fri, 7 Sep 2018 21:32:54 -0700 (PDT)
In-Reply-To: <CA+55aFz9aZUo0psXDqiQ4aTZSiiU-mRr_PSWkm_vzAZzpdhMmg@mail.gmail.com>
References: <cover.1536015544.git.luto@kernel.org> <8c7c6e483612c3e4e10ca89495dc160b1aa66878.1536015544.git.luto@kernel.org>
 <20180904070455.GX24124@hirez.programming.kicks-ass.net> <CALCETrUZm3KsonYVd5sn=LhoGZ2ciO7xT_Fz=jD_HZ04tB9o=Q@mail.gmail.com>
 <alpine.DEB.2.21.1809072145460.1402@nanos.tec.linutronix.de> <CA+55aFz9aZUo0psXDqiQ4aTZSiiU-mRr_PSWkm_vzAZzpdhMmg@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 7 Sep 2018 21:32:54 -0700
X-Gmail-Original-Message-ID: <CALCETrXw9kjeGTrGBy=VMV_2pqAUC4bRZVMgvTrqkZ-EzO80_A@mail.gmail.com>
Message-ID: <CALCETrXw9kjeGTrGBy=VMV_2pqAUC4bRZVMgvTrqkZ-EzO80_A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] x86/pti/64: Remove the SYSCALL64 entry trampoline
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 7, 2018 at 5:04 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Sep 7, 2018 at 12:54 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> >  - We execute from an extra page and read from another extra page
>> > during the syscall.  (The latter is because we need to use a relative
>> > addressing mode to find sp1 -- it's the same *cacheline* we'd use
>> > anyway, but we're accessing it using an alias, so it's an extra TLB
>> > entry.)
>>
>> Ok, but is this really an issue with PTI?
>
> I'd expect it to be *more* of an issue with PTI, since you're already
> wasting TLB entries due to the whole "two different page tables".
>
> Sure, address space ID's save you from reloading them all the time,
> but don't help with capacity.
>
> But yeah, in the sense of "with PTI, all kernel entries are slow
> anyway, so none of this matters" is probably correct in a very real
> sense.
>
> That said, the real reason I like Andy's patch series is that I think
> it's simpler than the alternatives (including the current setup). No
> subtle mappings, no nothing. It removes a lot more lines than it adds,
> and half the lines that it *does* add are comments.
>
> Virtual mapping tricks may be cool, but in the end, not having to use
> them is better still, I think.
>

If (and this is a *big* if) all the percpu data is within 2GB of the
entry text, then we could avoid this extra TLB reference by accessing
it directly instead of using an alias.

I suppose the summary is that the retpoline-free trampoline variant is
even more complicated than the code I'm removing in this series, and
that it would be at best a teeny tiny win.  Once all the Spectre dust
settles and we get fixed CPUs, we could consider re-optimizing this.
