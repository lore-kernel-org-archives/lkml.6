Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752481AbeDQIYn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 04:24:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:44232 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752254AbeDQIXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 04:23:15 -0400
Date: Tue, 17 Apr 2018 10:23:12 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@redhat.com>
cc: Petr Mladek <pmladek@suse.com>, Jiri Kosina <jikos@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 05/10] livepatch: Support separate list for replaced
 patches.
In-Reply-To: <20180416190425.tk7nnbqbmaxeniud@treble>
Message-ID: <alpine.LSU.2.21.1804171018500.12184@pobox.suse.cz>
References: <20180323224410.vuq5cabfprqhd6ej@treble> <20180326101107.bbloeh5l276on7uz@pathway.suse.cz> <20180406195049.dtfebzfdkbvv6yex@treble> <20180410083455.l26dgo5kx4cy7bc7@pathway.suse.cz> <20180410174206.l3uk6lchhzxvn75x@treble>
 <alpine.LSU.2.21.1804110956430.28885@pobox.suse.cz> <20180411123214.mfpkbrirze32phrb@treble> <20180411141711.cwceg7o5ttjgebii@pathway.suse.cz> <20180411154852.3yjab3ot76qicw6m@treble> <20180416145811.x4lvtm5kxyigbp56@pathway.suse.cz>
 <20180416190425.tk7nnbqbmaxeniud@treble>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> > > > Second, unrelated patches must never patch the same functions.
> > > > Otherwise we would not be able to define which implementation
> > > > should be used. This is especially important when a patch is
> > > > removed and we need to fallback either to another patch or
> > > > original code. Yes, it makes perfect sense. But it needs code
> > > > that will check it, refuse loading the patch, ... It is not
> > > > complicated. But it is rather additional code than
> > > > simplification. I might make livepatching more safe
> > > > but probably not simplify the code.
> > > 
> > > We don't need to enforce that.  The func stack can stay.  If somebody
> > > wants to patch the same function multiple times (without using
> > > 'replace'), that's inadvisable, but it's also their business.  They're
> > > responsible for the tooling to ensure the patch stack order is sane.
> > 
> > 
> > While it might make sense to ignore the patch stack (ordering) for
> > the enable operation. Do we really want to ignore it when disabling
> > a patch.
> > 
> > By other words, do we want to allow disabling a patch that is in
> > the middle of the stack, only partly in use? Does not this allow
> > some other crazy scenarios? Is it really the user business?
> > Will it make our life easier?
> 
> If there's no longer a patch stack, then there's no concept of a middle.
> We would expect the patches to be independent of one another, and so
> disabling any of them independently would be harmless.
> 
> If any of the patches share a func, and the user disables one in the
> "middle", it's not our job to support that.  The vendor / patch author
> should prevent such cases from occurring with tooling, packaging,
> documentation, etc.  Or they can just use 'replace'.
> 
> We can already have similar unexpected situations today.  For example,
> what if patch B is a cumulative superset of patch A, but the user
> mistakenly loads patch A (without replace) *after* loading patch B?
> Then some unforeseen craziness could ensue.
> 
> We can't control all such scenarios (and that's ok), but we shouldn't
> pretend that we support them.

FWIW I agree with the above. Provided we keep the func stack.

[...]

> > The question is what to do with the stack of patches. It will have
> > no meaning for the enable operation because it will be done
> > automatically. But what about the disable/unregistrer operation?
> 
> Assuming we got rid of the patch stack, would we even need to keep a
> global list of patches anymore?

There are places we walk through the list of patches (klp_add_nops() in 
this patch set, klp_module_coming()), so probably yes.

Miroslav
