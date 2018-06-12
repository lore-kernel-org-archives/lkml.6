Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9D564C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 09:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C9D2208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 09:27:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C9D2208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933679AbeFLJ1J (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 05:27:09 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59614 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932639AbeFLJ1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 05:27:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27B4C1435;
        Tue, 12 Jun 2018 02:27:07 -0700 (PDT)
Received: from [10.1.206.73] (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7768B3F59D;
        Tue, 12 Jun 2018 02:27:05 -0700 (PDT)
Subject: Re: [PATCH] arm64: make secondary_start_kernel() notrace
To:     Zhizhou Zhang <zhizhouzhang@asrmicro.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, james.morse@arm.com, mark.rutland@arm.com,
        julien.thierry@arm.com, hoeun.ryu@gmail.com,
        ard.biesheuvel@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1528794457-14129-1-git-send-email-zhizhouzhang@asrmicro.com>
From:   Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <c5dc3b1d-ad49-fa50-dae8-8b8d679deb5b@arm.com>
Date:   Tue, 12 Jun 2018 10:27:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1528794457-14129-1-git-send-email-zhizhouzhang@asrmicro.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/18 10:07, Zhizhou Zhang wrote:
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
>   arch/arm64/kernel/smp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index f3e2e3ae..11b0f30 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -179,7 +179,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>    * This is the secondary CPU boot entry.  We're using this CPUs
>    * idle thread stack, but a set of temporary page tables.
>    */
> -asmlinkage void secondary_start_kernel(void)
> +notrace asmlinkage void secondary_start_kernel(void)
>   {
>   	u64 mpidr = read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
>   	struct mm_struct *mm = &init_mm;
> 

Tested-by: Suzuki K Poulose <suzuki.poulose@arm.com>

I think this should go to stable releases as well.

Suzuki
