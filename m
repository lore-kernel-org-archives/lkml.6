Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B22C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 919A82080A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfBDTvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 14:51:12 -0500
Received: from mga05.intel.com ([192.55.52.43]:26660 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbfBDTvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 14:51:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2019 11:51:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,560,1539673200"; 
   d="scan'208";a="297217646"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga005.jf.intel.com with ESMTP; 04 Feb 2019 11:51:11 -0800
Message-ID: <10fe638278abc129eff53779cffb476f4fcbbf64.camel@linux.intel.com>
Subject: Re: [RFC PATCH 4/4] mm: Add merge page notifier
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     rkrcmar@redhat.com, x86@kernel.org, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, pbonzini@redhat.com, tglx@linutronix.de,
        akpm@linux-foundation.org
Date:   Mon, 04 Feb 2019 11:51:11 -0800
In-Reply-To: <33d14370-b47d-5ceb-09c4-41f0d6b33af8@intel.com>
References: <20190204181118.12095.38300.stgit@localhost.localdomain>
         <20190204181558.12095.83484.stgit@localhost.localdomain>
         <33d14370-b47d-5ceb-09c4-41f0d6b33af8@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-02-04 at 11:40 -0800, Dave Hansen wrote:
> > +void __arch_merge_page(struct zone *zone, struct page *page,
> > +		       unsigned int order)
> > +{
> > +	/*
> > +	 * The merging logic has merged a set of buddies up to the
> > +	 * KVM_PV_UNUSED_PAGE_HINT_MIN_ORDER. Since that is the case, take
> > +	 * advantage of this moment to notify the hypervisor of the free
> > +	 * memory.
> > +	 */
> > +	if (order != KVM_PV_UNUSED_PAGE_HINT_MIN_ORDER)
> > +		return;
> > +
> > +	/*
> > +	 * Drop zone lock while processing the hypercall. This
> > +	 * should be safe as the page has not yet been added
> > +	 * to the buddy list as of yet and all the pages that
> > +	 * were merged have had their buddy/guard flags cleared
> > +	 * and their order reset to 0.
> > +	 */
> > +	spin_unlock(&zone->lock);
> > +
> > +	kvm_hypercall2(KVM_HC_UNUSED_PAGE_HINT, page_to_phys(page),
> > +		       PAGE_SIZE << order);
> > +
> > +	/* reacquire lock and resume freeing memory */
> > +	spin_lock(&zone->lock);
> > +}
> 
> Why do the lock-dropping on merge but not free?  What's the difference?

The lock has not yet been acquired in the free path. The arch_free_page
call is made from free_pages_prepare, whereas the arch_merge_page call
is made from within __free_one_page which has the requirement that the
zone lock be taken before calling the function.

> This makes me really nervous.  You at *least* want to document this at
> the arch_merge_page() call-site, and perhaps even the __free_one_page()
> call-sites because they're near where the zone lock is taken.

Okay, that makes sense. I would probably look at adding the
documentation to the arch_merge_page call-site.

> The place you are calling arch_merge_page() looks OK to me, today.  But,
> it can't get moved around without careful consideration.  That also
> needs to be documented to warn off folks who might move code around.

Agreed.

> The interaction between the free and merge hooks is also really
> implementation-specific.  If an architecture is getting order-0
> arch_free_page() notifications, it's probably worth at least documenting
> that they'll *also* get arch_merge_page() notifications.

If an architecture is getting order-0 notifications then the merge
notifications would be pointless since all the pages would be already
hinted.

I can add documentation that explains that in the case where we are
only hinting on non-zero order pages then arch_merge_page should
provide hints for when a page is merged above that threshold.

> The reason x86 doesn't double-hypercall on those is not broached in the
> descriptions.  That seems to be problematic.

I will add more documentation to address that.



