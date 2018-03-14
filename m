Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751620AbeCNUWe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 16:22:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34032 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751289AbeCNUWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 16:22:32 -0400
Date: Wed, 14 Mar 2018 15:22:29 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Petr Mladek <pmladek@suse.com>, Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, Jessica Yu <jeyu@kernel.org>,
        Nicolai Stange <nstange@suse.de>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] livepatch: Initialize shadow variables by init
 function safely
Message-ID: <20180314202229.eck3aszdmwgsldyb@treble>
References: <20180313155448.1998-1-pmladek@suse.com>
 <20180313155448.1998-2-pmladek@suse.com>
 <20180314192857.yfdk2uwn4okuzlfh@treble>
 <acd1592a-3f0d-c515-b90f-b1ed9694204b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <acd1592a-3f0d-c515-b90f-b1ed9694204b@redhat.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 03:43:01PM -0400, Joe Lawrence wrote:
> >> @@ -150,6 +145,23 @@ static void *__klp_shadow_get_or_alloc(void *obj, unsigned long id, void *data,
> >>  		goto exists;
> >>  	}
> >>  
> >> +	new_shadow->obj = obj;
> >> +	new_shadow->id = id;
> >> +
> >> +	if (init_func) {
> >> +		int err;
> >> +
> >> +		err = init_func(obj, new_shadow->data, init_data);
> > 
> > Am I hallucinating, or will new_shadow->data always be NULL?  How did it
> > even work before?
> >
> struct klp_shadow {
>         struct hlist_node node;
>         struct rcu_head rcu_head;
>         void *obj;
>         unsigned long id;
>         char data[];            << not a pointer
> };

Ah.  This code needs a nice comment above the kzalloc() call, so I won't
get confused again next time.

-- 
Josh
