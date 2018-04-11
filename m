Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752898AbeDKJrb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 05:47:31 -0400
Received: from mga17.intel.com ([192.55.52.151]:59557 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752238AbeDKJrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 05:47:18 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,435,1517904000";
   d="scan'208";a="33432972"
Date: Wed, 11 Apr 2018 12:47:11 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] x86/PCI: Make pci=earlydump output neat
Message-ID: <20180411094711.GH2173@lahna.fi.intel.com>
References: <20180405121159.84241-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405121159.84241-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 03:11:59PM +0300, Andy Shevchenko wrote:
> Currently the early dump of PCI configuration space looks quite unhelpful, e.g.
> 
> [    0.000000]   60:
> [    0.000000]  00
> [    0.000000]  00
> [    0.000000]  00
> [    0.000000]  00
> [    0.000000]  00
> [    0.000000]  00
> [    0.000000]  00
> [    0.000000]  00
> [    0.000000]  00
> [    0.000000]  00
> [    0.000000]  00
> [    0.000000]  00
> [    0.000000]  00
> [    0.000000]  00
> [    0.000000]  00
> [    0.000000]  00
> [    0.000000]
> 
> which makes really hard to get anything out of this. Convert the function to
> use print_hex_dump() to make output neat.
> 
> In the result we will have
> 
> [    0.000000] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> which is much, much better.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/x86/pci/early.c | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/pci/early.c b/arch/x86/pci/early.c
> index f0114007e915..53a87692d687 100644
> --- a/arch/x86/pci/early.c
> +++ b/arch/x86/pci/early.c
> @@ -59,24 +59,15 @@ int early_pci_allowed(void)
>  
>  void early_dump_pci_device(u8 bus, u8 slot, u8 func)
>  {
> +	u32 value[256 / 4];
>  	int i;
> -	int j;
> -	u32 val;
>  
> -	printk(KERN_INFO "pci 0000:%02x:%02x.%d config space:",
> -	       bus, slot, func);
> +	pr_info("pci 0000:%02x:%02x.%d config space:\n", bus, slot, func);
>  
> -	for (i = 0; i < 256; i += 4) {
> -		if (!(i & 0x0f))
> -			printk("\n  %02x:",i);
> +	for (i = 0; i < 256; i += 4)
> +		value[i/4] = read_pci_config(bus, slot, func, i);

Please be consistent with your use of whitespace: 256 / 4 vs. i/4.

Other than that looks good and certainly is an improvement,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
