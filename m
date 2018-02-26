Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752779AbeBZLwI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 06:52:08 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49082 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752373AbeBZLwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 06:52:03 -0500
Date: Mon, 26 Feb 2018 11:51:58 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        graeme.gregory@linaro.org, jason@lakedaemon.net,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [RFC PATCH] irqchip/gic-v3-its: apply ACPI device based quirks
Message-ID: <20180226115158.GC19841@e107981-ln.cambridge.arm.com>
References: <20180213141118.3092-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213141118.3092-1-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 02:11:18PM +0000, Ard Biesheuvel wrote:
> Reapply the SynQuacer quirk for ITS frames that are matched by 'SCX0005'
> based ACPI devices, replacing the dummy fwnode with the one populated by
> the ACPI device core.
> 
> This allows the SynQuacer ACPI tables to publish a device node such
> as
> 
>     Device (ITS0) {
>       Name (_HID, "SCX0005")
>       Name (_ADR, 0x30020000)

You can't have both _HID and _ADR (ACPI 6.2 - 6.1 - page 321) and
I do not think _ADR is the correct binding to solve this problem either
(_ADR can only be used for enumerable busses).

>       Name (_DSD, Package ()  // _DSD: Device-Specific Data
>       {
>         ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>         Package () {
>           Package (2) {
>             "socionext,synquacer-pre-its",
>             Package () { 0x58000000, 0x200000 }
>           },
>         }
>       })
>     }
> 
> which will trigger the existing quirk that replaces the doorbell
> address with the appropriate address in the pre-ITS frame.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> Marc, Lorenzo,
> 
> I am aware that this patch may be seen as controversial, but I would like to
> propose it nonetheless. The reason is that this is the only thing standing in
> the way of full ACPI support in Socionext SynQuacer based platforms.

I question whether these platforms should have upstream and long-term
ACPI support(dependency) - that's where the controversy is (aka if you
allow one quirk you allow them all), I do not want to add a dependency
to the ITS ACPI support for a platform that may well/is likely to be
short-lived.

> The pre-ITS is a monstrosity, but as it turns out, Socionext had help from
> ARM designing it, and the reason we need DT/ACPI based quirks in the first
> place is that the IIDR of this GICv3 implementation is simply the ARM Ltd.
> one (as they designed the IP)
> 
> Please take this into consideration when reviewing this patch,
> 
> Thanks,
> Ard.
> 
>  drivers/irqchip/irq-gic-v3-its.c | 39 ++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 06f025fd5726..a63973baf08a 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -3517,3 +3517,42 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
>  
>  	return 0;
>  }
> +
> +#if defined(CONFIG_SOCIONEXT_SYNQUACER_PREITS) && defined(CONFIG_ACPI)
> +static acpi_status __init acpi_its_device_probe (acpi_handle handle,
> +						 u32 depth, void *context,
> +						 void **ret)
> +{
> +	struct acpi_device *adev;
> +	unsigned long long phys_base;
> +	struct its_node *its;
> +	acpi_status status;
> +	int err;
> +
> +	err = acpi_bus_get_device(handle, &adev);
> +	if (err)
> +		return AE_CTRL_TERMINATE;
> +
> +	status = acpi_evaluate_integer(handle, "_ADR", NULL, &phys_base);
> +	if (ACPI_FAILURE(status))
> +		return status;

I do not think using _ADR is correct here, the phys_base should be
described as a _CRS (or you avoided using _CRS for resources
conflicts ? Still, I do not think that using _ADR is right).

> +	list_for_each_entry(its, &its_nodes, entry)
> +		if (its->phys_base == phys_base) {
> +			irq_domain_free_fwnode(its->fwnode_handle);
> +			its->fwnode_handle = &adev->fwnode;
> +			its_enable_quirk_socionext_synquacer(its);
> +			break;
> +		}

I think this is wrong. Why do you need to replace the fwnode at all
(and how does this work with IORT ?) ?

I understand you want to have a uniform DT/ACPI quirk handling (and stash
the fwnode so that you can read a _DSD out of it with the fwnode_ API)
but still, that does not justify swapping the IRQ domain fwnode handle.

> +
> +	return AE_CTRL_TERMINATE;
> +}
> +
> +static int __init acpi_its_device_probe_init(void)
> +{
> +	if (!acpi_disabled)
> +		acpi_get_devices("SCX0005", acpi_its_device_probe, NULL, NULL);
> +	return 0;
> +}
> +subsys_initcall_sync(acpi_its_device_probe_init);

That's a subsys_initcall_sync just because you need the interpreter up and
running right ?

Thanks,
Lorenzo
