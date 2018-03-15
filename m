Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751551AbeCOIDT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 04:03:19 -0400
Received: from mail-pl0-f45.google.com ([209.85.160.45]:42947 "EHLO
        mail-pl0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750740AbeCOIDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 04:03:14 -0400
X-Google-Smtp-Source: AG47ELsNOs0tfMhxg1OEkE2zwJ3X33iDc1a1fTm8T6Gx0N11OMLmY9PgpurUi66/6P+CU/SQUoYWdw==
Date: Thu, 15 Mar 2018 17:03:09 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3] vsprintf: Prevent crash when dereferencing invalid
 pointers
Message-ID: <20180315080309.GF3628@jagdpanzerIV>
References: <1520330185.10722.401.camel@linux.intel.com>
 <20180307155244.b45c3fb5vcxb4q2l@pathway.suse.cz>
 <CA+55aFxr5eg_fWjyhcYFU4CSOoVP_GeB79cYa=8mUk7J1cUG7A@mail.gmail.com>
 <20180308141824.bfk2pr6wmjh4ytdi@pathway.suse.cz>
 <CA+55aFyDbr4JpiPoHXq=3wJu+WVCLZPpAVsmY=5HVStawmEiRw@mail.gmail.com>
 <CA+55aFwaNTC2HV9ERDFWCrmhvgZ58SKMM+ik9Ypr3i-ZUyU6Fw@mail.gmail.com>
 <20180309150153.3sxbbpd6jdn2d5yy@pathway.suse.cz>
 <CA+55aFwT-Vd+sVdAVemUjUvkNYFiLyVMHZxv9hF6KzRM7i4Yrg@mail.gmail.com>
 <20180314140947.rs3b6i5gguzzu5wi@pathway.suse.cz>
 <20180315075842.GD3628@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315075842.GD3628@jagdpanzerIV>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/15/18 16:58), Sergey Senozhatsky wrote:
> On (03/14/18 15:09), Petr Mladek wrote:
> [..]
> > +static const char *check_pointer_access(const void *ptr)
> > +{
> > +	unsigned char byte;
> > +
> > +	if (!ptr)
> > +		return "(null)";
> > +
> > +	if (probe_kernel_read(&byte, ptr, 1))
>                                         ^^^^^
> Why one byte? 			     sizeof(ptr)?

I think there is a shorter version - probe_kernel_address(),
which, seems, was designed for this particular kind of stuff.

	void *p;

	if (probe_kernel_address(ptr, p))
		....

	-ss
