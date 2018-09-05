Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969FAC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C68920861
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:28:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C68920861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbeIEQ6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 12:58:54 -0400
Received: from foss.arm.com ([217.140.101.70]:57350 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727808AbeIEQ6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 12:58:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A51D615B2;
        Wed,  5 Sep 2018 05:28:51 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 75E873F5BC;
        Wed,  5 Sep 2018 05:28:51 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id DCF1E1AE3546; Wed,  5 Sep 2018 13:29:05 +0100 (BST)
Date:   Wed, 5 Sep 2018 13:29:05 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Zhizhou Zhang <zhizhouzhang@asrmicro.com>
Cc:     catalin.marinas@arm.com, james.morse@arm.com,
        julien.thierry@arm.com, dave.martin@arm.com,
        suzuki.poulose@arm.com, sudeep.holla@arm.com, adobriyan@gmail.com,
        lorenzo.pieralisi@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: don't account for cpu offline time with irqsoff
 tracer
Message-ID: <20180905122905.GI20186@arm.com>
References: <1536135583-6607-1-git-send-email-zhizhouzhang@asrmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536135583-6607-1-git-send-email-zhizhouzhang@asrmicro.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 04:19:43PM +0800, Zhizhou Zhang wrote:
> This is no need to account for cpu offline time with irqsoff tracer.
> We can trigger a large irqsoff latency with below commands:
> 
> $ echo irqsoff > /sys/kernel/debug/tracing/current_tracer
> $ echo 0 > /sys/kernel/debug/tracing/options/function-trace
> $ echo 1 > /sys/kernel/debug/tracing/tracing_on
> $ echo 0 > /sys/devices/system/cpu/cpu1/online
> $ # wait a while ...
> $ echo 1 > /sys/devices/system/cpu/cpu1/online
> $ cat /sys/kernel/debug/tracing/trace
> 
> Signed-off-by: Zhizhou Zhang <zhizhouzhang@asrmicro.com>
> ---
>  arch/arm64/kernel/smp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 25fcd22..faed8f6 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -346,6 +346,7 @@ void cpu_die(void)
>  	idle_task_exit();
>  
>  	local_daif_mask();
> +	stop_critical_timings();
>  
>  	/* Tell __cpu_die() that this CPU is now safe to dispose of */
>  	(void)cpu_report_death();
> -- 
> 1.9.1

Hmm, so there are only a handful of other callers of stop_critical_timings()
which suggests that we probably shouldn't be calling this from deep in the
arch code. Do other architectures have the same problem? If not, how do they
avoid it?

Will
