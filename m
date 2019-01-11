Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E719AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0E72183F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547233871;
	bh=yN//O2JEt/gAhdDDb7qmS819gfzyTglCN/XhxaSlez8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OxfAroWnLauIXfJyR2s9BwwU/yL+f7sedSvkx5ynNla38QEzAq/NRw3VvzfyxoAhX
	 nLgKNNlYW7L//ENzxdPJ9DxCHStg+0HEej5Ix8b/gatC2Ms1pULg5QlXcr1a9UBynE
	 YO2hIxIVRgj/+dsaBc3qNZkYV+MklwI3tq2z/DAs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388173AbfAKTLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:11:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:40736 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729918AbfAKTLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 14:11:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0670AAD12;
        Fri, 11 Jan 2019 19:11:08 +0000 (UTC)
Date:   Fri, 11 Jan 2019 20:11:08 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     ying.huang@intel.com, tim.c.chen@intel.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: swap: use mem_cgroup_is_root() instead of
 deferencing css->parent
Message-ID: <20190111191108.GK14956@dhcp22.suse.cz>
References: <1547232913-118148-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547232913-118148-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 12-01-19 02:55:13, Yang Shi wrote:
> mem_cgroup_is_root() is preferred API to check if memcg is root or not.
> Use it instead of deferencing css->parent.
> 
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Tim Chen <tim.c.chen@intel.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>

Yes, this is more readable.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/swap.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index a8f6d5d..8739063 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -623,7 +623,7 @@ static inline int mem_cgroup_swappiness(struct mem_cgroup *memcg)
>  		return vm_swappiness;
>  
>  	/* root ? */
> -	if (mem_cgroup_disabled() || !memcg->css.parent)
> +	if (mem_cgroup_disabled() || mem_cgroup_is_root(memcg))
>  		return vm_swappiness;
>  
>  	return memcg->swappiness;
> -- 
> 1.8.3.1

-- 
Michal Hocko
SUSE Labs
