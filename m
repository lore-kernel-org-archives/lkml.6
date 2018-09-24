Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09432ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED9B208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:19:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BED9B208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387439AbeIXXWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:22:51 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39090 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729351AbeIXXWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:22:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7203E80D;
        Mon, 24 Sep 2018 10:19:40 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 406B13F5BD;
        Mon, 24 Sep 2018 10:19:39 -0700 (PDT)
Date:   Mon, 24 Sep 2018 18:19:36 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Jun Yao <yaojun8558363@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/6] Move swapper_pg_dir to rodata section.
Message-ID: <20180924171936.q5bfvczzllmm5lpe@lakrids.cambridge.arm.com>
References: <20180917044333.30051-1-yaojun8558363@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917044333.30051-1-yaojun8558363@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 17, 2018 at 12:43:27PM +0800, Jun Yao wrote:
> Version 5 changes:
> 	1. Correct spelling and indentation errors[1].
> 	2. Update init_mm.pgd by assembly[2].
> 	3. Simplify set_p?d() by introducing set_swapper_pgd()[3].
> 	4. Reduce unnecessary tlbi for every write to swapper_pg_dir
> 	   during paging_init()[3].
> 
> v4: https://www.spinics.net/lists/arm-kernel/msg672195.html
> v3: https://www.spinics.net/lists/arm-kernel/msg662537.html
> v2: https://patchwork.kernel.org/patch/10485641/
> v1: https://patchwork.kernel.org/patch/10476595/
> 
> [1] https://www.spinics.net/lists/arm-kernel/msg675189.html
> [2] https://www.spinics.net/lists/arm-kernel/msg675193.html
> [3] https://www.spinics.net/lists/arm-kernel/msg675196.html
> 
> Jun Yao (6):
>   arm64/mm: Introduce the init_pg_dir.
>   arm64/mm: Pass ttbr1 as a parameter to __enable_mmu().
>   arm64/mm: Create the initial page table in the init_pg_dir.
>   arm64/mm: Create the final page table directly in swapper_pg_dir.
>   arm64/mm: Populate the swapper_pg_dir by fixmap.
>   arm64/mm: Move {idmap_pg_dir .. swapper_pg_dir} to rodata section.
> 
>  arch/arm64/include/asm/assembler.h | 29 ++++++++++++++++++
>  arch/arm64/include/asm/pgtable.h   | 36 ++++++++++++++++++----
>  arch/arm64/kernel/asm-offsets.c    |  1 +
>  arch/arm64/kernel/head.S           | 48 ++++++++++++++++++++----------
>  arch/arm64/kernel/sleep.S          |  1 +
>  arch/arm64/kernel/vmlinux.lds.S    | 47 +++++++++++++++++++----------
>  arch/arm64/mm/mmu.c                | 45 +++++++++++++---------------
>  7 files changed, 147 insertions(+), 60 deletions(-)

I've pushed a branch with the cleanups I requested [1] folded in.

I'm still a bit worried about the pgd lock, but otherwise I think this
is sound. I intend to throw some testing at it, just in case.

If you're happy with that branch, I'll ask Will and Catalin to consider
picking it up.

Thanks,
Mark.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/ro-swapper
