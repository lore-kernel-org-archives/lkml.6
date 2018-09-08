Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C15BC4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 00:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B2420855
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 00:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JvF2jbc6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B2420855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbeIHEsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 00:48:15 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:53889 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725734AbeIHEsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 00:48:15 -0400
Received: by mail-it0-f65.google.com with SMTP id p79-v6so22800589itp.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 17:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V8Hb5eo2IAn6bzrwuAPn2lLbXAl4LLOfWlAsZBkzIUo=;
        b=JvF2jbc6549jRlpvwwyVhK6zsKeRo0j7ATKatF41CHAW3EhmoPdxPF2MCA3GJYbduA
         xTcVZbBeJqK26RXsa/aiRT13QUPQ9XnAIk7g5TJp7EeEbt7DSIlvsfOe0R/7gJUbDe9y
         iSxH2h3aGsyuUw4e/nsWXyRWtmIHTc5m+gMkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V8Hb5eo2IAn6bzrwuAPn2lLbXAl4LLOfWlAsZBkzIUo=;
        b=bo1K+swAHdNHFCQNk/owVgPPBp88iyjYJXVvPbP4uJH95jTS89eUzoKagNsK3Eiqbv
         7tuc0YJWBfLxsIUbsXm5e6RZbUv0vI5pyzTsytPyeW8rnq1T41f1b1wAhl6hArelqLks
         On/yD/m4EMFYdH2vaZ5THb0VJFSdUaZMc8ASaVGd2dvz9yEIkmMesTQd4nCuAHwVSIF5
         V/RkX8rP6SaCAAU7InMJgnX1RzLPYKm5gAaM2Wu4VWGpWLpBLky7Bp3lRYog7i5UGnG3
         2LuI9h8D3TC2/j7qVlFAFknTTgzj/qK+3sWWIq4c6CIqGe9CpeLuZNOFOnzltXYCKwVw
         DbEg==
X-Gm-Message-State: APzg51By1Kp/o/quNkduDswJqT7neKYOdZ+cEsvAL5GDd8PNkLuz9o9x
        7YAKhmBEV9r3W5Dnwhydma4rsIunWu2pphXwrWE=
X-Google-Smtp-Source: ANB0VdbSck9ZUsnGq5wGr8Rxdy5XXaZ1Yeo8MVQCEHL0RiYV/2eMInA8NiTqWqfQiu7bC66+9DnNjA43JFKLa6doJcM=
X-Received: by 2002:a24:61d2:: with SMTP id s201-v6mr10261997itc.22.1536365089867;
 Fri, 07 Sep 2018 17:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536015544.git.luto@kernel.org> <8c7c6e483612c3e4e10ca89495dc160b1aa66878.1536015544.git.luto@kernel.org>
 <20180904070455.GX24124@hirez.programming.kicks-ass.net> <CALCETrUZm3KsonYVd5sn=LhoGZ2ciO7xT_Fz=jD_HZ04tB9o=Q@mail.gmail.com>
 <alpine.DEB.2.21.1809072145460.1402@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1809072145460.1402@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Sep 2018 17:04:38 -0700
Message-ID: <CA+55aFz9aZUo0psXDqiQ4aTZSiiU-mRr_PSWkm_vzAZzpdhMmg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] x86/pti/64: Remove the SYSCALL64 entry trampoline
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrew Lutomirski <luto@kernel.org>,
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

On Fri, Sep 7, 2018 at 12:54 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> >  - We execute from an extra page and read from another extra page
> > during the syscall.  (The latter is because we need to use a relative
> > addressing mode to find sp1 -- it's the same *cacheline* we'd use
> > anyway, but we're accessing it using an alias, so it's an extra TLB
> > entry.)
>
> Ok, but is this really an issue with PTI?

I'd expect it to be *more* of an issue with PTI, since you're already
wasting TLB entries due to the whole "two different page tables".

Sure, address space ID's save you from reloading them all the time,
but don't help with capacity.

But yeah, in the sense of "with PTI, all kernel entries are slow
anyway, so none of this matters" is probably correct in a very real
sense.

That said, the real reason I like Andy's patch series is that I think
it's simpler than the alternatives (including the current setup). No
subtle mappings, no nothing. It removes a lot more lines than it adds,
and half the lines that it *does* add are comments.

Virtual mapping tricks may be cool, but in the end, not having to use
them is better still, I think.

              Linus
