Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77341C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22567204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:39:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22567204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbeH2WhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 18:37:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:55094 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727657AbeH2WhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 18:37:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 10D66AB64;
        Wed, 29 Aug 2018 18:39:08 +0000 (UTC)
Date:   Wed, 29 Aug 2018 20:39:06 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH v6 1/2] mm: migration: fix migration of huge PMD shared
 pages
Message-ID: <20180829183906.GF10223@dhcp22.suse.cz>
References: <20180823205917.16297-1-mike.kravetz@oracle.com>
 <20180823205917.16297-2-mike.kravetz@oracle.com>
 <20180824084157.GD29735@dhcp22.suse.cz>
 <6063f215-a5c8-2f0c-465a-2c515ddc952d@oracle.com>
 <20180827074645.GB21556@dhcp22.suse.cz>
 <20180827134633.GB3930@redhat.com>
 <9209043d-3240-105b-72a3-b4cd30f1b1f1@oracle.com>
 <20180829181424.GB3784@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829181424.GB3784@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 29-08-18 14:14:25, Jerome Glisse wrote:
> On Wed, Aug 29, 2018 at 10:24:44AM -0700, Mike Kravetz wrote:
[...]
> > What would be the best mmu notifier interface to use where there are no
> > start/end calls?
> > Or, is the best solution to add the start/end calls as is done in later
> > versions of the code?  If that is the suggestion, has there been any change
> > in invalidate start/end semantics that we should take into account?
> 
> start/end would be the one to add, 4.4 seems broken in respect to THP
> and mmu notification. Another solution is to fix user of mmu notifier,
> they were only a handful back then. For instance properly adjust the
> address to match first address covered by pmd or pud and passing down
> correct page size to mmu_notifier_invalidate_page() would allow to fix
> this easily.
> 
> This is ok because user of try_to_unmap_one() replace the pte/pmd/pud
> with an invalid one (either poison, migration or swap) inside the
> function. So anyone racing would synchronize on those special entry
> hence why it is fine to delay mmu_notifier_invalidate_page() to after
> dropping the page table lock.
> 
> Adding start/end might the solution with less code churn as you would
> only need to change try_to_unmap_one().

What about dependencies? 369ea8242c0fb sounds like it needs work for all
notifiers need to be updated as well.

Anyway, I am wondering why we haven't see any bugs coming from
incomplete range invalidation. How would those exhibit?
-- 
Michal Hocko
SUSE Labs
