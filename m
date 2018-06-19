Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC458C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEED720875
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:47:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEED720875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756814AbeFSIrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:47:45 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:56590 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756374AbeFSIrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:47:42 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fVCIU-0002WP-09; Tue, 19 Jun 2018 10:47:30 +0200
Date:   Tue, 19 Jun 2018 10:47:29 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
cc:     Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH 6/8] x86/lib_direct_store.h: Add APIs for direct
 store instructions
In-Reply-To: <1529118375-90191-7-git-send-email-fenghua.yu@intel.com>
Message-ID: <alpine.DEB.2.21.1806191041390.1692@nanos.tec.linutronix.de>
References: <1529118375-90191-1-git-send-email-fenghua.yu@intel.com> <1529118375-90191-7-git-send-email-fenghua.yu@intel.com>
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

On Fri, 15 Jun 2018, Fenghua Yu wrote:
> +static inline bool movdiri_supported(void)
> +{
> +	int eax, ebx, ecx, edx;
> +	bool ret;
> +
> +	/*
> +	 * If movdiri has been enumerated before, return cached movdiri
> +	 * support info.
> +	 */
> +	if (_movdiri_enumerated)
> +		return _movdiri_supported;
> +
> +	/* Otherwise, enumerate movdiri from CPUID. */
> +	asm volatile("mov $7, %%eax\t\n"
> +		     "mov $0, %%ecx\t\n"
> +		     "cpuid\t\n"
> +		     : "=a" (eax), "=b" (ebx), "=c" (ecx), "=d" (edx));

Why on earth do we need yet another machinery to figure out whether
something is enumerated in CPUID? We have feature bits and the whole set of
functions around it, including those which are run time patched.

Aside of that adding static booleans to every compilation unit which
includes that header file is just broken.

Thanks,

	tglx
