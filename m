Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAA3C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B8F20684
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B8F20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbeJCUYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 16:24:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:35450 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726694AbeJCUYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 16:24:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 70A85AEB0;
        Wed,  3 Oct 2018 13:36:10 +0000 (UTC)
Date:   Wed, 3 Oct 2018 15:36:09 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, suzuki.poulose@arm.com,
        punit.agrawal@arm.com, will.deacon@arm.com, Steven.Price@arm.com,
        catalin.marinas@arm.com, mike.kravetz@oracle.com,
        n-horiguchi@ah.jp.nec.com
Subject: Re: [PATCH 1/4] mm/hugetlb: Enable PUD level huge page migration
Message-ID: <20181003133609.GG4714@dhcp22.suse.cz>
References: <1538482531-26883-1-git-send-email-anshuman.khandual@arm.com>
 <1538482531-26883-2-git-send-email-anshuman.khandual@arm.com>
 <20181002123909.GS18290@dhcp22.suse.cz>
 <fae68a4e-b14b-8342-940c-ea5ef3c978af@arm.com>
 <20181003065833.GD18290@dhcp22.suse.cz>
 <7f0488b5-053f-0954-9b95-8c0890ef5597@arm.com>
 <20181003105926.GA4714@dhcp22.suse.cz>
 <34b25855-fcef-61ed-312d-2011f80bdec4@arm.com>
 <20181003114842.GD4714@dhcp22.suse.cz>
 <d42cc88b-6bab-797c-f263-2dce650ea3ab@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d42cc88b-6bab-797c-f263-2dce650ea3ab@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 03-10-18 18:36:39, Anshuman Khandual wrote:
[...]
> So we have two checks here
> 
> 1) platform specific arch_hugetlb_migration -> In principle go ahead
> 
> 2) huge_movable() during allocation
> 
> 	- If huge page does not have to be placed on movable zone
> 
> 		- Allocate any where successfully and done !
>  
> 	- If huge page *should* be placed on a movable zone
> 
> 		- Try allocating on movable zone
> 
> 			- Successfull and done !
> 
> 		- If the new page could not be allocated on movable zone
> 		
> 			- Abort the migration completely
> 
> 					OR
> 
> 			- Warn and fall back to non-movable

I guess you are still making it more complicated than necessary. The
later is really only about __GFP_MOVABLE at this stage. I would just
make it simple for now. We do not have to implement any dynamic
heuristic right now. All that I am asking for is to split the migrate
possible part from movable part.

I should have been more clear about that I guess from my very first
reply. I do like how you moved the current coarse grained
hugepage_migration_supported to be more arch specific but I merely
wanted to point out that we need to do some other changes before we can
go that route and that thing is to distinguish movable from migration
supported.

See my point?
-- 
Michal Hocko
SUSE Labs
