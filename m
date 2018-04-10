Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752391AbeDJJbx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 05:31:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:50528 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752196AbeDJJbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 05:31:51 -0400
Date: Tue, 10 Apr 2018 11:31:47 +0200
From: Petr Mladek <pmladek@suse.com>
To: Miroslav Benes <mbenes@suse.cz>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, Jiri Kosina <jikos@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] livepatch: Add atomic replace
Message-ID: <20180410093147.agf7a3wcr2kjslkc@pathway.suse.cz>
References: <20180323120028.31451-1-pmladek@suse.com>
 <20180323120028.31451-4-pmladek@suse.com>
 <20180406220530.snglx7m3quye34wp@treble>
 <alpine.LSU.2.21.1804091547190.20943@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1804091547190.20943@pobox.suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2018-04-09 15:53:03, Miroslav Benes wrote:
> > > +	 * see klp_init_object_loaded().
> > > +	 */
> > > +	if (!func->new_func && !func->nop)
> > >  		return -EINVAL;
> > 
> > >  
> > >  	INIT_LIST_HEAD(&func->stack_node);
> > > @@ -742,6 +920,9 @@ static int klp_init_object_loaded(struct klp_patch *patch,
> > >  			return -ENOENT;
> > >  		}
> > >  
> > > +		if (func->nop)
> > > +			func->new_func = (void *)func->old_addr;
> > > +
> > 
> > These changes make it more obvious that 'new_func' isn't quite the right
> > name.  It should really be 'new_addr' IMO.
> 
> I think we wanted to point out the difference from old_addr which is 
> initialized with the symbol name while new_func is initialized with the 
> new function itself (function pointer). I agree though that it looks 
> awkward in this context and I'm not against changing it to new_addr.

I am fine with the rename. I was confused by "new_func" several times
in the past. "new_addr" makes it clear that we are setting an address in
compare with the name in "old_name".


> Petr, could you also add a note to the changelog why we need to setup 
> new_func for nop functions, please? It's not obvious because of the hack 
> in klp_ftrace_handler() 
> (klp_cancel_transition()->...->klp_check_stack_func() needs it).

Yup.

Best Regards,
Petr
