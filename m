Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772C2C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4312E2070B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731512AbfAIQBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:01:53 -0500
Received: from mga06.intel.com ([134.134.136.31]:49878 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730263AbfAIQBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 11:01:53 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2019 08:01:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,458,1539673200"; 
   d="scan'208";a="124690177"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga002.jf.intel.com with ESMTP; 09 Jan 2019 08:01:48 -0800
Received: from andy by smile with local (Exim 4.92-RC4)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ghGIc-00080X-SA; Wed, 09 Jan 2019 18:01:46 +0200
Date:   Wed, 9 Jan 2019 18:01:46 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yuri Norov <ynorov@marvell.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] bitmap_parselist: rework input string parser
Message-ID: <20190109160146.GG9170@smile.fi.intel.com>
References: <20181223094422.4849-1-ynorov@marvell.com>
 <20181223094422.4849-4-ynorov@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181223094422.4849-4-ynorov@marvell.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 23, 2018 at 09:44:55AM +0000, Yuri Norov wrote:
> The requirement for this rework is to keep the __bitmap_parselist()
> copy-less and single-pass but make it more readable and maintainable by
> splitting into logical parts and removing explicit nested cycles and
> opaque local variables.
> 
> __bitmap_parselist() can parse userspace inputs and therefore we cannot
> use simple_strtoul() to parse numbers.

I see two issues with this patch:
- you are using IS_ERR() but ain't utilizing PTR_ERR(), ERR_PTR() ones
- you remove lines here which you added in the same series.

Second one shows ordering issue of logical changes.

> 
> Signed-off-by: Yury Norov <ynorov@marvell.com>
> ---
>  lib/bitmap.c | 247 ++++++++++++++++++++++++++++++---------------------
>  1 file changed, 148 insertions(+), 99 deletions(-)
> 
> diff --git a/lib/bitmap.c b/lib/bitmap.c
> index a60fd9723677..edc7068c28a6 100644
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -513,6 +513,140 @@ static int bitmap_check_region(const struct region *r)
>  	return 0;
>  }
>  
> +static long get_char(char *c, const char *str, int is_user)
> +{
> +	if (unlikely(is_user))
> +		return __get_user(*c, str);
> +
> +	*c = *str;
> +	return 0;
> +}
> +
> +static const char *bitmap_getnum(unsigned int *num, const char *str,
> +			    const char *const end, int is_user)
> +{
> +	unsigned int n = 0;
> +	const char *_str;
> +	long ret;
> +	char c;
> +
> +	for (_str = str, *num = 0; _str <= end; _str++) {
> +		ret = get_char(&c, _str, is_user);
> +		if (ret)
> +			return (char *)ret;
> +
> +		if (!isdigit(c)) {
> +			if (_str == str)
> +				return (char *)-EINVAL;
> +
> +			goto out;
> +		}
> +
> +		*num = *num * 10 + (c - '0');
> +		if (*num < n)
> +			return (char *)-EOVERFLOW;
> +
> +		n = *num;
> +	}
> +
> +out:
> +	return _str;
> +}
> +
> +static const char *bitmap_find_region(const char *str,
> +			const char *const end, int is_user)
> +{
> +	long ret;
> +	char c;
> +
> +	for (; str < end; str++) {
> +		ret = get_char(&c, str, is_user);
> +		if (ret)
> +			return (char *)ret;
> +
> +		/* Unexpected end of line. */
> +		if (c == 0 || c == '\n')
> +			return NULL;
> +
> +		/*
> +		 * The format allows commas and whitespases
> +		 * at the beginning of the region, so skip it.
> +		 */
> +		if (!isspace(c) && c != ',')
> +			break;
> +	}
> +
> +	return str;
> +}
> +
> +static const char *bitmap_parse_region(struct region *r, const char *str,
> +				 const char *const end, int is_user)
> +{
> +	long ret;
> +	char c;
> +
> +	str = bitmap_getnum(&r->start, str, end, is_user);
> +	if (IS_ERR(str))
> +		return str;
> +
> +	ret = get_char(&c, str, is_user);
> +	if (ret)
> +		return (char *)ret;
> +
> +	if (c == 0 || c == '\n') {
> +		str = end + 1;
> +		goto no_end;
> +	}
> +
> +	if (isspace(c) || c == ',')
> +		goto no_end;
> +
> +	if (c != '-')
> +		return (char *)-EINVAL;
> +
> +	str = bitmap_getnum(&r->end, str + 1, end, is_user);
> +	if (IS_ERR(str))
> +		return str;
> +
> +	ret = get_char(&c, str, is_user);
> +	if (ret)
> +		return (char *)ret;
> +
> +	if (c == 0 || c == '\n') {
> +		str = end + 1;
> +		goto no_pattern;
> +	}
> +
> +	if (isspace(c) || c == ',')
> +		goto no_pattern;
> +
> +	if (c != ':')
> +		return (char *)-EINVAL;
> +
> +	str = bitmap_getnum(&r->off, str + 1, end, is_user);
> +	if (IS_ERR(str))
> +		return str;
> +
> +	ret = get_char(&c, str, is_user);
> +	if (ret)
> +		return (char *)ret;
> +
> +	if (c != '/')
> +		return (char *)-EINVAL;
> +
> +	str = bitmap_getnum(&r->grlen, str + 1, end, is_user);
> +
> +	return str;
> +
> +no_end:
> +	r->end = r->start;
> +no_pattern:
> +	r->off = r->end + 1;
> +	r->grlen = r->end + 1;
> +
> +	return (char *)str;
> +}
> +
>  /**
>   * __bitmap_parselist - convert list format ASCII string to bitmap
>   * @buf: read nul-terminated user string from this buffer
> @@ -534,113 +668,28 @@ static int bitmap_check_region(const struct region *r)
>   *
>   * Returns: 0 on success, -errno on invalid input strings. Error values:
>   *
> - *   - ``-EINVAL``: second number in range smaller than first
> + *   - ``-EINVAL``: wrong region format
>   *   - ``-EINVAL``: invalid character in string
>   *   - ``-ERANGE``: bit number specified too large for mask
> + *   - ``-EOVERFLOW``: integer overflow in the input parameters
>   */
> -static int __bitmap_parselist(const char *buf, unsigned int buflen,
> +static int __bitmap_parselist(const char *buf, const char *const end,
>  		int is_user, unsigned long *maskp,
>  		int nmaskbits)
>  {
> -	unsigned int a, b, old_a, old_b;
> -	unsigned int group_size, used_size;
> -	int c, old_c, totaldigits, ndigits;
> -	const char __user __force *ubuf = (const char __user __force *)buf;
> -	int at_start, in_range, in_partial_range, ret;
>  	struct region r;
> +	long ret;
>  
> -	totaldigits = c = 0;
> -	old_a = old_b = 0;
> -	group_size = used_size = 0;
>  	bitmap_zero(maskp, nmaskbits);
> -	do {
> -		at_start = 1;
> -		in_range = 0;
> -		in_partial_range = 0;
> -		a = b = 0;
> -		ndigits = totaldigits;
> -
> -		/* Get the next cpu# or a range of cpu#'s */
> -		while (buflen) {
> -			old_c = c;
> -			if (is_user) {
> -				if (__get_user(c, ubuf++))
> -					return -EFAULT;
> -			} else
> -				c = *buf++;
> -			buflen--;
> -			if (isspace(c))
> -				continue;
> -
> -			/* A '\0' or a ',' signal the end of a cpu# or range */
> -			if (c == '\0' || c == ',')
> -				break;
> -			/*
> -			* whitespaces between digits are not allowed,
> -			* but it's ok if whitespaces are on head or tail.
> -			* when old_c is whilespace,
> -			* if totaldigits == ndigits, whitespace is on head.
> -			* if whitespace is on tail, it should not run here.
> -			* as c was ',' or '\0',
> -			* the last code line has broken the current loop.
> -			*/
> -			if ((totaldigits != ndigits) && isspace(old_c))
> -				return -EINVAL;
> -
> -			if (c == '/') {
> -				used_size = a;
> -				at_start = 1;
> -				in_range = 0;
> -				a = b = 0;
> -				continue;
> -			}
> -
> -			if (c == ':') {
> -				old_a = a;
> -				old_b = b;
> -				at_start = 1;
> -				in_range = 0;
> -				in_partial_range = 1;
> -				a = b = 0;
> -				continue;
> -			}
> -
> -			if (c == '-') {
> -				if (at_start || in_range)
> -					return -EINVAL;
> -				b = 0;
> -				in_range = 1;
> -				at_start = 1;
> -				continue;
> -			}
>  
> -			if (!isdigit(c))
> -				return -EINVAL;
> -
> -			b = b * 10 + (c - '0');
> -			if (!in_range)
> -				a = b;
> -			at_start = 0;
> -			totaldigits++;
> -		}
> -		if (ndigits == totaldigits)
> -			continue;
> -		if (in_partial_range) {
> -			group_size = a;
> -			a = old_a;
> -			b = old_b;
> -			old_a = old_b = 0;
> -		} else {
> -			used_size = group_size = b - a + 1;
> -		}
> -		/* if no digit is after '-', it's wrong*/
> -		if (at_start && in_range)
> -			return -EINVAL;
> +	while (buf && buf < end) {
> +		buf = bitmap_find_region(buf, end, is_user);
> +		if (buf == NULL)
> +			return 0;
>  
> -		r.start = a;
> -		r.off = used_size;
> -		r.grlen = group_size;
> -		r.end = b;
> +		buf = bitmap_parse_region(&r, buf, end, is_user);
> +		if (IS_ERR(buf))
> +			return (long)buf;
>  
>  		ret = bitmap_check_region(&r);
>  		if (ret)
> @@ -649,14 +698,14 @@ static int __bitmap_parselist(const char *buf, unsigned int buflen,
>  		ret = bitmap_set_region(&r, maskp, nmaskbits);
>  		if (ret)
>  			return ret;
> +	}
>  
> -	} while (buflen && c == ',');
>  	return 0;
>  }
>  
>  int bitmap_parselist(const char *bp, unsigned long *maskp, int nmaskbits)
>  {
> -	return __bitmap_parselist(bp, UINT_MAX, 0, maskp, nmaskbits);
> +	return __bitmap_parselist(bp, (char *)SIZE_MAX, 0, maskp, nmaskbits);
>  }
>  EXPORT_SYMBOL(bitmap_parselist);
>  
> @@ -683,7 +732,7 @@ int bitmap_parselist_user(const char __user *ubuf,
>  	if (!access_ok(VERIFY_READ, ubuf, ulen))
>  		return -EFAULT;
>  	return __bitmap_parselist((const char __force *)ubuf,
> -					ulen, 1, maskp, nmaskbits);
> +					ubuf + ulen - 1, 1, maskp, nmaskbits);
>  }
>  EXPORT_SYMBOL(bitmap_parselist_user);
>  
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


