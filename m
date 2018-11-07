Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75BCC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2EA421019
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2EA421019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbeKGXiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 18:38:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:39970 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726635AbeKGXiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 18:38:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0AF42B179;
        Wed,  7 Nov 2018 14:07:37 +0000 (UTC)
Date:   Wed, 7 Nov 2018 15:07:36 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 2/3] mm: Use line-buffered printk() for show_free_areas().
Message-ID: <20181107140736.hmsomid74ofzpxvd@pathway.suse.cz>
References: <1541165517-3557-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <1541165517-3557-2-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541165517-3557-2-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-11-02 22:31:56, Tetsuo Handa wrote:
> syzbot is sometimes getting mixed output like below due to concurrent
> printk(). Mitigate such output by using line-buffered printk() API.
> 
>   Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 1*32kB 
>   syz-executor0: page allocation failure: order:0, mode:0x484020(GFP_ATOMIC|__GFP_COMP), nodemask=(null)
>   (U) 
>   syz-executor0 cpuset=
>   2*64kB 
>   syz0
>   (U) 
>    mems_allowed=0
>   1*128kB 
>   CPU: 0 PID: 7592 Comm: syz-executor0 Not tainted 4.19.0-rc6+ #118
>   (U) 
>   Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>   1*256kB (U) 
>   Call Trace:
>   0*512kB 
>    <IRQ>
>   1*1024kB 
>    __dump_stack lib/dump_stack.c:77 [inline]
>    dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
>   (U) 
>   1*2048kB 
>    warn_alloc.cold.119+0xb7/0x1bd mm/page_alloc.c:3426
>   (M) 
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  mm/page_alloc.c | 32 +++++++++++++++++---------------
>  1 file changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index a919ba5..4411d5a 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4694,10 +4694,10 @@ unsigned long nr_free_pagecache_pages(void)
>  	return nr_free_zone_pages(gfp_zone(GFP_HIGHUSER_MOVABLE));
>  }
>  
> -static inline void show_node(struct zone *zone)
> +static inline void show_node(struct zone *zone, struct printk_buffer *buf)
>  {
>  	if (IS_ENABLED(CONFIG_NUMA))
> -		printk("Node %d ", zone_to_nid(zone));
> +		printk_buffered(buf, "Node %d ", zone_to_nid(zone));

The conversion looks fine to me. I just think about renaming
printk_buffered to bprintk().

Best Regards,
Petr
