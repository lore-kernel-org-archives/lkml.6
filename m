Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F69C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624FD2087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:14:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 624FD2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbeJIVby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:31:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:58296 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726393AbeJIVby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:31:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8C614AC36;
        Tue,  9 Oct 2018 14:14:43 +0000 (UTC)
Date:   Tue, 9 Oct 2018 16:14:42 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, suzuki.poulose@arm.com,
        punit.agrawal@arm.com, will.deacon@arm.com, Steven.Price@arm.com,
        catalin.marinas@arm.com, mike.kravetz@oracle.com,
        n-horiguchi@ah.jp.nec.com
Subject: Re: [PATCH 1/4] mm/hugetlb: Enable PUD level huge page migration
Message-ID: <20181009141442.GT8528@dhcp22.suse.cz>
References: <20181002123909.GS18290@dhcp22.suse.cz>
 <fae68a4e-b14b-8342-940c-ea5ef3c978af@arm.com>
 <20181003065833.GD18290@dhcp22.suse.cz>
 <7f0488b5-053f-0954-9b95-8c0890ef5597@arm.com>
 <20181003105926.GA4714@dhcp22.suse.cz>
 <34b25855-fcef-61ed-312d-2011f80bdec4@arm.com>
 <20181003114842.GD4714@dhcp22.suse.cz>
 <d42cc88b-6bab-797c-f263-2dce650ea3ab@arm.com>
 <20181003133609.GG4714@dhcp22.suse.cz>
 <5dc1dc4d-de60-43b9-aab6-3b3bb6a22a4b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dc1dc4d-de60-43b9-aab6-3b3bb6a22a4b@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 05-10-18 13:04:43, Anshuman Khandual wrote:
> Does the following sound close enough to what you are looking for ?

I do not think so

> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 9df1d59..070c419 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -504,6 +504,13 @@ static inline bool hugepage_migration_supported(struct hstate *h)
>         return arch_hugetlb_migration_supported(h);
>  }
>  
> +static inline bool hugepage_movable_required(struct hstate *h)
> +{
> +       if (hstate_is_gigantic(h))
> +               return true;
> +       return false;
> +}
> +

Apart from naming (hugepage_movable_supported?) the above doesn't do the
most essential thing to query whether the hugepage migration is
supported at all. Apart from that i would expect the logic to be revers.
We do not really support giga pages migration enough to support them in
movable zone.
> @@ -1652,6 +1655,9 @@ struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
>  {
>         gfp_t gfp_mask = htlb_alloc_mask(h);
>  
> +       if (hugepage_movable_required(h))
> +               gfp_mask |= __GFP_MOVABLE;
> +

And besides that this really want to live in htlb_alloc_mask because
this is really an allocation policy. It would be unmap_and_move_huge_page
to call hugepage_migration_supported. The later is the one to allow for
an arch specific override.

Makes sense?
-- 
Michal Hocko
SUSE Labs
