Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73EAC10F02
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 02:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0C5222DD
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 02:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732995AbfBPCIE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 21:08:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:40750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbfBPCIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 21:08:04 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACA19222A1;
        Sat, 16 Feb 2019 02:08:02 +0000 (UTC)
Date:   Fri, 15 Feb 2019 21:08:01 -0500
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
Message-ID: <20190215210801.7f8c94cf@gandalf.local.home>
In-Reply-To: <D1A39BE5-CAB2-42D1-B87B-2E21906FE5B1@amacapital.net>
References: <20190215174712.372898450@goodmis.org>
        <20190215174945.557218316@goodmis.org>
        <CAHk-=wjP4bEYCFaKZVG4kLWmYBctyfsW9jjhC91tiTk9WwB8Rg@mail.gmail.com>
        <20190215171539.4682f0b4@gandalf.local.home>
        <300C4516-A093-43AE-8707-1C42486807A4@amacapital.net>
        <20190215191949.04604191@gandalf.local.home>
        <D1A39BE5-CAB2-42D1-B87B-2E21906FE5B1@amacapital.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Feb 2019 17:32:55 -0800
Andy Lutomirski <luto@amacapital.net> wrote:

> > I added you just because I wanted help getting the change log correct,
> > as that's what Linus was complaining about. I kept using "kernel
> > address" when the sample bug used for the patch was really a
> > non-canonical address (as Linus said, it's just garbage. Neither kernel
> > or user space). But I pointed out that this can also bug if the
> > address is canonical and in the kernel address space. The old code
> > didn't complain about non-canonical or kernel address faulting before
> > commit 9da3f2b7405, which only talks about kernel address space
> > faulting (which is why I only mentioned that in my messages).
> > 
> > Would changing all the mention of "kernel address" to "non user space"
> > be accurate?
> >   
> 
> I think “kernel address” is right. It’s illegal to access anything that isn’t known to be a valid kernel address while in KERNEL_DS.

But an non-canonical address is not a "kernel address", and that will
cause a bug too. This patch came about because it was changed that if
we do a uaccess on something other than a user space address and take a
fault (either because it was a non-canonical address, or a kernel
address), we BUG! Where before that one patch, it would just return a
fault.

> 
> The old __copy seems likely to have always been a bit bogus.
> 
> BTW, what is this probe_mem_read() thing?  Some minimal inspection suggests it’s a buggy reimplementation of probe_kernel_read().  Can you delete it and just use probe_kernel_read() directly?

Well, the issue is that we have trace_probe_tmpl.h in that same
directory, which does the work for kprobes and uprobes. The
trace_kprobes.c defines all the functions for handling kprobes, and
trace_uprobes.c does all the handling of uprobes, then they include
trace_probe_tmpl.h which does the bulk of the work.

In the uprobes case, we have:

static nokprobe_inline int
probe_mem_read(void *dest, void *src, size_t size)
{
	void __user *vaddr = (void __force __user *)src;

	return copy_from_user(dest, vaddr, size) ? -EFAULT : 0;
}

Because that is adding probes on userspace code.

-- Steve
