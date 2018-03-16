Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752918AbeCPFxw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 01:53:52 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41556 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750767AbeCPFxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 01:53:51 -0400
X-Google-Smtp-Source: AG47ELv5TcNY0KdMYT2RxOr/xhdO9QuKZ67Fuevq6tRsf2fIgTHyrSh7HyePQ8JbVECrYy6tlt2aHA==
Date: Fri, 16 Mar 2018 14:53:46 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH v3] vsprintf: Prevent crash when dereferencing invalid
 pointers
Message-ID: <20180316055346.GB5139@jagdpanzerIV>
References: <CA+55aFyDbr4JpiPoHXq=3wJu+WVCLZPpAVsmY=5HVStawmEiRw@mail.gmail.com>
 <CA+55aFwaNTC2HV9ERDFWCrmhvgZ58SKMM+ik9Ypr3i-ZUyU6Fw@mail.gmail.com>
 <20180309150153.3sxbbpd6jdn2d5yy@pathway.suse.cz>
 <CA+55aFwT-Vd+sVdAVemUjUvkNYFiLyVMHZxv9hF6KzRM7i4Yrg@mail.gmail.com>
 <20180314140947.rs3b6i5gguzzu5wi@pathway.suse.cz>
 <20180315075842.GD3628@jagdpanzerIV>
 <20180315080309.GF3628@jagdpanzerIV>
 <20180315130117.7c2fb761@vmware.local.home>
 <20180316011852.GA5139@jagdpanzerIV>
 <CA+55aFzLQvPCB-A2ZN9h86pBDbNC1RXwzB=URRKFcJpXFzanig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzLQvPCB-A2ZN9h86pBDbNC1RXwzB=URRKFcJpXFzanig@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/15/18 18:35), Linus Torvalds wrote:
> On Thu, Mar 15, 2018 at 6:18 PM, Sergey Senozhatsky
> <sergey.senozhatsky.work@gmail.com> wrote:
> >
> > Hm, may be sizeof(ptr) still won't suffice. It would be great if we
> > could always look at spec.field_width, which can be up to 2 * sizeof(void *),
> > and then just probe_kernel_read(spec.field_width). E.g., %b/%bl prints out a
> > bitmap, accessing max_t(int, spec.field_width, 0) bits, which is good. But,
> > for instance, %U (uuid printout) doesn't look at spec.field_width, and reads
> > in 16 bytes from the given memory address. Then we have ipv4/ipv6, mac, etc.
> > So I think that checking just 1 byte or sizeof(ptr) is not really enough if
> > we want to fix vsprintf. What do you think?
> 
> Honestly, I think it would be better to move the whole logic to the
> functions that actually do the printout.
> 
> Then you can do it right, and you don't need to have the strchr() either.
>
> There really isn't any commonality between the different versions.
> field_width is meaningless, since it's about the size of the _printed_
> field, not the size in memory.

Agreed!

> Would it be a few more lines? Yes. But it would also clarify the code
> and get all the cases right. Look at hex_string() for example, and
> imagine fetching a byte at a time and just getting the corner cases
> automatically right.

So, basically, what I tried to say - any byte past the first sizeof(ptr)
bytes or past the first byte that we check_access() can cause problems,
which this patch is trying to address. As an example, FORMAT_TYPE_STR
case

	printk("%.*s\n", p->buf)
	 vsnprintf()
	  string()

Where ->buf is a _nearly always_ properly nul terminated char buf[128]
array in struct foo. So moving that check_access() to every function that
does printout sounds good to me, as well as checking every byte we access
[assuming that we want to cure vsprintf], not just the first one or the
first sizeof(ptr) bytes.

	-ss
