Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662ECC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C57D2173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbfBRKlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 05:41:40 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55872 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727004AbfBRKlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 05:41:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE5E780D;
        Mon, 18 Feb 2019 02:41:39 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 774793F720;
        Mon, 18 Feb 2019 02:41:38 -0800 (PST)
Date:   Mon, 18 Feb 2019 10:41:33 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Qian Cai <cai@lca.pw>
Cc:     catalin.marinas@arm.com, andreyknvl@google.com,
        aryabinin@virtuozzo.com, linux-arm-kernel@lists.infradead.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: skip hwasan callbacks for pgtable walker
Message-ID: <20190218104133.GA10743@fuggles.cambridge.arm.com>
References: <20190216044735.32315-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190216044735.32315-1-cai@lca.pw>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 11:47:35PM -0500, Qian Cai wrote:
> Page table walkers trigger soft lockups below with KASAN_SW_TAGS outline
> mode on a large ThunderX2 system, because there is too much overhead to
> call check_memory_region() for every memory access where it needs to
> dereference every byte of the corresponding KASAN shadow address for the
> correct tag.
> 
> [   76.531328] watchdog: BUG: soft lockup - CPU#65 stuck for 23s! [swapper/0:1]
> [   76.538372] Modules linked in:
> [   76.541433] CPU: 65 PID: 1 Comm: swapper/0 Not tainted 5.0.0-rc6+ #62
> [   76.557697] pstate: 60400009 (nZCv daif +PAN -UAO)
> [   76.562491] pc : check_memory_region+0x64/0x94
> [   76.566934] lr : __hwasan_load8_noabort+0x20/0x2c
> [   76.571633] sp : 7eff808ba0247ca0
> [   76.574943] x29: 7eff808ba0247cc0 x28: ffff068cef720000
> [   76.580256] x27: ffff080000000000 x26: 0060000000000793
> [   76.585568] x25: ffff068d00000000 x24: ffff800003537b98
> [   76.590880] x23: 7eff808ba0247e08 x22: 0000000000000000
> [   76.596192] x21: 7eff808ba0247e08 x20: 0000000000000008
> [   76.601503] x19: ffff1000100a8d64 x18: 0000000000000000
> [   76.606814] x17: 0000000001000100 x16: 0000000000000000
> [   76.612125] x15: ffff100013805578 x14: ffff100014085000
> [   76.617437] x13: 0000000030373a2e x12: 00f0000000000793
> [   76.622749] x11: ffff808ba0247e0f x10: ffff0808ba0247e0
> [   76.628060] x9 : ffff0808ba0247e0 x8 : 000000000000007e
> [   76.633371] x7 : 0000000000000000 x6 : 0000000000000002
> [   76.638682] x5 : 0000000000000000 x4 : 00e0000000000793
> [   76.643994] x3 : ffff1000100a8d64 x2 : 0000000000000000
> [   76.649305] x1 : 0000000000000008 x0 : 7eff808ba0247e08
> [   76.654617] Call trace:
> [   76.657066]  check_memory_region+0x64/0x94
> [   76.661162]  __hwasan_load8_noabort+0x20/0x2c
> [   76.665519]  note_page+0x84/0x708
> [   76.668833]  walk_pgd+0x174/0x258
> [   76.672147]  ptdump_check_wx+0x90/0xfc
> [   76.675894]  mark_rodata_ro+0x38/0x44
> [   76.679557]  kernel_init+0x48/0x180
> [   76.683045]  ret_from_fork+0x10/0x18
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  arch/arm64/mm/Makefile | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
> index 849c1df3d214..4b9a7a50faaf 100644
> --- a/arch/arm64/mm/Makefile
> +++ b/arch/arm64/mm/Makefile
> @@ -12,3 +12,9 @@ KASAN_SANITIZE_physaddr.o	+= n
>  
>  obj-$(CONFIG_KASAN)		+= kasan_init.o
>  KASAN_SANITIZE_kasan_init.o	:= n
> +
> +ifdef CONFIG_KASAN_SW_TAGS
> +ifdef CONFIG_KASAN_OUTLINE
> +KASAN_SANITIZE_dump.o		:= n
> +endif
> +endif

I really don't think this is the right way to go about this. Either the
machine eventually makes progress, in which case perhaps the default soft
watchdog timeout should increase when KASAN is enabled, or the machine locks
up, which is a bug.

With your proposal, it will be very difficult to justify ever re-enabling
KASAN on this file and therefore it just chips away at the code coverage
because of an issue that doesn't appear to be well understood.

So please consider this a "NAK" from me based on the current information
that we have.

Will
