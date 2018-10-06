Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A5CC65C30
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 11:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA5D02087D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 11:56:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA5D02087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbeJFS7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 14:59:16 -0400
Received: from ozlabs.org ([203.11.71.1]:40779 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727491AbeJFS7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 14:59:16 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42S4pQ6HNXz9s1x;
        Sat,  6 Oct 2018 21:56:14 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-ntb@googlegroups.com, linux-crypto@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Suresh Warrier <warrier@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v22 3/6] iomap: introduce io{read|write}64_{lo_hi|hi_lo}
In-Reply-To: <20181002224108.3321-4-logang@deltatee.com>
References: <20181002224108.3321-1-logang@deltatee.com> <20181002224108.3321-4-logang@deltatee.com>
Date:   Sat, 06 Oct 2018 21:56:13 +1000
Message-ID: <877eivjnky.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Logan Gunthorpe <logang@deltatee.com> writes:

> In order to provide non-atomic functions for io{read|write}64 that will
> use readq and writeq when appropriate. We define a number of variants
> of these functions in the generic iomap that will do non-atomic
> operations on pio but atomic operations on mmio.
>
> These functions are only defined if readq and writeq are defined. If
> they are not, then the wrappers that always use non-atomic operations
> from include/linux/io-64-nonatomic*.h will be used.
>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Suresh Warrier <warrier@linux.vnet.ibm.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/include/asm/io.h |   2 +
>  include/asm-generic/iomap.h   |  22 ++++++
>  lib/iomap.c                   | 132 ++++++++++++++++++++++++++++++++++
>  3 files changed, 156 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
> index e0331e754568..20fe5d7515db 100644
> --- a/arch/powerpc/include/asm/io.h
> +++ b/arch/powerpc/include/asm/io.h
> @@ -798,8 +798,10 @@ extern void __iounmap_at(void *ea, unsigned long size);
>  
>  #define mmio_read16be(addr)		readw_be(addr)
>  #define mmio_read32be(addr)		readl_be(addr)
> +#define mmio_read64be(addr)		readq_be(addr)
>  #define mmio_write16be(val, addr)	writew_be(val, addr)
>  #define mmio_write32be(val, addr)	writel_be(val, addr)
> +#define mmio_write64be(val, addr)	writeq_be(val, addr)
>  #define mmio_insb(addr, dst, count)	readsb(addr, dst, count)
>  #define mmio_insw(addr, dst, count)	readsw(addr, dst, count)
>  #define mmio_insl(addr, dst, count)	readsl(addr, dst, count)

For the powerpc part:

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
