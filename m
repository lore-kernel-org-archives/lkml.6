Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB1DC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ECF02083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="b4IIH228"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ECF02083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388774AbeGZSf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 14:35:28 -0400
Received: from m12-15.163.com ([220.181.12.15]:52866 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730085AbeGZSf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 14:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=k+h/V
        zvOiVQ8oDcgcXd7FtCcUQIQ35iaG86Fx9vJIbQ=; b=b4IIH228335pgx5v5WLve
        BtMuGfdd2sTc08CP7m2MbWb+OrzU44feolUgdm2UKg8UsDCrqJ47WpBUv8/axyu4
        uyEvLP4bLheeQdhlv3V4iGRtFN9H6DzQJY6G0LC5yNPDrcOYpHR+NmUjSqtjG4WV
        JZl0z7ufx0Yf8Y8PNo2tA8=
Received: from [192.168.0.103] (unknown [223.74.107.77])
        by smtp11 (Coremail) with SMTP id D8CowAD3PtMRAlpbU45TBg--.37271S3;
        Fri, 27 Jul 2018 01:17:09 +0800 (CST)
Subject: Re: [PATCH 1/1] lib: use sunday algorithm to do strstr() and
 strnstr()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        linux-kernel@vger.kernel.org, Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
References: <20180722173715.25327-1-zengzhaoxiu@163.com>
 <20180722183706.GA7979@kroah.com>
From:   Zhaoxiu Zeng <zengzhaoxiu@163.com>
Message-ID: <9b18802b-a451-eb81-3317-1de406f03118@163.com>
Date:   Fri, 27 Jul 2018 01:17:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180722183706.GA7979@kroah.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: D8CowAD3PtMRAlpbU45TBg--.37271S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3AF47Wr43ur48Jw4rtF17Awb_yoW7Xr4DpF
        yDCF9aqw4Fqw1ayr4IyryxWrWkCFs3XrW8t348trsIvFn8WrsYyr43GFs09F4fX34kuF1r
        ArWSqwn8ZF4UX37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jiZ23UUUUU=
X-Originating-IP: [223.74.107.77]
X-CM-SenderInfo: p2hqw6xkdr5xrx6rljoofrz/xtbBDRaPgFaDzYSLXwAAsc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2018/7/23 2:37, Greg Kroah-Hartman Ð´µÀ:
> On Mon, Jul 23, 2018 at 01:37:15AM +0800, Zhaoxiu Zeng wrote:
>> From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
>>
>> The Sunday algorithm is a variation of Boyer-Moore algorithm, it is easy and fast.
>> For the Sunday algorithm, to see
>> 	http://www.inf.fh-flensburg.de/lang/algorithmen/pattern/sundayen.htm
> 
> So you say, but what does this really buy us?  Why make this change?
> How was it tested?  What is the downside of not taking this?
> 
> thanks,
> 
> greg k-h
> 

I use the following program to test on fc28.
Compile with O2, the new version is almost 2X faster than the original.
The code size of the original is 0x80, the newer is 0xB0.


#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

/**
 * strstr - Find the first substring in a %NUL terminated string
 * @s1: The string to be searched
 * @s2: The string to search for
 */
char *strstr1(const char *s1, const char *s2)
{
	size_t l1, l2;

	l2 = strlen(s2);
	if (!l2)
		return (char *)s1;
	l1 = strlen(s1);
	while (l1 >= l2) {
		l1--;
		if (!memcmp(s1, s2, l2))
			return (char *)s1;
		s1++;
	}
	return NULL;
}

char *strstr2(const char *s1, const char *s2)
{
	size_t l2;
	const char *pchk = s1;

#if 1//def __HAVE_ARCH_STRLEN
	l2 = strlen(s2);
#else
	for (l2 = 0; s2[l2] != 0; l2++)
		/* nothing */;
#endif
	if (!l2)
		return (char *)s1;

	/*
	 * Sunday matching
	 */
	while (1) {
		size_t i;
		char k;

		/* compare */
		for (i = 0; i < l2; i++) {
			if (s1[i] != s2[i])
				break;
		}
		if (i >= l2)
			return (char *)s1;

		/* if s1 terminate early? */
		if (pchk < s1 + i)
			pchk = s1 + i;
		do {
			k = *pchk;
			if (k == 0)
				return NULL;
		} while (pchk++ != s1 + l2);

		/* find the k's last presence in s2 (k = s1[l2]) */
		for (i = l2; --i != (size_t)-1; ) {
			if (k == s2[i])
				break;
		}

		/* shift */
		s1 += l2 - i;
	}
}

#ifdef __i386__
#  define RDTSC_CLOBBER "%eax", "%ebx", "%ecx", "%edx"
#elif __x86_64__
#  define RDTSC_CLOBBER "%rax", "%rbx", "%rcx", "%rdx"
#else
# error unknown platform
#endif

#define RDTSC_START(cycles)                                \
    do {                                                   \
        register unsigned cyc_high, cyc_low;               \
        asm volatile("CPUID\n\t"                           \
                     "RDTSC\n\t"                           \
                     "mov %%edx, %0\n\t"                   \
                     "mov %%eax, %1\n\t"                   \
                     : "=r" (cyc_high), "=r" (cyc_low)     \
                     :: RDTSC_CLOBBER);                    \
        (cycles) = ((uint64_t)cyc_high << 32) | cyc_low;   \
    } while (0)

#define RDTSC_STOP(cycles)                                 \
    do {                                                   \
        register unsigned cyc_high, cyc_low;               \
        asm volatile("RDTSCP\n\t"                          \
                     "mov %%edx, %0\n\t"                   \
                     "mov %%eax, %1\n\t"                   \
                     "CPUID\n\t"                           \
                     : "=r" (cyc_high), "=r" (cyc_low)     \
                     :: RDTSC_CLOBBER);                    \
        (cycles) = ((uint64_t)cyc_high << 32) | cyc_low;   \
    } while (0)

typedef unsigned long long TIME_T;
#define start_time(start)		RDTSC_START(start)
#define stop_time(stop)			RDTSC_STOP(stop)
#define diff_time(start, stop)	(stop - start)

#define MAX_HAYSTACK_LENGTH 64
#define MAX_NEEDLE_LENGTH 16
#define TEST_LOOPS 1000

char haystack[MAX_HAYSTACK_LENGTH + 1];
char needle[MAX_NEEDLE_LENGTH + 1];

int main(int argc, char **argv)
{
    size_t i, j, n;
    void *p1, *p2;

    srand(time(0));

    for (i = 0; i < MAX_HAYSTACK_LENGTH; ) {
        haystack[i] = rand();
        if (haystack[i] != 0)
            i++;
    }
    haystack[i] = 0;

    for (i = 0; i < MAX_HAYSTACK_LENGTH; i++) {
        TIME_T start, stop;
        unsigned long long elapsed1, elapsed2;

        j = rand() % MAX_NEEDLE_LENGTH;
        if (i <= MAX_HAYSTACK_LENGTH - (MAX_NEEDLE_LENGTH - j))
            n = i;
        else
            n = MAX_HAYSTACK_LENGTH - (MAX_NEEDLE_LENGTH - j);
        memcpy(needle + j, haystack + n, MAX_NEEDLE_LENGTH - j);
        needle[MAX_NEEDLE_LENGTH] = 0;

        elapsed1 = ~0UL;
        for (n = 0; n < TEST_LOOPS; n++) {
            start_time(start);
            asm volatile("":::"memory");
            p1 = strstr1(haystack, needle + j);
            asm volatile("":::"memory");
            stop_time(stop);

            if (elapsed1 > diff_time(start, stop))
                elapsed1 = diff_time(start, stop);
        }

        elapsed2 = ~0UL;
        for (n = 0; n < TEST_LOOPS; n++) {
            start_time(start);
            asm volatile("":::"memory");
            p2 = strstr2(haystack, needle + j);
            asm volatile("":::"memory");
            stop_time(stop);

            if (elapsed2 > diff_time(start, stop))
                elapsed2 = diff_time(start, stop);
        }

        if (p1 != p2)
            fprintf(stderr, "Error: %p != %p\n", p1, p2);
        else
            fprintf(stdout, "%3d, %3d:\t%lld,\t%lld\n", i, j, elapsed1, elapsed2);
    }

    return 0;
}

The test result:
[zzx@fedora strstr]$ ./test
  0,   3:	68,	68
  1,  13:	74,	66
  2,   2:	88,	94
  3,   5:	96,	88
  4,   8:	108,	80
  5,  13:	110,	76
  6,  12:	132,	82
  7,   9:	142,	82
  8,  11:	152,	88
  9,  13:	146,	90
 10,  14:	154,	94
 11,  15:	132,	104
 12,   1:	196,	114
 13,   8:	206,	108
 14,  14:	186,	110
 15,  13:	194,	112
 16,   0:	260,	124
 17,  10:	258,	124
 18,  15:	208,	136
 19,  11:	276,	136
 20,  13:	256,	128
 21,  12:	292,	144
 22,  11:	300,	142
 23,  13:	278,	144
 24,   7:	334,	152
 25,   1:	346,	166
 26,   6:	368,	168
 27,  15:	278,	182
 28,   1:	374,	168
 29,   3:	382,	188
 30,   8:	398,	172
 31,   4:	402,	188
 32,   0:	430,	180
 33,  10:	398,	184
 34,  10:	410,	192
 35,   8:	434,	180
 36,   7:	444,	198
 37,   6:	454,	204
 38,   1:	464,	220
 39,   2:	472,	206
 40,   4:	482,	210
 41,  15:	388,	262
 42,   2:	502,	210
 43,   5:	510,	220
 44,   8:	520,	214
 45,   0:	564,	236
 46,   3:	550,	242
 47,   8:	552,	262
 48,  10:	528,	270
 49,   2:	572,	256
 50,   3:	586,	246
 51,   7:	590,	278
 52,  14:	506,	308
 53,  14:	514,	298
 54,   4:	602,	240
 55,   5:	626,	284
 56,  15:	506,	316
 57,  10:	606,	326
 58,   4:	606,	240
 59,   0:	596,	240
 60,  13:	570,	316
 61,  13:	576,	328
 62,   5:	618,	284
 63,  13:	576,	328

Thanks!

