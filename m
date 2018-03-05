Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964819AbeCEMyp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 07:54:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:38536 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934693AbeCEMym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 07:54:42 -0500
Date: Mon, 5 Mar 2018 13:54:38 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Evgenii Shatokhin <eshatokhin@virtuozzo.com>
cc: Petr Mladek <pmladek@suse.com>, Jason Baron <jbaron@akamai.com>,
        Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/8] livepatch: Atomic replace feature
In-Reply-To: <5c956014-b717-aed8-de1b-58967ef835c6@virtuozzo.com>
Message-ID: <alpine.LSU.2.21.1803051352300.26605@pobox.suse.cz>
References: <20180221132914.4809-1-pmladek@suse.com> <5c956014-b717-aed8-de1b-58967ef835c6@virtuozzo.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Mar 2018, Evgenii Shatokhin wrote:

> Hi,

Hi,
 
> > The atomic replace allows to create cumulative patches. They
> > are useful when you maintain many livepatches and want to remove
> > one that is lower on the stack. In addition it is very useful when
> > more patches touch the same function and there are dependencies
> > between them.
> 
> I have experimented with this updated patchset a bit.
> It looks like replace operation fails if there is a loaded but disabled patch.
> 
> Suppose there are 2 binary patches changing the same kernel functions. Load
> patch1, then disable it (echo 0 > /sys/kernel/livepatch/patch1/enabled), then
> try load patch2 with atomic replace. I get "Device or resource busy" error at
> this point.
> 
> It seems, __klp_enable_patch() returns -EBUSY for some reason. I haven't dug
> deeper into that code yet.

Yes, it is "enforce stacking" check in __klp_enable_patch():

        /* enforce stacking: only the first disabled patch can be enabled */
        if (patch->list.prev != &klp_patches &&
            !list_prev_entry(patch, list)->enabled)
                return -EBUSY;

So not connected to this patch set. We've had the behaviour for quite some 
time.

Miroslav
 
> A workaround is simple: just unload all disabled patches before trying to load
> patch2 with replace. Still, the behavior is quite strange.
