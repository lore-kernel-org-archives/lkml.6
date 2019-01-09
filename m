Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B49C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C7FC206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ULa2hxDU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbfAIMtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 07:49:03 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43912 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729732AbfAIMtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 07:49:03 -0500
Received: from zn.tnic (p200300EC2BEA1000E56F05EB9FFDE1E7.dip0.t-ipconnect.de [IPv6:2003:ec:2bea:1000:e56f:5eb:9ffd:e1e7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A905D1EC014B;
        Wed,  9 Jan 2019 13:49:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547038141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Sj6ddva6iFOtF3top2ruh0n1QXiQQrYhiUkE8TXk4H8=;
        b=ULa2hxDUOie8DioGGU527C8w3pttybcdDzEvnpxAjufs5Xsh9r8+x6OesIRH6KcNg3txqN
        NoZWdt4PK75L0veDWDTURzmzcSUIIr4kSowUITFBx4nhb0pC0s+EoeUuX2QyvuV8eebZb2
        u2mZUMMGUCAVyduN5wTZScftuNXtf04=
Date:   Wed, 9 Jan 2019 13:48:53 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, keescook@chromium.org,
        bhe@redhat.com, msys.mizuma@gmail.com, indou.takao@jp.fujitsu.com,
        caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v15 1/6] x86/boot: Copy kstrtoull() to boot/string.c
 instead of using simple_strtoull()
Message-ID: <20190109124853.GD15665@zn.tnic>
References: <20190107032243.25324-1-fanc.fnst@cn.fujitsu.com>
 <20190107032243.25324-2-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190107032243.25324-2-fanc.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 11:22:38AM +0800, Chao Fan wrote:
> Copy kstrtoull() and necessary functions from lib/kstrtox.c to
> boot/string.c so that code in boot/ can use kstrtoull() and the old
> simple_strtoull() can be replaced.
> 
> In boot/string.c, using div_u64() from math64.h directly will cause the
> dividend handled as 64-bit value and bring ld error. The solution is to
> separate the dividend to upper and lower in boot/string.o. So copy the
> useful div_u64() and div_u64_rem() to boot/string.c also. To avoid
> redefinition in i386, rename them as __div_u64() and __div_u64_rem().
> 
> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> ---
>  arch/x86/boot/string.c | 137 +++++++++++++++++++++++++++++++++++++++++
>  arch/x86/boot/string.h |   2 +
>  2 files changed, 139 insertions(+)

...

> +static inline char _tolower(const char c)
> +{
> +	return c | 0x20;
> +}
> +
> +const char *_parse_integer_fixup_radix(const char *s, unsigned int *base)

static

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

static

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
> +			if (res > __div_u64(ULLONG_MAX - val, base))
> +				rv |= KSTRTOX_OVERFLOW;
> +		}
> +		res = res * base + val;
> +		rv++;
> +		s++;
> +	}
> +	*p = res;
> +	return rv;
> +}
 

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
