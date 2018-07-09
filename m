Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E91C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13985208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="nFXWv2gc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13985208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933589AbeGISdR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 14:33:17 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42500 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933315AbeGISdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 14:33:14 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w69ITMa3000420;
        Mon, 9 Jul 2018 11:32:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=fNNOgFojnedJE7GGD+xQ7gJ/zbfWrMS82aNKGJa6ZgM=;
 b=nFXWv2gcKnMbh06RLbyiX4tMqMFbJCA1dxOJ+u4VAwCOqddpMeBBSvNSbIumPo86puYT
 3/ElKSTvcVLh3z8OUu0MeUX0MOvIuM/VEKY/Mk/HNNJXn8L4bNz/6dwHjAWTgY+9RFsp
 Pp19NIpgEI4WQea9tfuG6QKKRIX9MnuZMM8= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2k4a5agq7s-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 09 Jul 2018 11:32:50 -0700
Received: from kafai-mbp.dhcp.thefacebook.com (192.168.52.123) by
 mail.thefacebook.com (192.168.16.22) with Microsoft SMTP Server (TLS) id
 14.3.319.2; Mon, 9 Jul 2018 11:32:40 -0700
Date:   Mon, 9 Jul 2018 11:32:36 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Okash Khawaja <osk@fb.com>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf 1/1] bpf: btf: Fix bitfield extraction for big endian
Message-ID: <20180709183236.r4b7gzmev5h4lcbw@kafai-mbp.dhcp.thefacebook.com>
References: <20180709002202.019053555@fb.com>
 <20180709004002.440153594@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180709004002.440153594@fb.com>
User-Agent: NeoMutt/20180512
X-Originating-IP: [192.168.52.123]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-09_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 08, 2018 at 05:22:03PM -0700, Okash Khawaja wrote:
> When extracting bitfield from a number, btf_int_bits_seq_show() builds
> a mask and accesses least significant byte of the number in a way
> specific to little-endian. This patch fixes that by checking endianness
> of the machine and then shifting left and right the unneeded bits.
> 
> Thanks to Martin Lau for the help in navigating potential pitfalls when
> dealing with endianess and for the final solution.
> 
> Fixes: b00b8daec828 ("bpf: btf: Add pretty print capability for data with BTF type info")
> Signed-off-by: Okash Khawaja <osk@fb.com>
> 
> ---
>  kernel/bpf/btf.c |   32 +++++++++++++++-----------------
>  1 file changed, 15 insertions(+), 17 deletions(-)
> 
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -162,6 +162,8 @@
>  #define BITS_ROUNDDOWN_BYTES(bits) ((bits) >> 3)
>  #define BITS_ROUNDUP_BYTES(bits) \
>  	(BITS_ROUNDDOWN_BYTES(bits) + !!BITS_PER_BYTE_MASKED(bits))
> +const int one = 1;
> +#define is_big_endian() ((*(char *)&one) == 0)
>  
>  #define BTF_INFO_MASK 0x0f00ffff
>  #define BTF_INT_MASK 0x0fffffff
> @@ -991,16 +993,13 @@ static void btf_int_bits_seq_show(const
>  				  void *data, u8 bits_offset,
>  				  struct seq_file *m)
>  {
> +	u8 left_shift_bits, right_shift_bits;
Nit.
Although only max 64 bit int is allowed now (ensured by btf_int_check_meta),
it is better to use u16 such that it will be consistent to BTF_INT_BITS.

>  	u32 int_data = btf_type_int(t);
>  	u16 nr_bits = BTF_INT_BITS(int_data);
>  	u16 total_bits_offset;
>  	u16 nr_copy_bytes;
>  	u16 nr_copy_bits;
> -	u8 nr_upper_bits;
> -	union {
> -		u64 u64_num;
> -		u8  u8_nums[8];
> -	} print_num;
> +	u64 print_num;
>  
>  	total_bits_offset = bits_offset + BTF_INT_OFFSET(int_data);
>  	data += BITS_ROUNDDOWN_BYTES(total_bits_offset);
> @@ -1008,21 +1007,20 @@ static void btf_int_bits_seq_show(const
>  	nr_copy_bits = nr_bits + bits_offset;
>  	nr_copy_bytes = BITS_ROUNDUP_BYTES(nr_copy_bits);
>  
> -	print_num.u64_num = 0;
> -	memcpy(&print_num.u64_num, data, nr_copy_bytes);
> -
> -	/* Ditch the higher order bits */
> -	nr_upper_bits = BITS_PER_BYTE_MASKED(nr_copy_bits);
> -	if (nr_upper_bits) {
> -		/* We need to mask out some bits of the upper byte. */
> -		u8 mask = (1 << nr_upper_bits) - 1;
> -
> -		print_num.u8_nums[nr_copy_bytes - 1] &= mask;
> +	print_num = 0;
> +	memcpy(&print_num, data, nr_copy_bytes);
> +	if (is_big_endian()) {
> +		left_shift_bits = bits_offset;
> +		right_shift_bits = BITS_PER_U64 - nr_bits;
> +	} else {
> +		left_shift_bits = BITS_PER_U64 - nr_copy_bits;
> +		right_shift_bits = BITS_PER_U64 - nr_bits;
Nit.
right_shift_bits is the same for both cases.  Lets simplify it.

>  	}
>  
> -	print_num.u64_num >>= bits_offset;
> +	print_num <<= left_shift_bits;
> +	print_num >>= right_shift_bits;
>  
> -	seq_printf(m, "0x%llx", print_num.u64_num);
> +	seq_printf(m, "0x%llx", print_num);
>  }
>  
>  static void btf_int_seq_show(const struct btf *btf, const struct btf_type *t,
> 
