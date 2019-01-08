Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F06C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7DB7206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546959171;
	bh=PlorBsu+z/7u2piHFIruGyaQiakExf3P+uehUkSU1xw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KUTcpb3n9lhaIXkAZb3vb09R0n8QkSyzKMmFzIfCj46VleVPObcl//e4djOsnfAaJ
	 nAWtZPlD2KJSGL/NaHCEHsNqgTwu1mQfkm5RuGpJBNvSJyry0LRnULldgU07FUiATY
	 g8cShUh18ER74mA0hsbUKn88TkX9IxvwnZokPBRw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbfAHOwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 09:52:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:54482 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728604AbfAHOws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 09:52:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A4E96B0B1;
        Tue,  8 Jan 2019 14:52:46 +0000 (UTC)
Date:   Tue, 8 Jan 2019 15:52:45 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: memcontrol: use struct_size() in kmalloc()
Message-ID: <20190108145245.GW31793@dhcp22.suse.cz>
References: <20190104183726.GA6374@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104183726.GA6374@embeddedor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc Andrew (original patch is here http://lkml.kernel.org/r/20190104183726.GA6374@embeddedor)

On Fri 04-01-19 12:37:26, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct foo {
>     int stuff;
>     void *entry[];
> };
> 
> instance = kmalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
> 
> instance = kmalloc(struct_size(instance, entry, count), GFP_KERNEL);

This looks indeed neater

> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks

> ---
>  mm/memcontrol.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index af7f18b32389..ad256cf7da47 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3626,8 +3626,7 @@ static int __mem_cgroup_usage_register_event(struct mem_cgroup *memcg,
>  	size = thresholds->primary ? thresholds->primary->size + 1 : 1;
>  
>  	/* Allocate memory for new array of thresholds */
> -	new = kmalloc(sizeof(*new) + size * sizeof(struct mem_cgroup_threshold),
> -			GFP_KERNEL);
> +	new = kmalloc(struct_size(new, entries, size), GFP_KERNEL);
>  	if (!new) {
>  		ret = -ENOMEM;
>  		goto unlock;
> -- 
> 2.20.1

-- 
Michal Hocko
SUSE Labs
