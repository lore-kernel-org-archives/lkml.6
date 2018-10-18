Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD2BC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86483214AB
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSWkZd5+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86483214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbeJSB2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 21:28:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:41714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728331AbeJSB2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 21:28:32 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FB2A214FA
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 17:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539883593;
        bh=e16kwM7hrBmJthwN/t+6Uv/0dFgLE1LBs9brtKNztEI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TSWkZd5+G3V+EURqLVW3lmKA6D2qVg5D5NeoHBDdZRvyNtsphkoeSp7IMKAsfDnq7
         +9hBU3YFJA8k6ltA35K2x/kbXd+c7S7UwGsDMd9L7VAqkO7zp0qwIJaxWgsymi/Mqf
         tLgifoXhHJ2iyJ7ocYYXf2W/RLaZBn5LhTJxqNo8=
Received: by mail-wr1-f44.google.com with SMTP id a13-v6so34580619wrt.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 10:26:33 -0700 (PDT)
X-Gm-Message-State: AGRZ1gJxhVA+7WSaTyaM2EJbyAJKb34C9xM/AlRbrKZ/ezyoXNhE9d95
        S9dLLjmbJ8sOIpDGYMDb1RLfZsrQHSE60n9/iCqn0Q==
X-Google-Smtp-Source: AJdET5cY6k7orwPy036/+rNuNmk8t/EjxwqnNcKBcBBaO2+Fm2UZJ0ADtMY8fxq1kDFS9U4X+WHJG9GIAmYvLts55LM=
X-Received: by 2002:adf:82c2:: with SMTP id 60-v6mr3498326wrc.131.1539883591969;
 Thu, 18 Oct 2018 10:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <1460987025-30360-1-git-send-email-dsafonov@virtuozzo.com>
 <tip-abfb9498ee1327f534df92a7ecaea81a85913bae@git.kernel.org>
 <87h8hkc9fd.fsf@notabene.neil.brown.name> <CALCETrXB8PE4Ue0BeD0wUS9psLLjpv_pt+nj=SEaj+Nb_dZzUA@mail.gmail.com>
 <871s8ndg6a.fsf@notabene.neil.brown.name>
In-Reply-To: <871s8ndg6a.fsf@notabene.neil.brown.name>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 18 Oct 2018 10:26:20 -0700
X-Gmail-Original-Message-ID: <CALCETrWH342Y7jKHsYdT=_3fuyDkWhvQLK9z4PTs9jzbfoCVwg@mail.gmail.com>
Message-ID: <CALCETrWH342Y7jKHsYdT=_3fuyDkWhvQLK9z4PTs9jzbfoCVwg@mail.gmail.com>
Subject: Re: in_compat_syscall() returns from kernel thread for X86_32.
To:     NeilBrown <neilb@suse.com>, "Ted Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        Andrew Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-tip-commits@vger.kernel.org, jsimmons@infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 9:36 PM NeilBrown <neilb@suse.com> wrote:
>
> On Wed, Oct 17 2018, Andy Lutomirski wrote:
>
> > On Wed, Oct 17, 2018 at 6:48 PM NeilBrown <neilb@suse.com> wrote:
> >>
> >>
> >> Was: Re: [tip:x86/asm] x86/entry: Rename is_{ia32,x32}_task() to in_{ia32,x32}_syscall()
> >> On Tue, Apr 19 2016, tip-bot for Dmitry Safonov wrote:
> >>
> >> > Commit-ID:  abfb9498ee1327f534df92a7ecaea81a85913bae
> >> > Gitweb:     http://git.kernel.org/tip/abfb9498ee1327f534df92a7ecaea81a85913bae
> >> > Author:     Dmitry Safonov <dsafonov@virtuozzo.com>
> >> > AuthorDate: Mon, 18 Apr 2016 16:43:43 +0300
> >> > Committer:  Ingo Molnar <mingo@kernel.org>
> >> > CommitDate: Tue, 19 Apr 2016 10:44:52 +0200
> >> >
> >> > x86/entry: Rename is_{ia32,x32}_task() to in_{ia32,x32}_syscall()
> >> >
> >> ...
> >> > @@ -318,7 +318,7 @@ static inline bool is_x32_task(void)
> >> >
> >> >  static inline bool in_compat_syscall(void)
> >> >  {
> >> > -     return is_ia32_task() || is_x32_task();
> >> > +     return in_ia32_syscall() || in_x32_syscall();
> >> >  }
> >>
> >> Hi,
> >>  I'm reply to this patch largely to make sure I get the right people
> >>  .....
> >>
> >> This test is always true when CONFIG_X86_32 is set, as that forces
> >> in_ia32_syscall() to true.
> >> However we might not be in a syscall at all - we might be running a
> >> kernel thread which is always in 64 mode.
> >> Every other implementation of in_compat_syscall() that I found is
> >> dependant on a thread flag or syscall register flag, and so returns
> >> "false" in a kernel thread.
> >>
> >> Might something like this be appropriate?
> >>
> >> diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
> >> index 2ff2a30a264f..c265b40a78f2 100644
> >> --- a/arch/x86/include/asm/thread_info.h
> >> +++ b/arch/x86/include/asm/thread_info.h
> >> @@ -219,7 +219,7 @@ static inline int arch_within_stack_frames(const void * const stack,
> >>  #ifndef __ASSEMBLY__
> >>
> >>  #ifdef CONFIG_X86_32
> >> -#define in_ia32_syscall() true
> >> +#define in_ia32_syscall() (!(current->flags & PF_KTHREAD))
> >>  #else
> >>  #define in_ia32_syscall() (IS_ENABLED(CONFIG_IA32_EMULATION) && \
> >>                            current_thread_info()->status & TS_COMPAT)
> >>
> >> This came up in the (no out-of-tree) lustre filesystem where some code
> >> needs to assume 32-bit mode in X86_32 syscalls, and 64-bit mode in kernel
> >> threads.
> >>
> >
> > I could get on board with:
> >
> > ({WARN_ON_ONCE(current->flags & PF_KTHREAD); true})
> >
> > The point of these accessors is to be used *in a syscall*.
> >
> > What on Earth is Lustre doing that makes it have this problem?
>
> Lustre uses it in the ->getattr method to make sure ->ino, ->dev and
> ->rdev are appropriately sized.  This isn't very different from the
> usage in ext4 to ensure the seek offset for directories is suitable.
>
> These interfaces can be used both from systemcalls and from kernel
> threads, such as via nfsd.
>
> I don't *know* if nfsd is the particular kthread that causes problems
> for lustre.  All I know is that ->getattr returns 32bit squashed inode
> numbers in kthread context where 64 bit numbers would be expected.
>

Well, that looks like Lustre is copying an ext4 bug.

Hi ext4 people-

ext4's is_32bit_api() function is bogus.  You can't use
in_compat_syscall() unless you know you're in a syscall

The buggy code was introduced in:

commit d1f5273e9adb40724a85272f248f210dc4ce919a
Author: Fan Yong <yong.fan@whamcloud.com>
Date:   Sun Mar 18 22:44:40 2012 -0400

    ext4: return 32/64-bit dir name hash according to usage type

I don't know what the right solution is.  Al, is it legit at all for
fops->llseek to care about the caller's bitness?  If what ext4 is
doing is legit, then ISTM the VFS needs to gain a new API to tell
->llseek what to do.  But I'm wondering why FMODE_64BITHASH by itself
isn't sufficient,

I'm quite tempted to add a warning to the x86 arch code to try to
catch this type of bug.  Fortunately, a bit of grepping suggests that
ext4 is the only filesystem with this problem.

--Andy
