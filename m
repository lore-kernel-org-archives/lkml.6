Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754738AbeEaLB1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:01:27 -0400
Received: from foss.arm.com ([217.140.101.70]:39766 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754504AbeEaLBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:01:20 -0400
Date: Thu, 31 May 2018 12:01:15 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Dongjiu Geng <gengdongjiu@huawei.com>, james.morse@arm.com
Cc: catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, tony.luck@intel.com, bp@alien8.de,
        robert.moore@intel.com, erik.schmauss@intel.com, dave.martin@arm.com,
        ard.biesheuvel@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1 2/2] arm64: handle NOTIFY_SEI notification by the APEI
 driver
Message-ID: <20180531110115.uglmicy3nzwfoyx3@lakrids.cambridge.arm.com>
References: <1527770506-8076-1-git-send-email-gengdongjiu@huawei.com>
 <1527770506-8076-3-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527770506-8076-3-git-send-email-gengdongjiu@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 08:41:46PM +0800, Dongjiu Geng wrote:
> When kernel or KVM gets the NOTIFY_SEI notification, it firstly
> calls the APEI driver to handle this notification.
> 
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> ---
>  arch/arm64/kernel/traps.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> ---
> change since https://www.spinics.net/lists/kvm/msg168919.html
> 
> 1. Remove the handle_guest_sei() helper
> 
> 
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 8bbdc17..676e40c 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -50,6 +50,7 @@
>  #include <asm/exception.h>
>  #include <asm/system_misc.h>
>  #include <asm/sysreg.h>
> +#include <acpi/ghes.h>

Nit: please place newline before the new include, since it comes from a
different directory (and we do so in fault.c).

>  static const char *handler[]= {
>  	"Synchronous Abort",
> @@ -701,6 +702,20 @@ void __noreturn arm64_serror_panic(struct pt_regs *regs, u32 esr)
>  bool arm64_is_fatal_ras_serror(struct pt_regs *regs, unsigned int esr)
>  {
>  	u32 aet = arm64_ras_serror_get_severity(esr);
> +	int ret = -ENOENT;
> +
> +	if (IS_ENABLED(CONFIG_ACPI_APEI_SEI)) {
> +		if (interrupts_enabled(regs))
> +			nmi_enter();
> +
> +		ret = ghes_notify_sei();
> +
> +		if (interrupts_enabled(regs))
> +			nmi_exit();
> +
> +		if (!ret)
> +			return false;
> +	}

In do_serror() we already handle nmi_{enter,exit}(), so there's no need
for that here.

TBH, I don't understand why do_sea() does that conditionally today.
Unless there's some constraint I'm missing, I think it would make more
sense to do that regardless of whether the interrupted context had
interrupts enabled. James -- does that make sense to you?

If you update the prior patch with a stub for !CONFIG_ACPI_APEI_SEI, you
can simplify all of the above additions down to:

	if (!ghes_notify_sei())
		return;

... which would look a lot nicer.

Thanks,
Mark.
