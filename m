Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753323AbeCPI4B (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 04:56:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:56803 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751094AbeCPIz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 04:55:59 -0400
Date: Fri, 16 Mar 2018 09:55:56 +0100
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH v3] vsprintf: Prevent crash when dereferencing invalid
 pointers
Message-ID: <20180316085556.t3j65zyuyjzro3n3@pathway.suse.cz>
References: <CA+55aFwaNTC2HV9ERDFWCrmhvgZ58SKMM+ik9Ypr3i-ZUyU6Fw@mail.gmail.com>
 <20180309150153.3sxbbpd6jdn2d5yy@pathway.suse.cz>
 <CA+55aFwT-Vd+sVdAVemUjUvkNYFiLyVMHZxv9hF6KzRM7i4Yrg@mail.gmail.com>
 <20180314140947.rs3b6i5gguzzu5wi@pathway.suse.cz>
 <20180315075842.GD3628@jagdpanzerIV>
 <20180315080309.GF3628@jagdpanzerIV>
 <20180315130117.7c2fb761@vmware.local.home>
 <20180316011852.GA5139@jagdpanzerIV>
 <CA+55aFzLQvPCB-A2ZN9h86pBDbNC1RXwzB=URRKFcJpXFzanig@mail.gmail.com>
 <20180316055346.GB5139@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316055346.GB5139@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-03-16 14:53:46, Sergey Senozhatsky wrote:
> On (03/15/18 18:35), Linus Torvalds wrote:
> > On Thu, Mar 15, 2018 at 6:18 PM, Sergey Senozhatsky
> > <sergey.senozhatsky.work@gmail.com> wrote:
> > >
> > > Hm, may be sizeof(ptr) still won't suffice. It would be great if we
> > > could always look at spec.field_width, which can be up to 2 * sizeof(void *),
> > > and then just probe_kernel_read(spec.field_width). E.g., %b/%bl prints out a
> > > bitmap, accessing max_t(int, spec.field_width, 0) bits, which is good. But,
> > > for instance, %U (uuid printout) doesn't look at spec.field_width, and reads
> > > in 16 bytes from the given memory address. Then we have ipv4/ipv6, mac, etc.
> > > So I think that checking just 1 byte or sizeof(ptr) is not really enough if
> > > we want to fix vsprintf. What do you think?
> > 
> > Honestly, I think it would be better to move the whole logic to the
> > functions that actually do the printout.
>
> > Would it be a few more lines? Yes. But it would also clarify the code
> > and get all the cases right. Look at hex_string() for example, and
> > imagine fetching a byte at a time and just getting the corner cases
> > automatically right.

I am learning every day. I like this idea and am happy that
it is acceptable to others.


> So, basically, what I tried to say - any byte past the first sizeof(ptr)
> bytes or past the first byte that we check_access() can cause problems,
> which this patch is trying to address. As an example, FORMAT_TYPE_STR
> case
> 
> 	printk("%.*s\n", p->buf)
> 	 vsnprintf()
> 	  string()
> 
> Where ->buf is a _nearly always_ properly nul terminated char buf[128]
> array in struct foo. So moving that check_access() to every function that
> does printout sounds good to me, as well as checking every byte we access
> [assuming that we want to cure vsprintf], not just the first one or the
> first sizeof(ptr) bytes.

I am not sure if it is worth it. I think that we would catch 99% of
problems by checking the first byte.

This patch was motivated by a code clean up rather than bug reports.
The original patch removed two more strict checks and kept only
the check for pure NULL. I suggested that it was the wrong way to
go...

I do not want to go suddenly to the other extreme. I suggest to start
with simple check for the first byte and see how often it helps
in the real life. We could always extend it later.

Best Regards,
Petr
