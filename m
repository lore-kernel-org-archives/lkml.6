Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58DBC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A5F2087A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84A5F2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbeH2B3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 21:29:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57348 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbeH2B3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 21:29:05 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 79C9CC77;
        Tue, 28 Aug 2018 21:35:31 +0000 (UTC)
Date:   Tue, 28 Aug 2018 14:35:30 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Oscar Salvador <osalvador@techadventures.net>
Cc:     mhocko@suse.com, vbabka@suse.cz, Pavel.Tatashin@microsoft.com,
        sfr@canb.auug.org.au, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
        Lai Jiangshan <laijs@cn.fujitsu.com>
Subject: Re: [PATCH] mm/page_alloc: Clean up check_for_memory
Message-Id: <20180828143530.4b681bf9e0b3c03519fbe943@linux-foundation.org>
In-Reply-To: <20180828210158.4617-1-osalvador@techadventures.net>
References: <20180828210158.4617-1-osalvador@techadventures.net>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018 23:01:58 +0200 Oscar Salvador <osalvador@techadventures.net> wrote:

> From: Oscar Salvador <osalvador@suse.de>
> 
> check_for_memory looks a bit confusing.
> First of all, we have this:
> 
> if (N_MEMORY == N_NORMAL_MEMORY)
> 	return;
> 
> Checking the ENUM declaration, looks like N_MEMORY canot be equal to
> N_NORMAL_MEMORY.
> I could not find where N_MEMORY is set to N_NORMAL_MEMORY, or the other
> way around either, so unless I am missing something, this condition 
> will never evaluate to true.
> It makes sense to get rid of it.

Added by

commit 4b0ef1fe8a626f0ba7f649764f979d0dc9eab86b
Author:     Lai Jiangshan <laijs@cn.fujitsu.com>
AuthorDate: Wed Dec 12 13:51:46 2012 -0800
Commit:     Linus Torvalds <torvalds@linux-foundation.org>
CommitDate: Wed Dec 12 17:38:33 2012 -0800

    page_alloc: use N_MEMORY instead N_HIGH_MEMORY change the node_states initia
lization

Let's cc Lai Jiangshan, see if he can remmeber the reasoning.

But yes, it does look like im-not-sure-whats-going-on-here
defensiveness.

> Moving forward, the operations whithin the loop look a bit confusing
> as well.
> 
> We set N_HIGH_MEMORY unconditionally, and then we set N_NORMAL_MEMORY
> in case we have CONFIG_HIGHMEM (N_NORMAL_MEMORY != N_HIGH_MEMORY)
> and zone <= ZONE_NORMAL.
> (N_HIGH_MEMORY falls back to N_NORMAL_MEMORY on !CONFIG_HIGHMEM systems,
> and that is why we can just go ahead and set N_HIGH_MEMORY unconditionally)
> 
> Although this works, it is a bit subtle.
> 
> I think that this could be easier to follow:
> 
> First, we should only set N_HIGH_MEMORY in case we have
> CONFIG_HIGHMEM.

Why?  Just a teeny optimization?

> And then we should set N_NORMAL_MEMORY in case zone <= ZONE_NORMAL,
> without further checking whether we have CONFIG_HIGHMEM or not.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  mm/page_alloc.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 839e0cc17f2c..6aa947f9e614 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6819,15 +6819,12 @@ static void check_for_memory(pg_data_t *pgdat, int nid)
>  {
>  	enum zone_type zone_type;
>  
> -	if (N_MEMORY == N_NORMAL_MEMORY)
> -		return;
> -
>  	for (zone_type = 0; zone_type <= ZONE_MOVABLE - 1; zone_type++) {
>  		struct zone *zone = &pgdat->node_zones[zone_type];
>  		if (populated_zone(zone)) {
> -			node_set_state(nid, N_HIGH_MEMORY);
> -			if (N_NORMAL_MEMORY != N_HIGH_MEMORY &&
> -			    zone_type <= ZONE_NORMAL)
> +			if (IS_ENABLED(CONFIG_HIGHMEM))
> +				node_set_state(nid, N_HIGH_MEMORY);
> +			if (zone_type <= ZONE_NORMAL)
>  				node_set_state(nid, N_NORMAL_MEMORY);
>  			break;
>  		}

