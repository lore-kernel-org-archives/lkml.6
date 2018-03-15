Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751889AbeCONHK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 09:07:10 -0400
Received: from mga17.intel.com ([192.55.52.151]:41522 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751481AbeCONHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 09:07:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,310,1517904000";
   d="scan'208";a="42282618"
Message-ID: <1521119224.10722.664.camel@linux.intel.com>
Subject: Re: [PATCH v3] vsprintf: Prevent crash when dereferencing invalid
 pointers
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Date: Thu, 15 Mar 2018 15:07:04 +0200
In-Reply-To: <20180315075842.GD3628@jagdpanzerIV>
References: <20180306092513.ibodfsnv4xrxdlub@pathway.suse.cz>
         <1520330185.10722.401.camel@linux.intel.com>
         <20180307155244.b45c3fb5vcxb4q2l@pathway.suse.cz>
         <CA+55aFxr5eg_fWjyhcYFU4CSOoVP_GeB79cYa=8mUk7J1cUG7A@mail.gmail.com>
         <20180308141824.bfk2pr6wmjh4ytdi@pathway.suse.cz>
         <CA+55aFyDbr4JpiPoHXq=3wJu+WVCLZPpAVsmY=5HVStawmEiRw@mail.gmail.com>
         <CA+55aFwaNTC2HV9ERDFWCrmhvgZ58SKMM+ik9Ypr3i-ZUyU6Fw@mail.gmail.com>
         <20180309150153.3sxbbpd6jdn2d5yy@pathway.suse.cz>
         <CA+55aFwT-Vd+sVdAVemUjUvkNYFiLyVMHZxv9hF6KzRM7i4Yrg@mail.gmail.com>
         <20180314140947.rs3b6i5gguzzu5wi@pathway.suse.cz>
         <20180315075842.GD3628@jagdpanzerIV>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-15 at 16:58 +0900, Sergey Senozhatsky wrote:
> On (03/14/18 15:09), Petr Mladek wrote:
> 


> >  char *pointer(const char *fmt, char *buf, char *end, void *ptr,
> >  	      struct printf_spec spec)
> >  {
> > +	static const char data_access_fmt[] =
> > "RrhbMmIiEUVNadCDgGO";
> >  	const int default_width = 2 * sizeof(void *);
> > +	const char *err_msg = NULL;
> > +
> > +	/* Prevent silent crash when this is called under
> > logbuf_lock. */
> > +	if (*fmt && strchr(data_access_fmt, *fmt) != NULL)
> > +		err_msg = check_pointer_access(ptr);
> 
> Agree with Rasmus, I think switch() is easier.
> 

One more to the same.

Though need to add that we also have to append / update some comment to
keep these lists synchronized (in Documentation, around pointer() and
here)

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
