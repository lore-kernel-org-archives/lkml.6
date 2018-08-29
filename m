Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028CEC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A348820658
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="arl7oGcf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A348820658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbeH3Beh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 21:34:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:38894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726592AbeH3Beh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 21:34:37 -0400
Received: from [10.231.3.186] (unknown [72.28.92.218])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6BA8205F4;
        Wed, 29 Aug 2018 21:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535578548;
        bh=rgG8GEhhR4NwLbsAZHKaqMPAlDqCgy/HK52diEG25aA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=arl7oGcf1LAkXkPX1n+H4crJk/Rhnid76edRGwDchXagNrjPOTvS1PMqWl+v0cEkP
         eo3MmP1zs1oaGwyupfyv/MYg+clksu16Fe+zTCjgKA5/2jWbgCtA94gJFCgLCtYIeR
         X50LFaMv0ioolsKC3OxRd+AxxVLk98ff43nBKdfI=
Date:   Wed, 29 Aug 2018 14:35:48 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-X260
To:     Julien Thierry <julien.thierry@arm.com>
cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        daniel.thompson@linaro.org, joel@joelfernandes.org,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH v5 07/27] arm64: xen: Use existing helper to check
 interrupt status
In-Reply-To: <1535471497-38854-8-git-send-email-julien.thierry@arm.com>
Message-ID: <alpine.DEB.2.10.1808291132570.14449@sstabellini-ThinkPad-X260>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com> <1535471497-38854-8-git-send-email-julien.thierry@arm.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018, Julien Thierry wrote:
> The status of interrupts might depend on more than just pstate. Use
> interrupts_disabled() instead of raw_irqs_disabled_flags() to take the full
> context into account.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Acked-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  arch/arm64/include/asm/xen/events.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/xen/events.h b/arch/arm64/include/asm/xen/events.h
> index 4e22b7a..2788e95 100644
> --- a/arch/arm64/include/asm/xen/events.h
> +++ b/arch/arm64/include/asm/xen/events.h
> @@ -14,7 +14,7 @@ enum ipi_vector {
>  
>  static inline int xen_irqs_disabled(struct pt_regs *regs)
>  {
> -	return raw_irqs_disabled_flags((unsigned long) regs->pstate);
> +	return !interrupts_enabled(regs);
>  }
>  
>  #define xchg_xen_ulong(ptr, val) xchg((ptr), (val))
> -- 
> 1.9.1
> 
