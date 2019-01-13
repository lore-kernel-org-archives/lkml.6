Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27081C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 17:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E539A206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 17:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547400962;
	bh=6dKg1oy95i8Pu0nFMt4eJsj2WFx0lWBTVqRb5+MI6l8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UOnwk+ObI+35+cIk8xGdeDa+7ArE7/XADelqgDfG7gCd8uaoc2l37JP//A6fssXIZ
	 rJLpnrlOHzaMOIpU8WxMvDXow3x91YQBioNyJ/bXk5b9PEAsoPHfBsghulM6Z+fMuQ
	 12209en/Iy/onRd5oGjSpjbuhjXnwBsWAgjIlBvU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfAMRgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 12:36:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:53970 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726254AbfAMRgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 12:36:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8527AAD0A;
        Sun, 13 Jan 2019 17:35:58 +0000 (UTC)
Date:   Sun, 13 Jan 2019 18:35:55 +0100
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
Message-ID: <20190113173555.GC1578@dhcp22.suse.cz>
References: <1547288798-10243-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547288798-10243-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 12-01-19 15:56:38, Anshuman Khandual wrote:
> All architectures have been defining their own PGALLOC_GFP as (GFP_KERNEL |
> __GFP_ZERO) and using it for allocating page table pages. This causes some
> code duplication which can be easily avoided. GFP_KERNEL allocated and
> cleared out pages (__GFP_ZERO) are required for page tables on any given
> architecture. This creates a new generic GFP flag flag which can be used
> for any page table page allocation. Does not cause any functional change.

I agree that some unification is due but GFP_PGTABLE is not something to
expose in generic gfp.h IMHO. It just risks an abuse. I would be looking
at providing asm-generic implementation and reuse it to remove the code
duplication. But I haven't tried that to know that it will work out due
to small/subtle differences between arches.

> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
-- 
Michal Hocko
SUSE Labs
