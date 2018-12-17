Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F5BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 23:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5BFE2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 23:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbeLQXKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 18:10:10 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:34560 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeLQXKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 18:10:10 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gZ21Q-0000UP-UN; Mon, 17 Dec 2018 23:10:01 +0000
Date:   Mon, 17 Dec 2018 23:10:00 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Steven Whitehouse <swhiteho@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [git pull] mount API series
Message-ID: <20181217231000.GA30610@ZenIV.linux.org.uk>
References: <20181031053355.GQ32577@ZenIV.linux.org.uk>
 <87a7mut9cm.fsf@xmission.com>
 <2f4a2d58-dc7b-3a8f-65aa-9db432ce0a1e@redhat.com>
 <877ehjkq07.fsf@xmission.com>
 <20181112205439.GF32577@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112205439.GF32577@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 08:54:39PM +0000, Al Viro wrote:
> On Sun, Nov 11, 2018 at 08:07:20PM -0600, Eric W. Biederman wrote:
> > Steven Whitehouse <swhiteho@redhat.com> writes:
> 
> > > Can you share some details of what this NULL dereference is? David and
> > > Al have been working on the changes as requested by Linus later in
> > > this thread, and they'd like to tidy up this issue too at the same
> > > time if possible. We are not asking you to actually provide a fix, in
> > > case you are too busy to do so, however it would be good to know what
> > > the issue is so that we can make sure that it is resolved in the next
> > > round of patches,
> > 
> > https://lore.kernel.org/lkml/87bm7n5k1r.fsf@xmission.com/
> 
> Thought it had been dealt with, but you are right - oops is still there
> and obviously needs fixing.  However, looking at that place in mainline...
> How does that thing manage to work?  Look:
>         /* Notice when we are propagating across user namespaces */
>         if (m->mnt_ns->user_ns != user_ns)
>                 type |= CL_UNPRIVILEGED;
>         child = copy_tree(last_source, last_source->mnt.mnt_root, type);
>         if (IS_ERR(child))
>                 return PTR_ERR(child);
>         child->mnt.mnt_flags &= ~MNT_LOCKED;
>         mnt_set_mountpoint(m, mp, child);
>         last_dest = m;
>         last_source = child;
> OK, we'd created the copy to be attached to the next candidate mountpoint.
> If we have e.g. a 4-element peer group, we'll start with what we'd been
> asked to mount, then call that sucker three times, getting a copy for
> each of those mountpoints.  Right?  Now, what happens if the 1st, 3rd and
> 4th members live in your namespace, with the second one being elsewhere?
> We have
> 	source_mnt: that'll go on top of the 1st mountpoint
> 	copy of source_mnt: that'll go on top of the 2nd mountpoint
> 	copy of copy of source_mnt: that'll go on top of the 3rd mountpoint
> 	copy of copy of copy of source_mnt: that'll go on top of the 4th one
> And AFAICS your logics there has just made sure that everything except the
> source_mnt will have MNT_LOCK_... all over the place.  IOW, the effect of
> CL_UNPRIVELEGED is cumulative.
> 
> How the hell does that code avoid this randomness?  Note had the members of
> that peer group been in a different order, you would've gotten a different result.
> What am I missing here?
> 
> Oops is a separate story, and a regression in its own right; it needs to be
> fixed.  But I would really like to sort out the semantics of the existing
> code in that area, so that we don't end up with patch conflicts.

Ping?

FWIW, I don't believe that CL_UNPRIVELEGED approach is workable; the logics
we want is, AFAICS, "when destination is not yours, whatever you attach to
it should be all locked".  Correct?

If so, the natural place to deal with that would be in commit_tree() after
propagate_mnt() has created all copies, not while creating those copies.
That, after all, is where we mark all those struct mount as belonging to
namespace...

Again, this is quite independent from the oops you've reported (and that,
BTW, can be triggered without any userns involvement - commit_tree() itself
will oops just fine if parent's ->mnt_ns is NULL, userns or no userns).
I think I understand how to deal with that thing, but it's a separate
story; handling of MNT_LOCK... is a problem that exists in the mainline
and whatever fix we come up with for this one will need to be backportable.

Al "resurfaced from long and thoroughly nasty dive through the LSM gutter
and finally getting around to more pleasant stuff" Viro
