Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80245C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5653920821
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfBDXhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 18:37:35 -0500
Received: from mga18.intel.com ([134.134.136.126]:36473 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbfBDXhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 18:37:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2019 15:37:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,560,1539673200"; 
   d="scan'208";a="123953782"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga003.jf.intel.com with ESMTP; 04 Feb 2019 15:37:33 -0800
Message-ID: <c24dc2351f3dc2f0e0bdf552c6504851e6fa6c06.camel@linux.intel.com>
Subject: Re: [RFC PATCH 3/4] kvm: Add guest side support for free memory
 hints
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     Nadav Amit <nadav.amit@gmail.com>,
        Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Radim Krcmar <rkrcmar@redhat.com>, X86 ML <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de, hpa@zytor.com,
        pbonzini@redhat.com, tglx@linutronix.de, akpm@linux-foundation.org
Date:   Mon, 04 Feb 2019 15:37:33 -0800
In-Reply-To: <4E64E8CA-6741-47DF-87DE-88D01B01B15D@gmail.com>
References: <20190204181118.12095.38300.stgit@localhost.localdomain>
         <20190204181552.12095.46287.stgit@localhost.localdomain>
         <4E64E8CA-6741-47DF-87DE-88D01B01B15D@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-02-04 at 15:00 -0800, Nadav Amit wrote:
> > On Feb 4, 2019, at 10:15 AM, Alexander Duyck <alexander.duyck@gmail.com> wrote:
> > 
> > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > 
> > Add guest support for providing free memory hints to the KVM hypervisor for
> > freed pages huge TLB size or larger. I am restricting the size to
> > huge TLB order and larger because the hypercalls are too expensive to be
> > performing one per 4K page. Using the huge TLB order became the obvious
> > choice for the order to use as it allows us to avoid fragmentation of higher
> > order memory on the host.
> > 
> > I have limited the functionality so that it doesn't work when page
> > poisoning is enabled. I did this because a write to the page after doing an
> > MADV_DONTNEED would effectively negate the hint, so it would be wasting
> > cycles to do so.
> > 
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > ---
> > arch/x86/include/asm/page.h |   13 +++++++++++++
> > arch/x86/kernel/kvm.c       |   23 +++++++++++++++++++++++
> > 2 files changed, 36 insertions(+)
> > 
> > diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
> > index 7555b48803a8..4487ad7a3385 100644
> > --- a/arch/x86/include/asm/page.h
> > +++ b/arch/x86/include/asm/page.h
> > @@ -18,6 +18,19 @@
> > 
> > struct page;
> > 
> > +#ifdef CONFIG_KVM_GUEST
> > +#include <linux/jump_label.h>
> > +extern struct static_key_false pv_free_page_hint_enabled;
> > +
> > +#define HAVE_ARCH_FREE_PAGE
> > +void __arch_free_page(struct page *page, unsigned int order);
> > +static inline void arch_free_page(struct page *page, unsigned int order)
> > +{
> > +	if (static_branch_unlikely(&pv_free_page_hint_enabled))
> > +		__arch_free_page(page, order);
> > +}
> > +#endif
> 
> This patch and the following one assume that only KVM should be able to hook
> to these events. I do not think it is appropriate for __arch_free_page() to
> effectively mean “kvm_guest_free_page()”.
> 
> Is it possible to use the paravirt infrastructure for this feature,
> similarly to other PV features? It is not the best infrastructure, but at least
> it is hypervisor-neutral.

I could probably tie this into the paravirt infrastructure, but if I
did so I would probably want to pull the checks for the page order out
of the KVM specific bits and make it something we handle in the inline.
Doing that I would probably make it a paravirtual hint that only
operates at the PMD level. That way we wouldn't incur the cost of the
paravirt infrastructure at the per 4K page level.

