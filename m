Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0477C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 868042085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:39:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 868042085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbeKFSDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:03:15 -0500
Received: from foss.arm.com ([217.140.101.70]:56574 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729021AbeKFSDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:03:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 660FB80D;
        Tue,  6 Nov 2018 00:39:08 -0800 (PST)
Received: from salmiak (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7BC83F5BD;
        Tue,  6 Nov 2018 00:39:06 -0800 (PST)
Date:   Tue, 6 Nov 2018 08:39:01 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Michael Weiser <michael.weiser@gmx.de>,
        James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch/arm64 : fix error in dump_backtrace
Message-ID: <20181106083901.erezwtcomiijvdrk@salmiak>
References: <1541488775-29610-1-git-send-email-huangzhaoyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541488775-29610-1-git-send-email-huangzhaoyang@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 03:19:35PM +0800, Zhaoyang Huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> In some cases, the instruction of "bl foo1" will be the last one of the
> foo2[1], which will cause the lr be the first instruction of the adjacent
> foo3[2]. Hence, the backtrace will show the weird result as bellow[3].
> The patch will fix it by miner 4 of the lr when dump_backtrace

This has come up in the past (and a similar patch has been applied, then
reverted).

In general, we don't know that a function call was made via BL, and therefore
cannot know that LR - 4 is the address of the caller. The caller could set up
the LR as it likes, then B or BR to the callee, and depending on how the basic
blocks get laid out in memory, LR - 4 might point at something completely
different.

More ideally, the compiler wouldn't end a function with a BL. When does that
happen, and is there some way we could arrange for that to not happen? e.g.
somehow pad a NOP after the BL.

Thanks,
Mark.

> 
> [1]
> 0xffffff80081e6b04 <handle_mm_fault+3996>:      adrp    x0, 0xffffff8008ca8000
> 0xffffff80081e6b08 <handle_mm_fault+4000>:      add     x0, x0, #0x5a8
> 0xffffff80081e6b0c <handle_mm_fault+4004>:      bl      0xffffff80081b0ca0 <panic>
> 0xffffff80081e6b10 <access_remote_vm>:  stp     x29, x30, [sp,#-64]!
> 0xffffff80081e6b14 <access_remote_vm+4>:        mov     x29, sp
> 
> [2]
> crash_arm64> rd ffffffc02eec3bd0 2
> ffffffc02eec3bd0:  ffffffc02eec3cb0 ffffff80081e6b10
> 
> [3]
> wrong:
> [<ffffff80081b0d90>] panic+0xf0/0x24c
> [<ffffff80081e6b10>] access_remote_vm+0x0/0x5c
> [<ffffff800809d7b0>] do_page_fault+0x290/0x3b8
> [<ffffff8008081570>] do_mem_abort+0x64/0xdc
> 
> correct:
> [ffffffc02eec3bd0] panic at ffffff80081b0da4
> [ffffffc02eec3cb0] handle_mm_fault at ffffff80081e6b0c
> [ffffffc02eec3d80] do_page_fault at ffffff800809d7ac
> [ffffffc02eec3df0] do_mem_abort at ffffff800808156c
> 
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  arch/arm64/kernel/traps.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index d399d45..7a097cc 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -113,7 +113,7 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
>  
>  	if (tsk == current) {
>  		frame.fp = (unsigned long)__builtin_frame_address(0);
> -		frame.pc = (unsigned long)dump_backtrace;
> +		frame.pc = (unsigned long)dump_backtrace + 4;
>  	} else {
>  		/*
>  		 * task blocked in __switch_to
> @@ -130,7 +130,7 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
>  	do {
>  		/* skip until specified stack frame */
>  		if (!skip) {
> -			dump_backtrace_entry(frame.pc);
> +			dump_backtrace_entry(frame.pc - 4);
>  		} else if (frame.fp == regs->regs[29]) {
>  			skip = 0;
>  			/*
> -- 
> 1.9.1
> 
