Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6723C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E8D221479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730725AbfACLuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 06:50:22 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47858 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbfACLuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 06:50:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8DAFA78;
        Thu,  3 Jan 2019 03:50:20 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8EC5E3F5D4;
        Thu,  3 Jan 2019 03:50:19 -0800 (PST)
Date:   Thu, 3 Jan 2019 11:50:12 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "moderated list:ARM64 PORT AARCH64 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: Mirror arm for small unimplemented compat syscalls
Message-ID: <20190103114959.GA3529@e103592.cambridge.arm.com>
References: <20190103074550.217421-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190103074550.217421-1-pihsun@chromium.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 03:45:47PM +0800, Pi-Hsun Shih wrote:
> For syscall number smaller than 0xf0000, arm calls sys_ni_syscall
> instead of arm_syscall in arch/arm/kernel/entry-common.S, which returns
> -ENOSYS instead of raising SIGILL. Mirror this behavior for compat
> syscalls in arm64.
> 
> Fixes: 532826f3712b607 ("arm64: Mirror arm for unimplemented compat
> syscalls")
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> ---
>  arch/arm64/kernel/syscall.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> index 8f3371415642ad..95fd8c7ec8a171 100644
> --- a/arch/arm64/kernel/syscall.c
> +++ b/arch/arm64/kernel/syscall.c
> @@ -21,7 +21,7 @@ asmlinkage long do_ni_syscall(struct pt_regs *regs)
>  {
>  #ifdef CONFIG_COMPAT
>  	long ret;
> -	if (is_compat_task()) {
> +	if (is_compat_task() && regs->regs[7] >= __ARM_NR_COMPAT_BASE) {

compat_arm_syscall() ignores all bits r7 except for bits [15:0].

So, doesn't this mean that 0xf0000, 0x100000, 0x110000 will all do the
same thing now?  (Previously to your patch, 0xe0000, 0xd0000 etc. would
also match in this code I've misunderstood something.)

The gating check in arch/arm/kernel/trapc.s:arm_syscall() is

	if ((no >> 16) != (__ARM_NR_BASE>> 16))

I would expect that arm64 needs a similar check somewhere.  Is the check
already present?  I may have missed it.


Cheers
---Dave
