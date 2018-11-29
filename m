Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AE1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E532145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QkCGqzyj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8E532145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbeK3Gbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:31:33 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34765 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbeK3Gbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 01:31:33 -0500
Received: by mail-lj1-f195.google.com with SMTP id u6-v6so2803768ljd.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 11:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XQeagdLFyvMM9scr2P7YsfnFCA7ncq0KUIIuv74kyQE=;
        b=QkCGqzyjxiOiKMg1LWSPGOmqibHQ1MV3aARK4ImIZxhOn9rEyFOTLh70EN1fJ3izGt
         y8MC4eYQ7e0wiAYqjlrUMRGwRqxDn+TXc43CT/XtALVnRECqYDh4tsMm1k8lZsRbVmnz
         o6QyD1iA6BmuPIyslXWfeOvgYb6a0XCbxeheU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XQeagdLFyvMM9scr2P7YsfnFCA7ncq0KUIIuv74kyQE=;
        b=RoPnaLEjuLEz4TGuXzpdseB/cQe9sTCro9AXKkEe4i6OBaRAuWTCrhVDgT1ZeakE93
         oO9iT54itEOCQ/R8BsMrd3U5FhR3FtkL/IEyDEleEs6eSjmHx90qXl6WitsLAVnIphYO
         zN/mwqMw0HHI2u5GQRCKXpSpuDTGHA66/POzHXOBZnQK15dctI0w7ZAqs2Q2HUwgK4PR
         q2hkc/KiQnvY1U71r8l+lb+TF3pRl1ybSV7BYA4DJ6PknjjxECRWLxsvxR+SSR4zi0mc
         m9ZdlOpOVE+fG1rjpnqKacSHmq9UNxaEjWrbPwADAuduP7Y591TX3IyVSu+RxpUkLfnO
         Pl3w==
X-Gm-Message-State: AA+aEWawMnhJYFL9bZYuGoFpPeyc1+0VlAZLJA4NaojmJEFhG0094Tq6
        5QHOtLNzPXshfJtQ+Ue5MFOqSKLfMc8=
X-Google-Smtp-Source: AFSGD/UcrTZPBFJpbDVHNNQFwy3F777Luv3J6Mt/tT7OaVr9hacPH2A3rNGbaF+RtZWgjhsXHWZhMQ==
X-Received: by 2002:a2e:9f56:: with SMTP id v22-v6mr1900543ljk.114.1543519502855;
        Thu, 29 Nov 2018 11:25:02 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id p138sm448470lfp.22.2018.11.29.11.25.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 11:25:01 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id v1-v6so2805579ljd.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 11:25:00 -0800 (PST)
X-Received: by 2002:a2e:9983:: with SMTP id w3-v6mr2069361lji.133.1543519500423;
 Thu, 29 Nov 2018 11:25:00 -0800 (PST)
MIME-Version: 1.0
References: <20181126160217.GR2113@hirez.programming.kicks-ass.net>
 <CALCETrXam8JBtXE3S97Vyb_=+pmjgr23SoZ-Dm5pmYtwZYA+7Q@mail.gmail.com>
 <20181129094210.GC2131@hirez.programming.kicks-ass.net> <ECF632D9-581B-40B7-9F0A-6B5607A4D0E3@amacapital.net>
 <20181129143853.GO2131@hirez.programming.kicks-ass.net> <20181129163342.tp5wlfcyiazwwyoh@treble>
 <CAHk-=wg5wUXJX5mF+22WXWM_vPESb+p6-z-ZrG7rC1k2O7u=NQ@mail.gmail.com>
 <0A629D30-ADCF-4159-9443-E5727146F65F@amacapital.net> <20181129121307.12393c57@gandalf.local.home>
 <CAHk-=wik5AfDs7qqjGHQ5vRBYkV8K6tFmPna3PdbwdzVwPGTsg@mail.gmail.com>
 <20181129124404.2fe55dd0@gandalf.local.home> <CAHk-=wgnZobye-KNaBVO-SdqX-5Xkz+i=aJ_kOFZ4RpZFT0HqQ@mail.gmail.com>
 <20181129125857.75c55b96@gandalf.local.home> <CAHk-=wigLUgxDM6Dq2aS7efduffratP976Ggmpv4Ev4EOrJxyA@mail.gmail.com>
 <20181129134725.6d86ade6@gandalf.local.home> <CAHk-=wgbnQs4fpuHqT1jLkDnKcvTGS5EN8m=qy7oUE5n_fhOig@mail.gmail.com>
 <20181129141648.6ef944a9@gandalf.local.home>
In-Reply-To: <20181129141648.6ef944a9@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Nov 2018 11:24:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=whBuSXe1+8HGT23FWDypkAP7TPun3te=fw2aLx+F6WVig@mail.gmail.com>
Message-ID: <CAHk-=whBuSXe1+8HGT23FWDypkAP7TPun3te=fw2aLx+F6WVig@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, mhiramat@kernel.org,
        jbaron@akamai.com, Jiri Kosina <jkosina@suse.cz>,
        David.Laight@aculab.com, bp@alien8.de, julia@ni.com,
        jeyu@kernel.org, Peter Anvin <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 11:16 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> But then we need to implement all numbers of parameters.

Oh, I agree, it's nasty.

But it's actually a nastiness that we've solved before. In particular,
with the system call mappings, which have pretty much the exact same
issue of "map unknown number of arguments to registers".

Yes, it's different - there you map the unknown number of arguments to
a structure access instead. And yes, the macros are unbelievably ugly.
See

    arch/x86/include/asm/syscall_wrapper.h

and the __MAP() macro from

    include/linux/syscalls.h

so it's not pretty. But it would solve all the problems.

              Linus
