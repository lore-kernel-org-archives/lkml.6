Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932978AbeCPBS7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 21:18:59 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:41387 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932341AbeCPBS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 21:18:57 -0400
X-Google-Smtp-Source: AG47ELuDpT6AdltrXJnpLhXIuz3qsJhH356bXTJ+KqSI5yU+uacYxs5dXm0Rwde7mB05jqZCa363gw==
Date: Fri, 16 Mar 2018 10:18:52 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH v3] vsprintf: Prevent crash when dereferencing invalid
 pointers
Message-ID: <20180316011852.GA5139@jagdpanzerIV>
References: <CA+55aFxr5eg_fWjyhcYFU4CSOoVP_GeB79cYa=8mUk7J1cUG7A@mail.gmail.com>
 <20180308141824.bfk2pr6wmjh4ytdi@pathway.suse.cz>
 <CA+55aFyDbr4JpiPoHXq=3wJu+WVCLZPpAVsmY=5HVStawmEiRw@mail.gmail.com>
 <CA+55aFwaNTC2HV9ERDFWCrmhvgZ58SKMM+ik9Ypr3i-ZUyU6Fw@mail.gmail.com>
 <20180309150153.3sxbbpd6jdn2d5yy@pathway.suse.cz>
 <CA+55aFwT-Vd+sVdAVemUjUvkNYFiLyVMHZxv9hF6KzRM7i4Yrg@mail.gmail.com>
 <20180314140947.rs3b6i5gguzzu5wi@pathway.suse.cz>
 <20180315075842.GD3628@jagdpanzerIV>
 <20180315080309.GF3628@jagdpanzerIV>
 <20180315130117.7c2fb761@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315130117.7c2fb761@vmware.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/15/18 13:01), Steven Rostedt wrote:
> > > > +static const char *check_pointer_access(const void *ptr)
> > > > +{
> > > > +	unsigned char byte;
> > > > +
> > > > +	if (!ptr)
> > > > +		return "(null)";
> > > > +
> > > > +	if (probe_kernel_read(&byte, ptr, 1))  
> > >                                         ^^^^^
> > > Why one byte? 			     sizeof(ptr)?  
> > 
> > I think there is a shorter version - probe_kernel_address(),
> > which, seems, was designed for this particular kind of stuff.
> > 
> > 	void *p;
> > 
> > 	if (probe_kernel_address(ptr, p))
> > 		....
> >
> 
> Agreed.

Hm, may be sizeof(ptr) still won't suffice. It would be great if we
could always look at spec.field_width, which can be up to 2 * sizeof(void *),
and then just probe_kernel_read(spec.field_width). E.g., %b/%bl prints out a
bitmap, accessing max_t(int, spec.field_width, 0) bits, which is good. But,
for instance, %U (uuid printout) doesn't look at spec.field_width, and reads
in 16 bytes from the given memory address. Then we have ipv4/ipv6, mac, etc.
So I think that checking just 1 byte or sizeof(ptr) is not really enough if
we want to fix vsprintf. What do you think?

	-ss
