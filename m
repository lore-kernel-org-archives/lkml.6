Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751913AbeC0HhJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 03:37:09 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:39888 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbeC0HhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 03:37:07 -0400
X-Google-Smtp-Source: AIpwx4+AlMecIwhGwL9UvZYQxKeCCacYcP44NspSQydgg4zrIoGd5xvzoBxbw5cW+mxAt55QAyojeA==
Date: Tue, 27 Mar 2018 10:37:04 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: willy@infradead.org, yang.shi@linux.alibaba.com, adobriyan@gmail.com,
        mhocko@kernel.org, mguzik@redhat.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] mm: introduce arg_lock to protect arg_start|end and
 env_start|end in mm_struct
Message-ID: <20180327073704.GH2236@uranus>
References: <1522088439-105930-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180326183725.GB27373@bombadil.infradead.org>
 <20180326192132.GE2236@uranus>
 <0bfa8943-a2fe-b0ab-99a2-347094a2bcec@i-love.sakura.ne.jp>
 <20180326212944.GF2236@uranus>
 <201803270700.IJB35465.HJQFSFMVLFOtOO@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201803270700.IJB35465.HJQFSFMVLFOtOO@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 07:00:56AM +0900, Tetsuo Handa wrote:
> 
> >             To be fair I would prefer to drop this old per-field
> > interface completely. This per-field interface was rather an ugly
> > solution from my side.
> 
> But this is userspace visible API and thus we cannot change.

Hi! We could deplrecate this API call for a couple of releases
and then if nobody complain we could rip it off completely.
There should not be many users I think, didn't heard that
someone except criu used it ever.

> > > Then, I wonder whether reading arg_start|end and env_start|end atomically makes
> > > sense. Just retry reading if arg_start > env_end or env_start > env_end is fine?
> > 
> > Tetsuo, let me re-read this code tomorrow, maybe I miss something obvious.
> > 
> 
> You are not missing my point. What I thought is
> 
> +retry:
> -	down_read(&mm->mmap_sem);
>  	arg_start = mm->arg_start;
>  	arg_end = mm->arg_end;
>  	env_start = mm->env_start;
>  	env_end = mm->env_end;
> -	up_read(&mm->mmap_sem);
>  
> -	BUG_ON(arg_start > arg_end);
> -	BUG_ON(env_start > env_end);
> +	if (unlikely(arg_start > arg_end || env_start > env_end)) {
> +		cond_resched();
> +		goto retry;
> +	}
> 
> for reading these fields.

I fear such contentional cycles are acceptable if only they
are guaranteed to finish eventually. Which doesn't look so
in the code above.

	Cyrill
