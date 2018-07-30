Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B58816256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CDAB20894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CDAB20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731600AbeG3Rw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:52:27 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41714 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbeG3Rw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:52:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CF7880D;
        Mon, 30 Jul 2018 09:16:45 -0700 (PDT)
Received: from armageddon.cambridge.arm.com (armageddon.emea.arm.com [10.4.13.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8EB253F5D0;
        Mon, 30 Jul 2018 09:16:44 -0700 (PDT)
Date:   Mon, 30 Jul 2018 17:16:42 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Dave Kleikamp <dave.kleikamp@oracle.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm64: kexec: machine_kexec should call
 __flush_icache_range
Message-ID: <20180730161641.6zxxy3lxp27tznck@armageddon.cambridge.arm.com>
References: <faf6c7cb-d9da-9a9c-cc0f-43c95e864ca2@oracle.com>
 <e07fc674-2a71-29ae-2212-46ee5f79593d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e07fc674-2a71-29ae-2212-46ee5f79593d@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 10:29:21AM -0500, Dave Kleikamp wrote:
> machine_kexec flushes the reboot_code_buffer from the icache
> after stopping the other cpus.
> 
> Commit 3b8c9f1cdfc5 ("arm64: IPI each CPU after invalidating the I-cache
> for kernel mappings") added an IPI call to flush_icache_range, which
> causes a hang here, so replace the call with __flush_icache_range

While machine_kexec() may be called with interrupts disabled (IIUC) and
we shouldn't IPI other CPUs, I don't understand why it hangs here. Are
there any other CPUs online at this point?

> Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/kernel/machine_kexec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index f62effc..e8c0283 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -184,7 +184,7 @@ void machine_kexec(struct kimage *kimage)
>  
>  	/* Flush the reboot_code_buffer in preparation for its execution. */
>  	__flush_dcache_area(reboot_code_buffer, arm64_relocate_new_kernel_size);
> -	flush_icache_range((uintptr_t)reboot_code_buffer,
> +	__flush_icache_range((uintptr_t)reboot_code_buffer,
>  		arm64_relocate_new_kernel_size);

That's probably needed, at least to avoid a WARN_ON(irqs_disabled()) via
smp_call_function_many().

-- 
Catalin
