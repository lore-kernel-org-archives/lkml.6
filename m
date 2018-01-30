Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752936AbeA3ODH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 09:03:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:37980 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752540AbeA3ODF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 09:03:05 -0500
Date: Tue, 30 Jan 2018 15:03:03 +0100
From: Petr Mladek <pmladek@suse.com>
To: Evgenii Shatokhin <eshatokhin@virtuozzo.com>
Cc: Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, jpoimboe@redhat.com, jeyu@kernel.org,
        jikos@kernel.org, mbenes@suse.cz, joe.lawrence@redhat.com
Subject: Re: [PATCH v5 0/3] livepatch: introduce atomic replace
Message-ID: <20180130140303.6xmjgnbdemovzif5@pathway.suse.cz>
References: <cover.1515786085.git.jbaron@akamai.com>
 <c9064c38-9f04-f6d3-c28b-593a0bb74488@virtuozzo.com>
 <86cac2eb-0de4-bae7-f633-5ad03297880d@akamai.com>
 <20180126102326.u5jscbbgburrzatp@pathway.suse.cz>
 <adf9b91f-e9e9-9d9a-8b28-5754c16c0782@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adf9b91f-e9e9-9d9a-8b28-5754c16c0782@virtuozzo.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-01-26 14:29:36, Evgenii Shatokhin wrote:
> On 26.01.2018 13:23, Petr Mladek wrote:
> > On Fri 2018-01-19 16:10:42, Jason Baron wrote:
> > > 
> > > 
> > > On 01/19/2018 02:20 PM, Evgenii Shatokhin wrote:
> > > > On 12.01.2018 22:55, Jason Baron wrote:
> > > > There is one more thing that might need attention here. In my
> > > > experiments with this patch series, I saw that unpatch callbacks are not
> > > > called for the older binary patch (the one being replaced).
> > > 
> > > So I think the pre_unpatch() can be called for any prior livepatch
> > > modules from __klp_enable_patch(). Perhaps in reverse order of loading
> > > (if there is more than one), and *before* the pre_patch() for the
> > > livepatch module being loaded. Then, if it sucessfully patches in
> > > klp_complete_transition() the post_unpatch() can be called for any prior
> > > livepatch modules as well. I think again it makes sense to call the
> > > post_unpatch() for prior modules *before* the post_patch() for the
> > > current livepatch modules.
> > 
> > So, we are talking about a lot of rather non-trivial code.
> > IMHO, it might be easier to run just the callbacks from
> > the new patch. In reality, the author should always know
> > what it might be replacing and what needs to be done.
> > 
> > By other words, it might be much easier to handle all
> > situations in a single script in the new patch. Alternative
> > would be doing crazy hacks to prevent the older scripts from
> > destroying what we would like to keep. We would need to
> > keep in mind interactions between the scripts and
> > the order in which they are called.
> > 
> > Or do you plan to use cumulative patches to simply
> > get rid of any other "random" livepatches with something
> > completely different? In this case, it might be much more
> > safe to disable the older patches a normal way.
> 
> In my experience, it was quite convenient sometimes to just "replace all
> binary patches the user currently has loaded with this single one". No
> matter what these original binary patches did and where they came from.

To be honest, I would feel better if the livepatch framework is
more safe. It should prevent breaking the system by a patch
that atomically replaces other random patches that rely on callbacks.

Well, combining random livepatches from random vendors is a call
for troubles. It might easily fail when two patches add
different changes to the same function.

I wonder if we should introduce some tags, keys, vendors. I mean
to define an identification or dependencies that would say that some
patches are compatible or incompatible.

We could allow to livepatch one function by two livepatches
only if they are from the same vendor. But then the order still
might be important. Also I am not sure if this condition is safe
enough.

One the other hand, we could handle callbacks like the shadow
variables. Every shadow variable has an ID. We have an API to
add/read/update/remove them. We might allow to have more
callbacks with different IDs. Then we could run callbacks
only for IDs that are newly added or removed. Sigh, this would
be very complex implementation as well. But it might make
these features easier to use and maintain.


Alternatively, I thought about having two modes. One is
stack of "random" patches. Second is a cumulative mode.
IMHO, the combination of the two modes makes things very
complex. It might be much easier if we allow to load
patch with the replace flag enabled only on top of
another patch with this flag enabled.


> Another problematic situation is when you need to actually downgrade a
> cumulative patch. Should be rare, but...

Good point. Well, especially the callbacks should be rare.

I would like to hear from people that have some experience
or plans with using callbacks and cumulative patches.

I wonder how they plan to technically reuse a feature
in the cummulative patches. IMHO, it should be very
rare to add/remove callbacks. Then it might be safe
to downgrade a cummulative patch if the callbacks
are exactly the same.

> Well, I think we will disable the old patches explicitly in these cases,
> before loading of the new one. May be fragile but easier to maintain.

I am afraid that we will not be able to support all use cases
and keep the code sane.

Best Regards,
Petr
