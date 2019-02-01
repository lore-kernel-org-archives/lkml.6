Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172C1C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D08C720B1F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549005127;
	bh=KT6YKSmiZGGoC/MqpQBPXd9aAbLDadq5+J7FT9LwJNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VhtEVdtAGHsTuAx4rxobvQ6s5gQLPkDtmg8/9AUW/D8tkCb1VWu8Y8qVKi2BCxXib
	 jT8RtH01JqVYW5PYPAtROcokomGSgJJeLm7fF1fDPCsqbOKF7NDdOQ2Qr1H8doWoos
	 T+hl+/82JcqulObrghGnH6l2PyEQQDPQMsw3a1mA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfBAHMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 02:12:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:60182 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725763AbfBAHMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 02:12:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7AA71ADA9;
        Fri,  1 Feb 2019 07:12:04 +0000 (UTC)
Date:   Fri, 1 Feb 2019 08:12:03 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm, memcg: Handle cgroup_disable=memory when getting
 memcg protection
Message-ID: <20190201071203.GD11599@dhcp22.suse.cz>
References: <20190201045711.GA18302@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201045711.GA18302@chrisdown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 31-01-19 23:57:11, Chris Down wrote:
> memcg is NULL if we have CONFIG_MEMCG set, but cgroup_disable=memory on
> the kernel command line.
> 
> Fixes: 8a907cdf0177ab40 ("mm, memcg: proportional memory.{low,min} reclaim")

JFYI this is not a valid sha1. It is from linux next and it will change
with the next linux-next release.

Btw. I still didn't get to look at your patch and I am unlikely to do so
today. I will be offline next week but I will try to get to it after I
get back.

> Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: cgroups@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---
>  include/linux/memcontrol.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 290cfbfd60cd..49742489aa56 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -335,6 +335,9 @@ static inline bool mem_cgroup_disabled(void)
>  
>  static inline unsigned long mem_cgroup_protection(struct mem_cgroup *memcg)
>  {
> +	if (mem_cgroup_disabled())
> +		return 0;
> +
>  	return max(READ_ONCE(memcg->memory.emin), READ_ONCE(memcg->memory.elow));
>  }
>  
> -- 
> 2.20.1

-- 
Michal Hocko
SUSE Labs
