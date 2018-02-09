Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751139AbeBIL50 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 06:57:26 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:53574 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750895AbeBIL5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 06:57:24 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: davidwang <davidwang@zhaoxin.com>
Cc: len.brown@intel.com, pavel@ucw.cz, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        brucechang@via-alliance.com, cooperyan@zhaoxin.com,
        qiyuanwang@zhaoxin.com, benjaminpan@viatech.com, lukelin@viacpu.com,
        timguo@zhaoxin.com, cobechen@zhaoxin.com, jiangbowang@zhaoxin.com,
        chiachinchu@viacpu.com
Subject: Re: [PATCH] x86/acpi/cstate: Delete some unuseful operations for centaur
Date: Fri, 09 Feb 2018 12:55:40 +0100
Message-ID: <30992269.nlskoqoYDk@aspire.rjw.lan>
In-Reply-To: <1516701471-25374-1-git-send-email-davidwang@zhaoxin.com>
References: <1516701471-25374-1-git-send-email-davidwang@zhaoxin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, January 23, 2018 10:57:51 AM CET davidwang wrote:
> For Centaur CPU, the ucode will make sure that each cpu core can keep cache
> coherency with each other when the CPU core entering to any C State. So the cache
> flush operations when enter C3 is not necessary and will cause large C3 enter/exit
> latency.
> And the bus master disable operation when CPU core entering C3 state is not needed
> too. Because the chipset will automatically do this operation. 
> Signed-off-by: davidwang <davidwang@zhaoxin.com>

I was about to apply this, but then I realized that your full name (as you
formally spell it) is needed in the Signed-off-by tag.  Can you please provide it?

> ---
>  arch/x86/kernel/acpi/cstate.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
> index dde437f..1cd357b 100644
> --- a/arch/x86/kernel/acpi/cstate.c
> +++ b/arch/x86/kernel/acpi/cstate.c
> @@ -51,6 +51,18 @@ void acpi_processor_power_init_bm_check(struct acpi_processor_flags *flags,
>  	if (c->x86_vendor == X86_VENDOR_INTEL &&
>  	    (c->x86 > 0xf || (c->x86 == 6 && c->x86_model >= 0x0f)))
>  			flags->bm_control = 0;
> +
> +        if (c->x86_vendor == X86_VENDOR_CENTAUR) {
> +		/*
> +		 * on all centaur CPUs, sw need not execute cache flush operation
> +		 * when entering C3 type State.
> +		 *
> +		 * On all Centaur platforms, sw need not execute ARB_DISABLE while
> +		 * entering C3 type state.
> +		 */
> +		flags->bm_check = 1;
> +		flags->bm_control = 0;
> +	}
>  }
>  EXPORT_SYMBOL(acpi_processor_power_init_bm_check);
>  
> 
