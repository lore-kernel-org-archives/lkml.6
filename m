Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932968AbeBVPWz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 10:22:55 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43072 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932796AbeBVPWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 10:22:54 -0500
Date: Thu, 22 Feb 2018 15:22:44 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Shanker Donthineni <shankerd@codeaurora.org>
Cc: Will Deacon <will.deacon@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Philip Elcan <pelcan@codeaurora.org>
Subject: Re: [PATCH v4] arm64: Add support for new control bits CTR_EL0.DIC
 and CTR_EL0.IDC
Message-ID: <20180222152244.zozx2tlptgnnfu6b@lakrids.cambridge.arm.com>
References: <1519311090-19998-1-git-send-email-shankerd@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519311090-19998-1-git-send-email-shankerd@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 08:51:30AM -0600, Shanker Donthineni wrote:
> +#define CTR_B31_SHIFT		31

Since this is just a RES1 bit, I think we don't need a mnemonic for it,
but I'll defer to Will and Catalin on that.

>  ENTRY(invalidate_icache_range)
> +#ifdef CONFIG_ARM64_SKIP_CACHE_POU
> +alternative_if ARM64_HAS_CACHE_DIC
> +	mov	x0, xzr
> +	dsb	ishst
> +	isb
> +	ret
> +alternative_else_nop_endif
> +#endif

As commented on v3, I don't believe you need the DSB here. If prior
stores haven't been completed at this point, the existing implementation
would not work correctly here.

Otherwise, this looks ok to me.

Thanks,
Mark.
