Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947EDC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D9721479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:38:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42D9721479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeJIRy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 13:54:59 -0400
Received: from foss.arm.com ([217.140.101.70]:35428 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbeJIRy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 13:54:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2847BED1;
        Tue,  9 Oct 2018 03:38:41 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16BC43F5D3;
        Tue,  9 Oct 2018 03:38:38 -0700 (PDT)
Date:   Tue, 9 Oct 2018 11:38:33 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Chunhui Li <chunhui.li@mediatek.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morse <james.morse@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH] kasan: avoid out-of-bounds in unwind_frame
Message-ID: <20181009103833.sk2jyhl77f5fb64r@lakrids.cambridge.arm.com>
References: <1539079863-19645-1-git-send-email-chunhui.li@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539079863-19645-1-git-send-email-chunhui.li@mediatek.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 06:11:03PM +0800, Chunhui Li wrote:
> From: "chunhui.li" <chunhui.li@mediatek.com>
> 
>    kasan detect unwind_frame out-of-bounds error when one task
> dump another, log as below
> BUG: KASAN: out-of-bounds in unwind_frame+0x140/0x20c Read of
> size 8 at addr ffffffea1e2378e0 by task AnrMonitorThrea/1111
> avoid kasan out-of-bounds error by disable kasan for stacktrace.c

This doesn't look right. Since unwind_frame uses READ_ONCE_NOCHECK(),
we should never perform an access that KASAN complains about.

I don't think that we should completely disable instrumentation of
stacktrace.c.

Can you please figure out precisely which line KASAN is complaining
about? i.e. use scripts/faddr2line.

Thanks,
Mark.

> 
> Signed-off-by: chunhui.li <chunhui.li@mediatek.com>
> ---
>  arch/arm64/kernel/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index 95ac737..606d0e2 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -57,6 +57,8 @@ arm64-obj-$(CONFIG_CRASH_DUMP)		+= crash_dump.o
>  arm64-obj-$(CONFIG_ARM_SDE_INTERFACE)	+= sdei.o
>  arm64-obj-$(CONFIG_ARM64_SSBD)		+= ssbd.o
>  
> +KASAN_SANITIZE_stacktrace.o := n
> +
>  obj-y					+= $(arm64-obj-y) vdso/ probes/
>  obj-m					+= $(arm64-obj-m)
>  head-y					:= head.o
> -- 
> 1.9.1
> 
