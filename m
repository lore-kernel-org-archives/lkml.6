Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752793AbeBSOi0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 09:38:26 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59912 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751429AbeBSOiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 09:38:25 -0500
Date: Mon, 19 Feb 2018 14:38:21 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Shanker Donthineni <shankerd@codeaurora.org>
Cc: Will Deacon <will.deacon@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Philip Elcan <pelcan@codeaurora.org>,
        Vikram Sethi <vikrams@codeaurora.org>
Subject: Re: [PATCH] arm64: Add support for new control bits CTR_EL0.IDC and
 CTR_EL0.IDC
Message-ID: <20180219143820.5oxc2kendvq4bbtt@armageddon.cambridge.arm.com>
References: <1518829066-3558-1-git-send-email-shankerd@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518829066-3558-1-git-send-email-shankerd@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 06:57:46PM -0600, Shanker Donthineni wrote:
> Two point of unification cache maintenance operations 'DC CVAU' and
> 'IC IVAU' are optional for implementors as per ARMv8 specification.
> This patch parses the updated CTR_EL0 register definition and adds
> the required changes to skip POU operations if the hardware reports
> CTR_EL0.IDC and/or CTR_EL0.IDC.
> 
> CTR_EL0.DIC: Instruction cache invalidation requirements for
>  instruction to data coherence. The meaning of this bit[29].
>   0: Instruction cache invalidation to the point of unification
>      is required for instruction to data coherence.
>   1: Instruction cache cleaning to the point of unification is
>       not required for instruction to data coherence.
> 
> CTR_EL0.IDC: Data cache clean requirements for instruction to data
>  coherence. The meaning of this bit[28].
>   0: Data cache clean to the point of unification is required for
>      instruction to data coherence, unless CLIDR_EL1.LoC == 0b000
>      or (CLIDR_EL1.LoUIS == 0b000 && CLIDR_EL1.LoUU == 0b000).
>   1: Data cache clean to the point of unification is not required
>      for instruction to data coherence.

There is a difference between cache maintenance to PoU "is not required"
and the actual instructions being optional (i.e. undef when executed).
If your caches are transparent and DC CVAU/IC IVAU is not required,
these instructions should behave as NOPs. So, are you trying to improve
the performance of the cache maintenance routines in the kernel? If yes,
please show some (relative) numbers and a better description in the
commit log.

On the patch, I'd rather have an alternative framework entry for no VAU
cache maint required and some ret instruction at the beginning of the
cache maint function rather than jumping out of the loop somewhere
inside the cache maintenance code, penalising the CPUs that do require
it.

-- 
Catalin
