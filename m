Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA766C6778B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EAB025098
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:36:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EAB025098
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967069AbeF2QgC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 12:36:02 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59438 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967006AbeF2QgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 12:36:01 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fYwN2-0002nk-E9; Fri, 29 Jun 2018 18:35:40 +0200
Date:   Fri, 29 Jun 2018 18:35:39 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dave Hansen <dave.hansen@intel.com>
cc:     Fenghua Yu <fenghua.yu@intel.com>, Ingo Molnar <mingo@redhat.com>,
        H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v2 2/4] x86/split_lock: Align x86_capability to unsigned
 long to avoid split locked access
In-Reply-To: <ae0b8cb1-a8a9-f0ef-3c20-f4fe4b9b6f4a@intel.com>
Message-ID: <alpine.DEB.2.21.1806291824010.1595@nanos.tec.linutronix.de>
References: <1530282807-66555-1-git-send-email-fenghua.yu@intel.com> <1530282807-66555-3-git-send-email-fenghua.yu@intel.com> <ae0b8cb1-a8a9-f0ef-3c20-f4fe4b9b6f4a@intel.com>
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

On Fri, 29 Jun 2018, Dave Hansen wrote:

> On 06/29/2018 07:33 AM, Fenghua Yu wrote:
> > --- a/arch/x86/include/asm/processor.h
> > +++ b/arch/x86/include/asm/processor.h
> > @@ -105,7 +105,8 @@ struct cpuinfo_x86 {
> >  	__u32			extended_cpuid_level;
> >  	/* Maximum supported CPUID level, -1=no CPUID: */
> >  	int			cpuid_level;
> > -	__u32			x86_capability[NCAPINTS + NBUGINTS];
> > +	__u32			x86_capability[NCAPINTS + NBUGINTS]
> > +				__aligned(sizeof(unsigned long));
> >  	char			x86_vendor_id[16];
> >  	char			x86_model_id[64];
> >  	/* in KB - valid for CPUS which support this call: */
> 
> This is begging for comments.

Right and this patch wants to be the first in the series as it fixes an
existing issue and can be picked up independently of the rest.

Plus what enforces proper alignment for the other capability related
u32 arrays? 

Thanks,

	tglx
