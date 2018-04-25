Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754842AbeDYO5P (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 10:57:15 -0400
Received: from mga05.intel.com ([192.55.52.43]:51637 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753632AbeDYO5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 10:57:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,326,1520924400";
   d="scan'208";a="53564927"
Message-ID: <1524668229.21176.558.camel@linux.intel.com>
Subject: Re: [PATCH v5 01/11] vsprintf: Shuffle misc pointer to string
 functions
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Date: Wed, 25 Apr 2018 17:57:09 +0300
In-Reply-To: <20180425111251.13246-2-pmladek@suse.com>
References: <20180425111251.13246-1-pmladek@suse.com>
         <20180425111251.13246-2-pmladek@suse.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-04-25 at 13:12 +0200, Petr Mladek wrote:
> This is just a preparation step for further changes.
> 
> The patch does not change the code.
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  lib/vsprintf.c | 244 ++++++++++++++++++++++++++++------------------
> -----------
>  1 file changed, 122 insertions(+), 122 deletions(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index b82f0c6c2aec..19fdfe621b40 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -613,6 +613,128 @@ char *string(char *buf, char *end, const char
> *s, struct printf_spec spec)
>  }
>  
>  static noinline_for_stack
> +char *pointer_string(char *buf, char *end, const void *ptr,
> +		     struct printf_spec spec)
> +{
> +	spec.base = 16;
> +	spec.flags |= SMALL;
> +	if (spec.field_width == -1) {
> +		spec.field_width = 2 * sizeof(ptr);
> +		spec.flags |= ZEROPAD;
> +	}
> +
> +	return number(buf, end, (unsigned long int)ptr, spec);
> +}
> +
> +static bool have_filled_random_ptr_key __read_mostly;
> +static siphash_key_t ptr_key __read_mostly;
> +
> +static void fill_random_ptr_key(struct random_ready_callback *unused)
> +{
> +	get_random_bytes(&ptr_key, sizeof(ptr_key));
> +	/*
> +	 * have_filled_random_ptr_key==true is dependent on
> get_random_bytes().
> +	 * ptr_to_id() needs to see have_filled_random_ptr_key==true
> +	 * after get_random_bytes() returns.
> +	 */
> +	smp_mb();
> +	WRITE_ONCE(have_filled_random_ptr_key, true);
> +}
> +
> +static struct random_ready_callback random_ready = {
> +	.func = fill_random_ptr_key
> +};
> +
> +static int __init initialize_ptr_random(void)
> +{
> +	int ret = add_random_ready_callback(&random_ready);
> +
> +	if (!ret) {
> +		return 0;
> +	} else if (ret == -EALREADY) {
> +		fill_random_ptr_key(&random_ready);
> +		return 0;
> +	}
> +
> +	return ret;
> +}
> +early_initcall(initialize_ptr_random);
> +
> +/* Maps a pointer to a 32 bit unique identifier. */
> +static char *ptr_to_id(char *buf, char *end, void *ptr, struct
> printf_spec spec)
> +{
> +	const char *str = sizeof(ptr) == 8 ? "(____ptrval____)" :
> "(ptrval)";
> +	unsigned long hashval;
> +
> +	if (unlikely(!have_filled_random_ptr_key)) {
> +		spec.field_width = 2 * sizeof(ptr);
> +		/* string length must be less than default_width */
> +		return string(buf, end, str, spec);
> +	}
> +
> +#ifdef CONFIG_64BIT
> +	hashval = (unsigned long)siphash_1u64((u64)ptr, &ptr_key);
> +	/*
> +	 * Mask off the first 32 bits, this makes explicit that we
> have
> +	 * modified the address (and 32 bits is plenty for a unique
> ID).
> +	 */
> +	hashval = hashval & 0xffffffff;
> +#else
> +	hashval = (unsigned long)siphash_1u32((u32)ptr, &ptr_key);
> +#endif
> +	return pointer_string(buf, end, (const void *)hashval, spec);
> +}
> +
> +int kptr_restrict __read_mostly;
> +
> +static noinline_for_stack
> +char *restricted_pointer(char *buf, char *end, const void *ptr,
> +			 struct printf_spec spec)
> +{
> +	switch (kptr_restrict) {
> +	case 0:
> +		/* Always print %pK values */
> +		break;
> +	case 1: {
> +		const struct cred *cred;
> +
> +		/*
> +		 * kptr_restrict==1 cannot be used in IRQ context
> +		 * because its test for CAP_SYSLOG would be
> meaningless.
> +		 */
> +		if (in_irq() || in_serving_softirq() || in_nmi()) {
> +			if (spec.field_width == -1)
> +				spec.field_width = 2 * sizeof(ptr);
> +			return string(buf, end, "pK-error", spec);
> +		}
> +
> +		/*
> +		 * Only print the real pointer value if the current
> +		 * process has CAP_SYSLOG and is running with the
> +		 * same credentials it started with. This is because
> +		 * access to files is checked at open() time, but %pK
> +		 * checks permission at read() time. We don't want to
> +		 * leak pointer values if a binary opens a file using
> +		 * %pK and then elevates privileges before reading
> it.
> +		 */
> +		cred = current_cred();
> +		if (!has_capability_noaudit(current, CAP_SYSLOG) ||
> +		    !uid_eq(cred->euid, cred->uid) ||
> +		    !gid_eq(cred->egid, cred->gid))
> +			ptr = NULL;
> +		break;
> +	}
> +	case 2:
> +	default:
> +		/* Always print 0's for %pK */
> +		ptr = NULL;
> +		break;
> +	}
> +
> +	return pointer_string(buf, end, ptr, spec);
> +}
> +
> +static noinline_for_stack
>  char *dentry_name(char *buf, char *end, const struct dentry *d,
> struct printf_spec spec,
>  		  const char *fmt)
>  {
> @@ -1358,69 +1480,6 @@ char *uuid_string(char *buf, char *end, const
> u8 *addr,
>  }
>  
>  static noinline_for_stack
> -char *pointer_string(char *buf, char *end, const void *ptr,
> -		     struct printf_spec spec)
> -{
> -	spec.base = 16;
> -	spec.flags |= SMALL;
> -	if (spec.field_width == -1) {
> -		spec.field_width = 2 * sizeof(ptr);
> -		spec.flags |= ZEROPAD;
> -	}
> -
> -	return number(buf, end, (unsigned long int)ptr, spec);
> -}
> -
> -int kptr_restrict __read_mostly;
> -
> -static noinline_for_stack
> -char *restricted_pointer(char *buf, char *end, const void *ptr,
> -			 struct printf_spec spec)
> -{
> -	switch (kptr_restrict) {
> -	case 0:
> -		/* Always print %pK values */
> -		break;
> -	case 1: {
> -		const struct cred *cred;
> -
> -		/*
> -		 * kptr_restrict==1 cannot be used in IRQ context
> -		 * because its test for CAP_SYSLOG would be
> meaningless.
> -		 */
> -		if (in_irq() || in_serving_softirq() || in_nmi()) {
> -			if (spec.field_width == -1)
> -				spec.field_width = 2 * sizeof(ptr);
> -			return string(buf, end, "pK-error", spec);
> -		}
> -
> -		/*
> -		 * Only print the real pointer value if the current
> -		 * process has CAP_SYSLOG and is running with the
> -		 * same credentials it started with. This is because
> -		 * access to files is checked at open() time, but %pK
> -		 * checks permission at read() time. We don't want to
> -		 * leak pointer values if a binary opens a file using
> -		 * %pK and then elevates privileges before reading
> it.
> -		 */
> -		cred = current_cred();
> -		if (!has_capability_noaudit(current, CAP_SYSLOG) ||
> -		    !uid_eq(cred->euid, cred->uid) ||
> -		    !gid_eq(cred->egid, cred->gid))
> -			ptr = NULL;
> -		break;
> -	}
> -	case 2:
> -	default:
> -		/* Always print 0's for %pK */
> -		ptr = NULL;
> -		break;
> -	}
> -
> -	return pointer_string(buf, end, ptr, spec);
> -}
> -
> -static noinline_for_stack
>  char *netdev_bits(char *buf, char *end, const void *addr, const char
> *fmt)
>  {
>  	unsigned long long num;
> @@ -1654,65 +1713,6 @@ char *device_node_string(char *buf, char *end,
> struct device_node *dn,
>  	return widen_string(buf, buf - buf_start, end, spec);
>  }
>  
> -static bool have_filled_random_ptr_key __read_mostly;
> -static siphash_key_t ptr_key __read_mostly;
> -
> -static void fill_random_ptr_key(struct random_ready_callback *unused)
> -{
> -	get_random_bytes(&ptr_key, sizeof(ptr_key));
> -	/*
> -	 * have_filled_random_ptr_key==true is dependent on
> get_random_bytes().
> -	 * ptr_to_id() needs to see have_filled_random_ptr_key==true
> -	 * after get_random_bytes() returns.
> -	 */
> -	smp_mb();
> -	WRITE_ONCE(have_filled_random_ptr_key, true);
> -}
> -
> -static struct random_ready_callback random_ready = {
> -	.func = fill_random_ptr_key
> -};
> -
> -static int __init initialize_ptr_random(void)
> -{
> -	int ret = add_random_ready_callback(&random_ready);
> -
> -	if (!ret) {
> -		return 0;
> -	} else if (ret == -EALREADY) {
> -		fill_random_ptr_key(&random_ready);
> -		return 0;
> -	}
> -
> -	return ret;
> -}
> -early_initcall(initialize_ptr_random);
> -
> -/* Maps a pointer to a 32 bit unique identifier. */
> -static char *ptr_to_id(char *buf, char *end, void *ptr, struct
> printf_spec spec)
> -{
> -	const char *str = sizeof(ptr) == 8 ? "(____ptrval____)" :
> "(ptrval)";
> -	unsigned long hashval;
> -
> -	if (unlikely(!have_filled_random_ptr_key)) {
> -		spec.field_width = 2 * sizeof(ptr);
> -		/* string length must be less than default_width */
> -		return string(buf, end, str, spec);
> -	}
> -
> -#ifdef CONFIG_64BIT
> -	hashval = (unsigned long)siphash_1u64((u64)ptr, &ptr_key);
> -	/*
> -	 * Mask off the first 32 bits, this makes explicit that we
> have
> -	 * modified the address (and 32 bits is plenty for a unique
> ID).
> -	 */
> -	hashval = hashval & 0xffffffff;
> -#else
> -	hashval = (unsigned long)siphash_1u32((u32)ptr, &ptr_key);
> -#endif
> -	return pointer_string(buf, end, (const void *)hashval, spec);
> -}
> -
>  /*
>   * Show a '%p' thing.  A kernel extension is that the '%p' is
> followed
>   * by an extra set of alphanumeric characters that are extended
> format

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
