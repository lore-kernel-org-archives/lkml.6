Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F61C43612
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 974F42171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546460638;
	bh=dkT+A+W71nb6a5WYfYSTXUeGVnbIkaWENN6lc+Fhthk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FcssU/rVUm90SQo8GdmL1/VJ28HONfMnkE6iLbCz9LANqSaI4MZgjd71g9ONITOWp
	 Lhkh7YFiFrGql8XiQYalwsLvzBsX8NxZFODhkfldxiOy3JYlbLcZGPL3Qd4mDYTp8X
	 A1tHk6tsro3FrJitvsl7DAfMqduaPSpKhdF0oeig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfABUX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 15:23:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:40944 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726052AbfABUX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 15:23:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8F016AE25;
        Wed,  2 Jan 2019 20:23:55 +0000 (UTC)
Date:   Wed, 2 Jan 2019 21:23:48 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Rik van Riel <riel@surriel.com>, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] fork, memcg: fix cached_stacks case
Message-ID: <20190102202348.GE24572@dhcp22.suse.cz>
References: <20190102180145.57406-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190102180145.57406-1-shakeelb@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 02-01-19 10:01:45, Shakeel Butt wrote:
> Commit 5eed6f1dff87 ("fork,memcg: fix crash in free_thread_stack on
> memcg charge fail") fixes a crash caused due to failed memcg charge of
> the kernel stack. However the fix misses the cached_stacks case which
> this patch fixes. So, the same crash can happen if the memcg charge of
> a cached stack is failed.
> 
> Fixes: 5eed6f1dff87 ("fork,memcg: fix crash in free_thread_stack on memcg charge fail")
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: <stable@vger.kernel.org>

Ups, I have overlook that. Thanks for catching that.
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  kernel/fork.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index e4a51124661a..593cd1577dff 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -216,6 +216,7 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
>  		memset(s->addr, 0, THREAD_SIZE);
>  
>  		tsk->stack_vm_area = s;
> +		tsk->stack = s->addr;
>  		return s->addr;
>  	}
>  
> -- 
> 2.20.1.415.g653613c723-goog
> 

-- 
Michal Hocko
SUSE Labs
