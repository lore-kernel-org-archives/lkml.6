Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E48BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26CB620645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388261AbfAORCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:02:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:51030 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731711AbfAORCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 12:02:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C2A3EAF50;
        Tue, 15 Jan 2019 17:02:13 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 10C3D1E0DB1; Tue, 15 Jan 2019 18:02:13 +0100 (CET)
Date:   Tue, 15 Jan 2019 18:02:13 +0100
From:   Jan Kara <jack@suse.cz>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        Oscar Salvador <OSalvador@suse.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm, memory_hotplug: __offline_pages fix wrong locking
Message-ID: <20190115170213.GA26069@quack2.suse.cz>
References: <20190115120307.22768-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115120307.22768-1-mhocko@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 15-01-19 13:03:07, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> Jan has noticed that we do double unlock on some failure paths when
> offlining a page range. This is indeed the case when test_pages_in_a_zone
> respp. start_isolate_page_range fail. This was an omission when forward
> porting the debugging patch from an older kernel.
> 
> Fix the issue by dropping mem_hotplug_done from the failure condition
> and keeping the single unlock in the catch all failure path.
> 
> Reported-by: Jan Kara <jack@suse.cz>
> Fixes: 7960509329c2 ("mm, memory_hotplug: print reason for the offlining failure")
> Signed-off-by: Michal Hocko <mhocko@suse.com>

The patch looks good to me so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

Also it fixes the test that previously crashed for me so you can add:

Tested-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  mm/memory_hotplug.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index b9a667d36c55..faeeaccc5fae 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1576,7 +1576,6 @@ static int __ref __offline_pages(unsigned long start_pfn,
>  	   we assume this for now. .*/
>  	if (!test_pages_in_a_zone(start_pfn, end_pfn, &valid_start,
>  				  &valid_end)) {
> -		mem_hotplug_done();
>  		ret = -EINVAL;
>  		reason = "multizone range";
>  		goto failed_removal;
> @@ -1591,7 +1590,6 @@ static int __ref __offline_pages(unsigned long start_pfn,
>  				       MIGRATE_MOVABLE,
>  				       SKIP_HWPOISON | REPORT_FAILURE);
>  	if (ret) {
> -		mem_hotplug_done();
>  		reason = "failure to isolate range";
>  		goto failed_removal;
>  	}
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
