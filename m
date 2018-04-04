Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751097AbeDDHVN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 03:21:13 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40738 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750714AbeDDHVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 03:21:12 -0400
Subject: Re: [RFC PATCH 3/4] acpi: apei: Do not panic() in NMI because of GHES
 messages
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org,
        tony.luck@intel.com, bp@alien8.de, tbaicar@codeaurora.org,
        will.deacon@arm.com, shiju.jose@huawei.com, zjzhang@codeaurora.org,
        gengdongjiu@huawei.com, linux-kernel@vger.kernel.org,
        alex_gagniuc@dellteam.com, austin_bolen@dell.com, shyam_iyer@dell.com
References: <20180403170830.29282-1-mr.nuke.me@gmail.com>
 <20180403170830.29282-4-mr.nuke.me@gmail.com>
From: James Morse <james.morse@arm.com>
Message-ID: <338e9bb4-a837-69f9-36e5-5ee2ddcaaa38@arm.com>
Date: Wed, 4 Apr 2018 08:18:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180403170830.29282-4-mr.nuke.me@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandru,

On 03/04/18 18:08, Alexandru Gagniuc wrote:
> BIOSes like to send NMIs for a number of silly reasons often deemed
> to be "fatal". For example pin bounce during a PCIE hotplug/unplug
> might cause the link to go down and retrain, with fatal PCI errors
> being generated while the link is retraining.

Sounds fun!


> Instead of panic()ing in NMI context, pass fatal errors down to IRQ
> context to see if they can be resolved.

How do we know we will survive this trip?

On arm64 systems it may not be possible to return to the context we took the NMI
notification from: we may bounce back into firmware with the same "world is on
fire" error. Firmware can rightly assume the OS has made no attempt to handle
the error. Your 'not re-arming the error' example makes this worrying.


> With these change, PCIe error are handled by AER. Other far less
> common errors, such as machine check exceptions, still cause a panic()
> in their respective handlers.

I agree AER is always going to be different. Could we take a look at the CPER
records while still in_nmi() to decide whether linux knows better than firmware?

For non-standard or processor-errors I think we should always panic() if they're
marked as fatal.
For memory-errors we could split memory_failure() up to have
{NMI,IRQ,process}-context helpers, all we need to know at NMI-time is whether
the affected memory is kernel memory.

For the PCI*/AER errors we should be able to try and handle it ... if we can get
back to process/IRQ context:
What happens if a PCIe driver has interrupts masked and is doing something to
cause this error? We can take the NMI and setup the irq-work, but it may never
run as we return to interrupts-masked context.


> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 2c998125b1d5..7243a99ea57e 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -955,7 +962,7 @@ static void __process_error(struct ghes *ghes)
>  static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
>  {
>  	struct ghes *ghes;
> -	int sev, ret = NMI_DONE;
> +	int ret = NMI_DONE;
>  
>  	if (!atomic_add_unless(&ghes_in_nmi, 1, 1))
>  		return ret;
> @@ -968,13 +975,6 @@ static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
>  			ret = NMI_HANDLED;
>  		}
>  
> -		sev = ghes_severity(ghes->estatus->error_severity);
> -		if (sev >= GHES_SEV_PANIC) {
> -			oops_begin();
> -			ghes_print_queued_estatus();
> -			__ghes_panic(ghes);
> -		}
> -
>  		if (!(ghes->flags & GHES_TO_CLEAR))
>  			continue;

For Processor-errors I think this is the wrong thing to do, but we should be
able to poke around in the CPER records and find out what we are dealing with.


Thanks,

James
