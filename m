Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90306C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47DE0214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47DE0214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbeJJQrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 12:47:45 -0400
Received: from foss.arm.com ([217.140.101.70]:49178 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbeJJQrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 12:47:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A2C080D;
        Wed, 10 Oct 2018 02:26:27 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E66DA3F5BC;
        Wed, 10 Oct 2018 02:26:24 -0700 (PDT)
Date:   Wed, 10 Oct 2018 10:26:18 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Chunhui Li =?utf-8?B?KOadjuaYpei+iSk=?= <chunhui.li@mediatek.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morse <james.morse@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        Miles Chen =?utf-8?B?KOmZs+awkeaouik=?= 
        <Miles.Chen@mediatek.com>,
        Walter-ZH Wu =?utf-8?B?KOWQs+elluWvsCk=?= 
        <Walter-ZH.Wu@mediatek.com>,
        Yu Liang =?utf-8?B?KOaigeWuhyk=?= <Yu.Liang@mediatek.com>,
        Nicholas Tang =?utf-8?B?KOmEreenpui8nSk=?= 
        <nicholas.tang@mediatek.com>
Subject: Re: =?utf-8?B?562U5aSN?= =?utf-8?Q?=3A?= [PATCH] kasan: avoid
 out-of-bounds in unwind_frame
Message-ID: <20181010092618.pwkrqqw7br7762rs@lakrids.cambridge.arm.com>
References: <1539079863-19645-1-git-send-email-chunhui.li@mediatek.com>
 <20181009103833.sk2jyhl77f5fb64r@lakrids.cambridge.arm.com>
 <193a2b2efdaf41f39cb35a72feb3b39e@MTKMBS32N1.mediatek.inc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <193a2b2efdaf41f39cb35a72feb3b39e@MTKMBS32N1.mediatek.inc>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 06:45:17AM +0000, Chunhui Li (李春辉) wrote:
> Hi Mark,
> 
> kasan detect out-of-bounds in stacktrace.c line 70, it's already over READ_ONCE_NOCHECK, but still crash
> kernel-4.9/arch/arm64/kernel/stacktrace.c
> 69frame->sp = fp + 0x10;
> 70frame->fp = READ_ONCE_NOCHECK(*(unsigned long *)(fp));
> 
> we test on Android platform, kernel-4.9 build with clang 6.0.2, we will do experiment to clarify whether compiler related issue.
> 
> READ_ONCE_NOCHECK->__read_once_size_nocheck with __no_sanitize_address if enable CONFIG_KASAN
> 
> kernel-4.9/include/linux/compiler-gcc.h
> #define __no_sanitize_address __attribute__((no_sanitize_address))
> 
> kernel-4.9/include/linux/compiler-clang.h
> #define __no_sanitize_address __attribute__((no_sanitize("address")))

If READ_ONCE_NOCHECK() isn't working as intended, then this is a
compiler issue, and there are bigger problems regardless.

If we need to workaround some compiler issue, that should be done in the
implementation of READ_ONCE_NOCHECK().

Please note that there are other issues with using clang to compile the
kernel; at minimum 7.0.0 is required to build a mainline kernel (and
even then, the LSE atomics have to be explicitly disabled), so if this
only affects 6.0.x, I don't think we need to carry any workaround
upstream.

> there is patch from internet, avoid kasan by wrapping with kasan_disable_current, it seems better.
> https://lore.kernel.org/patchwork/patch/644463
> such as:
> +kasan_disable_current();
>   // access fp
> +kasan_enable_current();

Please note that the solution later in the thread [1] was to use
READ_ONCE_NOCHECK().

Thanks,
Mark.

[1] https://lore.kernel.org/patchwork/patch/644463/#829858
