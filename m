Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32CFC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 03:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F3120855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 03:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1F3120855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fieldses.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbeKIMuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 07:50:14 -0500
Received: from fieldses.org ([173.255.197.46]:39504 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727238AbeKIMuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 07:50:14 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id 93ED21E29; Thu,  8 Nov 2018 22:11:38 -0500 (EST)
Date:   Thu, 8 Nov 2018 22:11:38 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] fs/locks: rename some lists and pointers.
Message-ID: <20181109031138.GB8831@fieldses.org>
References: <154138128401.31651.1381177427603557514.stgit@noble>
 <154138144767.31651.11225349164396042986.stgit@noble>
 <20181108202659.GD6090@fieldses.org>
 <87muqjw0of.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87muqjw0of.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 11:32:16AM +1100, NeilBrown wrote:
> On Thu, Nov 08 2018, J. Bruce Fields wrote:
> 
> > On Mon, Nov 05, 2018 at 12:30:47PM +1100, NeilBrown wrote:
> >> struct file lock contains an 'fl_next' pointer which
> >> is used to point to the lock that this request is blocked
> >> waiting for.  So rename it to fl_blocker.
> >> 
> >> The fl_blocked list_head in an active lock is the head of a list of
> >> blocked requests.  In a request it is a node in that list.
> >> These are two distinct uses, so replace with two list_heads
> >> with different names.
> >> fl_blocked is the head of a list of blocked requests
> >> fl_block is a node on that list.
> >
> > Reading these, I have a lot of trouble keeping fl_blocked, fl_block, and
> > fl_blocker straight.  Is it just me?
> 
> "Naming is hard" - but that is no excuse.
> I suspect it isn't just you.
> 
> I particularly like "fl_blocker".
> 
> 		error = wait_event_interruptible(fl->fl_wait, !fl->fl_blocker);
> 
> reads well to me - wait until this lock has a no blocker - i.e. until
> nothing blocks it.
> 
> fl_blocked could be fl_blockees (the things that I block), but I doubt
> that is an improvement.

Maybe.  The plural might help me remember that it's the head of a list?

> > I guess they form a tree, so fl_children, fl_siblings, and fl_parent
> > might be easier for me to keep straight.
> 
> This requires one to know a priori that the tree records which locks
> block which requests, which is obvious to us now, but might not be so
> obvious in 5 years time when we look at this code again.
> 
> An I have never really liked the "siblings" naming. 'struct dentry' uses
> "d_child", which is possibly ever more confusing.
> I would like it to be obvious that this is a list-member, not a
> list-head.  Rusty once posted patches to allow the list head to be a
> different type to the members, but that fell on deaf ears.
> So
>    fl_blocked_member
> might be an improvement - this is a member of the fl_blocked list.
> It would be easier to search for than fl_block - which needs
> fl_block[^a-z] to avoid false positives.

Yeah, maybe, if it's not too long.

> I'd be quite happy to change fl_block is any two people can agree on a
> better name.  I'm less inclined to change the others without a really
> good proposal.
> 
> Hmmm. what is the inverse of "Block"?  If I block you then you ....  I
> know, you are a usurper.
> So
>   fl_blocker points to the "parent"
>   fl_usurpers is a list of "children"
>   fl_usurpers_member is my linkage in that list.
> or not.

"Usurper" isn't doing it for me.

Yeah, I've got no clever scheme.

--b.
