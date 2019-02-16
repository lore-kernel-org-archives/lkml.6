Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED318C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 00:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3BA222D9
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 00:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391025AbfBPATy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 19:19:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:58836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390732AbfBPATw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 19:19:52 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EEEB222D9;
        Sat, 16 Feb 2019 00:19:50 +0000 (UTC)
Date:   Fri, 15 Feb 2019 19:19:49 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
Message-ID: <20190215191949.04604191@gandalf.local.home>
In-Reply-To: <300C4516-A093-43AE-8707-1C42486807A4@amacapital.net>
References: <20190215174712.372898450@goodmis.org>
        <20190215174945.557218316@goodmis.org>
        <CAHk-=wjP4bEYCFaKZVG4kLWmYBctyfsW9jjhC91tiTk9WwB8Rg@mail.gmail.com>
        <20190215171539.4682f0b4@gandalf.local.home>
        <300C4516-A093-43AE-8707-1C42486807A4@amacapital.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Feb 2019 15:49:35 -0800
Andy Lutomirski <luto@amacapital.net> wrote:

> I’m missing most of the context here, but even probe_kernel_...() is
> unwise for a totally untrustworthy address. It could be MMIO, for
> example.

True, but kprobes are used like modules, and only allowed by root. They
are used to poke literally anywhere one wants. That's the entire
purpose of kprobes.

> 
> If needed, we could come up with a safe-ish helper for tracing.  For
> direct-map addresses, probe_kernel_...() is probably okay.  Same for
> the current stack. Otherwise we could walk the page tables and check
> that the address is cacheable, I suppose, although this is slightly
> dubious if we don’t also check MTRRs. We could also check that the PA
> is in main memory, I suppose, although this may have unfortunate
> interactions with the MCE code.

I added you just because I wanted help getting the change log correct,
as that's what Linus was complaining about. I kept using "kernel
address" when the sample bug used for the patch was really a
non-canonical address (as Linus said, it's just garbage. Neither kernel
or user space). But I pointed out that this can also bug if the
address is canonical and in the kernel address space. The old code
didn't complain about non-canonical or kernel address faulting before
commit 9da3f2b7405, which only talks about kernel address space
faulting (which is why I only mentioned that in my messages).

Would changing all the mention of "kernel address" to "non user space"
be accurate?

 For reference:

  http://lkml.kernel.org/r/20190215174945.557218316@goodmis.org
  http://lkml.kernel.org/r/20190215142015.860423791@goodmis.org

-- Steve
