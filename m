Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2157C43444
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF3D021019
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546510385;
	bh=q2nxlgDS4NAZROZjCEKEp4Lw1T0Pk6dE1bfU9gHrlnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SqZCQuOkon/V2siyaM/MUSsWEkj/KeoDXCOMVugWl47DsfsVvWkbuJ7Me0XRvEfjG
	 LlZ4PfLDZvg78lwbmc+LyggndXRW+zizZxNYNCTTWKP3lldG2tjiFFKAXQPmeFO5mG
	 0RdYIKfxLicPzukZ2rx2arG73Yy3uSHi4JTjfLOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbfACKNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 05:13:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:49116 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728530AbfACKNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 05:13:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8136DAD4B;
        Thu,  3 Jan 2019 10:13:02 +0000 (UTC)
Date:   Thu, 3 Jan 2019 11:13:02 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] doc: memcontrol: fix the obsolete content about
 force empty
Message-ID: <20190103101302.GI31793@dhcp22.suse.cz>
References: <1546459533-36247-1-git-send-email-yang.shi@linux.alibaba.com>
 <1546459533-36247-2-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546459533-36247-2-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03-01-19 04:05:31, Yang Shi wrote:
> We don't do page cache reparent anymore when offlining memcg, so update
> force empty related content accordingly.
> 
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>

Thanks for the clean up.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  Documentation/cgroup-v1/memory.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/cgroup-v1/memory.txt b/Documentation/cgroup-v1/memory.txt
> index 3682e99..8e2cb1d 100644
> --- a/Documentation/cgroup-v1/memory.txt
> +++ b/Documentation/cgroup-v1/memory.txt
> @@ -70,7 +70,7 @@ Brief summary of control files.
>   memory.soft_limit_in_bytes	 # set/show soft limit of memory usage
>   memory.stat			 # show various statistics
>   memory.use_hierarchy		 # set/show hierarchical account enabled
> - memory.force_empty		 # trigger forced move charge to parent
> + memory.force_empty		 # trigger forced page reclaim
>   memory.pressure_level		 # set memory pressure notifications
>   memory.swappiness		 # set/show swappiness parameter of vmscan
>  				 (See sysctl's vm.swappiness)
> @@ -459,8 +459,9 @@ About use_hierarchy, see Section 6.
>    the cgroup will be reclaimed and as many pages reclaimed as possible.
>  
>    The typical use case for this interface is before calling rmdir().
> -  Because rmdir() moves all pages to parent, some out-of-use page caches can be
> -  moved to the parent. If you want to avoid that, force_empty will be useful.
> +  Though rmdir() offlines memcg, but the memcg may still stay there due to
> +  charged file caches. Some out-of-use page caches may keep charged until
> +  memory pressure happens. If you want to avoid that, force_empty will be useful.
>  
>    Also, note that when memory.kmem.limit_in_bytes is set the charges due to
>    kernel pages will still be seen. This is not considered a failure and the
> -- 
> 1.8.3.1
> 

-- 
Michal Hocko
SUSE Labs
