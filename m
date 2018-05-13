Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751962AbeEMVzI (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 17:55:08 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51347 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750991AbeEMVzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 17:55:07 -0400
Date: Sun, 13 May 2018 23:55:00 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
cc: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/mm: Introduce 'no5lvl' kernel parameter
In-Reply-To: <20180511120859.26375-3-kirill.shutemov@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1805132339240.1582@nanos.tec.linutronix.de>
References: <20180511120859.26375-1-kirill.shutemov@linux.intel.com> <20180511120859.26375-3-kirill.shutemov@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 May 2018, Kirill A. Shutemov wrote:
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1008,6 +1008,12 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
>  	 */
>  	setup_clear_cpu_cap(X86_FEATURE_PCID);
>  #endif
> +
> +#ifdef CONFIG_X86_5LEVEL
> +	/* Clear the 5-level paging feature if user asked for 'no5lvl' */

no5lvl is only one reason why 5 level paging is not available.

> +	if (!__pgtable_l5_enabled)
> +		setup_clear_cpu_cap(X86_FEATURE_LA57);
> +#endif

And that #ifdeffery can be avoided by simply doing:

	if (IS_ENABLED(CONFIG_X86_5LEVEL) && !pgtable_l5_enabled)
		setup_clear_cpu_cap(X86_FEATURE_LA57);

Hmm?

Thanks,

	tglx
