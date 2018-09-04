Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACC1C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 06:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0007C20652
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 06:59:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0007C20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lge.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbeIDLXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 07:23:05 -0400
Received: from lgeamrelo12.lge.com ([156.147.23.52]:60797 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726041AbeIDLXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 07:23:05 -0400
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
        by 156.147.23.52 with ESMTP; 4 Sep 2018 15:59:19 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: kyeongdon.kim@lge.com
Received: from unknown (HELO ?10.159.80.93?) (10.159.80.93)
        by 156.147.1.121 with ESMTP; 4 Sep 2018 15:59:18 +0900
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
 <dff9a2f3-7db5-9e60-072a-312b6cfbe0f0@virtuozzo.com>
From:   Kyeongdon Kim <kyeongdon.kim@lge.com>
Message-ID: <ad334e64-28d1-4b91-aeba-8352934a9c46@lge.com>
Date:   Tue, 4 Sep 2018 15:59:17 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <dff9a2f3-7db5-9e60-072a-312b6cfbe0f0@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrey,

Thanks for your review.

On 2018-09-03 오후 6:40, Andrey Ryabinin wrote:
>
>
> On 08/23/2018 11:56 AM, Kyeongdon Kim wrote:
>
> > diff --git a/mm/kasan/kasan.c b/mm/kasan/kasan.c
> > index c3bd520..61ad7f1 100644
> > --- a/mm/kasan/kasan.c
> > +++ b/mm/kasan/kasan.c
> > @@ -304,6 +304,29 @@ void *memcpy(void *dest, const void *src, 
> size_t len)
> >
> > return __memcpy(dest, src, len);
> > }
> > +#ifdef CONFIG_ARM64
> > +/*
> > + * Arch arm64 use assembly variant for strcmp/strncmp,
> > + * xtensa use inline asm operations and x86_64 use c one,
> > + * so now this interceptors only for arm64 kasan.
> > + */
> > +#undef strcmp
> > +int strcmp(const char *cs, const char *ct)
> > +{
> > + check_memory_region((unsigned long)cs, 1, false, _RET_IP_);
> > + check_memory_region((unsigned long)ct, 1, false, _RET_IP_);
> > +
>
> Well this is definitely wrong. strcmp() often accesses far more than 
> one byte.
>
> > + return __strcmp(cs, ct);
> > +}
> > +#undef strncmp
> > +int strncmp(const char *cs, const char *ct, size_t len)
> > +{
> > + check_memory_region((unsigned long)cs, len, false, _RET_IP_);
> > + check_memory_region((unsigned long)ct, len, false, _RET_IP_);
>
> This will cause false positives. Both 'cs', and 'ct' could be less 
> than len bytes.
>
> There is no need in these interceptors, just use the C implementations 
> from lib/string.c
> like you did in your first patch.
> The only thing that was wrong in the first patch is that assembly 
> implementations
> were compiled out instead of being declared week.
>
Well, at first I thought so..
I would remove diff code in /mm/kasan/kasan.c then use C implementations 
in lib/string.c
w/ assem implementations as weak :

diff --git a/lib/string.c b/lib/string.c
index 2c0900a..a18b18f 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -312,7 +312,7 @@ size_t strlcat(char *dest, const char *src, size_t 
count)
  EXPORT_SYMBOL(strlcat);
  #endif

-#ifndef __HAVE_ARCH_STRCMP
+#if (defined(CONFIG_ARM64) && defined(CONFIG_KASAN)) || 
!defined(__HAVE_ARCH_STRCMP)
  /**
   * strcmp - Compare two strings
   * @cs: One string
@@ -336,7 +336,7 @@ int strcmp(const char *cs, const char *ct)
  EXPORT_SYMBOL(strcmp);
  #endif

-#ifndef __HAVE_ARCH_STRNCMP
+#if (defined(CONFIG_ARM64) && defined(CONFIG_KASAN)) || 
!defined(__HAVE_ARCH_STRNCMP)
  /**
   * strncmp - Compare two length-limited strings

Can I get your opinion wrt this ?

Thanks,

