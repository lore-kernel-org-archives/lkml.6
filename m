Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754118AbeEOQz0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 12:55:26 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:53263 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751578AbeEOQzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 12:55:25 -0400
X-Google-Smtp-Source: AB8JxZomv6OJgvXciPIpL7ZobSYxi5V/UkU81NhLdO14WI9uWNzUBYem1LJNDSnr+tKINm0F/hdP6ryqN5+DYYLxO6A=
MIME-Version: 1.0
References: <20180515100558.21df515e@gandalf.local.home>
In-Reply-To: <20180515100558.21df515e@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 May 2018 09:55:13 -0700
Message-ID: <CA+55aFyBHRmXLo07f_7qt7szaDvppMStfX5Sq9Df6mZSy+qYvA@mail.gmail.com>
Subject: Re: [PATCH] vsprintf: Fix memory barriers of ptr_key to have_filed_random_ptr_key
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>, tcharding <me@tobin.cc>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 7:06 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> -       smp_mb();
> +       smp_wmb();
>          WRITE_ONCE(have_filled_random_ptr_key, true);


> +       /* Read ptr_key after reading have_filled_random_ptr_key */
> +       smp_rmb();
> +
>   #ifdef CONFIG_64BIT
>          hashval = (unsigned long)siphash_1u64((u64)ptr, &ptr_key);

Hmm. smp_wmb/rmb are basically free on x86, but on some architectures
smp_rmb() in particular can be pretty expensive.

So when you have a "handoff" situation like this, it's _probably_ better to
use use "smp_store_release()" and "smp_load_acquire()". To some degree that
might also be better for documentation purposes, because that's exactly the
"release-acquire" pattern.

That said, I'm not convinced this really matters all that much for a
boot-time flag like this. The race is pretty theoretical.

                    Linus
