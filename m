Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752190AbeCZTVg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 15:21:36 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34265 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751157AbeCZTVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 15:21:35 -0400
X-Google-Smtp-Source: AG47ELsEUkGL1EvZprD59NIuTYK5IPLEKJZLFZyHUYvulaXVBsdeXTfd00K84nAf8HDHfgZB0sfy8g==
Date: Mon, 26 Mar 2018 22:21:32 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Yang Shi <yang.shi@linux.alibaba.com>, adobriyan@gmail.com,
        mhocko@kernel.org, mguzik@redhat.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] mm: introduce arg_lock to protect arg_start|end and
 env_start|end in mm_struct
Message-ID: <20180326192132.GE2236@uranus>
References: <1522088439-105930-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180326183725.GB27373@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180326183725.GB27373@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 11:37:25AM -0700, Matthew Wilcox wrote:
> On Tue, Mar 27, 2018 at 02:20:39AM +0800, Yang Shi wrote:
> > +++ b/kernel/sys.c
> > @@ -1959,7 +1959,7 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
> >  			return error;
> >  	}
> >  
> > -	down_write(&mm->mmap_sem);
> > +	down_read(&mm->mmap_sem);
> >  
> >  	/*
> >  	 * We don't validate if these members are pointing to
> > @@ -1980,10 +1980,13 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
> >  	mm->start_brk	= prctl_map.start_brk;
> >  	mm->brk		= prctl_map.brk;
> >  	mm->start_stack	= prctl_map.start_stack;
> > +
> > +	spin_lock(&mm->arg_lock);
> >  	mm->arg_start	= prctl_map.arg_start;
> >  	mm->arg_end	= prctl_map.arg_end;
> >  	mm->env_start	= prctl_map.env_start;
> >  	mm->env_end	= prctl_map.env_end;
> > +	spin_unlock(&mm->arg_lock);
> >  
> >  	/*
> >  	 * Note this update of @saved_auxv is lockless thus
> 
> I see the argument for the change to a write lock was because of a BUG
> validating arg_start and arg_end, but more generally, we are updating these
> values, so a write-lock is probably a good idea, and this is a very rare
> operation to do, so we don't care about making this more parallel.  I would
> not make this change (but if other more knowledgable people in this area
> disagree with me, I will withdraw my objection to this part).

Say we've two syscalls running prctl_set_mm_map in parallel, and imagine
one have @start_brk = 20 @brk = 10 and second caller has @start_brk = 30
and @brk = 20. Since now the call is guarded by _read_ the both calls
unlocked and due to OO engine it may happen then when both finish
we have @start_brk = 30 and @brk = 10. In turn "write" semaphore
has been take to have consistent data on exit, either you have [20;10]
or [30;20] assigned not something mixed.

That said I think using read-lock here would be a bug.

	Cyrill
