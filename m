Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0066EC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F1A20827
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1F1A20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbeJ2TRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 15:17:20 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38444 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729487AbeJ2TRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 15:17:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 845051684;
        Mon, 29 Oct 2018 03:29:16 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5518E3F6A8;
        Mon, 29 Oct 2018 03:29:16 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 4C3E91AE0757; Mon, 29 Oct 2018 10:29:23 +0000 (GMT)
Date:   Mon, 29 Oct 2018 10:29:23 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kyeongdon Kim <kyeongdon.kim@lge.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 2/3] arm64: lib: use C string functions with KASAN
 enabled.
Message-ID: <20181029102922.GC14127@arm.com>
References: <20180914152800.GB6236@arm.com>
 <20180920135631.23833-1-aryabinin@virtuozzo.com>
 <20180920135631.23833-2-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920135631.23833-2-aryabinin@virtuozzo.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 04:56:30PM +0300, Andrey Ryabinin wrote:
> ARM64 has asm implementation of memchr(), memcmp(), str[r]chr(),
> str[n]cmp(), str[n]len(). KASAN don't see memory accesses in asm
> code, thus it can potentially miss many bugs.
> 
> Ifdef out __HAVE_ARCH_* defines of these functions when KASAN is
> enabled, so the generic implementations from lib/string.c will be used.
> 
> We can't just remove the asm functions because efistub uses them.
> And we can't have two non-weak functions either, so declare the asm
> functions as weak.
> 
> Reported-by: Kyeongdon Kim <kyeongdon.kim@lge.com>
> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> ---
> Changes since v1:
>  - Use WEAK() instead of .weak
> 
>  arch/arm64/include/asm/string.h | 14 ++++++++------
>  arch/arm64/kernel/arm64ksyms.c  |  7 +++++--
>  arch/arm64/lib/memchr.S         |  2 +-
>  arch/arm64/lib/memcmp.S         |  2 +-
>  arch/arm64/lib/strchr.S         |  2 +-
>  arch/arm64/lib/strcmp.S         |  2 +-
>  arch/arm64/lib/strlen.S         |  2 +-
>  arch/arm64/lib/strncmp.S        |  2 +-
>  arch/arm64/lib/strnlen.S        |  2 +-
>  arch/arm64/lib/strrchr.S        |  2 +-
>  10 files changed, 21 insertions(+), 16 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Please post these again after the merge window and we'll figure out how to
get them queued.

Will
