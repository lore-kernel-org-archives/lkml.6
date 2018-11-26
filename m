Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27195C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F26EF20663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:44:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F26EF20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbeK0EjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:39:07 -0500
Received: from mga01.intel.com ([192.55.52.88]:10294 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbeK0EjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 23:39:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2018 09:44:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,283,1539673200"; 
   d="scan'208";a="283747810"
Received: from yyu32-desk1.sc.intel.com ([143.183.136.147])
  by fmsmga005.fm.intel.com with ESMTP; 26 Nov 2018 09:44:16 -0800
Message-ID: <35b33f293bc392df71710102f38fa6a40d0bb996.camel@intel.com>
Subject: Re: [RFC PATCH v6 00/26] Control-flow Enforcement: Shadow Stack
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Carlos O'Donell <carlos@redhat.com>,
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
Date:   Mon, 26 Nov 2018 09:38:49 -0800
In-Reply-To: <CALCETrWLtpfkecfUAXJ64Z5xDeHPJxTQSci+T4RCem7vCqorTw@mail.gmail.com>
References: <20181119214809.6086-1-yu-cheng.yu@intel.com>
         <CALCETrWLtpfkecfUAXJ64Z5xDeHPJxTQSci+T4RCem7vCqorTw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-11-22 at 08:53 -0800, Andy Lutomirski wrote:
> [cc some more libc folks]
> 
> I have a general question about this patch set:
> 
> If I'm writing a user program, and I write a signal handler, there are
> two things I want to make sure I can still do:
> 
> 1. I want to be able to unwind directly from the signal handler
> without involving sigreturn() -- that is, I want to make sure that
> siglongjmp() works.  How does this work?  Is INCSSP involved?  How

Yes, siglongjmp() works by doing INCSSP.

> exactly does the user program know how much to increment SSP by?  (And
> why on Earth does INCSSP only consider the low 8 bits of its argument?
>  That sounds like a mistake.  Can Intel still fix that?  On the other

GLIBC calculates how many frames to be unwound and breaks into 255 batches when
necessary.

> hand, what happens if you INCSSP off the end of the shadow stack
> entirely?  I assume the next access will fault as long as there's an
> appropriate guard page.)

Yes, that is the case.

> 
> 2. I want to be able to modify the signal context from a signal
> handler such that, when the signal handler returns, it will return to
> a frame higher up on the call stack than where the signal started and
> to a different RIP value.  How can I do this?  I guess I can modify
> the shadow stack with WRSS if WR_SHSTK_EN=1, but how do I tell the
> kernel to kindly skip the frames I want to skip when I do sigreturn()?
> 
> The reason I'm asking #2 is that I think it's time to resurrect my old
> vDSO syscall cancellation helper series here:
> 
> https://lwn.net/Articles/679434/

If tools/testing/selftests/x86/unwind_vdso.c passes, can we say the kernel does
the right thing?  Or do you have other tests that I can run?

> 
> and it's not at all clear to me that __vdso_abort_pending_syscall()
> can work without kernel assistance when CET is enabled.  I want to
> make sure that it can be done, or I want to come up with some other
> way to allow a signal handler to abort a syscall while CET is on.  I
> could probably change __vdso_abort_pending_syscall() to instead point
> RIP to __kernel_vsyscall's epilogue so that we con't change the depth
> of the call stack.  But I could imagine that other user programs might
> engage in similar shenanigans and want to have some way to unwind a
> signal's return context without actually jumping there a la
> siglongjmp().
> 
> Also, what is the intended setting of WR_SHSTK_EN with this patch set applied?

This bit enables WRSS instruction, which writes to kernel SHSTK.  This patch set
uses only WRUSS and WR_SHSTK_EN is not be set.

> 
> (I suppose we could just say that 32-bit processes should not use CET,
> but that seems a bit sad.)

They work in compat mode.  Should anything break, we can fix it.

Yu-cheng

