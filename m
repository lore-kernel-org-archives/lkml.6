Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F4FC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E5C20858
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E5C20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933036AbeGJIVP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 04:21:15 -0400
Received: from www62.your-server.de ([213.133.104.62]:47767 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751082AbeGJIVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 04:21:11 -0400
Received: from [88.198.220.132] (helo=sslproxy03.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fcntQ-0003JQ-2z; Tue, 10 Jul 2018 10:21:04 +0200
Received: from [2a02:120b:c3f4:b8b0:b5ea:3969:d380:aafd] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1fcntP-0004cw-GL; Tue, 10 Jul 2018 10:21:03 +0200
Subject: Re: [PATCH bpf 1/1] bpf: btf: Fix bitfield extraction for big endian
To:     Martin KaFai Lau <kafai@fb.com>, Okash Khawaja <osk@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
References: <20180709002202.019053555@fb.com>
 <20180709004002.440153594@fb.com>
 <20180709183236.r4b7gzmev5h4lcbw@kafai-mbp.dhcp.thefacebook.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <58136182-0eb1-78c9-ceb9-402418c7d10c@iogearbox.net>
Date:   Tue, 10 Jul 2018 10:21:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180709183236.r4b7gzmev5h4lcbw@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24739/Tue Jul 10 06:45:06 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2018 08:32 PM, Martin KaFai Lau wrote:
> On Sun, Jul 08, 2018 at 05:22:03PM -0700, Okash Khawaja wrote:
>> When extracting bitfield from a number, btf_int_bits_seq_show() builds
>> a mask and accesses least significant byte of the number in a way
>> specific to little-endian. This patch fixes that by checking endianness
>> of the machine and then shifting left and right the unneeded bits.
>>
>> Thanks to Martin Lau for the help in navigating potential pitfalls when
>> dealing with endianess and for the final solution.
>>
>> Fixes: b00b8daec828 ("bpf: btf: Add pretty print capability for data with BTF type info")
>> Signed-off-by: Okash Khawaja <osk@fb.com>
>>
>> ---
>>  kernel/bpf/btf.c |   32 +++++++++++++++-----------------
>>  1 file changed, 15 insertions(+), 17 deletions(-)
>>
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -162,6 +162,8 @@
>>  #define BITS_ROUNDDOWN_BYTES(bits) ((bits) >> 3)
>>  #define BITS_ROUNDUP_BYTES(bits) \
>>  	(BITS_ROUNDDOWN_BYTES(bits) + !!BITS_PER_BYTE_MASKED(bits))
>> +const int one = 1;
>> +#define is_big_endian() ((*(char *)&one) == 0)

Also here, in the kernel archs provide proper definitions.

>>  #define BTF_INFO_MASK 0x0f00ffff
>>  #define BTF_INT_MASK 0x0fffffff
>> @@ -991,16 +993,13 @@ static void btf_int_bits_seq_show(const
>>  				  void *data, u8 bits_offset,
>>  				  struct seq_file *m)
>>  {
>> +	u8 left_shift_bits, right_shift_bits;
> Nit.
> Although only max 64 bit int is allowed now (ensured by btf_int_check_meta),
> it is better to use u16 such that it will be consistent to BTF_INT_BITS.
> 
>>  	u32 int_data = btf_type_int(t);
>>  	u16 nr_bits = BTF_INT_BITS(int_data);
>>  	u16 total_bits_offset;
>>  	u16 nr_copy_bytes;
>>  	u16 nr_copy_bits;
>> -	u8 nr_upper_bits;
>> -	union {
>> -		u64 u64_num;
>> -		u8  u8_nums[8];
>> -	} print_num;
>> +	u64 print_num;
>>  
>>  	total_bits_offset = bits_offset + BTF_INT_OFFSET(int_data);
>>  	data += BITS_ROUNDDOWN_BYTES(total_bits_offset);
>> @@ -1008,21 +1007,20 @@ static void btf_int_bits_seq_show(const
>>  	nr_copy_bits = nr_bits + bits_offset;
>>  	nr_copy_bytes = BITS_ROUNDUP_BYTES(nr_copy_bits);
>>  
>> -	print_num.u64_num = 0;
>> -	memcpy(&print_num.u64_num, data, nr_copy_bytes);
>> -
>> -	/* Ditch the higher order bits */
>> -	nr_upper_bits = BITS_PER_BYTE_MASKED(nr_copy_bits);
>> -	if (nr_upper_bits) {
>> -		/* We need to mask out some bits of the upper byte. */
>> -		u8 mask = (1 << nr_upper_bits) - 1;
>> -
>> -		print_num.u8_nums[nr_copy_bytes - 1] &= mask;
>> +	print_num = 0;
>> +	memcpy(&print_num, data, nr_copy_bytes);
>> +	if (is_big_endian()) {
>> +		left_shift_bits = bits_offset;
>> +		right_shift_bits = BITS_PER_U64 - nr_bits;
>> +	} else {
>> +		left_shift_bits = BITS_PER_U64 - nr_copy_bits;
>> +		right_shift_bits = BITS_PER_U64 - nr_bits;
> Nit.
> right_shift_bits is the same for both cases.  Lets simplify it.
> 
>>  	}
>>  
>> -	print_num.u64_num >>= bits_offset;
>> +	print_num <<= left_shift_bits;
>> +	print_num >>= right_shift_bits;
>>  
>> -	seq_printf(m, "0x%llx", print_num.u64_num);
>> +	seq_printf(m, "0x%llx", print_num);
>>  }
>>  
>>  static void btf_int_seq_show(const struct btf *btf, const struct btf_type *t,
>>

