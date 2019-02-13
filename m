Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A66CC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB2321904
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550065112;
	bh=dF83jXtQHUKQonU89CxDOpKNBIf5Gxjx7E6Ig7ZqfQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ap+R3o+/sn1nFwvNP5EeYDg17TYVZ4Uzu0wxFrkw6bv4iiE84gSgLdVwIqG4gc42b
	 FvbkuKEmbtgO1CKZ8AohPPFliySKiICNxGVAlc1rHdrU94lYav3HZCXptV3toiCQGU
	 fVix8JH/gV50gguCxk6iRhAqDZUema6NzzzRP4No=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388062AbfBMNia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:38:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:43718 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726143AbfBMNi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:38:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 98D90AEBC;
        Wed, 13 Feb 2019 13:38:28 +0000 (UTC)
Date:   Wed, 13 Feb 2019 14:38:27 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        lsf-pc@lists.linux-foundation.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [LSF/MM TOPIC] Non standard size THP
Message-ID: <20190213133827.GN4525@dhcp22.suse.cz>
References: <dcb0b2cf-ba5c-e6ef-0b05-c6006227b6a9@arm.com>
 <20190212083331.dtch7xubjxlmz5tf@kshutemo-mobl1>
 <282f6d89-bcc2-2622-1205-7c43ba85c37e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <282f6d89-bcc2-2622-1205-7c43ba85c37e@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 13-02-19 18:20:03, Anshuman Khandual wrote:
> On 02/12/2019 02:03 PM, Kirill A. Shutemov wrote:
> > Honestly, I'm very skeptical about the idea. It took a lot of time to
> > stabilize THP for singe page size, equal to PMD page table, but this looks
> > like a new can of worms. :P
> 
> I understand your concern here but HW providing some more TLB sizes beyond
> standard page table level (PMD/PUD/PGD) based huge pages can help achieve
> performance improvement when the buddy is already fragmented enough not to
> provide higher order pages. PUD THP file mapping is already supported for
> DAX and PUD THP anon mapping might be supported in near future (it is not
> much challenging other than allocating HPAGE_PUD_SIZE huge page at runtime
> will be much difficult). Around PMD sizes like HPAGE_CONT_PMD_SIZE or
> HPAGE_CONT_PTE_SIZE really have better chances as future non-PMD level anon
> mapping than a PUD size anon mapping support in THP.

I do not think our page allocator is really ready to provide >PMD huge
pages. So even if we deal with all the nasty things wrt locking and page
table handling the crux becomes the allocation side. The current
CMA/contig allocator is everything but useful for THP. It can barely
handle hugetlb cases which are mostly pre-allocate based.

Besides that is there any real world usecase driving this or it is
merely "this is possible so let's just do it"?
-- 
Michal Hocko
SUSE Labs
