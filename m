Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D092EC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 12:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A236D20831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 12:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A236D20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeKBVks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 17:40:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:40032 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726008AbeKBVks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 17:40:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 27C8FABEF;
        Fri,  2 Nov 2018 12:33:45 +0000 (UTC)
Date:   Fri, 2 Nov 2018 13:32:52 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hotplug: Optimize clear_hwpoisoned_pages
Message-ID: <20181102120856.GC28039@dhcp22.suse.cz>
References: <20181102120001.4526-1-bsingharora@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102120001.4526-1-bsingharora@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 02-11-18 23:00:01, Balbir Singh wrote:
> In hot remove, we try to clear poisoned pages, but
> a small optimization to check if num_poisoned_pages
> is 0 helps remove the iteration through nr_pages.
> 
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>

Makes sense to me. It would be great to actually have some number but
the optimization for the normal case is quite obvious.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/sparse.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 33307fc05c4d..16219c7ddb5f 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -724,6 +724,16 @@ static void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
>  	if (!memmap)
>  		return;
>  
> +	/*
> +	 * A further optimization is to have per section
> +	 * ref counted num_poisoned_pages, but that is going
> +	 * to need more space per memmap, for now just do
> +	 * a quick global check, this should speed up this
> +	 * routine in the absence of bad pages.
> +	 */
> +	if (atomic_long_read(&num_poisoned_pages) == 0)
> +		return;
> +
>  	for (i = 0; i < nr_pages; i++) {
>  		if (PageHWPoison(&memmap[i])) {
>  			atomic_long_sub(1, &num_poisoned_pages);
> -- 
> 2.17.1
> 

-- 
Michal Hocko
SUSE Labs
