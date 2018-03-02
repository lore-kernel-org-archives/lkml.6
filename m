Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426539AbeCBKo1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 05:44:27 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:53624 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423977AbeCBKoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 05:44:22 -0500
Date: Fri, 2 Mar 2018 11:44:18 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Ivan Gorinov <ivan.gorinov@intel.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v3 2/3] x86: devicetree: enable multiprocessing in DT
In-Reply-To: <20180301230640.GA48521@intel.com>
Message-ID: <alpine.DEB.2.21.1803021103070.1803@nanos.tec.linutronix.de>
References: <20180301230640.GA48521@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Mar 2018, Ivan Gorinov wrote:

The patch order is wrong. Fixes first and then features simply because you
cannot test the feature patch standalone as the fix (3/3) is missing ....

> Adding code to register the processors described in Device Tree.

'Adding code...' is a pointless filler phrase. 

> APIC ID is specified in 'intel-apic_id' propery as used in U-Boot.

s/propery/property/

Also this has nothing to do with U-Boot. The DT properties are described in
the DT bindings and not specified in U-Boot.

Where is the matching devicetree binding documented? This should be a
separate patch and needs to go into Documentation/devicetree/x86/

Please Cc the DT maintainers as we need their ack for that.

> First address specified in 'reg' is used as default APIC ID.

Changelogs should describe the context/problem and the approach how this is
fixed or made working. Something like this:

  The current x86 device tree implementation does not support SMP.

  Use the new DT bindings for describing CPUs and their APIC resources.

Hmm?

> Signed-off-by: Ivan Gorinov <ivan.gorinov@intel.com>
> ---
>  arch/x86/kernel/devicetree.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
> index 44189ee..ef1cd85 100644
> --- a/arch/x86/kernel/devicetree.c
> +++ b/arch/x86/kernel/devicetree.c
> @@ -130,6 +130,29 @@ static void __init dtb_setup_hpet(void)
>  #endif
>  }
>  
> +static void __init dtb_cpu_setup(void)
> +{
> +	struct device_node *dn;
> +	struct resource r;
> +	const void *prop;
> +	int apic_id, version;
> +	int ret;
> +
> +	version = GET_APIC_VERSION(apic_read(APIC_LVR));
> +	for_each_node_by_type(dn, "cpu") {
> +		prop = of_get_property(dn, "intel,apic-id", NULL);
> +		if (prop) {
> +			apic_id = be32_to_cpup(prop);
> +		} else {
> +			ret = of_address_to_resource(dn, 0, &r);
> +			if (WARN_ON_ONCE(ret))
> +				continue;
> +			apic_id = r.start;
> +		}

What kind of logic is this? If a CPU node does not have apic id property
then it's invalid. That else clause is just voodoo programming at least
without a proper comment explaining it.

Thanks,

	tglx
