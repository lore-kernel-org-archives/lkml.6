Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 965EDC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 09:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A91B20693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 09:14:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A91B20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754342AbeFLJOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 05:14:47 -0400
Received: from foss.arm.com ([217.140.101.70]:59456 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754293AbeFLJOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 05:14:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56C261435;
        Tue, 12 Jun 2018 02:14:45 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BC7B3F59D;
        Tue, 12 Jun 2018 02:14:43 -0700 (PDT)
Date:   Tue, 12 Jun 2018 10:14:41 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Zhizhou Zhang <zhizhouzhang@asrmicro.com>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com,
        julien.thierry@arm.com, suzuki.poulose@arm.com,
        hoeun.ryu@gmail.com, ard.biesheuvel@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: make secondary_start_kernel() notrace
Message-ID: <20180612091440.f4jd2r4kq3nxv7pr@lakrids.cambridge.arm.com>
References: <1528794457-14129-1-git-send-email-zhizhouzhang@asrmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528794457-14129-1-git-send-email-zhizhouzhang@asrmicro.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 05:07:37PM +0800, Zhizhou Zhang wrote:
> We can't call function trace hook before setup percpu offset.
> When entering secondary_start_kernel(), percpu offset has not
> been initialized.  So this lead hotplug malfunction.
> Here is the flow to reproduce this bug:
> 
> echo 0 > /sys/devices/system/cpu/cpu1/online
> echo function > /sys/kernel/debug/tracing/current_tracer
> echo 1 > /sys/kernel/debug/tracing/tracing_on
> echo 1 > /sys/devices/system/cpu/cpu1/online
> 
> Signed-off-by: Zhizhou Zhang <zhizhouzhang@asrmicro.com>
> ---
>  arch/arm64/kernel/smp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index f3e2e3ae..11b0f30 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -179,7 +179,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>   * This is the secondary CPU boot entry.  We're using this CPUs
>   * idle thread stack, but a set of temporary page tables.
>   */
> -asmlinkage void secondary_start_kernel(void)
> +notrace asmlinkage void secondary_start_kernel(void)

Minor nit: can we please keep asmlinkage first, e.g.

asmlinkage notrace void secondary_start_kernel(void)

Either way:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

>  {
>  	u64 mpidr = read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
>  	struct mm_struct *mm = &init_mm;
> -- 
> 1.9.1
> 
