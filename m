Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4175C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72D402087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbfA2UFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 15:05:54 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:45137 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfA2UFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 15:05:54 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1goZdm-0005uX-8P; Tue, 29 Jan 2019 21:05:50 +0100
Date:   Tue, 29 Jan 2019 21:05:43 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Baoquan He <bhe@redhat.com>
cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, bp@alien8.de,
        hpa@zytor.com, kirill.shutemov@linux.intel.com, dyoung@redhat.com,
        x86@kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH RESEND 1/3] x86/boot: Add bit fields into xloadflags for
 5-level kernel checking
In-Reply-To: <20190125022817.29506-2-bhe@redhat.com>
Message-ID: <alpine.DEB.2.21.1901292059260.1950@nanos.tec.linutronix.de>
References: <20190125022817.29506-1-bhe@redhat.com> <20190125022817.29506-2-bhe@redhat.com>
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

On Fri, 25 Jan 2019, Baoquan He wrote:

> Add two bit fields XLF_5LEVEL and XLF_5LEVEL_ENABLED for 5-level kernel.

These are not bit fields. These are simple bits.

> Bit XLF_5LEVEL indicates if 5-level related code is contained
> in this kernel.
> Bit XLF_5LEVEL_ENABLED indicates if CONFIG_X86_5LEVEL=y is set.

I'm confused. 

> -			.word XLF0 | XLF1 | XLF23 | XLF4
> +#ifdef CONFIG_X86_64
> +#ifdef CONFIG_X86_5LEVEL
> +#define XLF56 (XLF_5LEVEL|XLF_5LEVEL_ENABLED)
> +#else
> +#define XLF56 XLF_5LEVEL
> +#endif
> +#else
> +#define XLF56 0
> +#endif
> +
> +			.word XLF0 | XLF1 | XLF23 | XLF4 | XLF56

So this actually stores the bits, but looking at the following patch which
fixes the real issue:

> +	if (!(header->xloadflags & XLF_5LEVEL) && pgtable_l5_enabled()) {
> +		pr_err("Can not jump to old 4-level kernel from 5-level kernel.\n");
> +		return ret;
> +	}

So what is XLF_5LEVEL_ENABLED used for and why does it exist at all?

Thanks,

	tglx

