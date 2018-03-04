Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932149AbeCDJby (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 04:31:54 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34113 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751831AbeCDJbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 04:31:51 -0500
X-Google-Smtp-Source: AG47ELsWMti73SVVAv0g6YMolIYF5rivQnMZFsW0coitwsjNEeb/t2tXXujD0LEjB9vAhOsseRTHpw==
Date: Sun, 4 Mar 2018 10:31:46 +0100
From: Ingo Molnar <mingo@kernel.org>
To: David Wang <davidwang@zhaoxin.com>
Cc: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-pm@kernel.org, linux-kernel@vger.kernel.org,
        brucechang@via-alliance.com, cooperyan@zhaoxin.com,
        qiyuanwang@zhaoxin.com, benjaminpan@viatech.com, lukelin@viacpu.com,
        timguo@zhaoxin.com, cobechen@zhaoxin.com, jiangbowang@zhaoxin.com
Subject: Re: [PATCH] Delete some unusefull operations for centaur CPU/platform
Message-ID: <20180304093146.rujp4f62fv6xotb7@gmail.com>
References: <1519963908-4359-1-git-send-email-davidwang@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519963908-4359-1-git-send-email-davidwang@zhaoxin.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* David Wang <davidwang@zhaoxin.com> wrote:

> For Centaur CPU, the ucode will make sure that each CPU core can keep cache
> coherency with each other when the CPU core entering to any C state. So the
> cache flush operations when enter C3 is not necessary and will cause large
> C3 enter/exit latency.
> And the bus master disable operation when CPU core entering C3 state is not
> needed too. Because the chipset will automatically do this operation.
> 
> Signed-off-by: David Wang <davidwang@zhaoxin.com>
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

Please clean up capitalization and spelling of the comment, and please also 
explain the ACPI-idle settings a bit better, i.e. something like:

		/*
		 * On all Centaur CPUs the kernel does not have to 
		 * execute a cache flush operation (WBINVD) when
		 * entering C3 state.
		 *
		 * On all Centaur platforms the kernel does not have to
		 * disable bus-master arbitration (ARB_DISABLE) when
		 * entering C3 state.
		 */

Also, two questions:

1)

I'm wondering about this logic in acpi_processor_power_verify_c3():

        if (pr->flags.bm_check) {
                if (!pr->flags.bm_control) {
                        if (pr->flags.has_cst != 1) {
                                /* bus mastering control is necessary */
                                ACPI_DEBUG_PRINT((ACPI_DB_INFO,
                                        "C3 support requires BM control\n"));
                                return;

So ->has_cst is set on Centaur CPUs?

2)

There's this comment in acpi_idle_enter_bm():

        /*
         * disable bus master
         * bm_check implies we need ARB_DIS
         * bm_control implies whether we can do ARB_DIS
         *
         * That leaves a case where bm_check is set and bm_control is
         * not set. In that case we cannot do much, we enter C3
         * without doing anything.
         */
        if (pr->flags.bm_control) {

It says 'bm_check == 1 implies we need ARB_DIS' - but we do the opposite in the 
Centaur case? It it me who is confused or the comment?

Thanks,

	Ingo
