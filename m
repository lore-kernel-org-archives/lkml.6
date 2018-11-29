Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32C7C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8588C20989
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8588C20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbeK3DqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:46:16 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38922 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729290AbeK3DqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:46:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CD0DA78;
        Thu, 29 Nov 2018 08:40:18 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BDA63F59C;
        Thu, 29 Nov 2018 08:40:16 -0800 (PST)
Date:   Thu, 29 Nov 2018 16:40:13 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        daniel.thompson@linaro.org, joel@joelfernandes.org,
        marc.zyngier@arm.com, christoffer.dall@arm.com,
        james.morse@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v6 06/24] arm64: ptrace: Provide definitions for PMR
 values
Message-ID: <20181129164013.qmmwhbygjkh5lwx5@lakrids.cambridge.arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
 <1542023835-21446-7-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542023835-21446-7-git-send-email-julien.thierry@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 11:56:57AM +0000, Julien Thierry wrote:
> Introduce fixed values for PMR that are going to be used to mask and
> unmask interrupts by priority. These values are chosent in such a way

Nit: s/chosent/chosen/

> that a single bit (GIC_PMR_UNMASKED_BIT) encodes the information whether
> interrupts are masked or not.

There's no GIC_PMR_UNMASKED_BIT in this patch. Should that be
GIC_PRIO_STATUS_BIT?

> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/ptrace.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
> index fce22c4..ce6998c 100644
> --- a/arch/arm64/include/asm/ptrace.h
> +++ b/arch/arm64/include/asm/ptrace.h
> @@ -25,6 +25,12 @@
>  #define CurrentEL_EL1		(1 << 2)
>  #define CurrentEL_EL2		(2 << 2)
>  
> +/* PMR values used to mask/unmask interrupts */
> +#define GIC_PRIO_IRQON		0xf0
> +#define GIC_PRIO_STATUS_SHIFT	6
> +#define GIC_PRIO_STATUS_BIT	(1 << GIC_PRIO_STATUS_SHIFT)
> +#define GIC_PRIO_IRQOFF		(GIC_PRIO_IRQON ^ GIC_PRIO_STATUS_BIT)

Could you elaborate on the GIC priority logic a bit?

Are lower numbers higher priority?

Are there restrictions on valid PMR values?

IIUC GIC_PRIO_IRQOFF is 0xb0 (aka 0b10110000), which seems a little
surprising. I'd have expected that we'd use the most signficant bit.


Thanks,
Mark.
