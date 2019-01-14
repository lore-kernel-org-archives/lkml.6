Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBD9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 07:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E29F20660
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 07:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547449305;
	bh=WpOyRXTNI8YMiheEIG3L/ffj7kQTvirfsL6uM660SHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Xrv5ehj/JDXdm+1yKmGWWu+1l15QPBd5WXIrkXOkTKHwKAqcBBw1PVpYFe6K5YiYX
	 k/OF/IpgaR5+whKpUR0K0SaU76ZYe582l/B1HuFvi4Sm9sOtwkgGl3eja7hVu11q3s
	 uQo+NIHnSXNovP2KL42R+c9KlmApPzCpTCgmwuRs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfANHBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 02:01:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:36658 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726460AbfANHBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 02:01:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4F069AE72;
        Mon, 14 Jan 2019 07:01:41 +0000 (UTC)
Date:   Mon, 14 Jan 2019 08:01:37 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, mpe@ellerman.id.au,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        peterz@infradead.org, christoffer.dall@arm.com,
        marc.zyngier@arm.com, kirill@shutemov.name,
        rppt@linux.vnet.ibm.com, ard.biesheuvel@linaro.org,
        mark.rutland@arm.com, steve.capper@arm.com, james.morse@arm.com,
        robin.murphy@arm.com, aneesh.kumar@linux.ibm.com, vbabka@suse.cz,
        shakeelb@google.com, rientjes@google.com
Subject: Re: [PATCH] mm: Introduce GFP_PGTABLE
Message-ID: <20190114070137.GB21345@dhcp22.suse.cz>
References: <1547288798-10243-1-git-send-email-anshuman.khandual@arm.com>
 <20190113173555.GC1578@dhcp22.suse.cz>
 <f9f333a5-5533-996a-dc8e-1ff1096c1d19@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9f333a5-5533-996a-dc8e-1ff1096c1d19@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14-01-19 09:30:55, Anshuman Khandual wrote:
> 
> 
> On 01/13/2019 11:05 PM, Michal Hocko wrote:
> > On Sat 12-01-19 15:56:38, Anshuman Khandual wrote:
> >> All architectures have been defining their own PGALLOC_GFP as (GFP_KERNEL |
> >> __GFP_ZERO) and using it for allocating page table pages. This causes some
> >> code duplication which can be easily avoided. GFP_KERNEL allocated and
> >> cleared out pages (__GFP_ZERO) are required for page tables on any given
> >> architecture. This creates a new generic GFP flag flag which can be used
> >> for any page table page allocation. Does not cause any functional change.
> > 
> > I agree that some unification is due but GFP_PGTABLE is not something to
> > expose in generic gfp.h IMHO. It just risks an abuse. I would be looking
> 
> Why would you think that it risks an abuse ? It does not create new semantics
> of allocation in the buddy. Its just uses existing GFP_KERNEL allocation which
> is then getting zeroed out. The risks (if any) is exactly same as GFP_KERNEL.

Beucase my experience just tells me that people tend to use whatever
they find and name fits what they think they need.

> > at providing asm-generic implementation and reuse it to remove the code
> 
> Does that mean GFP_PGTABLE can be created but not in gfp.h but in some other
> memory related header file ?

I would just keep it close to its users. If that is a single arch
generic place then only better. But I suspect some arches have special
requirements.

> > duplication. But I haven't tried that to know that it will work out due
> > to small/subtle differences between arches.
> 
> IIUC from the allocation perspective GFP_ACCOUNT is the only thing which gets
> added with GFP_PGTABLE for user page table for memcg accounting purpose. There
> does not seem to be any other differences unless I am missing something.

It's been some time since I've checked the last time. Some arches were
using GPF_REPEAT (__GFP_RETRY_MAYFAIL) back then. I have removed most of
those but some were doing a higher order allocations so they probably
have stayed.
-- 
Michal Hocko
SUSE Labs
