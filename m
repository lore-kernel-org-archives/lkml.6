Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC76C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA4320838
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJtj7sAp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA4320838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387638AbeKWDde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:33:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:40190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729534AbeKWDdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 22:33:33 -0500
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5177120865
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 16:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542905601;
        bh=CuRmImU4WOPbcRYBzpG4qMGkJYyk5ngkcvLIWa0dWNU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DJtj7sApMntrhuGEqe7UAgvfztFCUC6h8G9p5C4tabqRKaMZXzdbJW0ovKYD21ssW
         9RCR/5UzhRO5pLDuAaL94aKHyA9is/W8mx/hRwPDh8Qmbe/p+VSB1fvx9aTTbFbbkq
         g7gBcvNh8F7FM4ifAcYkg6CezESmmCN0zwHF3/TM=
Received: by mail-wm1-f53.google.com with SMTP id k198so9780927wmd.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 08:53:21 -0800 (PST)
X-Gm-Message-State: AGRZ1gKHNnHmB9RgY2Sa33GrIBGx1WH9cWII7x/P9zC+xgLAY1jq66yE
        FlubeEjYLKoSzuicfXzIncTy7pfJ16FGphY7+JDqYw==
X-Google-Smtp-Source: AJdET5f5Dlgse9j7JrPNXckCrOj30u5+XDNnQs/OgyGTSIwc5f4bgTZMvyiRTn90C9GYlwtWNtvn74CW2THyCMy3Jzg=
X-Received: by 2002:a1c:f112:: with SMTP id p18mr9970251wmh.83.1542905599799;
 Thu, 22 Nov 2018 08:53:19 -0800 (PST)
MIME-Version: 1.0
References: <20181119214809.6086-1-yu-cheng.yu@intel.com>
In-Reply-To: <20181119214809.6086-1-yu-cheng.yu@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 22 Nov 2018 08:53:08 -0800
X-Gmail-Original-Message-ID: <CALCETrWLtpfkecfUAXJ64Z5xDeHPJxTQSci+T4RCem7vCqorTw@mail.gmail.com>
Message-ID: <CALCETrWLtpfkecfUAXJ64Z5xDeHPJxTQSci+T4RCem7vCqorTw@mail.gmail.com>
Subject: Re: [RFC PATCH v6 00/26] Control-flow Enforcement: Shadow Stack
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Rich Felker <dalias@libc.org>
Cc:     X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
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

[cc some more libc folks]

I have a general question about this patch set:

If I'm writing a user program, and I write a signal handler, there are
two things I want to make sure I can still do:

1. I want to be able to unwind directly from the signal handler
without involving sigreturn() -- that is, I want to make sure that
siglongjmp() works.  How does this work?  Is INCSSP involved?  How
exactly does the user program know how much to increment SSP by?  (And
why on Earth does INCSSP only consider the low 8 bits of its argument?
 That sounds like a mistake.  Can Intel still fix that?  On the other
hand, what happens if you INCSSP off the end of the shadow stack
entirely?  I assume the next access will fault as long as there's an
appropriate guard page.)

2. I want to be able to modify the signal context from a signal
handler such that, when the signal handler returns, it will return to
a frame higher up on the call stack than where the signal started and
to a different RIP value.  How can I do this?  I guess I can modify
the shadow stack with WRSS if WR_SHSTK_EN=1, but how do I tell the
kernel to kindly skip the frames I want to skip when I do sigreturn()?

The reason I'm asking #2 is that I think it's time to resurrect my old
vDSO syscall cancellation helper series here:

https://lwn.net/Articles/679434/

and it's not at all clear to me that __vdso_abort_pending_syscall()
can work without kernel assistance when CET is enabled.  I want to
make sure that it can be done, or I want to come up with some other
way to allow a signal handler to abort a syscall while CET is on.  I
could probably change __vdso_abort_pending_syscall() to instead point
RIP to __kernel_vsyscall's epilogue so that we con't change the depth
of the call stack.  But I could imagine that other user programs might
engage in similar shenanigans and want to have some way to unwind a
signal's return context without actually jumping there a la
siglongjmp().

Also, what is the intended setting of WR_SHSTK_EN with this patch set applied?

(I suppose we could just say that 32-bit processes should not use CET,
but that seems a bit sad.)
