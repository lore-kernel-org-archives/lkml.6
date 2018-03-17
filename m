Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753554AbeCQST6 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 14:19:58 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:55026 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752819AbeCQST5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 14:19:57 -0400
X-Google-Smtp-Source: AG47ELuNVKe1AGGL+sC3ZOTKqnh/DAsYhMJ4dzxzzVchdmfzcOiGGt84lHqNcIv2D2vvIlPd45MTTGHAvPfr/z9XFys=
MIME-Version: 1.0
In-Reply-To: <20180317180131.GO30522@ZenIV.linux.org.uk>
References: <20180317180131.GO30522@ZenIV.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 17 Mar 2018 11:19:55 -0700
X-Google-Sender-Auth: rIkuohTQSCS_lF3s_U2HIXTohXk
Message-ID: <CA+55aFwdxjCjqSOR92GCz4Au9QLekWL_0zumnOyG-sxayDtfzg@mail.gmail.com>
Subject: Re: what the hell is compat_sys_x86_waitpid() for?
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 17, 2018 at 11:01 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> and tell me what is the difference between those.  In other words, the problem
> with sys32_waitpid() was not that it didn't use proper wrappers - it's that
> it was (and always had been) 100% pointless.

That long long predates Dominik's patches, though.

It clearly is worth fixing, but don't blame Dominik for just
mindlessly converting mindless code.

> For fsck sake, look at the arguments.  waitpid(2) takes pid_t, pointer to int
> and an int.  How the hell could it possibly have required a compat wrapper?

This seems to go all the way back to the original x86_64 merge in
2002, with the original version of arch/x86_64/ia32/sys_ia32.c
containing

   asmlinkage long
   sys32_waitpid(__kernel_pid_t32 pid, unsigned int *stat_addr, int options)
   {
        return sys32_wait4(pid, stat_addr, options, NULL);
   }

and it has only been modified syntactically since.

I suspect the reason is simply that the *regular* waitpid() was writtn
in terms of sys_wait4(), and sys_wait4() needed a compat function, so
then waitpid was basically just carried along.

               Linus
