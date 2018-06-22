Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FF6C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C80BA244E9
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:35:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C80BA244E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934116AbeFVPf0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 11:35:26 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42037 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933803AbeFVPfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 11:35:25 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fWO5m-0007g6-Vp; Fri, 22 Jun 2018 17:35:19 +0200
Date:   Fri, 22 Jun 2018 17:35:18 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
cc:     Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH REBASED RESEND] x86/cpu: Move early cpu initialization
 into a separate translation unit
In-Reply-To: <20180622151446.lqqmk6nkzzkb6lew@black.fi.intel.com>
Message-ID: <alpine.DEB.2.21.1806221720500.2402@nanos.tec.linutronix.de>
References: <20180612103657.18041-1-kirill.shutemov@linux.intel.com> <alpine.DEB.2.21.1806221603150.2402@nanos.tec.linutronix.de> <20180622151446.lqqmk6nkzzkb6lew@black.fi.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2018, Kirill A. Shutemov wrote:
> On Fri, Jun 22, 2018 at 02:05:47PM +0000, Thomas Gleixner wrote:
> > On Tue, 12 Jun 2018, Kirill A. Shutemov wrote:
> > 
> > > __pgtable_l5_enabled shouldn't be needed after system has booted, we can
> > > mark it as __initdata, but it requires preparation.
> > > 
> > > This patch moves early cpu initialization into a separate translation
> > > unit. This limits effect of USE_EARLY_PGTABLE_L5 to less code.
> > > 
> > > Without the change cpu_init() uses __pgtable_l5_enabled. cpu_init() is
> > > not __init function and it leads to section mismatch.
> > > 
> > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> > 
> > Second thoughts.
> > 
> > The only place where __pgtable_l5_enabled() is used in common.c is in
> > early_identify_cpu() which is marked __init. So how is that section
> > mismatch triggered?
> 
> Yeah, it's not obvious:
> 
> cpu_init()
>   load_mm_ldt()
>     ldt_slot_va()
>       LDT_BASE_ADDR
>         LDT_PGD_ENTRY
> 	  pgtable_l5_enabled()

How is that supposed to work correctly?

start_kernel()
  ....
  trap_init()
    cpu_init()

  ....
  check_bugs()
    alternative_instructions()

So the first invocation of cpu_init() on the boot CPU will then use
static_cpu_has() which is not yet initialized proper.

So, no. That does not work and the proper fix is:

-unsigned int __pgtable_l5_enabled __initdata;
+unsigned int __pgtable_l5_enabled __ro_after_init;

and make cpu/common.c use the early variant. The extra 4 bytes storage are
not a problem and cpu_init() is not a fast path at all.

Thanks,

	tglx
