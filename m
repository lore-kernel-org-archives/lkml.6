Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751434AbeDEOCy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 10:02:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:38652 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751195AbeDEOCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 10:02:53 -0400
Date: Thu, 5 Apr 2018 16:02:50 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v4 7/9] vsprintf: Factor out %pO handler as
 kobject_string()
Message-ID: <20180405140250.aejexhnl7lppvyzb@pathway.suse.cz>
References: <20180404085843.16050-1-pmladek@suse.com>
 <20180404085843.16050-8-pmladek@suse.com>
 <20180404233511.GB622@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404233511.GB622@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-04-05 08:35:11, Sergey Senozhatsky wrote:
> On (04/04/18 10:58), Petr Mladek wrote:
> >  static noinline_for_stack
> > +char *kobject_string(char *buf, char *end, void *ptr,
> > +		     struct printf_spec spec, const char *fmt)
> > +{
> > +	switch (fmt[1]) {
> > +	case 'F':
> > +		return device_node_string(buf, end, ptr, spec, fmt + 1);
> > +	}
> > +
> > +	WARN_ONCE(1, "Unsupported pointer format specifier: %%pO%c\n", fmt[1]);
> > +	return buf;
> > +}
> > +
> > +static noinline_for_stack
> >  char *pointer_string(char *buf, char *end, const void *ptr,
> >  		     struct printf_spec spec)
> >  {
> > @@ -1982,10 +1995,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
> >  	case 'G':
> >  		return flags_string(buf, end, ptr, fmt);
> >  	case 'O':
> > -		switch (fmt[1]) {
> > -		case 'F':
> > -			return device_node_string(buf, end, ptr, spec, fmt + 1);
> > -		}
> > +		return kobject_string(buf, end, ptr, spec, fmt);
> >  	case 'x':
> >  		return pointer_string(buf, end, ptr, spec);
> >  	}
> 
> So, previously, unsupported 'O' would end up in ptr_to_id()

No, it fallen through to pointer_string() because there was
missing "break". Therefore it eventually leaked the pointer.

Don't panic. It seems that all %pOF are correct in the mainline.

> 	case 'O':
> 		switch (fmt[1]) {
> 		case 'F':
> 			return device_node_string()
> 		}
> 	}
> 
> 	return ptr_to_id();
> 
> 
> 
> now we will just return `buf' without doing ptr_to_id()?

Yes, but it will also generate the WARNING. It should help people
undestand what is going on. We have no idea what the author
wanted to do. IMHO, it is confusing to show any random (address)
in that case.

Best Regards,
Petr
