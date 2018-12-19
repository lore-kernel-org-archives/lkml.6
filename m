Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E04AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C678218A4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545212383;
	bh=n1xjUUJ5dkXv3Mw5i6d+2py9yKHPP0ob6PH1FAVKnsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WwsMHe+1jnLdVo0QGYFj8lfehp4l4GXsmtoXyccgjbaCtoUoGSVoZiw7L0GVrfhHC
	 CPttTbL9j0kdRlWM8QGZITLwTTCjTVpP3LML3vc5wqFMv4lgvvw0N6xvaRb1Iumw62
	 mLDfxXkbc4KyoneOa5F4KNN+euZ8G18lEv2bntS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbeLSJjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 04:39:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:59550 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726537AbeLSJjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 04:39:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DE963ACEA;
        Wed, 19 Dec 2018 09:39:39 +0000 (UTC)
Date:   Wed, 19 Dec 2018 10:39:38 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     =?utf-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>,
        akpm@linux-foundation.org, rientjes@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com, guro@fb.com,
        yang.s@alibaba-inc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Wind Yu <yuzhoujian@didichuxing.com>
Subject: Re: [PATCH v15 2/2] Add oom victim's memcg to the oom context
 information
Message-ID: <20181219093938.GA5758@dhcp22.suse.cz>
References: <20181122133954.GI18011@dhcp22.suse.cz>
 <CAHCio2gdCX3p-7=N0cA22cWTaUmUXRq8WbiMAA2sM2wLVX4GjQ@mail.gmail.com>
 <201812190723.wBJ7NdkN032628@www262.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201812190723.wBJ7NdkN032628@www262.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 19-12-18 16:23:39, Tetsuo Handa wrote:
> Andrew, will you fold below diff into "mm, oom: add oom victim's memcg to the oom context information" ?
> 
> >From add1e8daddbfc5186417dbc58e9e11e7614868f8 Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Wed, 19 Dec 2018 16:09:31 +0900
> Subject: [PATCH] mm, oom: Use pr_cont() in mem_cgroup_print_oom_context().
> 
> One line summary of the OOM killer context is not one line due to
> not using KERN_CONT.
> 
> [   23.346650] oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),cpuset=/,mems_allowed=0
> [   23.346691] ,global_oom,task_memcg=/,task=firewalld,pid=5096,uid=0
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Sorry, I have missed that during review. Thanks for catching this up!

> ---
>  mm/memcontrol.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index b860dd4f7..4afd597 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1306,10 +1306,10 @@ void mem_cgroup_print_oom_context(struct mem_cgroup *memcg, struct task_struct *
>  	rcu_read_lock();
>  
>  	if (memcg) {
> -		pr_info(",oom_memcg=");
> +		pr_cont(",oom_memcg=");
>  		pr_cont_cgroup_path(memcg->css.cgroup);
>  	} else
> -		pr_info(",global_oom");
> +		pr_cont(",global_oom");
>  	if (p) {
>  		pr_cont(",task_memcg=");
>  		pr_cont_cgroup_path(task_cgroup(p, memory_cgrp_id));
> -- 
> 1.8.3.1

-- 
Michal Hocko
SUSE Labs
