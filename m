Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93255C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD0D20864
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="oEINCkmM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AD0D20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933981AbeGIRdR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 13:33:17 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49104 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933558AbeGIRdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 13:33:15 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w69HOQ0P016422;
        Mon, 9 Jul 2018 10:32:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=Gg36oTZk5jjDt3cbblzSf5lCp+umxOdDn+olRmstLgY=;
 b=oEINCkmMiC+LudNlT6ew0iX055gaYSq02fNUERBT7jLs6pVtPXGYyli2rf1KPeqkrWe0
 40oUiEY1TuUuSMX/FdSvscgYreVKYtAkOlQKYJJnk/gCSDGzjhGi9zZcLWxRv8KEVwIo
 B+ZXfmoyhg/p3oaT25jJ1cLySoy6rpWemNw= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k4c1t816m-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 09 Jul 2018 10:32:52 -0700
Received: from kafai-mbp.dhcp.thefacebook.com (192.168.52.123) by
 mail.thefacebook.com (192.168.16.13) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Mon, 9 Jul 2018 10:32:41 -0700
Date:   Mon, 9 Jul 2018 10:32:37 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Okash Khawaja <osk@fb.com>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf 1/1] bpf: btf: Fix bitfield extraction for big endian
Message-ID: <20180709173237.hpjvoxcbf3xufwcf@kafai-mbp.dhcp.thefacebook.com>
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
Can the __BIG_ENDIAN be reused here?

>  
>  #define BTF_INFO_MASK 0x0f00ffff
>  #define BTF_INT_MASK 0x0fffffff
> @@ -991,16 +993,13 @@ static void btf_int_bits_seq_show(const
>  				  void *data, u8 bits_offset,
>  				  struct seq_file *m)
>  {
> +	u8 left_shift_bits, right_shift_bits;
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
