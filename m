Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AD2C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5780621B31
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAurSwU2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5780621B31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731293AbeHIBL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 21:11:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:59380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727530AbeHIBL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 21:11:57 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D68221A86;
        Wed,  8 Aug 2018 22:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533768609;
        bh=BJPE6ZLt0v2ZuoQxn8+/w0W5p/nDn1Jg+smoOjFnCGg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=PAurSwU2l/rMH6P0OM3ahhQ9jvPMihnxWVLEM1lRxieuvHpLra5jZ8ZikPP5VV2uI
         do2SDTMlMKCqOhVG9p2FjUArir0+Ic39CdmZnT9LX/bQqWK8xMQNMM6T7HSEMSVF9m
         HK66nO/Z1sCHjj7VNTAyKaS5usQaZx+gz2YdqbbI=
Message-ID: <04ffa27c29d2bff8bd9cb9b6d4ea6b6fd3969b6c.camel@kernel.org>
Subject: Re: [PATCH 0/4] locks: avoid thundering-herd wake-ups
From:   Jeff Layton <jlayton@kernel.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        NeilBrown <neilb@suse.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Wilck <mwilck@suse.de>
Date:   Wed, 08 Aug 2018 18:50:06 -0400
In-Reply-To: <20180808212832.GF23873@fieldses.org>
References: <153369219467.12605.13472423449508444601.stgit@noble>
         <20180808195445.GD23873@fieldses.org> <20180808200912.GE23873@fieldses.org>
         <20180808212832.GF23873@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-08 at 17:28 -0400, J. Bruce Fields wrote:
> On Wed, Aug 08, 2018 at 04:09:12PM -0400, J. Bruce Fields wrote:
> > On Wed, Aug 08, 2018 at 03:54:45PM -0400, J. Bruce Fields wrote:
> > > On Wed, Aug 08, 2018 at 11:51:07AM +1000, NeilBrown wrote:
> > > > If you have a many-core machine, and have many threads all wanting to
> > > > briefly lock a give file (udev is known to do this), you can get quite
> > > > poor performance.
> > > > 
> > > > When one thread releases a lock, it wakes up all other threads that
> > > > are waiting (classic thundering-herd) - one will get the lock and the
> > > > others go to sleep.
> > > > When you have few cores, this is not very noticeable: by the time the
> > > > 4th or 5th thread gets enough CPU time to try to claim the lock, the
> > > > earlier threads have claimed it, done what was needed, and released.
> > > > With 50+ cores, the contention can easily be measured.
> > > > 
> > > > This patchset creates a tree of pending lock request in which siblings
> > > > don't conflict and each lock request does conflict with its parent.
> > > > When a lock is released, only requests which don't conflict with each
> > > > other a woken.
> > > 
> > > Are you sure you aren't depending on the (incorrect) assumption that "X
> > > blocks Y" is a transitive relation?
> > > 
> > > OK I should be able to answer that question myself, my patience for
> > > code-reading is at a real low this afternoon....
> > 
> > In other words, is there the possibility of a tree of, say, exclusive
> > locks with (offset, length) like:
> > 
> > 	(0, 2) waiting on (1, 2) waiting on (2, 2) waiting on (0, 4)
> > 
> > and when waking (0, 4) you could wake up (2, 2) but not (0, 2), leaving
> > a process waiting without there being an actual conflict.
> 
> After batting it back and forth with Jeff on IRC....  So do I understand
> right that when we wake a waiter, we leave its own tree of waiters
> intact, and when it wakes if it finds a conflict it just adds it lock
> (with tree of waiters) in to the tree of the conflicting lock?
> 
> If so then yes I think that depends on the transitivity
> assumption--you're assuming that finding a conflict between the root of
> the tree and a lock proves that all the other members of the tree also
> conflict.
> 
> So maybe this example works.  (All locks are exclusive and written
> (offset, length), X->Y means X is waiting on Y.)
> 
> 	process acquires (0,3)
> 	2nd process requests (1,2), is put to sleep.
> 	3rd process requests (0,2), is put to sleep.
> 
> 	The tree of waiters now looks like (0,2)->(1,2)->(0,3)
> 
> 	(0,3) is unlocked.
> 	A 4th process races in and locks (2,2).
> 	The 2nd process wakes up, sees this new conflict, and waits on
> 	(2,2).  Now the tree looks like (0,2)->(1,2)->(2,2), and (0,2)
> 	is waiting for no reason.
> 

That seems like a legit problem.

One possible fix might be to have the waiter on (1,2) walk down the
entire subtree and wake up any waiter that is waiting on a lock that
doesn't conflict with the lock on which it's waiting.

So, before the task waiting on 1,2 goes back to sleep to wait on 2,2, it
could walk down its entire fl_blocked subtree and wake up anything
waiting on a lock that doesn't conflict with (2,2).

That's potentially an expensive operation, but:

a) the task is going back to sleep anyway, so letting it do a little
extra work before that should be no big deal

b) it's probably still cheaper than waking up the whole herd

-- 
Jeff Layton <jlayton@kernel.org>

