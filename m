Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02ED2C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C025820820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:48:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C025820820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405355AbeKWWcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 17:32:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:57600 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387844AbeKWWcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 17:32:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 92749AF59;
        Fri, 23 Nov 2018 11:48:27 +0000 (UTC)
Date:   Fri, 23 Nov 2018 12:48:26 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 07/17] debugobjects: Move printk out of db lock
 critical sections
Message-ID: <20181123114826.h27t7qiwfp7grrqx@pathway.suse.cz>
References: <1542653726-5655-1-git-send-email-longman@redhat.com>
 <1542653726-5655-8-git-send-email-longman@redhat.com>
 <2ddd9e3d-951e-1892-c941-54be80f7e6aa@redhat.com>
 <20181122020422.GA3441@jagdpanzerIV>
 <20181122101606.GP2131@hirez.programming.kicks-ass.net>
 <20181123024048.GD1582@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123024048.GD1582@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-11-23 11:40:48, Sergey Senozhatsky wrote:
> On (11/22/18 11:16), Peter Zijlstra wrote:
> > > So maybe we need to switch debug objects print-outs to _always_
> > > printk_deferred(). Debug objects can be used in code which cannot
> > > do direct printk() - timekeeping is just one example.
> > 
> > No, printk_deferred() is a disease, it needs to be eradicated, not
> > spread around.
> 
> deadlock-free printk() is deferred, but OK.

The best solution would be lockless console drivers. Sigh.


> Another idea then:
> 
> ---
> 
> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
> index 70935ed91125..3928c2b2f77c 100644
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -323,10 +323,13 @@ static void debug_print_object(struct debug_obj *obj, char *msg)
>  		void *hint = descr->debug_hint ?
>  			descr->debug_hint(obj->object) : NULL;
>  		limit++;
> +
> +		bust_spinlocks(1);
>  		WARN(1, KERN_ERR "ODEBUG: %s %s (active state %u) "
>  				 "object type: %s hint: %pS\n",
>  			msg, obj_states[obj->state], obj->astate,
>  			descr->name, hint);
> +		bust_spinlocks(0);
>  	}
>  	debug_objects_warnings++;
>  }
> 
> ---
> 
> This should make serial consoles re-entrant.
> So printk->console_driver_write() hopefully will not deadlock.

Is the re-entrance safe? Some risk might be acceptable in Oops/panic
situations. It is much less acceptable for random warnings.

Best Regards,
Petr
