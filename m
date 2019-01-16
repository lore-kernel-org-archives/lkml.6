Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CABDC43612
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE232086D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I2zD+5ks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393102AbfAPNSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:18:32 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41008 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390305AbfAPNSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 08:18:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TFMZXUk04LJbPVJ8+B2CZscWp1ifUJnxVz23qGGpFbA=; b=I2zD+5ksmYd5Z1B59LQzdRZIU
        8RZuDY8lGqTOQ7ZdxesV+qbF/T6KEicwmUHQoPlRTzKBW5i7ChfneUiy/FFSHEUyeOIpIUWySboeY
        vGIABq14TJJrBCmuL0EQ1yHn+LVr0sI/O04la+JHNx2nDBgrgixf4sMgecWVX00lmQpLwABY31gdu
        VCEHpx6j7AqOMZyqbBp8BUxpvE+ulXT7mylY6unqCu07AA9OGxK0/KA1063tpTP80tN5ZsGewTqI4
        RyfElS1m2X7UlA9mtFcAca9O5dg2+ZcI36J6dECAUCcBpQ42REUDbzHd/3EnL/a0KKQ4Z6hUxPUnl
        hC9qKJsRg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gjl5P-0006Vx-9a; Wed, 16 Jan 2019 13:18:27 +0000
Date:   Wed, 16 Jan 2019 05:18:27 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-riscv@lists.infradead.org,
        linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, mpe@ellerman.id.au, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com,
        peterz@infradead.org, christoffer.dall@arm.com,
        marc.zyngier@arm.com, kirill@shutemov.name,
        rppt@linux.vnet.ibm.com, ard.biesheuvel@linaro.org,
        mark.rutland@arm.com, steve.capper@arm.com, james.morse@arm.com,
        robin.murphy@arm.com, aneesh.kumar@linux.ibm.com, vbabka@suse.cz,
        shakeelb@google.com, rientjes@google.com, palmer@sifive.com,
        greentime@andestech.com
Subject: Re: [PATCH V2] mm: Introduce GFP_PGTABLE
Message-ID: <20190116131827.GH6310@bombadil.infradead.org>
References: <1547619692-7946-1-git-send-email-anshuman.khandual@arm.com>
 <20190116065703.GE24149@dhcp22.suse.cz>
 <20190116123018.GF6310@bombadil.infradead.org>
 <07d6a264-dccd-78ab-e8a9-2410bbef7b97@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07d6a264-dccd-78ab-e8a9-2410bbef7b97@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 06:42:22PM +0530, Anshuman Khandual wrote:
> On 01/16/2019 06:00 PM, Matthew Wilcox wrote:
> > On Wed, Jan 16, 2019 at 07:57:03AM +0100, Michal Hocko wrote:
> >> On Wed 16-01-19 11:51:32, Anshuman Khandual wrote:
> >>> All architectures have been defining their own PGALLOC_GFP as (GFP_KERNEL |
> >>> __GFP_ZERO) and using it for allocating page table pages. This causes some
> >>> code duplication which can be easily avoided. GFP_KERNEL allocated and
> >>> cleared out pages (__GFP_ZERO) are required for page tables on any given
> >>> architecture. This creates a new generic GFP flag flag which can be used
> >>> for any page table page allocation. Does not cause any functional change.
> >>>
> >>> GFP_PGTABLE is being added into include/asm-generic/pgtable.h which is the
> >>> generic page tabe header just to prevent it's potential misuse as a general
> >>> allocation flag if included in include/linux/gfp.h.
> >>
> >> I haven't reviewed the patch yet but I am wondering whether this is
> >> really worth it without going all the way down to unify the common code
> >> and remove much more code duplication. Or is this not possible for some
> >> reason?
> > 
> > Exactly what I suggested doing in response to v1.
> > 
> > Also, the approach taken here is crazy.  x86 has a feature that no other
> > architecture has bothered to implement yet -- accounting page tables
> > to the process.  Yet instead of spreading that goodness to all other
> > architectures, Anshuman has gone to more effort to avoid doing that.
> 
> The basic objective for this patch is to create a common minimum allocation
> flag that can be used by architectures but that still allows archs to add
> on additional constraints if they see fit. This patch does not intend to
> change functionality for any arch.

I disagree with your objective.  Making more code common is a great idea,
but this patch is too unambitious.  We should be heading towards one or
two page table allocation functions instead of having every architecture do
its own thing.

So start there.  Move the x86 function into common code and convert one
other architecture to use it too.
