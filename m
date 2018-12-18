Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AADC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14F4218A1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbeLROPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:15:18 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:56197 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbeLROPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:15:18 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gZG98-0002vn-Id; Tue, 18 Dec 2018 15:14:54 +0100
Date:   Tue, 18 Dec 2018 15:14:53 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Aubrey Li <aubrey.li@intel.com>
cc:     mingo@redhat.com, peterz@infradead.org, hpa@zytor.com,
        ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com,
        linux-kernel@vger.kernel.org, Aubrey Li <aubrey.li@linux.intel.com>
Subject: Re: [PATCH v6 1/3] x86/fpu: track AVX-512 usage of tasks
In-Reply-To: <20181218042218.8653-1-aubrey.li@intel.com>
Message-ID: <alpine.DEB.2.21.1812181448170.12686@nanos.tec.linutronix.de>
References: <20181218042218.8653-1-aubrey.li@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2018, Aubrey Li wrote:
> diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
> index a38bf5a1e37a..8778ac172255 100644
> --- a/arch/x86/include/asm/fpu/internal.h
> +++ b/arch/x86/include/asm/fpu/internal.h
> @@ -411,6 +411,13 @@ static inline int copy_fpregs_to_fpstate(struct fpu *fpu)
>  {
>  	if (likely(use_xsave())) {
>  		copy_xregs_to_kernel(&fpu->state.xsave);
> +
> +		/*
> +		 * AVX512 state is tracked here because its use is
> +		 * known to slow the max clock speed of the core.
> +		 */
> +		if (fpu->state.xsave.header.xfeatures & XFEATURE_MASK_AVX512)
> +			fpu->avx512_timestamp = jiffies_64;

Even if unlikely this is incorrect when running a 32 bit kernel because
there jiffies_64 cannot be atomically loaded vs. a concurrent update. See
the comment in include/linux/jiffies.h right above the jiffies_64
declaration.

Thanks,

	tglx

