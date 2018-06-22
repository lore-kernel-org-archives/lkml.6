Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96D2C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5496240C7
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:58:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5496240C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934087AbeFVP60 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 11:58:26 -0400
Received: from mga07.intel.com ([134.134.136.100]:22693 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933853AbeFVP6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 11:58:24 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2018 08:58:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,257,1526367600"; 
   d="scan'208";a="51098420"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 22 Jun 2018 08:58:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 8FC79143; Fri, 22 Jun 2018 18:58:24 +0300 (EEST)
Date:   Fri, 22 Jun 2018 18:58:24 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH REBASED RESEND] x86/cpu: Move early cpu initialization
 into a separate translation unit
Message-ID: <20180622155824.npfinfnpidplufad@black.fi.intel.com>
References: <20180612103657.18041-1-kirill.shutemov@linux.intel.com>
 <alpine.DEB.2.21.1806221603150.2402@nanos.tec.linutronix.de>
 <20180622151446.lqqmk6nkzzkb6lew@black.fi.intel.com>
 <alpine.DEB.2.21.1806221720500.2402@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1806221720500.2402@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 03:35:18PM +0000, Thomas Gleixner wrote:
> On Fri, 22 Jun 2018, Kirill A. Shutemov wrote:
> > On Fri, Jun 22, 2018 at 02:05:47PM +0000, Thomas Gleixner wrote:
> > > On Tue, 12 Jun 2018, Kirill A. Shutemov wrote:
> > > 
> > > > __pgtable_l5_enabled shouldn't be needed after system has booted, we can
> > > > mark it as __initdata, but it requires preparation.
> > > > 
> > > > This patch moves early cpu initialization into a separate translation
> > > > unit. This limits effect of USE_EARLY_PGTABLE_L5 to less code.
> > > > 
> > > > Without the change cpu_init() uses __pgtable_l5_enabled. cpu_init() is
> > > > not __init function and it leads to section mismatch.
> > > > 
> > > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> > > 
> > > Second thoughts.
> > > 
> > > The only place where __pgtable_l5_enabled() is used in common.c is in
> > > early_identify_cpu() which is marked __init. So how is that section
> > > mismatch triggered?
> > 
> > Yeah, it's not obvious:
> > 
> > cpu_init()
> >   load_mm_ldt()
> >     ldt_slot_va()
> >       LDT_BASE_ADDR
> >         LDT_PGD_ENTRY
> > 	  pgtable_l5_enabled()
> 
> How is that supposed to work correctly?
> 
> start_kernel()
>   ....
>   trap_init()
>     cpu_init()
> 
>   ....
>   check_bugs()
>     alternative_instructions()
> 
> So the first invocation of cpu_init() on the boot CPU will then use
> static_cpu_has() which is not yet initialized proper.

Ouch.

Is there a way to catch such improper static_cpu_has() users?
Silent misbehaviour is risky.

> So, no. That does not work and the proper fix is:
> 
> -unsigned int __pgtable_l5_enabled __initdata;
> +unsigned int __pgtable_l5_enabled __ro_after_init;
> 
> and make cpu/common.c use the early variant. The extra 4 bytes storage are
> not a problem and cpu_init() is not a fast path at all.

Okay, I'll prepare the patch.

BTW, if we go this path after all, shouldn't we revert these:

  046c0dbec023 ("x86: Mark native_set_p4d() as __always_inline")
  1ea66554d3b0 ("x86/mm: Mark p4d_offset() __always_inline")

?

I can send it as part of the patchset.

-- 
 Kirill A. Shutemov
