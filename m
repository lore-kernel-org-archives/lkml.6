Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D756BC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86530208AF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86530208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731845AbeGaKY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 06:24:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:46690 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731364AbeGaKY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 06:24:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 83903B00D;
        Tue, 31 Jul 2018 08:45:10 +0000 (UTC)
Date:   Tue, 31 Jul 2018 10:45:09 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Tejun Heo <tj@kernel.org>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 1/3] mm: introduce mem_cgroup_put() helper
Message-ID: <20180731084509.GE4557@dhcp22.suse.cz>
References: <20180730180100.25079-1-guro@fb.com>
 <20180730180100.25079-2-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730180100.25079-2-guro@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 30-07-18 11:00:58, Roman Gushchin wrote:
> Introduce the mem_cgroup_put() helper, which helps to eliminate guarding
> memcg css release with "#ifdef CONFIG_MEMCG" in multiple places.

Is there any reason for this to be a separate patch? I usually do not
like to add helpers without their users because this makes review
harder. This one is quite trivial to fit into Patch3 easilly.

> Link: http://lkml.kernel.org/r/20180623000600.5818-2-guro@fb.com
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  include/linux/memcontrol.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 6c6fb116e925..e53e00cdbe3f 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -375,6 +375,11 @@ struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css){
>  	return css ? container_of(css, struct mem_cgroup, css) : NULL;
>  }
>  
> +static inline void mem_cgroup_put(struct mem_cgroup *memcg)
> +{
> +	css_put(&memcg->css);
> +}
> +
>  #define mem_cgroup_from_counter(counter, member)	\
>  	container_of(counter, struct mem_cgroup, member)
>  
> @@ -837,6 +842,10 @@ static inline bool task_in_mem_cgroup(struct task_struct *task,
>  	return true;
>  }
>  
> +static inline void mem_cgroup_put(struct mem_cgroup *memcg)
> +{
> +}
> +
>  static inline struct mem_cgroup *
>  mem_cgroup_iter(struct mem_cgroup *root,
>  		struct mem_cgroup *prev,
> -- 
> 2.14.4
> 

-- 
Michal Hocko
SUSE Labs
