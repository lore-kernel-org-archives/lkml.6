Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751892AbeCNWMm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 18:12:42 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37151 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751279AbeCNWMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 18:12:41 -0400
X-Google-Smtp-Source: AG47ELu/uzrDyvuAWZrYFsUkhdeWmbm6D3rpGH3A1QS/oEDMYPSf4ya28amyMoGvAhg2L/4TWmrQZg==
Subject: Re: [PATCH v3] vsprintf: Prevent crash when dereferencing invalid
 pointers
To: Petr Mladek <pmladek@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
References: <CAKwiHFgTbFof34oc59OU3M1=-PTzstv0uxSmoiRc8TJPJPMHVw@mail.gmail.com>
 <20180306092513.ibodfsnv4xrxdlub@pathway.suse.cz>
 <1520330185.10722.401.camel@linux.intel.com>
 <20180307155244.b45c3fb5vcxb4q2l@pathway.suse.cz>
 <CA+55aFxr5eg_fWjyhcYFU4CSOoVP_GeB79cYa=8mUk7J1cUG7A@mail.gmail.com>
 <20180308141824.bfk2pr6wmjh4ytdi@pathway.suse.cz>
 <CA+55aFyDbr4JpiPoHXq=3wJu+WVCLZPpAVsmY=5HVStawmEiRw@mail.gmail.com>
 <CA+55aFwaNTC2HV9ERDFWCrmhvgZ58SKMM+ik9Ypr3i-ZUyU6Fw@mail.gmail.com>
 <20180309150153.3sxbbpd6jdn2d5yy@pathway.suse.cz>
 <CA+55aFwT-Vd+sVdAVemUjUvkNYFiLyVMHZxv9hF6KzRM7i4Yrg@mail.gmail.com>
 <20180314140947.rs3b6i5gguzzu5wi@pathway.suse.cz>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <0c52c2f1-60d8-bb8a-80f2-c699d47659d3@rasmusvillemoes.dk>
Date: Wed, 14 Mar 2018 23:12:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180314140947.rs3b6i5gguzzu5wi@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-14 15:09, Petr Mladek wrote:

> diff --git a/lib/test_printf.c b/lib/test_printf.c
> index 71ebfa43ad05..61c05a352d79 100644
> --- a/lib/test_printf.c
> +++ b/lib/test_printf.c
> @@ -207,14 +207,15 @@ test_string(void)
> @@ -256,18 +259,18 @@ plain_hash(void)
>   * after an address is hashed.
>   */
>  static void __init
> -plain(void)
> +plain(void *ptr)
>  {
>  	int err;
>  
> -	err = plain_hash();
> +	err = plain_hash(ptr);
>  	if (err) {
>  		pr_warn("plain 'p' does not appear to be hashed\n");
>  		failed_tests++;
>  		return;
>  	}
>  
> -	err = plain_format();
> +	err = plain_format(ptr);
>  	if (err) {
>  		pr_warn("hashing plain 'p' has unexpected format\n");
>  		failed_tests++;
> @@ -275,6 +278,24 @@ plain(void)
>  }

Thanks for adding tests. Please increment total_tests for each test case.

>  static void __init
> +null_pointer(void)
> +{
> +	plain(NULL);
> +	test(ZEROS "00000000", "%px", NULL);
> +	test(SPACE "  (null)", "%pC", NULL);
> +}

Hm, %pC depends on CONFIG_CLOCK, not that we ever reach clock() with
these invalid pointers, but perhaps clearer to choose one whose
behaviour is not config-dependent.

> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index d7a708f82559..54b985143e07 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -520,6 +520,19 @@ char *number(char *buf, char *end, unsigned long long num,
>  	return buf;
>  }
>  
> +static const char *check_pointer_access(const void *ptr)
> +{
> +	unsigned char byte;
> +
> +	if (!ptr)
> +		return "(null)";
> +
> +	if (probe_kernel_read(&byte, ptr, 1))
> +		return "(efault)";
> +
> +	return 0;
> +}

return NULL;

> +
>  static noinline_for_stack
>  char *special_hex_number(char *buf, char *end, unsigned long long num, int size)
>  {
> @@ -586,9 +599,11 @@ char *string(char *buf, char *end, const char *s, struct printf_spec spec)
>  {
>  	int len = 0;
>  	size_t lim = spec.precision;
> +	const char *err_msg;
>  
> -	if ((unsigned long)s < PAGE_SIZE)
> -		s = "(null)";
> +	err_msg = check_pointer_access(s);
> +	if (err_msg)
> +		s = err_msg;
>  
>  	while (lim--) {
>  		char c = *s++;
> @@ -1847,16 +1862,22 @@ static noinline_for_stack
>  char *pointer(const char *fmt, char *buf, char *end, void *ptr,
>  	      struct printf_spec spec)
>  {
> +	static const char data_access_fmt[] = "RrhbMmIiEUVNadCDgGO";
>  	const int default_width = 2 * sizeof(void *);
> +	const char *err_msg = NULL;
> +
> +	/* Prevent silent crash when this is called under logbuf_lock. */
> +	if (*fmt && strchr(data_access_fmt, *fmt) != NULL)
> +		err_msg = check_pointer_access(ptr);

Can we please make this more readable and maintainable in case other
fancy %p* stuff is added. The extensions which do dereference ptr
outnumber those which don't, and a new one is also likely to fall in
that category. Something like

static bool extension_dereferences_ptr(const char *fmt)
{
  switch(*fmt) {
  case 'x':
  case 'K':
  case 'F':
  case 'f':
  case 'S':
  case 's':
  case 'B':
    return false;
  default:
    return isalnum(*fmt);
  }
}

which you could spell isalnum(*fmt) && !strchr("xKFfSsB", *fmt), but
having a switch is a closer match to the subsequent dispatching (and
would allow a more fine-grained approach should the answer depend on
fmt[1] as well).

Question: probe_kernel_read seems to allow (mapped) userspace addresses.
Is that really what we want? Sure, some %p* just format the pointed-to
bytes directly (as an IP address or raw hex dump or whatnot), but some
(e.g. %pD, and %pV could be particularly fun) do another dereference.
I'm not saying it would be easy for an attacker to get a userpointer
passed to %pV, but there's a lot of places that end up calling vsnprintf
(not just printk and friends). Isn't there some cheap address comparison
one can do to rule that out completely?

Rasmus
