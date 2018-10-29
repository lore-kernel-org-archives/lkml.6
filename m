Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA46EC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 11:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D792082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 11:30:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86D792082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbeJ2USP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 16:18:15 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39100 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbeJ2USO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 16:18:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DE20341;
        Mon, 29 Oct 2018 04:20:28 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4AB7B3F6A8;
        Mon, 29 Oct 2018 04:20:28 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 395D91AE091C; Mon, 29 Oct 2018 11:20:35 +0000 (GMT)
Date:   Mon, 29 Oct 2018 11:20:35 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        akpm@linux-foundation.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Kyeongdon Kim <kyeongdon.kim@lge.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 2/3] arm64: lib: use C string functions with KASAN
 enabled.
Message-ID: <20181029112034.GE14127@arm.com>
References: <20180914152800.GB6236@arm.com>
 <20180920135631.23833-1-aryabinin@virtuozzo.com>
 <20180920135631.23833-2-aryabinin@virtuozzo.com>
 <20181029102922.GC14127@arm.com>
 <9cf4a5ff-b68d-5703-720a-bce05409428a@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cf4a5ff-b68d-5703-720a-bce05409428a@virtuozzo.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey, Andrew,

On Mon, Oct 29, 2018 at 11:16:15AM +0000, Andrey Ryabinin wrote:
> On 10/29/2018 01:29 PM, Will Deacon wrote:
> > On Thu, Sep 20, 2018 at 04:56:30PM +0300, Andrey Ryabinin wrote:
> >> ARM64 has asm implementation of memchr(), memcmp(), str[r]chr(),
> >> str[n]cmp(), str[n]len(). KASAN don't see memory accesses in asm
> >> code, thus it can potentially miss many bugs.
> >>
> >> Ifdef out __HAVE_ARCH_* defines of these functions when KASAN is
> >> enabled, so the generic implementations from lib/string.c will be used.
> >>
> >> We can't just remove the asm functions because efistub uses them.
> >> And we can't have two non-weak functions either, so declare the asm
> >> functions as weak.
> >>
> >> Reported-by: Kyeongdon Kim <kyeongdon.kim@lge.com>
> >> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> >> ---
> >> Changes since v1:
> >>  - Use WEAK() instead of .weak
> >>
> >>  arch/arm64/include/asm/string.h | 14 ++++++++------
> >>  arch/arm64/kernel/arm64ksyms.c  |  7 +++++--
> >>  arch/arm64/lib/memchr.S         |  2 +-
> >>  arch/arm64/lib/memcmp.S         |  2 +-
> >>  arch/arm64/lib/strchr.S         |  2 +-
> >>  arch/arm64/lib/strcmp.S         |  2 +-
> >>  arch/arm64/lib/strlen.S         |  2 +-
> >>  arch/arm64/lib/strncmp.S        |  2 +-
> >>  arch/arm64/lib/strnlen.S        |  2 +-
> >>  arch/arm64/lib/strrchr.S        |  2 +-
> >>  10 files changed, 21 insertions(+), 16 deletions(-)
> > 
> > Acked-by: Will Deacon <will.deacon@arm.com>
> > 
> > Please post these again after the merge window and we'll figure out how to
> > get them queued.
> 
> Andrew sent these patches to Linus couple days ago, so they are in tree
> already.

Oh, good thing I was happy with them in the end, then!

> Something went wrong with mail notification though. I didn't even realize
> that they were in -mm tree, because I didn't receive the usual 'the patch
> has been added to -mm tree' email.  But I did receive email that was sent
> to Linus.

Yeah, strange. I usually see the notifications from Andrew.

> Also there was no you or Catalin in Cc tags in 2,3 patches, and in the
> first patch, the Cc tags were corrupted:

:/

Andrew -- have we broken your scripts somehow, or is this just a one-off
for these patches?

Thanks,

Will

> From: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Subject: include/linux/linkage.h: align weak symbols
> 
> Since WEAK() supposed to be used instead of ENTRY() to define weak
> symbols, but unlike ENTRY() it doesn't have ALIGN directive.  It seems
> there is no actual reason to not have, so let's add ALIGN to WEAK() too.
> 
> Link: http://lkml.kernel.org/r/20180920135631.23833-1-aryabinin@virtuozzo.com
> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>
> Cc: Kyeongdon Kim <kyeongdon.kim@lge.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
