Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696CBC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5B021477
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5B021477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbeJBNEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 09:04:49 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58906 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbeJBNEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 09:04:48 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g7E56-0002rB-4A; Tue, 02 Oct 2018 08:22:52 +0200
Date:   Tue, 2 Oct 2018 08:22:51 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Mike Travis <mike.travis@hpe.com>
cc:     Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Hedi Berriche <hedi@sgi.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Borislav Petkov <bp@alien8.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ram Pai <linuxram@us.ibm.com>, Juergen Gross <jgross@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        Sinan Kaya <okaya@codeaurora.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Hedi Berriche <hedi.berriche@hpe.com>
Subject: Re: [PATCH 2/2] x86/tsc: Fix UV TSC initialization
In-Reply-To: <20181002012204.568382740@stormcage.americas.sgi.com>
Message-ID: <alpine.DEB.2.21.1810020820430.32062@nanos.tec.linutronix.de>
References: <20181002012204.297193336@stormcage.americas.sgi.com> <20181002012204.568382740@stormcage.americas.sgi.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Oct 2018, Mike Travis wrote:

> Fix regression introduced by
> 
> commit cf7a63ef4e02 ("x86/tsc: Calibrate tsc only once")
> 
> as it changed setup_arch() so that it now calls tsc_early_init() before
> acpi_boot_table_init() which is a necessary step, in the case of UV
> systems, to inform tsc_sanitize_first_cpu() that we're on a platform
> with async TSC resets as documented in
> 
> commit 341102c3ef29 ("x86/tsc: Add option that TSC on Socket 0 being non-zero is valid")
> 
> Fix by skipping tsc_early_init() on UV systems and let TSC initialization
> take place later in tsc_init().
> 
> Fixes: cf7a63ef4e02 ("x86/tsc: Calibrate tsc only once") 
> Signed-off-by: Mike Travis <mike.travis@hpe.com>
> Signed-off-by: Hedi Berriche <hedi.berriche@hpe.com>

See previous mail.

> Reviewed-by: Russ Anderson <rja@hpe.com>
> Reviewed-by: Dimitri Sivanich <sivanich@hpe.com>
> ---
>  arch/x86/kernel/setup.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> --- linux.orig/arch/x86/kernel/setup.c
> +++ linux/arch/x86/kernel/setup.c
> @@ -117,6 +117,7 @@
>  #include <asm/microcode.h>
>  #include <asm/kaslr.h>
>  #include <asm/unwind.h>
> +#include <asm/uv/uv.h>
>  
>  /*
>   * max_low_pfn_mapped: highest direct mapped pfn under 4GB
> @@ -1015,7 +1016,10 @@ void __init setup_arch(char **cmdline_p)
>  	 */
>  	init_hypervisor_platform();
>  
> -	tsc_early_init();
> +	/* UV TSC multi-chassis synchronization already set, don't change it */
> +	if (!is_early_uv_system())
> +		tsc_early_init();

tsc_early_init() has already a check which makes it not invoke the
calibration code, so please put your uv check into that.

Thanks,

	tglx
