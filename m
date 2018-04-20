Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754636AbeDTK3x (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 06:29:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39700 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754540AbeDTK3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 06:29:52 -0400
Date: Fri, 20 Apr 2018 12:29:46 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kan Liang <kan.liang@linux.intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, linux-kernel@vger.kernel.org,
        eranian@google.com, osk@google.com, mark@voidzero.net,
        ak@linux.intel.com
Subject: Re: [RESEND PATCH 2/2] perf/x86/intel/uncore: Fix SBOX support for
 Broadwell CPUs
Message-ID: <20180420102946.GI4064@hirez.programming.kicks-ass.net>
References: <1521810690-2576-1-git-send-email-kan.liang@linux.intel.com>
 <1521810690-2576-2-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521810690-2576-2-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 09:11:30AM -0400, Kan Liang wrote:
> @@ -3067,7 +3069,15 @@ void bdx_uncore_cpu_init(void)
>  	/* BDX-DE doesn't have SBOX */
>  	if (boot_cpu_data.x86_model == 86)
>  		uncore_msr_uncores[BDX_MSR_UNCORE_SBOX] = NULL;
> -
> +	/* Detect systems with no SBOXes */

That really wants { }.

> +	else if (uncore_extra_pci_dev[pkg].dev[HSWEP_PCI_PCU_3]) {
> +		u32 capid4;
> +		pci_read_config_dword(
> +			uncore_extra_pci_dev[pkg].dev[HSWEP_PCI_PCU_3],
> +			0x94, &capid4);
> +		if (((capid4 >> 6) & 0x3) == 0)
> +			bdx_msr_uncores[BDX_MSR_UNCORE_SBOX] = NULL;
> +	}
>  	hswep_uncore_pcu.constraints = bdx_uncore_pcu_constraints;
>  }

Otherwise these look fine to me;

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thomas will you magic them into tip?
