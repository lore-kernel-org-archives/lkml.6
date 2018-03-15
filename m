Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752811AbeCOPH7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:07:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:52680 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752747AbeCOPH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:07:57 -0400
Date: Thu, 15 Mar 2018 16:07:54 +0100
From: Petr Mladek <pmladek@suse.com>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v3] vsprintf: Prevent crash when dereferencing invalid
 pointers
Message-ID: <20180315150754.qeshnhmtnob2jhxs@pathway.suse.cz>
References: <1520330185.10722.401.camel@linux.intel.com>
 <20180307155244.b45c3fb5vcxb4q2l@pathway.suse.cz>
 <CA+55aFxr5eg_fWjyhcYFU4CSOoVP_GeB79cYa=8mUk7J1cUG7A@mail.gmail.com>
 <20180308141824.bfk2pr6wmjh4ytdi@pathway.suse.cz>
 <CA+55aFyDbr4JpiPoHXq=3wJu+WVCLZPpAVsmY=5HVStawmEiRw@mail.gmail.com>
 <CA+55aFwaNTC2HV9ERDFWCrmhvgZ58SKMM+ik9Ypr3i-ZUyU6Fw@mail.gmail.com>
 <20180309150153.3sxbbpd6jdn2d5yy@pathway.suse.cz>
 <CA+55aFwT-Vd+sVdAVemUjUvkNYFiLyVMHZxv9hF6KzRM7i4Yrg@mail.gmail.com>
 <20180314140947.rs3b6i5gguzzu5wi@pathway.suse.cz>
 <0c52c2f1-60d8-bb8a-80f2-c699d47659d3@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c52c2f1-60d8-bb8a-80f2-c699d47659d3@rasmusvillemoes.dk>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-03-14 23:12:36, Rasmus Villemoes wrote:
> On 2018-03-14 15:09, Petr Mladek wrote:
> 
> > diff --git a/lib/test_printf.c b/lib/test_printf.c
> > index 71ebfa43ad05..61c05a352d79 100644
> > --- a/lib/test_printf.c
> > +++ b/lib/test_printf.c
> > @@ -207,14 +207,15 @@ test_string(void)
> > @@ -256,18 +259,18 @@ plain_hash(void)
> >   * after an address is hashed.
> >   */
> >  static void __init
> > -plain(void)
> > +plain(void *ptr)
> >  {
> >  	int err;
> >  
> > -	err = plain_hash();
> > +	err = plain_hash(ptr);
> >  	if (err) {
> >  		pr_warn("plain 'p' does not appear to be hashed\n");
> >  		failed_tests++;
> >  		return;
> >  	}
> >  
> > -	err = plain_format();
> > +	err = plain_format(ptr);
> >  	if (err) {
> >  		pr_warn("hashing plain 'p' has unexpected format\n");
> >  		failed_tests++;
> > @@ -275,6 +278,24 @@ plain(void)
> >  }
> 
> Thanks for adding tests. Please increment total_tests for each test case.

Good point! Will do in v4.

> >  static void __init
> > +null_pointer(void)
> > +{
> > +	plain(NULL);
> > +	test(ZEROS "00000000", "%px", NULL);
> > +	test(SPACE "  (null)", "%pC", NULL);
> > +}
> 
> Hm, %pC depends on CONFIG_CLOCK, not that we ever reach clock() with
> these invalid pointers, but perhaps clearer to choose one whose
> behaviour is not config-dependent.

It is not a real problem, but I could select another "random" one for v4.

BTW: I chosen "%pC" because clock was a basic word that anyone could
understand ;-) Otherwise, "%pC" is always handled and the purpose of the
specifier is to access the data. IMHO, it does not make sense to make
it too complicated and avoid the access check when CONFIG_CLOCK is not
enabled.

The only specifier that is optionally handled is "%pg". And I think
that it is wrong. It is strange when 'g' is sometimes handled as
specifier and sometimes part of the output string. Well, it is
not a big deal. Who would want to print something like "hello, %pgroup"?

Anyway, you made me to look at clock() more closely. The
implementation is questionable:

  + it always printks "(null)" when CONFIG_HAVE_CLK is not enabled.
    This might hide an error.

  + it prints the address for plain "%pC" and "%pCn" when
    CONFIG_COMMON_CLK is not enabled. We should rather print
    the pointer hash or some error string.

Andy Shevchenko plans to do some clean up on top of this patch.
We could sort it there.


> > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > index d7a708f82559..54b985143e07 100644
> > --- a/lib/vsprintf.c
> > +++ b/lib/vsprintf.c
> > @@ -520,6 +520,19 @@ char *number(char *buf, char *end, unsigned long long num,
> >  	return buf;
> >  }
> >  
> > +static const char *check_pointer_access(const void *ptr)
> > +{
> > +	unsigned char byte;
> > +
> > +	if (!ptr)
> > +		return "(null)";
> > +
> > +	if (probe_kernel_read(&byte, ptr, 1))
> > +		return "(efault)";
> > +
> > +	return 0;
> > +}
> 
> return NULL;

Good catch! This is an artifact from an older variant where it returned int.

> > +
> >  static noinline_for_stack
> >  char *special_hex_number(char *buf, char *end, unsigned long long num, int size)
> >  {
> > @@ -1847,16 +1862,22 @@ static noinline_for_stack
> >  char *pointer(const char *fmt, char *buf, char *end, void *ptr,
> >  	      struct printf_spec spec)
> >  {
> > +	static const char data_access_fmt[] = "RrhbM mIiEU VNadC DgGO";
> >  	const int default_width = 2 * sizeof(void *);
> > +	const char *err_msg = NULL;
> > +
> > +	/* Prevent silent crash when this is called under logbuf_lock. */
> > +	if (*fmt && strchr(data_access_fmt, *fmt) != NULL)
> > +		err_msg = check_pointer_access(ptr);
> 
> Can we please make this more readable and maintainable in case other
> fancy %p* stuff is added. The extensions which do dereference ptr
> outnumber those which don't, and a new one is also likely to fall in
> that category. Something like
> 
> static bool extension_dereferences_ptr(const char *fmt)
> {
>   switch(*fmt) {
>   case 'x':
>   case 'K':
>   case 'F':
>   case 'f':
>   case 'S':
>   case 's':
>   case 'B':
>     return false;
>   default:
>     return isalnum(*fmt);
>   }
> }
> 
> which you could spell isalnum(*fmt) && !strchr("xKFfSsB", *fmt), but
> having a switch is a closer match to the subsequent dispatching (and
> would allow a more fine-grained approach should the answer depend on
> fmt[1] as well).

The thing is that *fmt points to the original format. It might be
something like: "print%ponscreen". It will be handled as "%p" because
'o' is not valid specifier. But your function would return true.

To be honest, I cannot imagine reasonable real-life example where
the above implementation might fail. On the other hand, there are
currently 19 specifiers where we do the dereference. It means the
your simplified approach has 36 false positives. People might be
creative, ... So I prefer to avoid false positives.


> Question: probe_kernel_read seems to allow (mapped) userspace addresses.
> Is that really what we want? Sure, some %p* just format the pointed-to
> bytes directly (as an IP address or raw hex dump or whatnot), but some
> (e.g. %pD, and %pV could be particularly fun) do another dereference.
> I'm not saying it would be easy for an attacker to get a userpointer
> passed to %pV, but there's a lot of places that end up calling vsnprintf
> (not just printk and friends). Isn't there some cheap address comparison
> one can do to rule that out completely?

Good point. The following should do the job:

static const char *check_pointer_access(const void *ptr)
{
	char c;

	if (!ptr)
		return "(null)";

	if ((unsigned long)ptr < TASK_SIZE || probe_kernel_address(ptr, c))
		return "(efault)";

	return 0;
}

Best Regards,
Petr
