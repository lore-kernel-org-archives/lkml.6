Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DA8C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA4B820883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546958313;
	bh=PEmmpU2eISHWQK4vousNNIctfEnEaVaowYlp3GY23kY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qz0OmvQ9rG1tIIQufZg2CdydxyNzxRV6tukneuIO+DZH6CRnkkAezubExyE5c0uV2
	 ZUpdn5m39K6iRelhnP3UIAV05wyo/GsbO6SLyfUXxtuZWRnDlNbw4IFgND9+MqhrqN
	 6G6dblquuV6LVAlX9UVHbcjH5m8eZSeaowVeOlqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbfAHOid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 09:38:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:51476 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728112AbfAHOic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 09:38:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 313AAB081;
        Tue,  8 Jan 2019 14:38:31 +0000 (UTC)
Date:   Tue, 8 Jan 2019 15:38:30 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/2] memcg: Facilitate termination of memcg OOM victims.
Message-ID: <20190108143830.GV31793@dhcp22.suse.cz>
References: <20190107143802.16847-1-mhocko@kernel.org>
 <a49e2b45-10b2-715c-7dcb-2eb7ec5d2cf2@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a49e2b45-10b2-715c-7dcb-2eb7ec5d2cf2@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08-01-19 23:21:23, Tetsuo Handa wrote:
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> 
> If memcg OOM events in different domains are pending, already OOM-killed
> threads needlessly wait for pending memcg OOM events in different domains.
> An out_of_memory() call is slow because it involves printk(). With slow
> serial consoles, out_of_memory() might take more than a second. Therefore,
> allowing killed processes to quickly call mmput() from exit_mm() from
> do_exit() will help calling __mmput() (which can reclaim more memory than
> the OOM reaper can reclaim) quickly.

Can you post it separately out of this thread please? It is really a
separate topic and I do not want to end with back and forth without
making a further progress.
 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  mm/memcontrol.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 90eb2e2..a7d3ba9 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1389,14 +1389,19 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	};
>  	bool ret = true;
>  
> -	mutex_lock(&oom_lock);
> -
>  	/*
> -	 * multi-threaded tasks might race with oom_reaper and gain
> -	 * MMF_OOM_SKIP before reaching out_of_memory which can lead
> -	 * to out_of_memory failure if the task is the last one in
> -	 * memcg which would be a false possitive failure reported
> +	 * Multi-threaded tasks might race with oom_reaper() and gain
> +	 * MMF_OOM_SKIP before reaching out_of_memory(). But if current
> +	 * thread was already killed or is ready to terminate, there is
> +	 * no need to call out_of_memory() nor wait for oom_reaoer() to
> +	 * set MMF_OOM_SKIP. These three checks minimize possibility of
> +	 * needlessly calling out_of_memory() and try to call exit_mm()
> +	 * as soon as possible.
>  	 */
> +	if (mutex_lock_killable(&oom_lock))
> +		return true;
> +	if (fatal_signal_pending(current))
> +		goto unlock;
>  	if (tsk_is_oom_victim(current))
>  		goto unlock;
>  
> -- 
> 1.8.3.1
> 

-- 
Michal Hocko
SUSE Labs
