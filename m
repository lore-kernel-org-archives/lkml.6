Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECF0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA92420818
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:02:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA92420818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391864AbeKWCmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 21:42:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:55752 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732369AbeKWCmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 21:42:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2BA28AED6;
        Thu, 22 Nov 2018 16:02:51 +0000 (UTC)
Date:   Thu, 22 Nov 2018 17:02:50 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 07/17] debugobjects: Move printk out of db lock
 critical sections
Message-ID: <20181122160250.lxyfzsybfwskrh54@pathway.suse.cz>
References: <1542653726-5655-1-git-send-email-longman@redhat.com>
 <1542653726-5655-8-git-send-email-longman@redhat.com>
 <2ddd9e3d-951e-1892-c941-54be80f7e6aa@redhat.com>
 <20181122020422.GA3441@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122020422.GA3441@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-11-22 11:04:22, Sergey Senozhatsky wrote:
> On (11/21/18 11:49), Waiman Long wrote:
> [..]
> > >  	case ODEBUG_STATE_ACTIVE:
> > > -		debug_print_object(obj, "init");
> > >  		state = obj->state;
> > >  		raw_spin_unlock_irqrestore(&db->lock, flags);
> > > +		debug_print_object(obj, "init");
> > >  		debug_object_fixup(descr->fixup_init, addr, state);
> > >  		return;
> > >  
> > >  	case ODEBUG_STATE_DESTROYED:
> > > -		debug_print_object(obj, "init");
> > > +		debug_printobj = true;
> > >  		break;
> > >  	default:
> > >  		break;
> > >  	}
> > >  
> > >  	raw_spin_unlock_irqrestore(&db->lock, flags);
> > > +	if (debug_chkstack)
> > > +		debug_object_is_on_stack(addr, onstack);
> > > +	if (debug_printobj)
> > > +		debug_print_object(obj, "init");
> > >
> [..]
> >
> > As a side note, one of the test systems that I used generated a
> > debugobjects splat in the bootup process and the system hanged
> > afterward. Applying this patch alone fix the hanging problem and the
> > system booted up successfully. So it is not really a good idea to call
> > printk() while holding a raw spinlock.

Please, was the system hang reproducible? I wonder if it was a
deadlock described by Sergey below.

The commit message is right. printk() might take too long and
cause softlockup or livelock. But it does not explain why
the system could competely hang.

Also note that prinkt() should not longer block a single process
indefinitely thanks to the commit dbdda842fe96f8932 ("printk:
Add console owner and waiter logic to load balance console writes").

> Some serial consoles call mod_timer(). So what we could have with the
> debug objects enabled was
> 
> 	mod_timer()
> 	 lock_timer_base()
> 	  debug_activate()
> 	   printk()
> 	    call_console_drivers()
> 	     foo_console()
> 	      mod_timer()
> 	       lock_timer_base()       << deadlock

Anyway, I wonder what was the primary motivation for this patch.
Was it the system hang? Or was it lockdep report about nesting
two terminal locks: db->lock, pool_lock with logbuf_lock?

Printk is problematic. It might delay any atomic context
where it is used. I would like to better understand the
problem here before we start spread printk-related hacks.

Best Regards,
Petr
