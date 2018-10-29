Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDE7C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166722064C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 166722064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbeJ3DZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:25:12 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52566 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728898AbeJ3DZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:25:11 -0400
Received: from tmo-115-37.customers.d1-online.com ([80.187.115.37] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gHCNP-0000mo-NM; Mon, 29 Oct 2018 19:34:59 +0100
Date:   Mon, 29 Oct 2018 19:34:58 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>
cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] x86/ioremap: tighten integer overflow checking
In-Reply-To: <20181025061633.t32bxslxj3h7jv2x@kili.mountain>
Message-ID: <alpine.DEB.2.21.1810291925470.5984@nanos.tec.linutronix.de>
References: <20181025061633.t32bxslxj3h7jv2x@kili.mountain>
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

Dan,

On Thu, 25 Oct 2018, Dan Carpenter wrote:

> The current check is a bit off in the case where "phys_addr + size"
> wraps to zero because then "last_addr" is set to ULONG_MAX which is >=
> phys_addr.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  arch/x86/mm/ioremap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index 5378d10f1d31..ee43df3ebe66 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -146,9 +146,9 @@ static void __iomem *__ioremap_caller(resource_size_t phys_addr,
>  	void __iomem *ret_addr;
>  
>  	/* Don't allow wraparound or zero size */
> -	last_addr = phys_addr + size - 1;
> -	if (!size || last_addr < phys_addr)
> +	if (!size || phys_addr + size < phys_addr)

Assume the following (resource_size_t == u32, which is the case when
CONFIG_PHYS_ADDR_T_64BIT=n):

       phys_addr = 0xFFFF0000
       size	 = 0x00010000

       sum	 = 0x00000000  which is < phys_addr

But the existing code does:

       last_addr = phys_addr + size - 1

       		 = 0xFFFFFFFF

which is correct. last_addr is the last valid address in the to be remapped
range starting @phys_addr.

Thanks,

	tglx
