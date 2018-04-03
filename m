Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755668AbeDCW7l (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 18:59:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:52116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755606AbeDCW7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 18:59:40 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EEC921720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 3 Apr 2018 18:59:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Tobin C. Harding" <me@tobin.cc>
Cc: Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [RFC][PATCH] tracing, printk: Force no hashing when
 trace_printk() is used
Message-ID: <20180403185937.5bcc66de@gandalf.local.home>
In-Reply-To: <20180403214349.GF781@eros>
References: <20180403154102.150b1be0@gandalf.local.home>
        <CAGXu5j+g6nbDz+gjAxZTSf1004J=naAf7b9dPTE0q8+7UtXCLw@mail.gmail.com>
        <20180403170612.7b11fc41@gandalf.local.home>
        <20180403214349.GF781@eros>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Apr 2018 07:43:49 +1000
"Tobin C. Harding" <me@tobin.cc> wrote:

> >  static noinline_for_stack
> >  char *restricted_pointer(char *buf, char *end, const void *ptr,
> > @@ -1962,6 +1963,10 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
> >  		return pointer_string(buf, end, ptr, spec);
> >  	}
> >  
> > +	/* When the kernel is in debugging mode, show all pointers */
> > +	if (static_key_false(&trace_debug))
> > +		return restricted_pointer(buf, end, ptr, spec);
> > +
> >  	/* default is to _not_ leak addresses, hash before printing */
> >  	return ptr_to_id(buf, end, ptr, spec);
> >  }  
> 
> This uses the deprecated API Steve (I only know because I went to read
> Documentation/static-keys.txt after seeing this patch).

Hmm, I've been involved with static keys since it was introduced. I
simply copied the code for the original use case (tracepoints). I
forgot that we are changing the name (this has been an ongoing bikeshed
for some time, I can't keep up. Better than the original suggestion
"really_unlikely()" ;)

I need to update tracepoints too.

-- Steve
