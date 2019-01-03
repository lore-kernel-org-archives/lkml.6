Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25674C43444
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 09:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE7C821019
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 09:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546507925;
	bh=yinMsv5fbA3tVu+bujFnkgPhBEVGk6j/t0S0fTCPMoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VJHIErpAMdwoAIy5/NSd2xGinODhkUM5oj4bxEgxO3rYFkzeQAeRrOXnMQ1y1C4UO
	 PAEAbTudL6cB2ToXC91Sf61lHJiR8vAR5Avc5I6WTcQuaSLPcuyzcb7GYFMTaNO1qk
	 VQKVBzY9OBt97d/vYfEegyjWP0gTOF4+rZMlg8lw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730491AbfACJcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 04:32:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:44016 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726152AbfACJcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 04:32:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 95914AE18;
        Thu,  3 Jan 2019 09:32:02 +0000 (UTC)
Date:   Thu, 3 Jan 2019 10:32:01 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     catalin.marinas@arm.com, akpm@linux-foundation.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kmemleak: survive in a low-memory situation
Message-ID: <20190103093201.GB31793@dhcp22.suse.cz>
References: <20190102165931.GB6584@arrakis.emea.arm.com>
 <20190102180619.12392-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190102180619.12392-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 02-01-19 13:06:19, Qian Cai wrote:
[...]
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index f9d9dc250428..9e1aa3b7df75 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -576,6 +576,16 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
>  	struct rb_node **link, *rb_parent;
>  
>  	object = kmem_cache_alloc(object_cache, gfp_kmemleak_mask(gfp));
> +#ifdef CONFIG_PREEMPT_COUNT
> +	if (!object) {
> +		/* last-ditch effort in a low-memory situation */
> +		if (irqs_disabled() || is_idle_task(current) || in_atomic())
> +			gfp = GFP_ATOMIC;
> +		else
> +			gfp = gfp_kmemleak_mask(gfp) | __GFP_DIRECT_RECLAIM;
> +		object = kmem_cache_alloc(object_cache, gfp);
> +	}
> +#endif

I do not get it. How can this possibly help when gfp_kmemleak_mask()
adds __GFP_NOFAIL modifier to the given gfp mask? Or is this not the
case anymore in some tree?
-- 
Michal Hocko
SUSE Labs
