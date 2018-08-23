Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A64C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 19:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 465952147A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 19:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 465952147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbeHWXHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 19:07:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:60508 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725979AbeHWXHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 19:07:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2C0F7ADA9;
        Thu, 23 Aug 2018 19:36:04 +0000 (UTC)
Date:   Thu, 23 Aug 2018 21:36:00 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm: migration: fix migration of huge PMD shared
 pages
Message-ID: <20180823193600.GV29735@dhcp22.suse.cz>
References: <20180821205902.21223-2-mike.kravetz@oracle.com>
 <201808220831.eM0je51n%fengguang.wu@intel.com>
 <975b740d-26a6-eb3f-c8ca-1a9995d0d343@oracle.com>
 <20180823124855.GI29735@dhcp22.suse.cz>
 <12ea5339-f2b1-62b4-6d37-57d737fac34a@oracle.com>
 <df05e2e0-be29-1651-40e7-82dc686919c2@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df05e2e0-be29-1651-40e7-82dc686919c2@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 23-08-18 10:56:30, Mike Kravetz wrote:
> On 08/23/2018 10:01 AM, Mike Kravetz wrote:
> > On 08/23/2018 05:48 AM, Michal Hocko wrote:
> >> On Tue 21-08-18 18:10:42, Mike Kravetz wrote:
> >> [...]
> >>
> >> OK, after burning myself when trying to be clever here it seems like
> >> your proposed solution is indeed simpler.
> >>
> >>> +bool huge_pmd_sharing_possible(struct vm_area_struct *vma,
> >>> +				unsigned long *start, unsigned long *end)
> >>> +{
> >>> +	unsigned long check_addr = *start;
> >>> +	bool ret = false;
> >>> +
> >>> +	if (!(vma->vm_flags & VM_MAYSHARE))
> >>> +		return ret;
> >>> +
> >>> +	for (check_addr = *start; check_addr < *end; check_addr += PUD_SIZE) {
> >>> +		unsigned long a_start = check_addr & PUD_MASK;
> >>> +		unsigned long a_end = a_start + PUD_SIZE;
> >>
> >> I guess this should be rather in HPAGE_SIZE * PTRS_PER_PTE units as
> >> huge_pmd_unshare does.
> > 
> > Sure, I can do that.
> 
> On second thought, this is more similar to vma_shareable() which uses
> PUD_MASK and PUD_SIZE.  In fact Kirill asked me to put in a common helper
> for this and vma_shareable.  So, I would prefer to leave it as PUD* unless
> you feel strongly.

I don't
 
> IMO, it would make more sense to change this in huge_pmd_unshare as PMD
> sharing is pretty explicitly tied to PUD_SIZE.  But, that is a future cleanup.

Fair enough. I didn't realize we are PUD explicit elsewhere. So if you
plan to update huge_pmd_unshare to be in sync then no objections from me
at all. I merely wanted to be in sync with this because it is a central
point to look at wrt pmd sharing.
-- 
Michal Hocko
SUSE Labs
