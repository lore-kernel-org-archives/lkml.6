Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B706AC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 19:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886FE21738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 19:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbfBSTDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 14:03:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:54704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbfBSTDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 14:03:33 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 738C92147C;
        Tue, 19 Feb 2019 19:03:32 +0000 (UTC)
Date:   Tue, 19 Feb 2019 14:03:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
Message-ID: <20190219140330.5dd9e876@gandalf.local.home>
In-Reply-To: <CAHk-=wgTuK3kAduP-gr10vykT1uG=B2VpdffvmyBuTQ1UxPpMg@mail.gmail.com>
References: <20190215174712.372898450@goodmis.org>
        <20190215174945.557218316@goodmis.org>
        <CAHk-=wjP4bEYCFaKZVG4kLWmYBctyfsW9jjhC91tiTk9WwB8Rg@mail.gmail.com>
        <20190215171539.4682f0b4@gandalf.local.home>
        <300C4516-A093-43AE-8707-1C42486807A4@amacapital.net>
        <20190215191949.04604191@gandalf.local.home>
        <CAHk-=wgJzNp0R3cVhjBPHTR4X9sOvHdqK4UVFfbsOKQ6L=A_eQ@mail.gmail.com>
        <CAHk-=wh9XrOykA5J9RQ7zaBio-S_D+1AE+rGnBYWSd==pCXh+w@mail.gmail.com>
        <20190219111802.1d6dbaa3@gandalf.local.home>
        <CAHk-=wgTuK3kAduP-gr10vykT1uG=B2VpdffvmyBuTQ1UxPpMg@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2019 10:43:36 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, Feb 19, 2019 at 8:18 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >  
> > > So it would be good to not just say "user or kernel", but actually say
> > > what *kind* of kernel access it expects.  
> >
> > Note, kprobes are a different kind of beast. I've used kprobes to probe
> > userspace information as well as kernel. Heck, I could see someone
> > even using kprobes to probe IO memory to check if a device is doing
> > what they expect it's doing.  
> 
> Note that even if that is the case, you _need_ to special "user vs
> kernel" information.
> 
> Because the exact same address might exist in both.
> 
> Right now I think that only happens on sparc32, but vendors used to
> have that issue on x86-32 too (if they had the 4G:4G patches).

Hmm, I didn't realize that Linux allowed the same address to be
different depending on being in kernel or user space (learn something
new everyday). I guess it makes sense, and even easier with the switch
of cr3 from user to kernel. And I even knew of 4G:4G, but never used
it, nor put too much thought about its implementation.

> 
> > Basically, a kprobe is mostly used for debugging what's happening in a
> > live kernel, to read any address.  
> 
> My point is that "any address" is not sufficient to begin with. You
> need "kernel or user".
> 
> Having a flag for what _kind_ of kernel address is ok might then be
> required for other cases if they might not be ok with following page
> tables to IO space..
> 

Good point. Looks like we should add a new flag for kprobe
trace parameters, that tell kprobes if the address is expected to be
user or kernel. That would be good regardless of the duplicate
meanings, as we could use copy_from_user without touching KERNEL_DS, if
the probe argument specifically states "this is user space". For
example, when probing do_sys_open, and you want to read what path string
was passed into the kernel.

Masami, thoughts?

-- Steve
