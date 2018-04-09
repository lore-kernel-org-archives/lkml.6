Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752249AbeDINxH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 09:53:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:46700 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751896AbeDINxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 09:53:05 -0400
Date: Mon, 9 Apr 2018 15:53:03 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@redhat.com>
cc: Petr Mladek <pmladek@suse.com>, Jiri Kosina <jikos@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] livepatch: Add atomic replace
In-Reply-To: <20180406220530.snglx7m3quye34wp@treble>
Message-ID: <alpine.LSU.2.21.1804091547190.20943@pobox.suse.cz>
References: <20180323120028.31451-1-pmladek@suse.com> <20180323120028.31451-4-pmladek@suse.com> <20180406220530.snglx7m3quye34wp@treble>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +	 * see klp_init_object_loaded().
> > +	 */
> > +	if (!func->new_func && !func->nop)
> >  		return -EINVAL;
> 
> >  
> >  	INIT_LIST_HEAD(&func->stack_node);
> > @@ -742,6 +920,9 @@ static int klp_init_object_loaded(struct klp_patch *patch,
> >  			return -ENOENT;
> >  		}
> >  
> > +		if (func->nop)
> > +			func->new_func = (void *)func->old_addr;
> > +
> 
> These changes make it more obvious that 'new_func' isn't quite the right
> name.  It should really be 'new_addr' IMO.

I think we wanted to point out the difference from old_addr which is 
initialized with the symbol name while new_func is initialized with the 
new function itself (function pointer). I agree though that it looks 
awkward in this context and I'm not against changing it to new_addr.

Petr, could you also add a note to the changelog why we need to setup 
new_func for nop functions, please? It's not obvious because of the hack 
in klp_ftrace_handler() 
(klp_cancel_transition()->...->klp_check_stack_func() needs it).

Miroslav
