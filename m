Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3DDC28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 295A620831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:34:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 295A620831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbeKUCEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:04:20 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:35797 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbeKUCEU (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 20 Nov 2018 21:04:20 -0500
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Tue, 20 Nov 2018 16:34:36 +0100
Received: from [149.44.172.157] (nwb-a10-snat.microfocus.com [10.120.13.201])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Tue, 20 Nov 2018 15:13:52 +0000
Message-ID: <1542726815.6817.8.camel@suse.com>
Subject: Re: [RFC PATCH 2/3] mm, memory_hotplug: deobfuscate migration part
 of offlining
From:   osalvador <osalvador@suse.com>
To:     Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Date:   Tue, 20 Nov 2018 16:13:35 +0100
In-Reply-To: <20181120134323.13007-3-mhocko@kernel.org>
References: <20181120134323.13007-1-mhocko@kernel.org>
         <20181120134323.13007-3-mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Signed-off-by: Michal Hocko <mhocko@suse.com>
[...]
> +	do {
> +		for (pfn = start_pfn; pfn;)
> +		{
> +			/* start memory hot removal */

Should we change thAT comment? I mean, this is not really the hot-
removal stage.

Maybe "start memory migration" suits better? or memory offlining?

> +			ret = -EINTR;
> +			if (signal_pending(current)) {
> +				reason = "signal backoff";
> +				goto failed_removal_isolated;
> +			}
>  
> -	cond_resched();
> -	lru_add_drain_all();
> -	drain_all_pages(zone);
> +			cond_resched();
> +			lru_add_drain_all();
> +			drain_all_pages(zone);
>  
> -	pfn = scan_movable_pages(start_pfn, end_pfn);
> -	if (pfn) { /* We have movable pages */
> -		ret = do_migrate_range(pfn, end_pfn);
> -		goto repeat;
> -	}
> +			pfn = scan_movable_pages(pfn, end_pfn);
> +			if (pfn) {
> +				/* TODO fatal migration failures
> should bail out */
> +				do_migrate_range(pfn, end_pfn);
> +			}
> +		}
> +
> +		/*
> +		 * dissolve free hugepages in the memory block
> before doing offlining
> +		 * actually in order to make hugetlbfs's object
> counting consistent.
> +		 */
> +		ret = dissolve_free_huge_pages(start_pfn, end_pfn);
> +		if (ret) {
> +			reason = "failure to dissolve huge pages";
> +			goto failed_removal_isolated;
> +		}
> +		/* check again */
> +		offlined_pages = check_pages_isolated(start_pfn,
> end_pfn);
> +	} while (offlined_pages < 0);
>  
> -	/*
> -	 * dissolve free hugepages in the memory block before doing
> offlining
> -	 * actually in order to make hugetlbfs's object counting
> consistent.
> -	 */
> -	ret = dissolve_free_huge_pages(start_pfn, end_pfn);
> -	if (ret) {
> -		reason = "failure to dissolve huge pages";
> -		goto failed_removal_isolated;
> -	}
> -	/* check again */
> -	offlined_pages = check_pages_isolated(start_pfn, end_pfn);
> -	if (offlined_pages < 0)
> -		goto repeat;

This indeed looks much nicer and it is easier to follow.
With the changes commented by David:

Reviewed-by: Oscar Salvador <osalvador@suse.de>
