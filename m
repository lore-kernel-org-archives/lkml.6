Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751459AbeCNTol (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 15:44:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39480 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750779AbeCNToj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 15:44:39 -0400
Date: Wed, 14 Mar 2018 14:44:36 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Petr Mladek <pmladek@suse.com>, Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, Jessica Yu <jeyu@kernel.org>,
        Nicolai Stange <nstange@suse.de>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] livepatch: Initialize shadow variables by init
 function safely
Message-ID: <20180314194436.fl5xro6aixroqzxk@treble>
References: <20180313155448.1998-1-pmladek@suse.com>
 <20180313155448.1998-2-pmladek@suse.com>
 <20180314192702.h6fvqoo7myt426ww@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180314192702.h6fvqoo7myt426ww@redhat.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 03:27:02PM -0400, Joe Lawrence wrote:
> On Tue, Mar 13, 2018 at 04:54:47PM +0100, Petr Mladek wrote:
> > The existing API allows to pass a sample data to initialize the shadow
> > data. It works well when the data are position independent. But it fails
> > miserably when we need to set a pointer to the shadow structure itself.
> > 
> > Unfortunately, we might need to initialize the pointer surprisingly
> > often because of struct list_head. It is even worse because the list
> > might be hidden in other common structures, for example, struct mutex,
> > struct wait_queue_head.
> > 
> > This patch makes the API more safe. A custom init function and data
> > are passed to klp_shadow_*alloc() functions instead of the sample data.
> 
> Yup, this looks kinda familiar, I remember tinkering with the same idea
> last year [1] before settling on the simpler API.
> 
> [1] https://github.com/torvalds/linux/compare/master...joe-lawrence:shadow_variables_v2_c
> 
> > Note that the init_data are not longer a template for the shadow->data.
> > It might point to any data that might be necessary when the init
> > function is called.
> 
> I'm not opposed to changing the API, but I was wondering if you had
> thought about expanding it as an alternative? 
> 
> When working on this last summer, I remember holding onto to some less
> than intuitive naming conventions so that I could support a basic API
> and an extended API with bells and whistles like this patchset
> implements.  It didn't seem too difficult to layer the basic API ontop
> of one like this (see [1] for example), so maybe that's an option to
> keep basic shadow variable usage a little simpler.  /two cents

I like Petr's new API.  It's not a big deal to just pass a couple of
NULLs if you don't need the callback.

And I prefer fewer functions anyway -- maybe it's my functionitis
allergies acting up again.

> Perhaps shadow variables are another candidate for some kind of
> kselftest?

Indeed!

-- 
Josh
