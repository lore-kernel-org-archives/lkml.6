Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CAEC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D14162075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D14162075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lge.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbeIEMN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 08:13:57 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:60260 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbeIEMN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 08:13:56 -0400
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.51 with ESMTP; 5 Sep 2018 16:44:58 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: kyeongdon.kim@lge.com
Received: from unknown (HELO ?10.159.80.93?) (10.159.80.93)
        by 156.147.1.125 with ESMTP; 5 Sep 2018 16:44:56 +0900
X-Original-SENDERIP: 10.159.80.93
X-Original-MAILFROM: kyeongdon.kim@lge.com
Subject: Re: Re: [PATCH v2] arm64: kasan: add interceptors for strcmp/strncmp
 functions
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, glider@google.com,
        dvyukov@google.com, Jason@zx2c4.com, robh@kernel.org,
        ard.biesheuvel@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org
References: <1535014606-176525-1-git-send-email-kyeongdon.kim@lge.com>
 <12d4e435-e229-b4af-4286-a53fa77cb09d@virtuozzo.com>
From:   Kyeongdon Kim <kyeongdon.kim@lge.com>
Message-ID: <0bde837e-2804-c6d6-4bda-8b166bdcfc6b@lge.com>
Date:   Wed, 5 Sep 2018 16:44:54 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <12d4e435-e229-b4af-4286-a53fa77cb09d@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-09-05 오전 1:24, Andrey Ryabinin wrote:
>
>
> On 09/04/2018 01:10 PM, Andrey Ryabinin wrote:
> >
> >
> > On 09/04/2018 09:59 AM, Kyeongdon Kim wrote:
> >
> >>>> +#undef strncmp
> >>>> +int strncmp(const char *cs, const char *ct, size_t len)
> >>>> +{
> >>>> + check_memory_region((unsigned long)cs, len, false, _RET_IP_);
> >>>> + check_memory_region((unsigned long)ct, len, false, _RET_IP_);
> >>>
> >>> This will cause false positives. Both 'cs', and 'ct' could be less 
> than len bytes.
> >>>
> >>> There is no need in these interceptors, just use the C 
> implementations from lib/string.c
> >>> like you did in your first patch.
> >>> The only thing that was wrong in the first patch is that assembly 
> implementations
> >>> were compiled out instead of being declared week.
> >>>
> >> Well, at first I thought so..
> >> I would remove diff code in /mm/kasan/kasan.c then use C 
> implementations in lib/string.c
> >> w/ assem implementations as weak :
> >>
> >> diff --git a/lib/string.c b/lib/string.c
> >> index 2c0900a..a18b18f 100644
> >> --- a/lib/string.c
> >> +++ b/lib/string.c
> >> @@ -312,7 +312,7 @@ size_t strlcat(char *dest, const char *src, 
> size_t count)
> >>  EXPORT_SYMBOL(strlcat);
> >>  #endif
> >>
> >> -#ifndef __HAVE_ARCH_STRCMP
> >> +#if (defined(CONFIG_ARM64) && defined(CONFIG_KASAN)) || 
> !defined(__HAVE_ARCH_STRCMP)
> >
> > No. What part of "like you did in your first patch" is unclear to you?
>
> Just to be absolutely clear, I meant #ifdef out __HAVE_ARCH_* defines 
> like it has been done in this patch
> http://lkml.kernel.org/r/<1534233322-106271-1-git-send-email-kyeongdon.kim@lge.com> 
>
I understood what you're saying, but I might think the wrong patch.

So, thinking about the other way as below:
can pick up assem variant or c one, declare them as weak.
---
diff --git a/arch/arm64/include/asm/string.h 
b/arch/arm64/include/asm/string.h
index dd95d33..53a2ae0 100644
--- a/arch/arm64/include/asm/string.h
+++ b/arch/arm64/include/asm/string.h
@@ -22,11 +22,22 @@ extern char *strrchr(const char *, int c);
  #define __HAVE_ARCH_STRCHR
  extern char *strchr(const char *, int c);

+#ifdef CONFIG_KASAN
+extern int __strcmp(const char *, const char *);
+extern int __strncmp(const char *, const char *, __kernel_size_t);
+
+#ifndef __SANITIZE_ADDRESS__
+#define strcmp(cs, ct) __strcmp(cs, ct)
+#define strncmp(cs, ct, n) __strncmp(cs, ct, n)
+#endif
+
+#else
  #define __HAVE_ARCH_STRCMP
  extern int strcmp(const char *, const char *);

  #define __HAVE_ARCH_STRNCMP
  extern int strncmp(const char *, const char *, __kernel_size_t);
+#endif

  #define __HAVE_ARCH_STRLEN
  extern __kernel_size_t strlen(const char *);
diff --git a/arch/arm64/kernel/arm64ksyms.c b/arch/arm64/kernel/arm64ksyms.c
index d894a20..9aeffd5 100644
--- a/arch/arm64/kernel/arm64ksyms.c
+++ b/arch/arm64/kernel/arm64ksyms.c
@@ -50,6 +50,10 @@ EXPORT_SYMBOL(strcmp);
  EXPORT_SYMBOL(strncmp);
  EXPORT_SYMBOL(strlen);
  EXPORT_SYMBOL(strnlen);
+#ifdef CONFIG_KASAN
+EXPORT_SYMBOL(__strcmp);
+EXPORT_SYMBOL(__strncmp);
+#endif
  EXPORT_SYMBOL(memset);
  EXPORT_SYMBOL(memcpy);
  EXPORT_SYMBOL(memmove);
diff --git a/arch/arm64/kernel/image.h b/arch/arm64/kernel/image.h
index a820ed0..5ef7a57 100644
--- a/arch/arm64/kernel/image.h
+++ b/arch/arm64/kernel/image.h
@@ -110,6 +110,8 @@ __efistub___flush_dcache_area    = 
KALLSYMS_HIDE(__pi___flush_dcache_area);
  __efistub___memcpy        = KALLSYMS_HIDE(__pi_memcpy);
  __efistub___memmove        = KALLSYMS_HIDE(__pi_memmove);
  __efistub___memset        = KALLSYMS_HIDE(__pi_memset);
+__efistub___strcmp        = KALLSYMS_HIDE(__pi_strcmp);
+__efistub___strncmp        = KALLSYMS_HIDE(__pi_strncmp);
  #endif

  __efistub__text            = KALLSYMS_HIDE(_text);
diff --git a/arch/arm64/lib/strcmp.S b/arch/arm64/lib/strcmp.S
index 471fe61..0dffef7 100644
--- a/arch/arm64/lib/strcmp.S
+++ b/arch/arm64/lib/strcmp.S
@@ -60,6 +60,8 @@ tmp3        .req    x9
  zeroones    .req    x10
  pos        .req    x11

+.weak strcmp
+ENTRY(__strcmp)
  ENTRY(strcmp)
      eor    tmp1, src1, src2
      mov    zeroones, #REP8_01
@@ -232,3 +234,4 @@ CPU_BE(    orr    syndrome, diff, has_nul )
      sub    result, data1, data2, lsr #56
      ret
  ENDPIPROC(strcmp)
+ENDPROC(__strcmp)
diff --git a/arch/arm64/lib/strncmp.S b/arch/arm64/lib/strncmp.S
index e267044..b2648c7 100644
--- a/arch/arm64/lib/strncmp.S
+++ b/arch/arm64/lib/strncmp.S
@@ -64,6 +64,8 @@ limit_wd    .req    x13
  mask        .req    x14
  endloop        .req    x15

+.weak strncmp
+ENTRY(__strncmp)
  ENTRY(strncmp)
      cbz    limit, .Lret0
      eor    tmp1, src1, src2
@@ -308,3 +310,4 @@ CPU_BE( orr    syndrome, diff, has_nul )
      mov    result, #0
      ret
  ENDPIPROC(strncmp)
+ENDPROC(__strncmp)
-- 
Could you review this diff?
