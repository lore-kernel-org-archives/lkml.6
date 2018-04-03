Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753734AbeDCVnr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 17:43:47 -0400
Received: from mail-ua0-f171.google.com ([209.85.217.171]:44104 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753638AbeDCVnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 17:43:46 -0400
X-Google-Smtp-Source: AIpwx4+CQ/7M9a6Ub2GSaYx/JyTFBr5uJXEs5QRkUNGNf9Pc0fd21yzoVqLOgC1z5l8Clp1XbqsfyeV2PmsPJXEVZKI=
MIME-Version: 1.0
In-Reply-To: <20180403173126.4f79af9e@gandalf.local.home>
References: <20180403173126.4f79af9e@gandalf.local.home>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 3 Apr 2018 14:43:43 -0700
X-Google-Sender-Auth: BHdjrG8WzL_HyHKdoz7kxCexUfI
Message-ID: <CAGXu5jLbNtn9CqqCeG3UHmWfC9=qPmhjSLw9vu0Zcyt04XaQ+A@mail.gmail.com>
Subject: Re: [PATCH v2] tracing, printk: Force no hashing when trace_printk()
 is used
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Tobin C. Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 3, 2018 at 2:31 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> From: Steven Rostedt (VMware) <rostedt@goodmis.org>
>
> While debugging an issue I needed to see if the pointers were being
> processed correctly with trace_printk() and after using "%p" and
> triggering my bug and trace output, I was disappointed that all my
> pointers were random garbage and didn't produce anything useful for me.
> I had to rewrite all the trace_printk()s to use "%lx" instead.
>
> As trace_printk() is not to be used for anything but debugging, and
> this is enforced by printing in the dmesg:
>
>  **********************************************************
>  **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
>  **                                                      **
>  ** trace_printk() being used. Allocating extra memory.  **
>  **                                                      **
>  ** This means that this is a DEBUG kernel and it is     **
>  ** unsafe for production use.                           **
>  **                                                      **
>  ** If you see this message and you are not debugging    **
>  ** the kernel, report this immediately to your vendor!  **
>  **                                                      **
>  **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
>  **********************************************************
>
> on boot up if trace_printk() is used (or when a module is loaded that
> uses trace_printk()), we can safely assume that the use of
> trace_printk() is not going to be accidentally added to production code
> (and if it is, they should be whacked with an overcooked spaghetti
> noodle).
>
> A static_key is added called "trace_debug" and if it is set, then %p will
> not be hashed.

Hrm, well, using a static key does make it weirder for an attacker to enable. :)

Whatever the case, if you can get Linus's Ack, sure. I would expect
he'd want you to change all the trace_printk()s to %px with
justifications, though.

-Kees

-- 
Kees Cook
Pixel Security
