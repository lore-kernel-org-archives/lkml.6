Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933119AbeCPQ6u (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 12:58:50 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:54287 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753558AbeCPQ6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 12:58:47 -0400
X-Google-Smtp-Source: AG47ELsQF6DVdymZ9QH2gbDNvdLkv5A/4XtJmGy/GMxU9nj/wmgHl4T0Nf0h0QCCBXv0qzKIjI+nSXh0nomYB0SGkSQ=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2H=LoW5apWNxbqda+JAa33R=tqc7RK=2Uv7J_Xpy+bgg@mail.gmail.com>
References: <20180315190529.20943-1-linux@dominikbrodowski.net>
 <20180315190529.20943-15-linux@dominikbrodowski.net> <CAK8P3a2H=LoW5apWNxbqda+JAa33R=tqc7RK=2Uv7J_Xpy+bgg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 16 Mar 2018 09:58:46 -0700
X-Google-Sender-Auth: glzYhWKosXtNakKBF5BTjdtUJvo
Message-ID: <CA+55aFyGtWEZFzUKJO5NZNxeh4Z624P0EOy6u-zisJT354eLeQ@mail.gmail.com>
Subject: Re: [PATCH v2 14/36] fs: add ksys_mount() helper; remove in-kernel
 calls to sys_mount()
To: Arnd Bergmann <arnd@arndb.de>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 1:11 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> Shouldn't the callers of sys_mount just call do_mount() instead?

So for most of these, I'd rather not really change the code and just
do a direct translation, but I have to agree that "sys_mount ->
do_mount" might be special.

As you say, the only thing sys_mount() does is to copy things from
user space and allocate temporaries, and then call do_mount(). And we
already use do_mount in other places.

So it translating sys_mount() to do_mount() might just be the right thing to do.

Of course, do_mount() still ends up doing yet more "translate user
mode stuff to kernel stuff", so it's kind o fa confusing half-way
state where the user mountpoint name is still in user space, and the
flags are still in the MS namespace, but the device name and the mount
options have been moved to kernel space.

So I dunno. It might make sense to convert to do_mount(), but in many
ways ksys_mount() that just passes *everything* as if it was a user
call is actually more logical, even if it's just pointless churn to
then copy things.

I do like the mindless "let's just use the SYSCALL_DEFINEx()
interfaces for in-kernel use" model, exactly because it's so
black-and-white and doesn't have these kinds of "on one hand.."
issues.

                   Linus
