Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25B4C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F51C2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F51C2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729995AbeKADHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:07:41 -0400
Received: from www62.your-server.de ([213.133.104.62]:47000 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729762AbeKADHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:07:40 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gHuur-0004mx-Vy; Wed, 31 Oct 2018 19:08:30 +0100
Received: from [178.197.249.30] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gHuur-000Jnk-Q8; Wed, 31 Oct 2018 19:08:29 +0100
Subject: Re: arm64 tools build failure wrt smp_load_{acquire,release}
 expansion on gcc version 5.4.0 20160609 (Ubuntu/Linaro
 5.4.0-6ubuntu1~16.04.9)
To:     Will Deacon <will.deacon@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181031154550.GA28340@kernel.org>
 <20181031174408.GA27871@arm.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <50dc7bfe-47de-6837-30e0-4d31dabacd31@iogearbox.net>
Date:   Wed, 31 Oct 2018 19:08:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20181031174408.GA27871@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25078/Wed Oct 31 14:11:44 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/2018 06:44 PM, Will Deacon wrote:
> Hi Arnaldo,
> 
> On Wed, Oct 31, 2018 at 12:45:50PM -0300, Arnaldo Carvalho de Melo wrote:
>> So I noticed the following build failure thare point to:
>>
>> commit 09d62154f61316f7e97eae3f31ef8770c7e4b386
>> Author: Daniel Borkmann <daniel@iogearbox.net>
>> Date:   Fri Oct 19 15:51:02 2018 +0200
>>
>>     tools, perf: add and use optimized ring_buffer_{read_head, write_tail} helpers
>>
>> -------------------------
>>
>>   50 ubuntu:16.04-x-arm64          : FAIL aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
>>   
>> Works well with:
>>
>>   59 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.3.0-27ubuntu1~18.04) 7.3.0
>>
>> And all the other environments I test build :-)

Urgh, sorry about that, I tested the patch with arm64 on Ubuntu 18.04
back then, but not 16.04. :(

> Cheers for reporting this. I managed to reproduce the build failure with
> gcc version 6.3.0 20170516 (Debian 6.3.0-18+deb9u1).
> 
> The code in question is the arm64 versions of smp_load_acquire() and
> smp_store_release(). Unlike other architectures, these are not built
> around READ_ONCE() and WRITE_ONCE() since we have instructions we can
> use instead of fences. Bringing our macros up-to-date with those (i.e.
> tweaking the union initialisation and using the special "uXX_alias_t"
> types) appears to fix the issue for me.
> 
> Diff below...

I just gave this a spin on 16.04 and it resolves the build issue, thanks
for the quick fix, Will!

Tested-by: Daniel Borkmann <daniel@iogearbox.net>

> Will
> 
> --->8
> 
> diff --git a/tools/arch/arm64/include/asm/barrier.h b/tools/arch/arm64/include/asm/barrier.h
> index 12835ea0e417..378c051fa177 100644
> --- a/tools/arch/arm64/include/asm/barrier.h
> +++ b/tools/arch/arm64/include/asm/barrier.h
> @@ -14,74 +14,75 @@
>  #define wmb()		asm volatile("dmb ishst" ::: "memory")
>  #define rmb()		asm volatile("dmb ishld" ::: "memory")
>  
> -#define smp_store_release(p, v)					\
> -do {								\
> -	union { typeof(*p) __val; char __c[1]; } __u =		\
> -		{ .__val = (__force typeof(*p)) (v) }; 		\
> -								\
> -	switch (sizeof(*p)) {					\
> -	case 1:							\
> -		asm volatile ("stlrb %w1, %0"			\
> -				: "=Q" (*p)			\
> -				: "r" (*(__u8 *)__u.__c)	\
> -				: "memory");			\
> -		break;						\
> -	case 2:							\
> -		asm volatile ("stlrh %w1, %0"			\
> -				: "=Q" (*p)			\
> -				: "r" (*(__u16 *)__u.__c)	\
> -				: "memory");			\
> -		break;						\
> -	case 4:							\
> -		asm volatile ("stlr %w1, %0"			\
> -				: "=Q" (*p)			\
> -				: "r" (*(__u32 *)__u.__c)	\
> -				: "memory");			\
> -		break;						\
> -	case 8:							\
> -		asm volatile ("stlr %1, %0"			\
> -				: "=Q" (*p)			\
> -				: "r" (*(__u64 *)__u.__c)	\
> -				: "memory");			\
> -		break;						\
> -	default:						\
> -		/* Only to shut up gcc ... */			\
> -		mb();						\
> -		break;						\
> -	}							\
> +#define smp_store_release(p, v)						\
> +do {									\
> +	union { typeof(*p) __val; char __c[1]; } __u =			\
> +		{ .__val = (v) }; 					\
> +									\
> +	switch (sizeof(*p)) {						\
> +	case 1:								\
> +		asm volatile ("stlrb %w1, %0"				\
> +				: "=Q" (*p)				\
> +				: "r" (*(__u8_alias_t *)__u.__c)	\
> +				: "memory");				\
> +		break;							\
> +	case 2:								\
> +		asm volatile ("stlrh %w1, %0"				\
> +				: "=Q" (*p)				\
> +				: "r" (*(__u16_alias_t *)__u.__c)	\
> +				: "memory");				\
> +		break;							\
> +	case 4:								\
> +		asm volatile ("stlr %w1, %0"				\
> +				: "=Q" (*p)				\
> +				: "r" (*(__u32_alias_t *)__u.__c)	\
> +				: "memory");				\
> +		break;							\
> +	case 8:								\
> +		asm volatile ("stlr %1, %0"				\
> +				: "=Q" (*p)				\
> +				: "r" (*(__u64_alias_t *)__u.__c)	\
> +				: "memory");				\
> +		break;							\
> +	default:							\
> +		/* Only to shut up gcc ... */				\
> +		mb();							\
> +		break;							\
> +	}								\
>  } while (0)
>  
> -#define smp_load_acquire(p)					\
> -({								\
> -	union { typeof(*p) __val; char __c[1]; } __u;		\
> -								\
> -	switch (sizeof(*p)) {					\
> -	case 1:							\
> -		asm volatile ("ldarb %w0, %1"			\
> -			: "=r" (*(__u8 *)__u.__c)		\
> -			: "Q" (*p) : "memory");			\
> -		break;						\
> -	case 2:							\
> -		asm volatile ("ldarh %w0, %1"			\
> -			: "=r" (*(__u16 *)__u.__c)		\
> -			: "Q" (*p) : "memory");			\
> -		break;						\
> -	case 4:							\
> -		asm volatile ("ldar %w0, %1"			\
> -			: "=r" (*(__u32 *)__u.__c)		\
> -			: "Q" (*p) : "memory");			\
> -		break;						\
> -	case 8:							\
> -		asm volatile ("ldar %0, %1"			\
> -			: "=r" (*(__u64 *)__u.__c)		\
> -			: "Q" (*p) : "memory");			\
> -		break;						\
> -	default:						\
> -		/* Only to shut up gcc ... */			\
> -		mb();						\
> -		break;						\
> -	}							\
> -	__u.__val;						\
> +#define smp_load_acquire(p)						\
> +({									\
> +	union { typeof(*p) __val; char __c[1]; } __u =			\
> +		{ .__c = { 0 } };					\
> +									\
> +	switch (sizeof(*p)) {						\
> +	case 1:								\
> +		asm volatile ("ldarb %w0, %1"				\
> +			: "=r" (*(__u8_alias_t *)__u.__c)		\
> +			: "Q" (*p) : "memory");				\
> +		break;							\
> +	case 2:								\
> +		asm volatile ("ldarh %w0, %1"				\
> +			: "=r" (*(__u16_alias_t *)__u.__c)		\
> +			: "Q" (*p) : "memory");				\
> +		break;							\
> +	case 4:								\
> +		asm volatile ("ldar %w0, %1"				\
> +			: "=r" (*(__u32_alias_t *)__u.__c)		\
> +			: "Q" (*p) : "memory");				\
> +		break;							\
> +	case 8:								\
> +		asm volatile ("ldar %0, %1"				\
> +			: "=r" (*(__u64_alias_t *)__u.__c)		\
> +			: "Q" (*p) : "memory");				\
> +		break;							\
> +	default:							\
> +		/* Only to shut up gcc ... */				\
> +		mb();							\
> +		break;							\
> +	}								\
> +	__u.__val;							\
>  })
>  
>  #endif /* _TOOLS_LINUX_ASM_AARCH64_BARRIER_H */
> 

