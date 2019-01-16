Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC59C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F2020657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547642682;
	bh=POdIZ2yOuysxpHyx96Jdas1VKPgBc4oYmnmFiLg4HfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DQAMlbGE2rvfEN1mAVSdny9QLB8qm6HM+Fz0dK7QYTsgiMuYAp+O6BfUdmq76br/q
	 G3qCxB4APkR7ZOjRA8M8Pn4OSFXb00oshyccliRKXmpxIYSNU4KJVZaNteOUqkUHCF
	 FATnM917VervjXK6JmonC8SnFTMoqdKvBpV6DBy8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392815AbfAPMok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 07:44:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:37738 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732803AbfAPMoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 07:44:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C0897AED6;
        Wed, 16 Jan 2019 12:44:37 +0000 (UTC)
Date:   Wed, 16 Jan 2019 13:44:31 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
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
Message-ID: <20190116124431.GK24149@dhcp22.suse.cz>
References: <1547619692-7946-1-git-send-email-anshuman.khandual@arm.com>
 <20190116065703.GE24149@dhcp22.suse.cz>
 <20190116123018.GF6310@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116123018.GF6310@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 16-01-19 04:30:18, Matthew Wilcox wrote:
> On Wed, Jan 16, 2019 at 07:57:03AM +0100, Michal Hocko wrote:
> > On Wed 16-01-19 11:51:32, Anshuman Khandual wrote:
> > > All architectures have been defining their own PGALLOC_GFP as (GFP_KERNEL |
> > > __GFP_ZERO) and using it for allocating page table pages. This causes some
> > > code duplication which can be easily avoided. GFP_KERNEL allocated and
> > > cleared out pages (__GFP_ZERO) are required for page tables on any given
> > > architecture. This creates a new generic GFP flag flag which can be used
> > > for any page table page allocation. Does not cause any functional change.
> > > 
> > > GFP_PGTABLE is being added into include/asm-generic/pgtable.h which is the
> > > generic page tabe header just to prevent it's potential misuse as a general
> > > allocation flag if included in include/linux/gfp.h.
> > 
> > I haven't reviewed the patch yet but I am wondering whether this is
> > really worth it without going all the way down to unify the common code
> > and remove much more code duplication. Or is this not possible for some
> > reason?
> 
> Exactly what I suggested doing in response to v1.
> 
> Also, the approach taken here is crazy.  x86 has a feature that no other
> architecture has bothered to implement yet -- accounting page tables
> to the process.  Yet instead of spreading that goodness to all other
> architectures, Anshuman has gone to more effort to avoid doing that.

Yes, I believe the only reason this is x86 only is that each arch would
have to be tweaked separately. So a cleanup in _that_ regard would be
helpful. There is no real reason to have ptes accounted only for x86.
There might be some exceptions but well, our asm-generic allows to opt
in for generic implementation or override it with a special one. The
later should be an exception rather than the rule.
-- 
Michal Hocko
SUSE Labs
