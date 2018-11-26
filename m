Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B49BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11AA020865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AL1lPhoI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11AA020865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbeK0FYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 00:24:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:53244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726745AbeK0FYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 00:24:51 -0500
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B244A208E4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 18:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543256994;
        bh=7HfgAS31S3MBTg6aCWFB7OG7qwwUQNkUtAAt6bQyTHs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AL1lPhoIt7FGDbOB7x93yIelShfAGAs/XxuzPtDScgQOavPlWg/IU6CUD0p22w0yS
         SeXeDUVMFTgc2Ah8AfeeDbN0c6j9oukykejegZrpMV+zTFx/5/Ix53dIGrDU2ZZjAw
         D0jNJuCulmhT2Kf34sET2qgcOR21Hp9zzUMNJqWw=
Received: by mail-wm1-f45.google.com with SMTP id y185so13150173wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 10:29:53 -0800 (PST)
X-Gm-Message-State: AA+aEWbBvq6nrHnVnjJfis93bCkkBn5McuBei0wwR5/RHUU8LYzaXHa8
        riDGMdbxcbcizVw273Bf8Nneb0Lmn++x6PgGUBJr3g==
X-Google-Smtp-Source: AJdET5eYdvGDoeNsLHYwqYlmUeF3j0KwcSKR8p7r4mL7xnccS1a4yi78jaCaSO2uFVvwXyYm3g8jKj01FqrKin0v3is=
X-Received: by 2002:a1c:b1d5:: with SMTP id a204mr25099599wmf.32.1543256992210;
 Mon, 26 Nov 2018 10:29:52 -0800 (PST)
MIME-Version: 1.0
References: <20181119214809.6086-1-yu-cheng.yu@intel.com> <CALCETrWLtpfkecfUAXJ64Z5xDeHPJxTQSci+T4RCem7vCqorTw@mail.gmail.com>
 <35b33f293bc392df71710102f38fa6a40d0bb996.camel@intel.com>
In-Reply-To: <35b33f293bc392df71710102f38fa6a40d0bb996.camel@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 26 Nov 2018 10:29:40 -0800
X-Gmail-Original-Message-ID: <CALCETrV4BP6gTgVZos19WZrbgEH7t4PqPOeP2VJte1kE=ehokg@mail.gmail.com>
Message-ID: <CALCETrV4BP6gTgVZos19WZrbgEH7t4PqPOeP2VJte1kE=ehokg@mail.gmail.com>
Subject: Re: [RFC PATCH v6 00/26] Control-flow Enforcement: Shadow Stack
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Rich Felker <dalias@libc.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        "H. J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 9:44 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> On Thu, 2018-11-22 at 08:53 -0800, Andy Lutomirski wrote:
> > [cc some more libc folks]

>
> >
> > 2. I want to be able to modify the signal context from a signal
> > handler such that, when the signal handler returns, it will return to
> > a frame higher up on the call stack than where the signal started and
> > to a different RIP value.  How can I do this?  I guess I can modify
> > the shadow stack with WRSS if WR_SHSTK_EN=1, but how do I tell the
> > kernel to kindly skip the frames I want to skip when I do sigreturn()?
> >
> > The reason I'm asking #2 is that I think it's time to resurrect my old
> > vDSO syscall cancellation helper series here:
> >
> > https://lwn.net/Articles/679434/
>
> If tools/testing/selftests/x86/unwind_vdso.c passes, can we say the kernel does
> the right thing?  Or do you have other tests that I can run?

I haven't written the relevant test yet.  Hopefully soon :)
