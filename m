Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C896FECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 06:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8469920673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 06:32:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8469920673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbeGTHSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 03:18:42 -0400
Received: from foss.arm.com ([217.140.101.70]:58428 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727156AbeGTHSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 03:18:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6848118A;
        Thu, 19 Jul 2018 23:32:02 -0700 (PDT)
Received: from salmiak (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 641683F246;
        Thu, 19 Jul 2018 23:31:59 -0700 (PDT)
Date:   Fri, 20 Jul 2018 07:31:56 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Cc:     linux-arm-kernel@lists.infradead.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, rishabhb@codeaurora.org,
        linux-kernel@vger.kernel.org, robh@kernel.org, hoeun.ryu@gmail.com,
        adobriyan@gmail.com, zhizhouzhang@asrmicro.com,
        suzuki.poulose@arm.com, james.morse@arm.com, will.deacon@arm.com,
        catalin.marinas@arm.com, Matt Wagantall <mattw@codeaurora.org>
Subject: Re: [PATCH] ARM64: smp: BUG() if smp_send_reschedule() is called for
 an offline cpu
Message-ID: <20180720063156.ico2wsqc3lr2pesa@salmiak>
References: <1532038369-5159-1-git-send-email-vnkgutta@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532038369-5159-1-git-send-email-vnkgutta@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 03:12:49PM -0700, Venkata Narendra Kumar Gutta wrote:
> Based on the 'commit <8b775be35e41b9f> ("ARM: smp:
> BUG() if smp_send_reschedule() is called for an offline cpu")'

This commit does not appear to exist in mainline. Which tree is it in?

> Sending an IPI_RESCHEDULE to an offline CPU is incorrect and potentially
> bad for both power and stability. On some sub-architectures such as MSM,
> if a power-collapsed CPU is unexpectedly woken up by an IPI, it will be
> begin executing without the preparations that would normally happen as
> part of CPU_UP_PREPARE. If clocks, voltage regulators, or other hardware
> configuration are not performed, the booting CPU may cause general
> instability or (at best) poor power performance since the CPU would be
> powered up but not utilized.
> 
> One common cause for such issues is misuse of add_timer_on() or APIs
> such as queue_work_on() which call it. If proper precautions are not
> taken to block hotplug while these APIs are called then a race may
> result in IPIs being sent to CPUs that are already offline.
> 
> This same argument could be applied to other IPIs (with the exception
> of IPI_WAKEUP), but the others are already restricted to only online
> CPUs by existing mechanisms, so an explicit assertion is not useful.
> 
> Signed-off-by: Matt Wagantall <mattw@codeaurora.org>
> Signed-off-by: Trilok Soni <tsoni@codeaurora.org>
> Signed-off-by: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
> ---
>  arch/arm64/kernel/smp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 2faa986..5e39030 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -898,6 +898,7 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
>  
>  void smp_send_reschedule(int cpu)
>  {
> +	BUG_ON(cpu_is_offline(cpu));
>  	smp_cross_call(cpumask_of(cpu), IPI_RESCHEDULE);
>  }

Is BUG_ON() appropriate?

Why not WARN_ON() and return?

AFAICT, arm doesn't have this logic today either.

Thanks,
Mark.
