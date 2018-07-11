Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07212C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F3B2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:08:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97F3B2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389358AbeGKUOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:14:39 -0400
Received: from www62.your-server.de ([213.133.104.62]:39834 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733070AbeGKUOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:14:39 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fdLPg-0005LE-0e; Wed, 11 Jul 2018 22:08:36 +0200
Received: from [62.203.87.61] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1fdLPf-000V1p-SB; Wed, 11 Jul 2018 22:08:35 +0200
Subject: Re: [PATCH bpf-next v4 2/3] bpf: btf: add btf print functionality
To:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Okash Khawaja <osk@fb.com>
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
References: <20180711032108.631367556@fb.com>
 <20180711032557.728015225@fb.com> <20180711121015.42873aff@cakuba.lan>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <8887ff9a-329e-3d89-8872-4bcc16c462e2@iogearbox.net>
Date:   Wed, 11 Jul 2018 22:08:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180711121015.42873aff@cakuba.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24743/Wed Jul 11 14:56:17 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2018 09:10 PM, Jakub Kicinski wrote:
> Thank you for all the changes made so far.
> 
> On Tue, 10 Jul 2018 20:21:10 -0700, Okash Khawaja wrote:
>> --- /dev/null
>> +++ b/tools/bpf/bpftool/btf_dumper.c
>> @@ -0,0 +1,248 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2018 Facebook */
>> +
>> +#include <linux/btf.h>
>> +#include <linux/err.h>
>> +#include <stdio.h> /* for (FILE *) used by json_writer */
>> +#include <linux/bitops.h>
>> +#include <string.h>
>> +#include <ctype.h>
> 
> Again, please sort the headers the way I suggested.  Otherwise as the
> list of includes grows it's hard to know what's already there.
> 
>> +#include "btf.h"
>> +#include "json_writer.h"
>> +#include "main.h"
>> +
>> +#define BITS_PER_BYTE_MASK (BITS_PER_BYTE - 1)
>> +#define BITS_PER_BYTE_MASKED(bits) ((bits) & BITS_PER_BYTE_MASK)
>> +#define BITS_ROUNDDOWN_BYTES(bits) ((bits) >> 3)
>> +#define BITS_ROUNDUP_BYTES(bits) \
>> +	(BITS_ROUNDDOWN_BYTES(bits) + !!BITS_PER_BYTE_MASKED(bits))
>> +
>> +static int btf_dumper_do_type(const struct btf_dumper *d, __u32 type_id,
>> +			      __u8 bit_offset, const void *data);
>> +
>> +static void btf_dumper_ptr(const void *data, json_writer_t *jw,
>> +			   bool is_plain_text)
>> +{
>> +	if (is_plain_text)
>> +		jsonw_printf(jw, "%p", *((unsigned long *)data));
>> +	else
>> +		jsonw_printf(jw, "%u", *((unsigned long *)data));
> 
> Again, please drop the extraneous parens. 
> 
>> +}
>> +
> 
>> +static void btf_dumper_int_bits(__u32 int_type, __u8 bit_offset,
>> +				const void *data, json_writer_t *jw,
>> +				bool is_plain_text)
>> +{
>> +	int left_shift_bits, right_shift_bits;
>> +	int nr_bits = BTF_INT_BITS(int_type);
>> +	int total_bits_offset;
>> +	int bytes_to_copy;
>> +	int bits_to_copy;
>> +	__u64 print_num;
>> +
>> +	total_bits_offset = bit_offset + BTF_INT_OFFSET(int_type);
>> +	data += BITS_ROUNDDOWN_BYTES(total_bits_offset);
>> +	bit_offset = BITS_PER_BYTE_MASKED(total_bits_offset);
>> +	bits_to_copy = bit_offset + nr_bits;
>> +	bytes_to_copy = BITS_ROUNDUP_BYTES(bits_to_copy);
>> +
>> +	print_num = 0;
>> +	memcpy(&print_num, data, bytes_to_copy);
>> +#ifdef __BIG_ENDIAN_BITFIELD
>> +	left_shift_bits = bit_offset;
>> +#else
>> +	left_shift_bits = 64 - bits_to_copy;
>> +#endif
>> +	right_shift_bits = 64 - nr_bits;
> 
> Please include <asm/byteorder.h> as I suggested to you previously.
> This is dead code right now, look:
> 
> $ git diff
> diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
> index c64465094b92..045add07b721 100644
> --- a/tools/bpf/bpftool/btf_dumper.c
> +++ b/tools/bpf/bpftool/btf_dumper.c
> @@ -91,7 +91,8 @@ static void btf_dumper_int_bits(__u32 int_type, __u8 bit_offset,
>  
>         print_num = 0;
>         memcpy(&print_num, data, bytes_to_copy);
> -#ifdef __BIG_ENDIAN_BITFIELD
> +#ifndef __LITTLE_ENDIAN_BITFIELD
> +#error "abc"
>         left_shift_bits = bit_offset;
>  #else
>         left_shift_bits = 64 - bits_to_copy;
> 
> $ make -C tools/bpf/bpftool/ CC=gcc-8
> make: Entering directory '/home/jkicinski/devel/linux/tools/bpf/bpftool'
>   CC       btf_dumper.o
> btf_dumper.c: In function ‘btf_dumper_int_bits’:
> btf_dumper.c:95:2: error: #error "abc"
>  #error "abc"
>   ^~~~~
> Makefile:96: recipe for target 'btf_dumper.o' failed
> make: *** [btf_dumper.o] Error 1
> make: Leaving directory '/home/jkicinski/devel/linux/tools/bpf/bpftool'

You could also easily test this on s390x (big endian) through a LinuxONE
test instance, this is how I usually test changes related to their JIT.

Thanks,
Daniel
