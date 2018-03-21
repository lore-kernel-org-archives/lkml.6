Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752454AbeCUNYI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 09:24:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:45696 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751899AbeCUNXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 09:23:51 -0400
Date: Wed, 21 Mar 2018 14:05:14 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@redhat.com>
cc: Petr Mladek <pmladek@suse.com>, Jiri Kosina <jikos@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Nicolai Stange <nstange@suse.de>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] livepatch: Allow to unregister or free shadow data
 using a custom function
In-Reply-To: <20180314193217.jl2pkzikzrk7wgpz@treble>
Message-ID: <alpine.LSU.2.21.1803211404010.19993@pobox.suse.cz>
References: <20180313155448.1998-1-pmladek@suse.com> <20180313155448.1998-3-pmladek@suse.com> <20180314193217.jl2pkzikzrk7wgpz@treble>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Mar 2018, Josh Poimboeuf wrote:

> On Tue, Mar 13, 2018 at 04:54:48PM +0100, Petr Mladek wrote:
> > We might need to do some actions before the shadow variable is freed.
> > For example, we might need to remove it from a list or free some data
> > that it points to.
> > 
> > This is already possible now. The user can get the shadow variable
> > by klp_shadow_get(), do the necessary actions, and then call
> > klp_shadow_free().
> > 
> > This patch allow to do this a more elegant way. The user could implement
> > the needed actions in a callback that is passed to klp_shadow_free()
> > as a parameter. The callback usually does reverse operations to
> > the init_func that can be called by klp_shadow_*alloc().
> > 
> > It is especially useful for klp_shadow_free_all(). There we need to do
> > these extra actions for each found shadow variable with the given ID.
> > 
> > Note that the memory used by the shadow variable itself is still released
> > later by rcu callback. It is needed to protect internal structures that
> > keep all shadow variables. But free_func is called immediately. The shadow
> > variable must not be access anyway after klp_shadow_free() is called.
> > The user is responsible to protect this any suitable way.
> > 
> > Be aware that free_func callback is called under klp_shadow_lock. It is
> > the same as for init_func in klp_shadow_alloc().
> > 
> > Signed-off-by: Petr Mladek <pmladek@suse.com>
> 
> Makes sense, though I'm not sure "free" is the right name:
> 
>   a) "free" isn't the opposite of "init"; and
> 
>   b) it may be used for things other than freeing.
>   
> Shall we call them constructor/destructor?

Agreed. _ctor/_dtor both sound better.

Miroslav
