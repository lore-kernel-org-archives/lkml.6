Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18726C65C31
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 14:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA67A2089D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 14:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA67A2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbeJFVoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 17:44:44 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39408 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbeJFVoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 17:44:44 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g8nlF-0002rK-FN; Sat, 06 Oct 2018 16:40:53 +0200
Date:   Sat, 6 Oct 2018 16:40:53 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andi Kleen <andi@firstfloor.org>
cc:     peterz@infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, kan.liang@intel.com, isaku.yamahata@intel.com,
        kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v1 2/2] perf/x86/kvm: Avoid unnecessary work in guest
 filtering
In-Reply-To: <20181006001928.28097-2-andi@firstfloor.org>
Message-ID: <alpine.DEB.2.21.1810061632100.5454@nanos.tec.linutronix.de>
References: <20181006001928.28097-1-andi@firstfloor.org> <20181006001928.28097-2-andi@firstfloor.org>
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

On Fri, 5 Oct 2018, Andi Kleen wrote:
> Some time ago KVM added a workaround for PEBS events leaking
> into guests. This uses the KVM entry/exit list to add an extra
> disable of the PEBS_ENABLE MSR.
> 
> Intel also added a fix for this issue to microcode updates on
> Haswell/Broadwell/Skylake.
> 
> It turns out using the MSR entry/exit list makes VM exits
> significantly slower. The list is only needed for disabling
> PEBS, because the GLOBAL_CTRL change gets optimized by
> KVM into changing the VMCS.
> 
> This patch checks for the microcode updates that have the microcode

# grep "This patch" Documentation/process

> fix for leaking PEBS, and disables the extra entry/exit list
> entry for PEBS_ENABLE. In addition we always clear the
> GLOBAL_CTRL for the PEBS counter while running in the guest,
> which is enough to make them never fire at the wrong
> side of the host/guest transition.
>  
> +#define IUCODE(model, step, rev) \
> +	{ X86_VENDOR_INTEL, 6, model, step, rev, 0, 0 }

So we are going to have this kind of defines on every usage site. Please
put these macros into the corresponding header file.

Also this wants to be named INTEL_MIN_UCODE() so it's clear what this is
about.

Thanks,

	tglx
