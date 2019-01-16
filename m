Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32C6C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A64620675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394263AbfAPQrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:47:19 -0500
Received: from foss.arm.com ([217.140.101.70]:52780 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394251AbfAPQrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:47:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06095A78;
        Wed, 16 Jan 2019 08:47:19 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 981C63F5AF;
        Wed, 16 Jan 2019 08:47:16 -0800 (PST)
Date:   Wed, 16 Jan 2019 16:47:13 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, Qian Cai <cai@lca.pw>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] kasan: Remove use after scope bugs detection.
Message-ID: <20190116164712.GB1910@brain-police>
References: <20190111185842.13978-1-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111185842.13978-1-aryabinin@virtuozzo.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 09:58:42PM +0300, Andrey Ryabinin wrote:
> Use after scope bugs detector seems to be almost entirely useless
> for the linux kernel. It exists over two years, but I've seen only
> one valid bug so far [1]. And the bug was fixed before it has been
> reported. There were some other use-after-scope reports, but they
> were false-positives due to different reasons like incompatibility
> with structleak plugin.
> 
> This feature significantly increases stack usage, especially with
> GCC < 9 version, and causes a 32K stack overflow. It probably
> adds performance penalty too.
> 
> Given all that, let's remove use-after-scope detector entirely.
> 
> While preparing this patch I've noticed that we mistakenly enable
> use-after-scope detection for clang compiler regardless of
> CONFIG_KASAN_EXTRA setting. This is also fixed now.
> 
> [1] http://lkml.kernel.org/r/<20171129052106.rhgbjhhis53hkgfn@wfg-t540p.sh.intel.com>
> 
> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/memory.h |  4 ----
>  lib/Kconfig.debug               |  1 -
>  lib/Kconfig.kasan               | 10 ----------
>  lib/test_kasan.c                | 24 ------------------------
>  mm/kasan/generic.c              | 19 -------------------
>  mm/kasan/generic_report.c       |  3 ---
>  mm/kasan/kasan.h                |  3 ---
>  scripts/Makefile.kasan          |  5 -----
>  scripts/gcc-plugins/Kconfig     |  4 ----
>  9 files changed, 73 deletions(-)

For the arm64 part:

Acked-by: Will Deacon <will.deacon@arm.com>

but I defer to you and Dmitry as to whether or not you go ahead with this.

Will
