Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4743AC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 02:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C6921019
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 02:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551062432;
	bh=qoRAjveM0XTLRDPokfSxIhJeOuEBNISgXrzrF+KZeOE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=D+mHqQUZ4/KrJrB4cPxEUtAOqv+Ozpcw5o2712z1bpAB7bcjiGPuGFZ5HAxr8qug+
	 BsLwxUazqSXaB7q6C/jQP1fOCsPX0Yn/bjqByibuDnCqCS7fQXqhgCZ9b1tEDJlsRc
	 DYPVLcZzcicgh+19ztEoXC7Vxs8AcXz9nkaPaUCY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbfBYCka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 21:40:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:49894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbfBYCka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 21:40:30 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56B7F2084D;
        Mon, 25 Feb 2019 02:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551062429;
        bh=qoRAjveM0XTLRDPokfSxIhJeOuEBNISgXrzrF+KZeOE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uBmjJADdIvxUCQa/j3ZalKKjBzQqrUqEXPN0ASQGTJFHs1mPVB7yDCAAvQq8no0oj
         HFv3GnyMS3TvEVdPcUYb9XBlMBiEZL8HaZfgLcP6HMpVOT470ZYXC/vG3TP/YLa+4d
         /EmLanfKqUnjTYO+fvLJFSSD/poCNuVa3w2jsxlw=
Date:   Mon, 25 Feb 2019 11:40:25 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
Message-Id: <20190225114025.902c9031075e2f1fc55369a3@kernel.org>
In-Reply-To: <CAHk-=wjBD+MQfWP2Q4Zp8FP4HR4MdPACw1=iMbDZANdiBwXDAQ@mail.gmail.com>
References: <20190215174712.372898450@goodmis.org>
        <20190215191949.04604191@gandalf.local.home>
        <CAHk-=wgJzNp0R3cVhjBPHTR4X9sOvHdqK4UVFfbsOKQ6L=A_eQ@mail.gmail.com>
        <CAHk-=wh9XrOykA5J9RQ7zaBio-S_D+1AE+rGnBYWSd==pCXh+w@mail.gmail.com>
        <20190219111802.1d6dbaa3@gandalf.local.home>
        <CAHk-=wgTuK3kAduP-gr10vykT1uG=B2VpdffvmyBuTQ1UxPpMg@mail.gmail.com>
        <20190219140330.5dd9e876@gandalf.local.home>
        <20190220171019.5e81a4946b56982f324f7c45@kernel.org>
        <20190220094926.0ab575b3@gandalf.local.home>
        <20190222172745.2c7205d62003c0a858e33278@kernel.org>
        <20190222173509.88489b7c5d1bf0e2ec2382ee@kernel.org>
        <CAHk-=whNf_n1WXWW+ugAVeL5ZK0GcEP3cTYocju1nS85VtMjjQ@mail.gmail.com>
        <20190223124746.d021973004c7c892c3b3fde1@kernel.org>
        <20190223194421.725a03fd@oasis.local.home>
        <CALCETrVDMhpA-oJnpuEP2j21aK5ZosW2PNskVDxm4MSR6Afqug@mail.gmail.com>
        <20190225001757.519f40cd088c05fdd00a9397@kernel.org>
        <CAHk-=wjBD+MQfWP2Q4Zp8FP4HR4MdPACw1=iMbDZANdiBwXDAQ@mail.gmail.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Feb 2019 09:26:45 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sun, Feb 24, 2019 at 7:18 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Sat, 23 Feb 2019 20:38:03 -0800
> > Andy Lutomirski <luto@kernel.org> wrote:
> > >
> > > Can we just get rid of this might_sleep()?  access_ok() doesn't sleep
> > > as far as I know.
> >
> > Hmm, which might_sleep() would you pointed? What I talked was a
> > WARN_ON_ONCE(!in_task()) in access_ok() on x86 (only!), and in_task() just
> > checks preempt_count.
> 
> So the in_task() check does kind of make sense. Using "access_ok()"
> outside of task context is certainly an odd thing, for several
> reasons. The main one being simply that outside of task context, the
> whole "which task" question is open, and you don't know if the task is
> the active one, and so it's not clear if whatever task you interrupt
> might have done "set_fs()" or not.

Ah I got it. Usual case access_ok() in IRQ handler is strange.

> 
> So PeterZ isn't wrong:
> 
> > I guess PeterZ assumed that access_ok() is used only with user space access
> > APIs (e.g. copy_from_user) which can cause page-fault and locks mm (and might
> > sleep :)), but now we are trying to use access_ok() with new functions which
> > disables page-fault and just return -EFAULT.
> 
> .. but in this case, if we do it all *within* code that saves and
> restores the user access flag with get_fs/set_fs, access_ok() would be
> ok and it doesn't have the above issue.
> 
> So access_ok() in _general_ is absolutely not safe to do from
> interrupts, but within the context of probing user memory from a
> tracing event it just happens to be ok.

Hmm, but user can specify user-memory access from the tracing event
which is located in interrupt handler. So I understand that it is safe
only if we correctly setup access flag with get_fs/set_fs, is that
correct?

> It would be lovely to have a special macro for this, and keep the
> warning for the general case, but because this is a "every
> architecture needs to build their own" it's probably too painful.

Agreed.

> 
> PeterZ, do you remember the particular use case that triggered that
> commit 7c4788950ba5 ("x86/uaccess, sched/preempt: Verify access_ok()
> context")?
> 
>                     Linus


Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
