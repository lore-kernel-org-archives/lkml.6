Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30825C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC17217FA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbfBESJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 13:09:46 -0500
Received: from mga17.intel.com ([192.55.52.151]:37917 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbfBESJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 13:09:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2019 10:09:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,336,1544515200"; 
   d="scan'208";a="115478847"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga008.jf.intel.com with ESMTP; 05 Feb 2019 10:09:44 -0800
Message-ID: <b1282484e2e3cdaf22891f2b31c3c6f859dd0a52.camel@linux.intel.com>
Subject: Re: [RFC PATCH 3/4] kvm: Add guest side support for free memory
 hints
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     Nadav Amit <nadav.amit@gmail.com>,
        Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Radim Krcmar <rkrcmar@redhat.com>, X86 ML <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Anvin <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Tue, 05 Feb 2019 10:09:44 -0800
In-Reply-To: <D108194F-DEBE-43B7-BE61-7D5C52BDAAD3@gmail.com>
References: <20190204181118.12095.38300.stgit@localhost.localdomain>
         <20190204181552.12095.46287.stgit@localhost.localdomain>
         <4E64E8CA-6741-47DF-87DE-88D01B01B15D@gmail.com>
         <c24dc2351f3dc2f0e0bdf552c6504851e6fa6c06.camel@linux.intel.com>
         <4DFBB378-8E7A-4905-A94D-D56B5FF6D42B@gmail.com>
         <CAKgT0UevPXAG7xGzEur731-EJ0tOSGeg+AwugnRt6ugmfEKeLw@mail.gmail.com>
         <D108194F-DEBE-43B7-BE61-7D5C52BDAAD3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-02-04 at 17:46 -0800, Nadav Amit wrote:
> > On Feb 4, 2019, at 4:16 PM, Alexander Duyck <alexander.duyck@gmail.com> wrote:
> > 
> > On Mon, Feb 4, 2019 at 4:03 PM Nadav Amit <nadav.amit@gmail.com> wrote:
> > > > On Feb 4, 2019, at 3:37 PM, Alexander Duyck <alexander.h.duyck@linux.intel.com> wrote:
> > > > 
> > > > On Mon, 2019-02-04 at 15:00 -0800, Nadav Amit wrote:
> > > > > > On Feb 4, 2019, at 10:15 AM, Alexander Duyck <alexander.duyck@gmail.com> wrote:
> > > > > > 
> > > > > > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > > > > > 
> > > > > > Add guest support for providing free memory hints to the KVM hypervisor for
> > > > > > freed pages huge TLB size or larger. I am restricting the size to
> > > > > > huge TLB order and larger because the hypercalls are too expensive to be
> > > > > > performing one per 4K page. Using the huge TLB order became the obvious
> > > > > > choice for the order to use as it allows us to avoid fragmentation of higher
> > > > > > order memory on the host.
> > > > > > 
> > > > > > I have limited the functionality so that it doesn't work when page
> > > > > > poisoning is enabled. I did this because a write to the page after doing an
> > > > > > MADV_DONTNEED would effectively negate the hint, so it would be wasting
> > > > > > cycles to do so.
> > > > > > 
> > > > > > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > > > > > ---
> > > > > > arch/x86/include/asm/page.h |   13 +++++++++++++
> > > > > > arch/x86/kernel/kvm.c       |   23 +++++++++++++++++++++++
> > > > > > 2 files changed, 36 insertions(+)
> > > > > > 
> > > > > > diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
> > > > > > index 7555b48803a8..4487ad7a3385 100644
> > > > > > --- a/arch/x86/include/asm/page.h
> > > > > > +++ b/arch/x86/include/asm/page.h
> > > > > > @@ -18,6 +18,19 @@
> > > > > > 
> > > > > > struct page;
> > > > > > 
> > > > > > +#ifdef CONFIG_KVM_GUEST
> > > > > > +#include <linux/jump_label.h>
> > > > > > +extern struct static_key_false pv_free_page_hint_enabled;
> > > > > > +
> > > > > > +#define HAVE_ARCH_FREE_PAGE
> > > > > > +void __arch_free_page(struct page *page, unsigned int order);
> > > > > > +static inline void arch_free_page(struct page *page, unsigned int order)
> > > > > > +{
> > > > > > +   if (static_branch_unlikely(&pv_free_page_hint_enabled))
> > > > > > +           __arch_free_page(page, order);
> > > > > > +}
> > > > > > +#endif
> > > > > 
> > > > > This patch and the following one assume that only KVM should be able to hook
> > > > > to these events. I do not think it is appropriate for __arch_free_page() to
> > > > > effectively mean “kvm_guest_free_page()”.
> > > > > 
> > > > > Is it possible to use the paravirt infrastructure for this feature,
> > > > > similarly to other PV features? It is not the best infrastructure, but at least
> > > > > it is hypervisor-neutral.
> > > > 
> > > > I could probably tie this into the paravirt infrastructure, but if I
> > > > did so I would probably want to pull the checks for the page order out
> > > > of the KVM specific bits and make it something we handle in the inline.
> > > > Doing that I would probably make it a paravirtual hint that only
> > > > operates at the PMD level. That way we wouldn't incur the cost of the
> > > > paravirt infrastructure at the per 4K page level.
> > > 
> > > If I understand you correctly, you “complain” that this would affect
> > > performance.
> > 
> > It wasn't so much a "complaint" as an "observation". What I was
> > getting at is that if I am going to make it a PV operation I might set
> > a hard limit on it so that it will specifically only apply to huge
> > pages and larger. By doing that I can justify performing the screening
> > based on page order in the inline path and avoid any PV infrastructure
> > overhead unless I have to incur it.
> 
> I understood. I guess my use of “double quotes” was lost in translation. ;-)

Yeah, I just figured I would restate it to make sure we were "on the
same page". ;-)

> One more point regarding [2/4] - you may want to consider using madvise_free
> instead of madvise_dontneed to avoid unnecessary EPT violations.

For now I am using MADVISE_DONTNEED because it reduces the complexity.
I have been working on a proof of concept with MADVISE_FREE, however we
then have to add some additional checks as MADVISE_FREE only works with
anonymous memory if I am not mistaken.

