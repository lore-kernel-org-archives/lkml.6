Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1C8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 03:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B06920851
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 03:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B06920851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbeK1OBb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 09:01:31 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:6069 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726705AbeK1OBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 09:01:31 -0500
Received: from dggemi402-hub.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id A414DD7534E4F;
        Wed, 28 Nov 2018 11:01:22 +0800 (CST)
Received: from DGGEMI528-MBX.china.huawei.com ([169.254.8.11]) by
 dggemi402-hub.china.huawei.com ([10.3.17.135]) with mapi id 14.03.0415.000;
 Wed, 28 Nov 2018 11:01:23 +0800
From:   sunrui <sunrui26@huawei.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>
Subject: Re: [PATCH] arm64/lib: improve CRC32 performance for deep pipelines
Thread-Topic: [PATCH] arm64/lib: improve CRC32 performance for deep pipelines
Thread-Index: AdSGxiQQbnriIBeUQ8ucFbMMSDns2g==
Date:   Wed, 28 Nov 2018 03:01:22 +0000
Message-ID: <0DF8AA8C9CD0FB4ABF4E83674055F7E2D91052@DGGEMI528-MBX.china.huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.40.42.201]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code execute on my system performance improves from
# time ./old

real    0m6.645s
user    0m6.644s
sys     0m0.001s

to

# time ./new

real    0m5.565s
user    0m5.565s
sys     0m0.000s


> Improve the performance of the crc32() asm routines by getting rid of most of the branches and small sized loads on the common path.
> 
> Instead, use a branchless code path involving overlapping 16 byte loads to process the first (length % 32) bytes, and process the remainder using a loop that processes 32 bytes at a time.
> 
> Tested using the following test program:
> 
>   #include <stdlib.h>
> 
>   extern void crc32_le(unsigned short, char const*, int);
> 
>   int main(void)
>   {
>     static const char buf[4096];
> 
>     srand(20181126);
> 
>     for (int i = 0; i < 100 * 1000 * 1000; i++)
>       crc32_le(0, buf, rand() % 1024);
> 
>     return 0;
>   }
> 
> On Cortex-A53 and Cortex-A57, the performance regresses but only very slightly. On Cortex-A72 however, the performance improves from
> 
>   $ time ./crc32
> 
>   real  0m10.149s
>   user  0m10.149s
>   sys   0m0.000s
> 
> to
> 
>   $ time ./crc32
> 
>   real  0m7.915s
>   user  0m7.915s
>   sys   0m0.000s
> 
> Cc: Rui Sun <sunrui26@huawei.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> Cortex-A57 tcrypt results after the patch.
> 
> I ran Rui's code [0] as well. On Cortex-A57, performance regresses a bit more (but not dramatically). On Cortex-A72, it executes at
> 
> $ time ./crc32 
> 
> real	0m9.625s
> user	0m9.625s
> sys	0m0.000s
> 
> Rui, can you please benchmark this code on your system as well?
> 
> [0] https://lore.kernel.org/lkml/1542612560-10089-1-git-send-email-sunrui26@huawei.com/
> 
>  arch/arm64/lib/crc32.S | 54 ++++++++++++++++++--
>  1 file changed, 49 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/lib/crc32.S b/arch/arm64/lib/crc32.S index 5bc1e85b4e1c..f132f2a7522e 100644
> --- a/arch/arm64/lib/crc32.S
> +++ b/arch/arm64/lib/crc32.S
> @@ -15,15 +15,59 @@
>  	.cpu		generic+crc
>  
>  	.macro		__crc32, c
> -0:	subs		x2, x2, #16
> -	b.mi		8f
> -	ldp		x3, x4, [x1], #16
> +	cmp		x2, #16
> +	b.lt		8f			// less than 16 bytes
> +
> +	and		x7, x2, #0x1f
> +	and		x2, x2, #~0x1f
> +	cbz		x7, 32f			// multiple of 32 bytes
> +
> +	and		x8, x7, #0xf
> +	ldp		x3, x4, [x1]
> +	add		x8, x8, x1
> +	add		x1, x1, x7
> +	ldp		x5, x6, [x8]
>  CPU_BE(	rev		x3, x3		)
>  CPU_BE(	rev		x4, x4		)
> +CPU_BE(	rev		x5, x5		)
> +CPU_BE(	rev		x6, x6		)
> +
> +	tst		x7, #8
> +	crc32\c\()x	w8, w0, x3
> +	csel		x3, x3, x4, eq
> +	csel		w0, w0, w8, eq
> +	tst		x7, #4
> +	lsr		x4, x3, #32
> +	crc32\c\()w	w8, w0, w3
> +	csel		x3, x3, x4, eq
> +	csel		w0, w0, w8, eq
> +	tst		x7, #2
> +	lsr		w4, w3, #16
> +	crc32\c\()h	w8, w0, w3
> +	csel		w3, w3, w4, eq
> +	csel		w0, w0, w8, eq
> +	tst		x7, #1
> +	crc32\c\()b	w8, w0, w3
> +	csel		w0, w0, w8, eq
> +	tst		x7, #16
> +	crc32\c\()x	w8, w0, x5
> +	crc32\c\()x	w8, w8, x6
> +	csel		w0, w0, w8, eq
> +	cbz		x2, 0f
> +
> +32:	ldp		x3, x4, [x1], #32
> +	sub		x2, x2, #32
> +	ldp		x5, x6, [x1, #-16]
> +CPU_BE(	rev		x3, x3		)
> +CPU_BE(	rev		x4, x4		)
> +CPU_BE(	rev		x5, x5		)
> +CPU_BE(	rev		x6, x6		)
>  	crc32\c\()x	w0, w0, x3
>  	crc32\c\()x	w0, w0, x4
> -	b.ne		0b
> -	ret
> +	crc32\c\()x	w0, w0, x5
> +	crc32\c\()x	w0, w0, x6
> +	cbnz		x2, 32b
> +0:	ret
>  
>  8:	tbz		x2, #3, 4f
>  	ldr		x3, [x1], #8
> --
> 2.19.1
> 
> 
> BEFORE testing speed of async crc32c (crc32c-generic)
> tcrypt: test  0 (   16 byte blocks,   16 bytes per update,   1 updates): 35416299 opers/sec, 566660784 bytes/sec
> tcrypt: test  1 (   64 byte blocks,   16 bytes per update,   4 updates): 5342888 opers/sec, 341944832 bytes/sec
> tcrypt: test  2 (   64 byte blocks,   64 bytes per update,   1 updates): 30056634 opers/sec, 1923624576 bytes/sec
> tcrypt: test  3 (  256 byte blocks,   16 bytes per update,  16 updates): 1543567 opers/sec, 395153152 bytes/sec
> tcrypt: test  4 (  256 byte blocks,   64 bytes per update,   4 updates): 4865198 opers/sec, 1245490688 bytes/sec
> tcrypt: test  5 (  256 byte blocks,  256 bytes per update,   1 updates): 12709474 opers/sec, 3253625344 bytes/sec
> tcrypt: test  6 ( 1024 byte blocks,   16 bytes per update,  64 updates): 401746 opers/sec, 411387904 bytes/sec
> tcrypt: test  7 ( 1024 byte blocks,  256 bytes per update,   4 updates): 2576764 opers/sec, 2638606336 bytes/sec
> tcrypt: test  8 ( 1024 byte blocks, 1024 bytes per update,   1 updates): 4464109 opers/sec, 4571247616 bytes/sec
> tcrypt: test  9 ( 2048 byte blocks,   16 bytes per update, 128 updates): 202236 opers/sec, 414179328 bytes/sec
> tcrypt: test 10 ( 2048 byte blocks,  256 bytes per update,   8 updates): 1344017 opers/sec, 2752546816 bytes/sec
> tcrypt: test 11 ( 2048 byte blocks, 1024 bytes per update,   2 updates): 2000544 opers/sec, 4097114112 bytes/sec
> tcrypt: test 12 ( 2048 byte blocks, 2048 bytes per update,   1 updates): 2395890 opers/sec, 4906782720 bytes/sec
> tcrypt: test 13 ( 4096 byte blocks,   16 bytes per update, 256 updates): 101569 opers/sec, 416026624 bytes/sec
> tcrypt: test 14 ( 4096 byte blocks,  256 bytes per update,  16 updates): 687876 opers/sec, 2817540096 bytes/sec
> tcrypt: test 15 ( 4096 byte blocks, 1024 bytes per update,   4 updates): 1029042 opers/sec, 4214956032 bytes/sec
> tcrypt: test 16 ( 4096 byte blocks, 4096 bytes per update,   1 updates): 1206227 opers/sec, 4940705792 bytes/sec
> tcrypt: test 17 ( 8192 byte blocks,   16 bytes per update, 512 updates):  50842 opers/sec, 416497664 bytes/sec
> tcrypt: test 18 ( 8192 byte blocks,  256 bytes per update,  32 updates): 347779 opers/sec, 2849005568 bytes/sec
> tcrypt: test 19 ( 8192 byte blocks, 1024 bytes per update,   8 updates): 525054 opers/sec, 4301242368 bytes/sec
> tcrypt: test 20 ( 8192 byte blocks, 4096 bytes per update,   2 updates): 600919 opers/sec, 4922728448 bytes/sec
> tcrypt: test 21 ( 8192 byte blocks, 8192 bytes per update,   1 updates): 606954 opers/sec, 4972167168 bytes/sec
> 
> AFTER testing speed of async crc32c (crc32c-generic)
> tcrypt: test  0 (   16 byte blocks,   16 bytes per update,   1 updates): 30535173 opers/sec, 488562768 bytes/sec
> tcrypt: test  1 (   64 byte blocks,   16 bytes per update,   4 updates): 4798401 opers/sec, 307097664 bytes/sec
> tcrypt: test  2 (   64 byte blocks,   64 bytes per update,   1 updates): 30061075 opers/sec, 1923908800 bytes/sec
> tcrypt: test  3 (  256 byte blocks,   16 bytes per update,  16 updates): 1359905 opers/sec, 348135680 bytes/sec
> tcrypt: test  4 (  256 byte blocks,   64 bytes per update,   4 updates): 4862043 opers/sec, 1244683008 bytes/sec
> tcrypt: test  5 (  256 byte blocks,  256 bytes per update,   1 updates): 14375092 opers/sec, 3680023552 bytes/sec
> tcrypt: test  6 ( 1024 byte blocks,   16 bytes per update,  64 updates): 351936 opers/sec, 360382464 bytes/sec
> tcrypt: test  7 ( 1024 byte blocks,  256 bytes per update,   4 updates): 2665564 opers/sec, 2729537536 bytes/sec
> tcrypt: test  8 ( 1024 byte blocks, 1024 bytes per update,   1 updates): 4467924 opers/sec, 4575154176 bytes/sec
> tcrypt: test  9 ( 2048 byte blocks,   16 bytes per update, 128 updates): 177021 opers/sec, 362539008 bytes/sec
> tcrypt: test 10 ( 2048 byte blocks,  256 bytes per update,   8 updates): 1414689 opers/sec, 2897283072 bytes/sec
> tcrypt: test 11 ( 2048 byte blocks, 1024 bytes per update,   2 updates): 1995413 opers/sec, 4086605824 bytes/sec
> tcrypt: test 12 ( 2048 byte blocks, 2048 bytes per update,   1 updates): 2393630 opers/sec, 4902154240 bytes/sec
> tcrypt: test 13 ( 4096 byte blocks,   16 bytes per update, 256 updates):  88758 opers/sec, 363552768 bytes/sec
> tcrypt: test 14 ( 4096 byte blocks,  256 bytes per update,  16 updates): 731752 opers/sec, 2997256192 bytes/sec
> tcrypt: test 15 ( 4096 byte blocks, 1024 bytes per update,   4 updates): 1030393 opers/sec, 4220489728 bytes/sec
> tcrypt: test 16 ( 4096 byte blocks, 4096 bytes per update,   1 updates): 1205718 opers/sec, 4938620928 bytes/sec
> tcrypt: test 17 ( 8192 byte blocks,   16 bytes per update, 512 updates):  44450 opers/sec, 364134400 bytes/sec
> tcrypt: test 18 ( 8192 byte blocks,  256 bytes per update,  32 updates): 373236 opers/sec, 3057549312 bytes/sec
> tcrypt: test 19 ( 8192 byte blocks, 1024 bytes per update,   8 updates): 524905 opers/sec, 4300021760 bytes/sec
> tcrypt: test 20 ( 8192 byte blocks, 4096 bytes per update,   2 updates): 601242 opers/sec, 4925374464 bytes/sec
> tcrypt: test 21 ( 8192 byte blocks, 8192 bytes per update,   1 updates): 606769 opers/sec, 4970651648 bytes/sec
