Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E310DC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A500220870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:46:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A500220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbeLLHqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 02:46:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47302 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbeLLHqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 02:46:21 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AF83F308FB94;
        Wed, 12 Dec 2018 07:46:20 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 74236600C9;
        Wed, 12 Dec 2018 07:46:19 +0000 (UTC)
Date:   Wed, 12 Dec 2018 15:46:15 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, bp@alien8.de,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        keescook@chromium.org, msys.mizuma@gmail.com,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v13 1/6] x86/boot: Introduce kstrtoull() to boot
 directory instead of simple_strtoull()
Message-ID: <20181212074615.GO17340@MiWiFi-R3L-srv>
References: <20181212031053.1815-1-fanc.fnst@cn.fujitsu.com>
 <20181212031053.1815-2-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212031053.1815-2-fanc.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 12 Dec 2018 07:46:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/18 at 11:10am, Chao Fan wrote:
> Introduce kstrtoull() from lib/kstrtox.c to boot directory so that code

It's not introducing kstrtoull(), just copying kstrtoull() from
lib/kstrtox.c to boot.

> in boot/ can use kstrtoull() and the old simple_strtoull() can be
> replaced.
> 
> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> ---
>  arch/x86/boot/string.c | 137 +++++++++++++++++++++++++++++++++++++++++
>  arch/x86/boot/string.h |   2 +
>  2 files changed, 139 insertions(+)
> 
> diff --git a/arch/x86/boot/string.c b/arch/x86/boot/string.c
> index c4428a176973..e02405f20f98 100644
> --- a/arch/x86/boot/string.c
> +++ b/arch/x86/boot/string.c
> @@ -12,7 +12,10 @@
>   * Very basic string functions
>   */
>  
> +#define _LINUX_CTYPE_H
>  #include <linux/types.h>
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
>  #include <asm/asm.h>
>  #include "ctype.h"
>  #include "string.h"
> @@ -187,3 +190,137 @@ char *strchr(const char *s, int c)
>  			return NULL;
>  	return (char *)s;
>  }
> +
> +static inline u64 div_u64_rem(u64 dividend, u32 divisor, u32 *remainder)
> +{
> +	union {
> +		u64 v64;
> +		u32 v32[2];
> +	} d = { dividend };
> +	u32 upper;
> +
> +	upper = d.v32[1];
> +	d.v32[1] = 0;
> +	if (upper >= divisor) {
> +		d.v32[1] = upper / divisor;
> +		upper %= divisor;
> +	}
> +	asm ("divl %2" : "=a" (d.v32[0]), "=d" (*remainder) :
> +		"rm" (divisor), "0" (d.v32[0]), "1" (upper));
> +	return d.v64;
> +}
> +
> +static inline u64 div_u64(u64 dividend, u32 divisor)
> +{
> +	u32 remainder;
> +	return div_u64_rem(dividend, divisor, &remainder);
> +}
> +
> +static inline char _tolower(const char c)
> +{
> +	return c | 0x20;
> +}
> +
> +const char *_parse_integer_fixup_radix(const char *s, unsigned int *base)
> +{
> +	if (*base == 0) {
> +		if (s[0] == '0') {
> +			if (_tolower(s[1]) == 'x' && isxdigit(s[2]))
> +				*base = 16;
> +			else
> +				*base = 8;
> +		} else
> +			*base = 10;
> +	}
> +	if (*base == 16 && s[0] == '0' && _tolower(s[1]) == 'x')
> +		s += 2;
> +	return s;
> +}
> +
> +/*
> + * Convert non-negative integer string representation in explicitly given radix
> + * to an integer.
> + * Return number of characters consumed maybe or-ed with overflow bit.
> + * If overflow occurs, result integer (incorrect) is still returned.
> + *
> + * Don't you dare use this function.
> + */
> +unsigned int _parse_integer(const char *s, unsigned int base, unsigned long long *p)
> +{
> +	unsigned long long res;
> +	unsigned int rv;
> +
> +	res = 0;
> +	rv = 0;
> +	while (1) {
> +		unsigned int c = *s;
> +		unsigned int lc = c | 0x20; /* don't tolower() this line */
> +		unsigned int val;
> +
> +		if ('0' <= c && c <= '9')
> +			val = c - '0';
> +		else if ('a' <= lc && lc <= 'f')
> +			val = lc - 'a' + 10;
> +		else
> +			break;
> +
> +		if (val >= base)
> +			break;
> +		/*
> +		 * Check for overflow only if we are within range of
> +		 * it in the max base we support (16)
> +		 */
> +		if (unlikely(res & (~0ull << 60))) {
> +			if (res > div_u64(ULLONG_MAX - val, base))
> +				rv |= KSTRTOX_OVERFLOW;
> +		}
> +		res = res * base + val;
> +		rv++;
> +		s++;
> +	}
> +	*p = res;
> +	return rv;
> +}
> +
> +static int _kstrtoull(const char *s, unsigned int base, unsigned long long *res)
> +{
> +	unsigned long long _res;
> +	unsigned int rv;
> +
> +	s = _parse_integer_fixup_radix(s, &base);
> +	rv = _parse_integer(s, base, &_res);
> +	if (rv & KSTRTOX_OVERFLOW)
> +		return -ERANGE;
> +	if (rv == 0)
> +		return -EINVAL;
> +	s += rv;
> +	if (*s == '\n')
> +		s++;
> +	if (*s)
> +		return -EINVAL;
> +	*res = _res;
> +	return 0;
> +}
> +
> +/**
> + * kstrtoull - convert a string to an unsigned long long
> + * @s: The start of the string. The string must be null-terminated, and may also
> + *  include a single newline before its terminating null. The first character
> + *  may also be a plus sign, but not a minus sign.
> + * @base: The number base to use. The maximum supported base is 16. If base is
> + *  given as 0, then the base of the string is automatically detected with the
> + *  conventional semantics - If it begins with 0x the number will be parsed as a
> + *  hexadecimal (case insensitive), if it otherwise begins with 0, it will be
> + *  parsed as an octal number. Otherwise it will be parsed as a decimal.
> + * @res: Where to write the result of the conversion on success.
> + *
> + * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
> + * Used as a replacement for the obsolete simple_strtoull. Return code must
> + * be checked.
> + */
> +int kstrtoull(const char *s, unsigned int base, unsigned long long *res)
> +{
> +	if (s[0] == '+')
> +		s++;
> +	return _kstrtoull(s, base, res);
> +}
> diff --git a/arch/x86/boot/string.h b/arch/x86/boot/string.h
> index 3d78e27077f4..171007c99acc 100644
> --- a/arch/x86/boot/string.h
> +++ b/arch/x86/boot/string.h
> @@ -29,4 +29,6 @@ extern unsigned int atou(const char *s);
>  extern unsigned long long simple_strtoull(const char *cp, char **endp,
>  					  unsigned int base);
>  
> +int kstrtoull(const char *s, unsigned int base, unsigned long long *res);
> +#define KSTRTOX_OVERFLOW       (1U << 31)
>  #endif /* BOOT_STRING_H */
> -- 
> 2.19.2
> 
> 
> 
