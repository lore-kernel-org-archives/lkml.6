Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2A8C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080F2206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbfAIT1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:27:43 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45170 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbfAIT1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 14:27:42 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 29BB774;
        Wed,  9 Jan 2019 19:27:32 +0000 (UTC)
Date:   Wed, 9 Jan 2019 11:27:31 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, ying.huang@intel.com,
        kirill@shutemov.name, Linux-MM <linux-mm@kvack.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm, compaction: Use free lists to quickly locate a
 migration target -fix
Message-Id: <20190109112731.7d189ba6a606ca8f84dc5fa2@linux-foundation.org>
In-Reply-To: <20190109111344.GU31517@techsingularity.net>
References: <20190104125011.16071-1-mgorman@techsingularity.net>
        <20190109111344.GU31517@techsingularity.net>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2019 11:13:44 +0000 Mel Gorman <mgorman@techsingularity.net> wrote:

> Full compaction of a node passes in negative orders which can lead to array
> boundary issues. While it could be addressed in the control flow of the
> primary loop, it would be fragile so explicitly check for the condition.
> This is a fix for the mmotm patch
> broken-out/mm-compaction-use-free-lists-to-quickly-locate-a-migration-target.patch
> 
> ...
>
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1206,6 +1206,10 @@ fast_isolate_freepages(struct compact_control *cc)
>  	bool scan_start = false;
>  	int order;
>  
> +	/* Full compaction passes in a negative order */
> +	if (order <= 0)
> +		return cc->free_pfn;
> +
>  	/*
>  	 * If starting the scan, use a deeper search and use the highest
>  	 * PFN found if a suitable one is not found.

`order' is uninitialized.
