Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551A1C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D642089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23D642089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbeJCSgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 14:36:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:48324 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726936AbeJCSgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 14:36:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 13332B08D;
        Wed,  3 Oct 2018 11:48:45 +0000 (UTC)
Date:   Wed, 3 Oct 2018 13:48:42 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, suzuki.poulose@arm.com,
        punit.agrawal@arm.com, will.deacon@arm.com, Steven.Price@arm.com,
        catalin.marinas@arm.com, mike.kravetz@oracle.com,
        n-horiguchi@ah.jp.nec.com
Subject: Re: [PATCH 1/4] mm/hugetlb: Enable PUD level huge page migration
Message-ID: <20181003114842.GD4714@dhcp22.suse.cz>
References: <1538482531-26883-1-git-send-email-anshuman.khandual@arm.com>
 <1538482531-26883-2-git-send-email-anshuman.khandual@arm.com>
 <20181002123909.GS18290@dhcp22.suse.cz>
 <fae68a4e-b14b-8342-940c-ea5ef3c978af@arm.com>
 <20181003065833.GD18290@dhcp22.suse.cz>
 <7f0488b5-053f-0954-9b95-8c0890ef5597@arm.com>
 <20181003105926.GA4714@dhcp22.suse.cz>
 <34b25855-fcef-61ed-312d-2011f80bdec4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34b25855-fcef-61ed-312d-2011f80bdec4@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 03-10-18 17:07:13, Anshuman Khandual wrote:
> 
> 
> On 10/03/2018 04:29 PM, Michal Hocko wrote:
[...]
> > It is not the platform that decides. That is the whole point of the
> > distinction. It is us to say what is feasible and what we want to
> > support. Do we want to support giga pages in zone_movable? Under which
> > conditions? See my point?
> 
> So huge_movable() is going to be a generic MM function deciding on the
> feasibility for allocating a huge page of 'size' from movable zone during
> migration.

Yeah, this might be a more complex logic than just the size check. If
there is a sufficient pre-allocated pool to migrate the page off it
might be pre-reserved for future migration etc... Nothing to be done
right now of course.

> If the feasibility turns out to be negative, then migration
> process is aborted there.

You are still confusing allocation and migration here I am afraid. The
whole "feasible to migrate" is for the _allocation_ time when we decide
whether the new page should be placed in zone_movable or not.

> huge_movable() will do something like these:
> 
> - Return positive right away on smaller size huge pages
> - Measure movable allocation feasibility for bigger huge pages
> 	- Look out for free_pages in the huge page order in movable areas
> 	- if (order > (MAX_ORDER - 1))
> 		- Scan the PFN ranges in movable zone for possible allocation
> 	- etc
> 	- etc
> 
> Did I get this right ?

Well, not really. I was thinking of something like this for the
beginning
	if (!arch_hugepage_migration_supporte())
		return false;
	if (hstate_is_gigantic(h))
		return false;
	return true;

further changes might be done on top of this.
-- 
Michal Hocko
SUSE Labs
