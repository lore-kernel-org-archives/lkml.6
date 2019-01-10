Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3410C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 01:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79836214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 01:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfAJBRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 20:17:02 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:1251 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726458AbfAJBRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 20:17:02 -0500
X-IronPort-AV: E=Sophos;i="5.56,459,1539619200"; 
   d="scan'208";a="51673048"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 10 Jan 2019 09:16:59 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 4D0024B7349D;
        Thu, 10 Jan 2019 09:16:55 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 10 Jan 2019 09:17:02 +0800
Date:   Thu, 10 Jan 2019 09:15:59 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>, <msys.mizuma@gmail.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v15 1/6] x86/boot: Copy kstrtoull() to boot/string.c
 instead of using simple_strtoull()
Message-ID: <20190110011559.GB2216@localhost.localdomain>
References: <20190107032243.25324-1-fanc.fnst@cn.fujitsu.com>
 <20190107032243.25324-2-fanc.fnst@cn.fujitsu.com>
 <20190109124853.GD15665@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190109124853.GD15665@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 4D0024B7349D.AA0F5
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 01:48:53PM +0100, Borislav Petkov wrote:
>On Mon, Jan 07, 2019 at 11:22:38AM +0800, Chao Fan wrote:
>> Copy kstrtoull() and necessary functions from lib/kstrtox.c to
>> boot/string.c so that code in boot/ can use kstrtoull() and the old
>> simple_strtoull() can be replaced.
>> 
>> In boot/string.c, using div_u64() from math64.h directly will cause the
>> dividend handled as 64-bit value and bring ld error. The solution is to
>> separate the dividend to upper and lower in boot/string.o. So copy the
>> useful div_u64() and div_u64_rem() to boot/string.c also. To avoid
>> redefinition in i386, rename them as __div_u64() and __div_u64_rem().
>> 
>> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
>> ---
>>  arch/x86/boot/string.c | 137 +++++++++++++++++++++++++++++++++++++++++
>>  arch/x86/boot/string.h |   2 +
>>  2 files changed, 139 insertions(+)
>
>...
>
>> +static inline char _tolower(const char c)
>> +{
>> +	return c | 0x20;
>> +}
>> +
>> +const char *_parse_integer_fixup_radix(const char *s, unsigned int *base)
>
>static

Will add it.

>
>> +{
>> +	if (*base == 0) {
>> +		if (s[0] == '0') {
>> +			if (_tolower(s[1]) == 'x' && isxdigit(s[2]))
>> +				*base = 16;
>> +			else
>> +				*base = 8;
>> +		} else
>> +			*base = 10;
>> +	}
>> +	if (*base == 16 && s[0] == '0' && _tolower(s[1]) == 'x')
>> +		s += 2;
>> +	return s;
>> +}
>> +
>> +/*
>> + * Convert non-negative integer string representation in explicitly given radix
>> + * to an integer.
>> + * Return number of characters consumed maybe or-ed with overflow bit.
>> + * If overflow occurs, result integer (incorrect) is still returned.
>> + *
>> + * Don't you dare use this function.
>> + */
>> +unsigned int _parse_integer(const char *s, unsigned int base, unsigned long long *p)
>
>static

Will add it.

Thanks,
Chao Fan

>
>> +{
>> +	unsigned long long res;
>> +	unsigned int rv;
>> +
>> +	res = 0;
>> +	rv = 0;
>> +	while (1) {
>> +		unsigned int c = *s;
>> +		unsigned int lc = c | 0x20; /* don't tolower() this line */
>> +		unsigned int val;
>> +
>> +		if ('0' <= c && c <= '9')
>> +			val = c - '0';
>> +		else if ('a' <= lc && lc <= 'f')
>> +			val = lc - 'a' + 10;
>> +		else
>> +			break;
>> +
>> +		if (val >= base)
>> +			break;
>> +		/*
>> +		 * Check for overflow only if we are within range of
>> +		 * it in the max base we support (16)
>> +		 */
>> +		if (unlikely(res & (~0ull << 60))) {
>> +			if (res > __div_u64(ULLONG_MAX - val, base))
>> +				rv |= KSTRTOX_OVERFLOW;
>> +		}
>> +		res = res * base + val;
>> +		rv++;
>> +		s++;
>> +	}
>> +	*p = res;
>> +	return rv;
>> +}
> 
>
>-- 
>Regards/Gruss,
>    Boris.
>
>Good mailing practices for 400: avoid top-posting and trim the reply.
>
>


