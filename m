Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426983AbeCBLLV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 06:11:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:38905 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423519AbeCBLLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 06:11:13 -0500
Date: Fri, 2 Mar 2018 12:11:11 +0100
From: Petr Mladek <pmladek@suse.com>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Miroslav Benes <mbenes@suse.cz>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Jessica Yu <jeyu@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>
Subject: Re: [PATCH v0 2/3] livepatch: update documentation/samples for
 callbacks
Message-ID: <20180302111111.f6tt2rnwa4nnbswh@pathway.suse.cz>
References: <1519421630-12025-1-git-send-email-joe.lawrence@redhat.com>
 <1519421630-12025-3-git-send-email-joe.lawrence@redhat.com>
 <alpine.LSU.2.21.1802271324370.19255@pobox.suse.cz>
 <f87dbd4e-7262-5c90-0a5f-a54e4d0af20d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f87dbd4e-7262-5c90-0a5f-a54e4d0af20d@redhat.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-02-27 09:58:40, Joe Lawrence wrote:
> On 02/27/2018 07:36 AM, Miroslav Benes wrote:
> > On Fri, 23 Feb 2018, Joe Lawrence wrote:
> > 
> >> [ ... snip ... ]
> >>  
> >> +If a livepatch is replaced by a cumulative patch, then only the
> >> +callbacks belonging to the cumulative patch will be executed.  This
> >> +simplifies the livepatching core for it is the responsibility of the
> >> +cumulative patch to safely revert whatever needs to be reverted.  See
> >> +Documentation/livepatch/cumulative.txt for more information on such
> >> +patches.
> > 
> > s/cumulative/atomic replace/ almost everywhere?
> > 
> > 'Documentation/livepatch/cumulative.txt' should be 
> > 'Documentation/livepatch/cumulative-patches.txt' and we may rename it 
> > atomic-replace-patches.txt. I don't know. Cumulative patches forms a 
> > subset of atomic replace patches in my understanding. The feature itself 
> > is more general. Even if practically used for cumulative patches only. But 
> > it is for you and Petr to decide.
> 
> Hi Miroslav,
> 
> Thanks for reviewing!
> 
> I guess I'm a little confused about the distinction here.
> 
> I understood a "cumulative-patch" to mean that it would contain the sum
> of all changes.  So instead of this:
> 
>   patch 1 = A
> + patch 2 =     B
> + patch 3 =         C
> -----------------------
>   net     = A + B + C
> 
> We can group all of the changes together into a single cumulative-patch
> for the same net effect:
> 
>   patch 1 = A               -replaced by-
>   patch 2 = A + B             -replaced by-
>   patch 3 = A + B + C
> 
> I assumed this would also mean to include any reverted changes as well.
> So in the example above, if change C needed to be reverted, then:
> 
>   patch 4 = A + B
> 
> and that would still be considered a "cumulative-patch".

Yes, I would consider this a cumulative patch.


> In my mind, atomic replace is the mechanism that forces patching to be
> cumulative.  Perhaps this is too strict?  Are there other use-cases for
> atomic-replace?

Jason talked about using the atomic replace to get rid of any
existing livepatches and adding another changes instead. The changes
in the old and the new patch might be unrelated. They simply do
not want to mind what was there before. The term "atomic replace"
fits perfectly for this usecase.

My understanding is that cumulative patches do similar thing.
But the old and new patches should be related. In particular,
any new patch should include most changes from the older one.
The only exception is when an old change was wrong and we do
not want it anymore.

Now, your examples are close the the Jason's use case. They
do:

  patch1 = A         -replaced by-
  patch2 =    B
------------------
  result      B

I mean that one change is replaced by an "unrelated" one.
It might confuse people. They might ask why the new patch
is called cumulative when all the older changes are lost.

I would suggest to rename the sample patch to livepatch-test-replace
or so. Also I would try to avoid the world cumulative in the example
to avoid confusion.

I still would prefer to keep the documentation for the feature
called cumulative-patches.txt. From my point of view, the atomic
replace is rather a technical detail. It might be dangerous when
used for non-related patches. On the other, cumulative patches
seem to be a promising way how to keep livepatches maintainable
and safe.

Best Regards,
Petr

PS: I did not added these patches to v9 of the atomic replace
patchset. It was already big enough. And I hope that v9 might
be final. In addition, there are no conflicts on the touched
files side.

In each case, thanks a lot for these nice examples
and for finding the bug.
