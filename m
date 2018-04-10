Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752641AbeDJLdW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 07:33:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:35182 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752404AbeDJLdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 07:33:21 -0400
Date: Tue, 10 Apr 2018 13:33:19 +0200
From: Petr Mladek <pmladek@suse.com>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Nicolai Stange <nstange@suse.de>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] livepatch: Initialize shadow variables safely by
 a custom callback
Message-ID: <20180410113319.wgopcxznq7pqpxi7@pathway.suse.cz>
References: <20180405122315.29065-1-pmladek@suse.com>
 <20180405122315.29065-2-pmladek@suse.com>
 <20180406223420.icjwcq7vy24tvecu@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406223420.icjwcq7vy24tvecu@treble>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-04-06 17:34:20, Josh Poimboeuf wrote:
> On Thu, Apr 05, 2018 at 02:23:14PM +0200, Petr Mladek wrote:
> > @@ -150,6 +149,23 @@ static void *__klp_shadow_get_or_alloc(void *obj, unsigned long id, void *data,
> >  		goto exists;
> >  	}
> >  
> > +	new_shadow->obj = obj;
> > +	new_shadow->id = id;
> > +
> > +	if (ctor) {
> > +		int err;
> > +
> > +		err = ctor(obj, new_shadow->data, ctor_data);
> > +		if (err) {
> > +			spin_unlock_irqrestore(&klp_shadow_lock, flags);
> > +			kfree(new_shadow);
> > +			WARN(1,
> > +			     "Failed to construct shadow variable <%p, %lx>\n",
> > +			     obj, id);
> > +			return NULL;
> > +		}
> > +	}
> > +
> 
> I'm not sure why a constructor would return an error, though I guess it
> doesn't hurt to allow it.

It is true that constructors usually do not return an error code,
namely C++ or Java. But it is not true that they could not fail.
These languages use exceptions instead.

IMHO, the return value makes sense here.


> The WARN seems excessive though, IMO.  The constructor itself can warn
> (or printk or whatever else) if it thinks its warranted.

I am just fascinated by WARN(). But you are right. I am going to
replace it with

	pr_err("Failed to construct shadow variable <%p, %lx> (%d)\n",
	       obj, id, err);

> Also I think the 'err' variable isn't really needed.

Yup. Well, it will be needed by the pr_err() ;-)

Best Regard,
Petr
