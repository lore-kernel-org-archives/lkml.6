Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B24C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675E620870
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:18:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 675E620870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbeJ3DIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:08:45 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52541 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729261AbeJ3DIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:08:44 -0400
Received: from tmo-115-37.customers.d1-online.com ([80.187.115.37] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gHC7n-0000S3-Qk; Mon, 29 Oct 2018 19:18:52 +0100
Date:   Mon, 29 Oct 2018 19:18:50 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
cc:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: RE: [PATCH V2 1/2] x86/efi: Unmap EFI boot services code/data regions
 from efi_pgd
In-Reply-To: <alpine.DEB.2.21.1810291907320.5984@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1810291911570.5984@nanos.tec.linutronix.de>
References: <20181026213845.28166-1-sai.praneeth.prakhya@intel.com> <20181026213845.28166-2-sai.praneeth.prakhya@intel.com> <alpine.DEB.2.21.1810291809490.5984@nanos.tec.linutronix.de> <alpine.DEB.2.21.1810291820250.5984@nanos.tec.linutronix.de>
 <FFF73D592F13FD46B8700F0A279B802F485E5549@ORSMSX114.amr.corp.intel.com> <alpine.DEB.2.21.1810291907320.5984@nanos.tec.linutronix.de>
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

Sai,

On Mon, 29 Oct 2018, Thomas Gleixner wrote:
> On Mon, 29 Oct 2018, Prakhya, Sai Praneeth wrote:
> 
> > Hi Thomas and Peter,
> > 
> > [off the mailing list because I wasn't sure if it's a good idea to spam others with my questions]
> 
> In general it's good to do on list because others can learn from the
> answers as well.

So you somehow managed to keep everyone and the lists in CC
nevertheless. Did not pay attention to the CC list until I got my reply on
the list :)

> > > > > +	retval = __change_page_attr_set_clr(&cpa, 0);
> > > > > +	__flush_tlb_all();
> > > >
> > > > So this looks like you copied it from kernel_map_pages_in_pgd() which
> > > > has been discussed before to be not sufficient, but it can't be
> > > > changed right now due to locking issues.
> > >
> > > Managed to confuse myself. The place which cannot be changed is a different
> > > one, but still for your call site __flush_tlb_all() might not be sufficient.
> > 
> > Since the mappings are changed, I thought a flush_tlb() might be needed.
> > But, (to be honest), I don't completely understand the x86/mm code. So, could you 
> > please elaborate the issue more for my better understanding?
> > 
> > So some questions I have are,
> > 1. What did Peter Z mean here? "How is that not a TLB invalidation bug ?"
> 
> __flush_tlb_all() flushes only the mapping on the current CPU. So in a SMP
> environment it's not sufficient.
> 
> > 2. I assumed kernel_map_pages_in_pgd() to be a good code but you said that 
> > it has some locking issues. So, could you please elaborate more on that.
> 
> I corrected myself. It's the other function which cannot use the proper
> cpa_flush.*() functions.
> 
> > Or, could you please provide me some pointers in the source code that I
> > can take a look at so that I could understand the issue much better.
> 
> I'll have a second look at the whole thing and reply on list.

So actually for the problem at hand __flush_tlb_all() works, because that
is called way before the secondary CPUs are up.

Ditto for kernel_map_pages_in_pgd(). But both functions want to be marked
__init and aside of that they both should contain a warning when they are
called after the secondary CPUs have been brought up.

Thanks,

	tglx
