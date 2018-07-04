Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DEFC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454C821CF8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 454C821CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753236AbeGDR2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 13:28:24 -0400
Received: from mga18.intel.com ([134.134.136.126]:23283 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752158AbeGDR2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 13:28:23 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2018 10:28:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,306,1526367600"; 
   d="scan'208";a="72262493"
Received: from saamir-mobl.ger.corp.intel.com (HELO localhost) ([10.252.34.242])
  by orsmga002.jf.intel.com with ESMTP; 04 Jul 2018 10:28:15 -0700
Date:   Wed, 4 Jul 2018 20:28:14 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
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
Message-ID: <20180704172814.GH6724@linux.intel.com>
References: <20180703182118.15024-1-jarkko.sakkinen@linux.intel.com>
 <20180703182118.15024-7-jarkko.sakkinen@linux.intel.com>
 <alpine.DEB.2.21.1807032105290.1816@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1807032105290.1816@nanos.tec.linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 09:09:52PM +0200, Thomas Gleixner wrote:
> On Tue, 3 Jul 2018, Jarkko Sakkinen wrote:
> > @@ -0,0 +1,54 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> > +// Copyright(c) 2016-17 Intel Corporation.
> > +
> > +#include <asm/sgx.h>
> > +#include <asm/sgx_pr.h>
> > +#include <linux/freezer.h>
> > +#include <linux/highmem.h>
> > +#include <linux/kthread.h>
> > +#include <linux/ratelimit.h>
> > +#include <linux/sched/signal.h>
> > +#include <linux/slab.h>
> 
> The common include ordering is
> 
> include linux/....
> 
> include asm/...
> 
> > +
> > +bool sgx_enabled __ro_after_init;
> > +EXPORT_SYMBOL(sgx_enabled);
> 
> 
> > +bool sgx_lc_enabled __ro_after_init;
> > +EXPORT_SYMBOL(sgx_lc_enabled);
> > +
> > +static __init bool sgx_is_enabled(bool *lc_enabled)
> > +{
> > +	unsigned long fc;
> > +
> > +	if (!boot_cpu_has(X86_FEATURE_SGX))
> > +		return false;
> > +
> > +	if (!boot_cpu_has(X86_FEATURE_SGX1))
> > +		return false;
> > +
> > +	rdmsrl(MSR_IA32_FEATURE_CONTROL, fc);
> > +	if (!(fc & FEATURE_CONTROL_LOCKED)) {
> > +		pr_info("IA32_FEATURE_CONTROL MSR is not locked\n");
> > +		return false;
> > +	}
> > +
> > +	if (!(fc & FEATURE_CONTROL_SGX_ENABLE)) {
> > +		pr_info("disabled by the firmware\n");
> > +		return false;
> > +	}
> > +
> > +	if (!(fc & FEATURE_CONTROL_SGX_LE_WR)) {
> > +		pr_info("IA32_SGXLEPUBKEYHASHn MSRs are not writable\n");
> > +		return false;
> > +	}
> > +
> > +	*lc_enabled = !!(fc & FEATURE_CONTROL_SGX_LE_WR);
> > +	return true;
> > +}
> > +
> > +static __init int sgx_init(void)
> > +{
> > +	sgx_enabled = sgx_is_enabled(&sgx_lc_enabled);
> 
> This is horrible, really. Both variables are global. So what the heck is
> wrong with assigning them directly in the function? 

Fully agreed, does not make any sense.

> Thanks,
> 
> 	tglx

/Jarkko

