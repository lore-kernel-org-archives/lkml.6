Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B335ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C75DC208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C75DC208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbeGQG4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 02:56:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:46050 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728095AbeGQG4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 02:56:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9DBB0AD8F;
        Tue, 17 Jul 2018 06:25:31 +0000 (UTC)
Subject: Re: [PATCH 2/4] lib: add crc64 calculation routines
To:     Eric Biggers <ebiggers3@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
References: <20180716165507.23100-1-colyli@suse.de>
 <20180716165507.23100-3-colyli@suse.de>
 <20180717033425.GA1728@sol.localdomain>
From:   Coly Li <colyli@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=colyli@suse.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <40ed7be1-fb4d-7ae0-53db-cce8461c66b9@suse.de>
Date:   Tue, 17 Jul 2018 14:25:24 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180717033425.GA1728@sol.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/17 11:34 AM, Eric Biggers wrote:
> Hi Coly,
> 
> On Tue, Jul 17, 2018 at 12:55:05AM +0800, Coly Li wrote:
>> This patch adds the re-write crc64 calculation routines for Linux kernel.
>> The CRC64 polynomical arithmetic follows ECMA-182 specification, inspired
>> by CRC paper of Dr. Ross N. Williams
>> (see http://www.ross.net/crc/download/crc_v3.txt) and other public domain
>> implementations.
>>
>> All the changes work in this way,
>> - When Linux kernel is built, host program lib/gen_crc64table.c will be
>>   compiled to lib/gen_crc64table and executed.
>> - The output of gen_crc64table execution is an array called as lookup
>>   table (a.k.a POLY 0x42f0e1eba9ea369) which contain 256 64bits-long
>>   numbers, this talbe is dumped into header file lib/crc64table.h.
>> - Then the header file is included by lib/crc64.c for normal 64bit crc
>>   calculation.
>> - Function declaration of the crc64 calculation routines is placed in
>>   include/linux/crc64.h
>>
> [...]
>> diff --git a/lib/crc64.c b/lib/crc64.c
>> new file mode 100644
>> index 000000000000..03f078303bd3
>> --- /dev/null
>> +++ b/lib/crc64.c
>> @@ -0,0 +1,71 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Normal 64bit CRC calculation.
>> + *
>> + * This is a basic crc64 implementation following ECMA-182 specification,
>> + * which can be found from,
>> + * http://www.ecma-international.org/publications/standards/Ecma-182.htm
>> + *
>> + * Dr. Ross N. Williams has a great document to introduce the idea of CRC
>> + * algorithm, here the CRC64 code is also inspired by the table-driven
>> + * algorithm and detail example from this paper. This paper can be found
>> + * from,
>> + * http://www.ross.net/crc/download/crc_v3.txt
>> + *
>> + * crc64table_le[256] is the lookup table of a table-driver 64bit CRC
>> + * calculation, which is generated by gen_crc64table.c in kernel build
>> + * time. The polynomial of crc64 arithmetic is from ECMA-182 specification
>> + * as well, which is defined as,
>> + *
>> + * x^64 + x^62 + x^57 + x^55 + x^54 + x^53 + x^52 + x^47 + x^46 + x^45 +
>> + * x^40 + x^39 + x^38 + x^37 + x^35 + x^33 + x^32 + x^31 + x^29 + x^27 +
>> + * x^24 + x^23 + x^22 + x^21 + x^19 + x^17 + x^13 + x^12 + x^10 + x^9 +
>> + * x^7 + x^4 + x + 1
>> + *
>> + * Copyright 2018 SUSE Linux.
>> + *   Author: Coly Li <colyli@suse.de>
>> + *
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <uapi/linux/types.h>
>> +#include "crc64table.h"
>> +
>> +MODULE_DESCRIPTION("CRC64 calculations");
>> +MODULE_LICENSE("GPL");
>> +
>> +__le64 crc64_le_update(__le64 crc, const void *_p, size_t len)
>> +{
>> +	size_t i, t;
>> +
>> +	const unsigned char *p = _p;
>> +
>> +	for (i = 0; i < len; i++) {
>> +		t = ((crc >> 56) ^ (__le64)(*p++)) & 0xFF;
>> +		crc = crc64table_le[t] ^ (crc << 8);
>> +	}
>> +
>> +	return crc;
>> +}
>> +EXPORT_SYMBOL_GPL(crc64_le_update);
>> +
>> +__le64 crc64_le(const void *p, size_t len)
>> +{
>> +	__le64 crc = 0x0000000000000000ULL;
>> +
>> +	crc = crc64_le_update(crc, p, len);
>> +
>> +	return crc;
>> +}
>> +EXPORT_SYMBOL_GPL(crc64_le);
>> +
>> +/* For checksum calculation in drivers/md/bcache/ */
>> +__le64 crc64_le_bch(const void *p, size_t len)
>> +{
>> +	__le64 crc = 0xFFFFFFFFFFFFFFFFULL;
>> +
>> +	crc = crc64_le_update(crc, p, len);
>> +
>> +	return (crc ^ 0xFFFFFFFFFFFFFFFFULL);
>> +}
>> +EXPORT_SYMBOL_GPL(crc64_le_bch);
> 

Hi Eric,

> Using __le64 here makes no sense, because that type indicates the endianness of
> the *bytes*, whereas with CRC's "little endian" and "big endian" refer to the
> order in which the *bits* are mapped to the polynomial coefficients.
> 
> Also as you can see for lib/crc32.c you really only need to provide a function
> 
> 	u64 __pure crc64_le(u64 crc, unsigned char const *p, size_t len);
> 
> and the callers can invert at the beginning and/or end if needed.

Let me explain why I explicit use __le64 here. When crc64 is used as
on-disk checksum, the input of crc64 calculation should be in a explicit
specific byte order. Currently check sum in bcache code assumes the CPU
is in little endian and just feeds in-memory data into crc64
calculation, then the code does not work on big endian machine like s390x.

To solve such problem, before calculating CRC the in-memory data should
be swapped into a specific byte order (in bcache case it should be
little endian). For data storage or transfer, CRC calculation without
explicit endian is more easy to introduce bugs.

When I declare the type of input and output value as __le64, on big
endian machine, I expect a type mismatch warning if the input memory
buffer is not swapped into little endian. For u64, there is no such type
checking warning.

This is the initial version of lib/crc64.c, people may add their crc64
calculation routines when necessary, e.g. crc64_be() or crc64(). I only
add crc64_le_update() and crc64_le_bch() because bcache code needs them.

Indeed there is no user of crc64_le() for now, but the file is name as
lib/crc64.c, I think there should be a crc64 calculation at least, so I
add crc64_le().

> 
> Also your function names make it sound like inverting the bits is the exception
> or not recommended, since you called the function which does the inversions
> "crc32_le_bch()" so it sounds like a bcache-specific hack, while the one that
> doesn't do the inversions is simply called "crc32_le()".  But actually it's
> normally recommended to do CRC's with the inversions, so that leading and
> trailing zeroes affect the resulting CRC.
> 

I notice this, normally there are two crc routines provided, with and
without inversion. The reason that there is no inversion version is
no-user in Linux kernel. Indeed there is no user of crc64_le() in Linnux
kernel so far. For performance reason, I doubt whether there will be
more user to do 64bit crc in kernel.

I prefer two crc32 calculation for a 64bit value, but meta data checksum
by crc64 calculation is used in bcache for years, the consistency has to
be kept.


>> diff --git a/lib/gen_crc64table.c b/lib/gen_crc64table.c
>> new file mode 100644
>> index 000000000000..5f292f287498
>> --- /dev/null
>> +++ b/lib/gen_crc64table.c
>> @@ -0,0 +1,77 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Generate lookup table for the talbe-driven CRC64 calculation.
>> + *
>> + * gen_crc64table is executed in kernel build time and generates
>> + * lib/crc64table.h. This header is included by lib/crc64.c for
>> + * the table-driver CRC64 calculation.
>> + *
>> + * See lib/crc64.c for more information about which specification
>> + * and polynomical arithmetic that gen_crc64table.c follows to
>> + * generate the lookup table.
>> + *
>> + * Copyright 2018 SUSE Linux.
>> + *   Author: Coly Li <colyli@suse.de>
>> + *
>> + */
>> +
>> +#include <inttypes.h>
>> +#include <linux/swab.h>
>> +#include <stdio.h>
>> +#include "../usr/include/asm/byteorder.h"
>> +
>> +#define CRC64_ECMA182_POLY 0x42F0E1EBA9EA3693ULL
> 
> Okay, that's actually the ECMA-182 polynomial in "big endian" form (highest
> order bit is the coefficient of x^63, lowest order bit is the coefficient of
> x^0), so you're actually doing a "big endian" CRC.  So everything in your patch
> series that claims it's a little endian or "le" CRC is incorrect.
> 
>> +
>> +#ifdef __LITTLE_ENDIAN
>> +#  define cpu_to_le64(x) ((__le64)(x))
>> +#else
>> +#  define cpu_to_le64(x) ((__le64)__swab64(x))
>> +#endif
>> +
>> +static int64_t crc64_table[256] = {0,};
>> +
>> +static void generate_crc64_table(void)
>> +{
>> +	uint64_t i, j, c, crc;
>> +
>> +	for (i = 0; i < 256; i++) {
>> +		crc = 0;
>> +		c = i << 56;
>> +
>> +		for (j = 0; j < 8; j++) {
>> +			if ((crc ^ c) & 0x8000000000000000ULL)
>> +				crc = (crc << 1) ^ CRC64_ECMA182_POLY;
>> +			else
>> +				crc <<= 1;
>> +			c <<= 1;
> 
> See here, it's shifting out the most significant bit, which means it's the
> coefficient of the x^63 term ("big endian" or "normal" convention), not the x^0
> term ("little endian" or "reversed" convention).

I see your point here. I am not expert in coding theory, the knowledge I
have is from wikipedia, ECMA-182 and the document from Dr. Ross
Williams. From ECMA-182 document, I don't see any word with 'big
endian', so I take it as a standard poly and regardless the byte order.

And on wikepedia page
https://en.wikipedia.org/wiki/Cyclic_redundancy_check , CRC-64-ECMA
references the same poly and call "0x42F0E1EBA9EA3693" as normal poly,
which one links to polynomial
	"x^64 + x^62 + x^57 + x^55 + x^54 + ....x^7 + x^4 + x + 1"
if I understand correctly. But from your information, it seems the
polynomial in generate_crc64_table() is x^64 + x^61 ..... Maybe I
misunderstand you, could you please give me more hint ?

Thanks.

Coly Li




