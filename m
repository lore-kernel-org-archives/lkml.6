Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE67C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134BF20877
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 134BF20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731913AbeIXUcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:32:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:40864 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727494AbeIXUcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:32:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4F817AD1D;
        Mon, 24 Sep 2018 14:30:28 +0000 (UTC)
Date:   Mon, 24 Sep 2018 16:30:27 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] mm/migrate: Split only transparent huge pages when
 allocation fails
Message-ID: <20180924143027.GE18685@dhcp22.suse.cz>
References: <1537798495-4996-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537798495-4996-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 24-09-18 19:44:55, Anshuman Khandual wrote:
> When unmap_and_move[_huge_page] function fails due to lack of memory, the
> splitting should happen only for transparent huge pages not for HugeTLB
> pages. PageTransHuge() returns true for both THP and HugeTLB pages. Hence
> the conditonal check should test PagesHuge() flag to make sure that given
> pages is not a HugeTLB one.

Well spotted! Have you actually seen this happening or this is review
driven? I am wondering what would be the real effect of this mismatch?
I have tried to follow to code path but I suspect
split_huge_page_to_list would fail for hugetlbfs pages. If there is a
more serious effect then we should mark the patch for stable as well.

> 
> Fixes: 94723aafb9 ("mm: unclutter THP migration")
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/migrate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index d6a2e89..d2297fe 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1411,7 +1411,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  				 * we encounter them after the rest of the list
>  				 * is processed.
>  				 */
> -				if (PageTransHuge(page)) {
> +				if (PageTransHuge(page) && !PageHuge(page)) {
>  					lock_page(page);
>  					rc = split_huge_page_to_list(page, from);
>  					unlock_page(page);
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
