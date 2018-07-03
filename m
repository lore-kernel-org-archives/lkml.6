Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0783C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E47124972
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:10:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E47124972
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934606AbeGCTKE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 15:10:04 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45244 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932698AbeGCTKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:10:03 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1faQgT-0001Ep-2g; Tue, 03 Jul 2018 21:09:53 +0200
Date:   Tue, 3 Jul 2018 21:09:52 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com,
        linux-sgx@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Vikas Shivappa <vikas.shivappa@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 06/13] x86/sgx: detect Intel SGX
In-Reply-To: <20180703182118.15024-7-jarkko.sakkinen@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1807032105290.1816@nanos.tec.linutronix.de>
References: <20180703182118.15024-1-jarkko.sakkinen@linux.intel.com> <20180703182118.15024-7-jarkko.sakkinen@linux.intel.com>
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

On Tue, 3 Jul 2018, Jarkko Sakkinen wrote:
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> +// Copyright(c) 2016-17 Intel Corporation.
> +
> +#include <asm/sgx.h>
> +#include <asm/sgx_pr.h>
> +#include <linux/freezer.h>
> +#include <linux/highmem.h>
> +#include <linux/kthread.h>
> +#include <linux/ratelimit.h>
> +#include <linux/sched/signal.h>
> +#include <linux/slab.h>

The common include ordering is

include linux/....

include asm/...

> +
> +bool sgx_enabled __ro_after_init;
> +EXPORT_SYMBOL(sgx_enabled);


> +bool sgx_lc_enabled __ro_after_init;
> +EXPORT_SYMBOL(sgx_lc_enabled);
> +
> +static __init bool sgx_is_enabled(bool *lc_enabled)
> +{
> +	unsigned long fc;
> +
> +	if (!boot_cpu_has(X86_FEATURE_SGX))
> +		return false;
> +
> +	if (!boot_cpu_has(X86_FEATURE_SGX1))
> +		return false;
> +
> +	rdmsrl(MSR_IA32_FEATURE_CONTROL, fc);
> +	if (!(fc & FEATURE_CONTROL_LOCKED)) {
> +		pr_info("IA32_FEATURE_CONTROL MSR is not locked\n");
> +		return false;
> +	}
> +
> +	if (!(fc & FEATURE_CONTROL_SGX_ENABLE)) {
> +		pr_info("disabled by the firmware\n");
> +		return false;
> +	}
> +
> +	if (!(fc & FEATURE_CONTROL_SGX_LE_WR)) {
> +		pr_info("IA32_SGXLEPUBKEYHASHn MSRs are not writable\n");
> +		return false;
> +	}
> +
> +	*lc_enabled = !!(fc & FEATURE_CONTROL_SGX_LE_WR);
> +	return true;
> +}
> +
> +static __init int sgx_init(void)
> +{
> +	sgx_enabled = sgx_is_enabled(&sgx_lc_enabled);

This is horrible, really. Both variables are global. So what the heck is
wrong with assigning them directly in the function? 

Thanks,

	tglx
