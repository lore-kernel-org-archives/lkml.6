Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932680AbeCMLDe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 07:03:34 -0400
Received: from foss.arm.com ([217.140.101.70]:35706 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752315AbeCMLDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 07:03:33 -0400
Date: Tue, 13 Mar 2018 11:03:29 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Ivan Gorinov <ivan.gorinov@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v5 2/2] x86/devicetree: Use CPU description from Device
 Tree
Message-ID: <20180313110329.rqwqdakuhd6fktlx@lakrids.cambridge.arm.com>
References: <cover.1520891263.git.ivan.gorinov@intel.com>
 <789dcb8b2c87d1e370dc68b7058ee4fe0e877b9d.1520891263.git.ivan.gorinov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <789dcb8b2c87d1e370dc68b7058ee4fe0e877b9d.1520891263.git.ivan.gorinov@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 03:22:33PM -0700, Ivan Gorinov wrote:
> Current x86 Device Tree implementation does not support multiprocessing.
> Use new DT bindings to describe the processors.
> 
> Signed-off-by: Ivan Gorinov <ivan.gorinov@intel.com>
> ---
>  arch/x86/kernel/devicetree.c | 42 +++++++++++++++++++++++++++++++-----------
>  1 file changed, 31 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
> index 5cd387f..64671db 100644
> --- a/arch/x86/kernel/devicetree.c
> +++ b/arch/x86/kernel/devicetree.c
> @@ -131,31 +131,49 @@ static void __init dtb_setup_hpet(void)
>  #endif
>  }
>  
> +static void __init dtb_cpu_setup(void)
> +{
> +	struct device_node *dn;
> +	const void *prop;
> +	int prop_bytes;
> +	int apic_id, version;
> +	int ret;
> +
> +	version = GET_APIC_VERSION(apic_read(APIC_LVR));
> +	for_each_node_by_type(dn, "cpu") {
> +		prop = of_get_property(dn, "reg", &prop_bytes);
> +		if (!prop || prop_bytes < sizeof(u32)) {
> +			pr_warn("%pOF: missing local APIC ID\n", dn);
> +			continue;
> +		}
> +		apic_id = be32_to_cpup(prop);

Please use of_property_read_u32().

Thanks,
Mark.
