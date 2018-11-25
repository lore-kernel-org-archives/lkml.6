Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9ABAC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 20:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7BFE2082E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 20:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="f5GO/CNd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7BFE2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbeKZHc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 02:32:29 -0500
Received: from mail-lf1-f45.google.com ([209.85.167.45]:36580 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbeKZHc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 02:32:28 -0500
Received: by mail-lf1-f45.google.com with SMTP id a16so12007688lfg.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 12:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qiv54Uxx5aVxowin1oJD7EqWbMaSpOp82WQpDHzshQc=;
        b=f5GO/CNddvcGJ7hZvGFHkl90fcVGRwoMaeWeIGaJa/edRsyz70qI6nom9wxWkwPh7i
         Dy/e0m6LKpN/7PBxw6Il2imoxq/NnU61N8lptyauu4xn0DS4UWD7rSiJYMMT0on1AuQR
         sJgVXpsE4AqWkkCM3v2Fidr5Q7DfuOMrf8wRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qiv54Uxx5aVxowin1oJD7EqWbMaSpOp82WQpDHzshQc=;
        b=EiqXtb1vQB9CyhBUmZVrEDS3h32UQi3SuW+/4SdO44mY820Qw8p7ungZG5HtR/SCMs
         +yr2mZ/QeYSGo499FsrR0XktIseskLKr07gXDo63mQ6KDtCOJ4EVwowq9Ro8yObnGwcq
         HyXLkVIzDS2LZK6LAJrDxWjEOcPYp0d+ead0nHUxCJB6czEPM4NWAih3z6N6c79yQzXr
         puoJi5ZnwV+SmZx48/exocn6TlGL8pqM4wGxLr0n5k1ptPP3b/O2j3BFzt4v96BAPeKy
         V7GESNzR5/QusFwDG6SHGyE8ENeIRnvbNgY1z/H/vG0Umut7tM8Zr881fJF009jvzAdt
         xpeQ==
X-Gm-Message-State: AGRZ1gLKHt7qVK+uEXwKWrvo0wxAmP36K1c3u6BPnFoR24zn1LkDhmmE
        Xk0E/443WYwOZ4h7BQS38ad00NMk0n8=
X-Google-Smtp-Source: AJdET5cTUt+lFah7aIFWuBo9IQl3jmf/2o7nNLQUrPs/XTvsvD2YUVlr/WpOHmOzx9+PpHeplXW9MA==
X-Received: by 2002:a19:41c4:: with SMTP id o187mr14813306lfa.32.1543178432636;
        Sun, 25 Nov 2018 12:40:32 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id t18sm8712981lft.93.2018.11.25.12.40.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Nov 2018 12:40:31 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id e5-v6so14673545lja.4
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 12:40:30 -0800 (PST)
X-Received: by 2002:a2e:2416:: with SMTP id k22-v6mr16711994ljk.80.1543178430163;
 Sun, 25 Nov 2018 12:40:30 -0800 (PST)
MIME-Version: 1.0
References: <20181125183328.318175777@linutronix.de> <20181125185006.051663132@linutronix.de>
In-Reply-To: <20181125185006.051663132@linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 25 Nov 2018 12:40:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=whtiX45YPjFPMFuktZ3WB23zqBZR-rL6RewrTyvrFj2Fw@mail.gmail.com>
Message-ID: <CAHk-=whtiX45YPjFPMFuktZ3WB23zqBZR-rL6RewrTyvrFj2Fw@mail.gmail.com>
Subject: Re: [patch V2 27/28] x86/speculation: Add seccomp Spectre v2 user
 space protection mode
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Jiri Kosina <jkosina@suse.cz>, thomas.lendacky@amd.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, dave.hansen@intel.com,
        Casey Schaufler <casey.schaufler@intel.com>,
        "Mallick, Asit K" <asit.k.mallick@intel.com>,
        "Van De Ven, Arjan" <arjan@linux.intel.com>, jcm@redhat.com,
        longman9394@gmail.com, Greg KH <gregkh@linuxfoundation.org>,
        david.c.stewart@intel.com, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ You forgot to fix your quilt setup.. ]

On Sun, 25 Nov 2018, Thomas Gleixner wrote:
>
> The mitigation guide documents how STIPB works:
>
>    Setting bit 1 (STIBP) of the IA32_SPEC_CTRL MSR on a logical processor
>    prevents the predicted targets of indirect branches on any logical
>    processor of that core from being controlled by software that executes
>    (or executed previously) on another logical processor of the same core.

Can we please just fix this stupid lie?

Yes, Intel calls it "STIBP" and tries to make it out to be about the
indirect branch predictor being per-SMT thread.

But the reason it is unacceptable is apparently because in reality it just
disables indirect branch prediction entirely. So yes, *technically* it's
true that that limits indirect branch prediction to just a single SMT
core, but in reality it is just a "go really slow" mode.

If STIBP had actually just keyed off the logical SMT thread, we wouldn't
need to have worried about it in the first place.

So let's document reality rather than Intel's Pollyanna world-view.

Reality matters. It's why we had to go all this. Lying about things
and making it appear like it's not a big deal was why the original
patch made it through without people noticing.

           Linus
