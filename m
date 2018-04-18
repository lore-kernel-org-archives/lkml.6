Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753955AbeDRLzt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 07:55:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:55041 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753937AbeDRLzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 07:55:48 -0400
Date: Wed, 18 Apr 2018 13:55:46 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs, elf: drop MAP_FIXED usage from elf_map
Message-ID: <20180418115546.GZ17484@dhcp22.suse.cz>
References: <20171213092550.2774-1-mhocko@kernel.org>
 <20171213092550.2774-3-mhocko@kernel.org>
 <0b5c541a-91ee-220b-3196-f64264f9f0bc@I-love.SAKURA.ne.jp>
 <20180418113301.GY17484@dhcp22.suse.cz>
 <201804182043.JFH90161.LStOOMFFOJQHVF@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201804182043.JFH90161.LStOOMFFOJQHVF@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 18-04-18 20:43:11, Tetsuo Handa wrote:
> Michal Hocko wrote:
> > > Don't complain if IS_ERR_VALUE(),
> > 
> > this is simply wrong. We do want to warn on the failure because this is
> > when the actual clash happens. We should just warn on EEXIST.
> 
> >From 25442cdd31aa5cc8522923a0153a77dfd2ebc832 Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Wed, 18 Apr 2018 20:38:15 +0900
> Subject: [PATCH] fs, elf: don't complain MAP_FIXED_NOREPLACE unless -EEXIST
>  error.
> 
> Commit 4ed28639519c7bad ("fs, elf: drop MAP_FIXED usage from elf_map") is
> printing spurious messages under memory pressure due to map_addr == -ENOMEM.
> 
>  9794 (a.out): Uhuuh, elf segment at 00007f2e34738000(fffffffffffffff4) requested but the memory is mapped already
>  14104 (a.out): Uhuuh, elf segment at 00007f34fd76c000(fffffffffffffff4) requested but the memory is mapped already
>  16843 (a.out): Uhuuh, elf segment at 00007f930ecc7000(fffffffffffffff4) requested but the memory is mapped already
> 
> Complain only if -EEXIST, and use %px for printing the address.

Yes this is better. But...

[...]
> -	if ((type & MAP_FIXED_NOREPLACE) && BAD_ADDR(map_addr))
> -		pr_info("%d (%s): Uhuuh, elf segment at %p requested but the memory is mapped already\n",
> -				task_pid_nr(current), current->comm,
> -				(void *)addr);
> +	if ((type & MAP_FIXED_NOREPLACE) && map_addr == -EEXIST)

... please use PTR_ERR(map_addr) == -EEXIST

then you can add 
Acked-by: Michal Hocko <mhocko@suse.com>

> +		pr_info("%d (%s): Uhuuh, elf segment at %px requested but the memory is mapped already\n",
> +			task_pid_nr(current), current->comm, (void *)addr);
>  
>  	return(map_addr);
>  }
> -- 
> 1.8.3.1

-- 
Michal Hocko
SUSE Labs
