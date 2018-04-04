Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751612AbeDDTEq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 15:04:46 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:32836 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751556AbeDDTEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 15:04:43 -0400
X-Google-Smtp-Source: AIpwx4+AdDk5Q/64ZydVHrueMF0KrU8xROj6PUqVPRCPz37GKWzQsx4SwO2Xd1oUZ9p8yI40iLzBooZx0Kq05HC2gug=
MIME-Version: 1.0
In-Reply-To: <20180404131310.459e3ef2@gandalf.local.home>
References: <20180403173126.4f79af9e@gandalf.local.home> <CAGXu5jLbNtn9CqqCeG3UHmWfC9=qPmhjSLw9vu0Zcyt04XaQ+A@mail.gmail.com>
 <20180403180313.3cc8bb27@gandalf.local.home> <20180404023455.GA493@jagdpanzerIV>
 <20180404131310.459e3ef2@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 4 Apr 2018 12:04:42 -0700
X-Google-Sender-Auth: IYJfeiIgtmom7d23xUWPMsTpv0w
Message-ID: <CA+55aFytqnsCVFnQojuSdSH2gpXk-eOEyjafQjJPA3GwyFpw8A@mail.gmail.com>
Subject: Re: [PATCH v2] tracing, printk: Force no hashing when trace_printk()
 is used
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>,
        "Tobin C. Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 4, 2018 at 10:13 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Something like this will even prevent modules from disabling the printk
> hash...

That still seems broken.

The *natural* thing to do would seem to be to tie the hash to the
printk state, kind of like the percpu buffers that safe_printk() and
friends use.

Modifying the hash global is fundamentally broken, since some problem
that happens *during* tracing - on another CPU entirely - would now
have the hashing disabled.

So at the *very* least this would need to be percpu logic, but even
that is honestly broken since an NMI might come in and want to printk
too.

Why don't you just use %px? That avoids all of these hacks.

So NAK on this stupid "enable and disable hashing that is
fundamentally broken" approach.

                     Linus
