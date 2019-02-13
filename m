Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA084C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A60222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550067791;
	bh=69VfCGCM0mTaLCKewVw6Lcp78yfMvzxywBU5/KXGyZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tABNqqWiqzgIqNVa4FDJ1qg+BV6EBcn6G6YIxoe/jdTO0T30blWq/VYW5RHNclucz
	 gW6+dmW5alnBERDpAoh3gueio8f6TUsjaTeNA1PEdFM1rDFOgtR+TPKwTngfgxUsHQ
	 3vQ1q4Z++XYXDvfaJjhQZmiLbzW2YKKzIcwoG6ik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392063AbfBMOXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:23:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:53264 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731306AbfBMOXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 09:23:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CE619B120;
        Wed, 13 Feb 2019 14:23:08 +0000 (UTC)
Date:   Wed, 13 Feb 2019 15:23:08 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Fix __dump_page() for poisoned pages
Message-ID: <20190213142308.GQ4525@dhcp22.suse.cz>
References: <dbbcd36ca1f045ec81f49c7657928a1cdf24872b.1550065120.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbbcd36ca1f045ec81f49c7657928a1cdf24872b.1550065120.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 13-02-19 13:40:49, Robin Murphy wrote:
> Evaluating page_mapping() on a poisoned page ends up dereferencing junk
> and making PF_POISONED_CHECK() considerably crashier than intended. Fix
> that by not inspecting the mapping until we've determined that it's
> likely to be valid.

Has this ever triggered? I am mainly asking because there is no usage of
mapping so I would expect that the compiler wouldn't really call
page_mapping until it is really used.

> Fixes: 1c6fb1d89e73 ("mm: print more information about mapping in __dump_page")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  mm/debug.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/debug.c b/mm/debug.c
> index 0abb987dad9b..1611cf00a137 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -44,7 +44,7 @@ const struct trace_print_flags vmaflag_names[] = {
>  
>  void __dump_page(struct page *page, const char *reason)
>  {
> -	struct address_space *mapping = page_mapping(page);
> +	struct address_space *mapping;
>  	bool page_poisoned = PagePoisoned(page);
>  	int mapcount;
>  
> @@ -58,6 +58,8 @@ void __dump_page(struct page *page, const char *reason)
>  		goto hex_only;
>  	}
>  
> +	mapping = page_mapping(page);
> +
>  	/*
>  	 * Avoid VM_BUG_ON() in page_mapcount().
>  	 * page->_mapcount space in struct page is used by sl[aou]b pages to
> -- 
> 2.20.1.dirty
> 

-- 
Michal Hocko
SUSE Labs
