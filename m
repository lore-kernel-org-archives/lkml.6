Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753124AbeCXVsu (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 17:48:50 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43008 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752900AbeCXVst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 17:48:49 -0400
Date: Sat, 24 Mar 2018 21:48:45 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Aleksa Sarai <asarai@suse.de>, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org
Subject: Re: [PATCH 1/2] fs: Extend mount_ns with support for a fast
 namespace to vfsmount function
Message-ID: <20180324214845.GM30522@ZenIV.linux.org.uk>
References: <20180323060457.sxgsd3j2obi33fyw@gordon>
 <87k1u3ti9e.fsf@xmission.com>
 <87fu4qo4ff.fsf_-_@xmission.com>
 <20180323231511.GK30522@ZenIV.linux.org.uk>
 <87in9ljvvx.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87in9ljvvx.fsf@xmission.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 24, 2018 at 11:12:02AM -0500, Eric W. Biederman wrote:

> > This is completely wrong.  Look:
> > 	* SB_KERNMOUNT and !SB_KERNMOUNT cases are almost entirely isolated;
> > completely so once that ns_to_mnt becomes unconditionally non-NULL.  
> > 	* in !SB_KERNMOUNT passing ns_to_mnt() is pointless - you might as
> > well pass existing vfsmount (or ERR_PTR()) and use _that_.  fill_super()
> > is not used at all in that case.
> > 	* is SB_KERNMOUNT ns_to_mnt serves only as a flag, eventually
> > constant true.
> >
> > So let's split it in two helpers and give them sane arguments.
> 
> Everything I look at with multiple helpers feels even worse to me.
> The above has the advantage it is the minimal change to fix the
> regression.  So I am not worried about code correctness.

> I keep wondering is the intention long term to fix sget so it has an
> efficient data structure for finding super blocks (like an rbtree) or if
> the intention is to deprecate sget entirely and just have everything
> call alloc_super, and be responsible for their own data structures for
> finding existing superblocks.
>
> At this point since we are not in agreement on a proper fix I am going
> to plan on just queueing up a revert.   So that we don't ship 4.16 with
> a regression in a permission check.

Permission check is trivial to put back in; I'll do that.

FWIW, I don't believe that sget_userns() is a good place for any kind of
universal permission checks.  It's a library helper, not a place everything
must come through when mounting something.  So's mount_ns(), etc.

BTW, will you be at LSF?  I would suggest discussing the architectural
issues there - they are directly related to fsmount() proposals...
