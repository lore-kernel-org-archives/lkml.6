Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA366C4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 13:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C7E21A10
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 13:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFZ3DmIR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87C7E21A10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbeHKPth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 11:49:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727324AbeHKPth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 11:49:37 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79E2C21A05;
        Sat, 11 Aug 2018 13:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533993327;
        bh=IB9r6NfiKuWoWH0IDGX2zy9hq2ehfkTcWQLxM4zy248=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mFZ3DmIR0xM0J0VJkNdnKx/524vi1Yd5ntoGORI6CreUdaTo/K+OP6o4hpxbvULlR
         WNl0p687SEa/a0PHd+iGGFk/RrHze5BVAtpb9H2RGahEAnyTZIRb+R8y8oPaIlqKy2
         brEzs8UupDfPPrb+jctCU91NAwfTkJHfbFgZebHY=
Message-ID: <68c41d01959f2a8e3bb42483935865ff21e4af75.camel@kernel.org>
Subject: Re: [PATCH 0/5 - V2] locks: avoid thundering-herd wake-ups
From:   Jeff Layton <jlayton@kernel.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     NeilBrown <neilb@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Date:   Sat, 11 Aug 2018 09:15:25 -0400
In-Reply-To: <20180811122150.GA15848@fieldses.org>
References: <153378012255.1220.6754153662007899557.stgit@noble>
         <20180809173245.GM23873@fieldses.org>
         <87lg9frxyc.fsf@notabene.neil.brown.name>
         <20180810002922.GA3915@fieldses.org>
         <f1b9ca11a26eafbeb348bbfdf12d2ccdd43dc3c9.camel@kernel.org>
         <20180811122150.GA15848@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-08-11 at 08:21 -0400, J. Bruce Fields wrote:
> On Sat, Aug 11, 2018 at 07:51:13AM -0400, Jeff Layton wrote:
> > On Thu, 2018-08-09 at 20:29 -0400, J. Bruce Fields wrote:
> > > On Fri, Aug 10, 2018 at 08:12:43AM +1000, NeilBrown wrote:
> > > > On Thu, Aug 09 2018, J. Bruce Fields wrote:
> > > > 
> > > > > I think there's also a problem with multiple tasks sharing the same
> > > > > lock owner.
> > > > > 
> > > > > So, all locks are exclusive locks for the same range.  We have four
> > > > > tasks.  Tasks 1 and 4 share the same owner, the others' owners are
> > > > > distinct.
> > > > > 
> > > > > 	- Task 1 gets a lock.
> > > > > 	- Task 2 gets a conflicting lock.
> > > > > 	- Task 3 gets another conflicting lock.  So now we the tree is
> > > > > 		3->2->1.
> > > > > 	- Task 1's lock is released.
> > > > > 	- Before task 2 is scheduled, task 4 acquires a new lock.
> > > > > 	- Task 2 waits on task 4's lock, we now have
> > > > > 		3->2->4.
> > > > > 
> > > > > Task 3 shouldn't be waiting--the lock it's requesting has the same owner
> > > > > as the lock task 4 holds--but we fail to wake up task 3.
> > > > 
> > > > So task 1 and task 4 are threads in the one process - OK.
> > > > Tasks 2 and 3 are threads in two other processes.
> > > > 
> > > > So 2 and 3 conflict with either 1 or 4 equally - why should task 3 be
> > > > woken?
> > > > 
> > > > I suspect you got the numbers bit mixed up,
> > > 
> > > Whoops.
> > > 
> > > > but in any case, the "conflict()" function that is passed around takes
> > > > ownership into account when assessing if one lock conflicts with
> > > > another.
> > > 
> > > Right, I know, but, let me try again:
> > > 
> > > All locks are exclusive locks for the same range.  Only tasks 3 and 4
> > > share the the same owner.
> > > 
> > > 	- Task 1 gets a lock.
> > > 	- Task 2 requests a conflicting lock, so we have    2->1.
> > > 	- Task 3 requests a conflicting lock, so we have 3->2->1.
> > > 	- Task 1 unlocks.  We wake up task 2, but it isn't scheduled yet.
> > > 	- Task 4 gets a new lock.
> > > 	- Task 2 runs, discovers the conflict, and waits.  Now we have:
> > > 		3->2->4.
> > > 
> > > There is no conflict between the lock 3 requested and the lock 4 holds,
> > > but 3 is not woken up.
> > > 
> > > This is another version of the first problem: there's information we
> > > need (the owners of the waiting locks in the tree) that we can't
> > > determine just from looking at the root of the tree.
> > > 
> > > I'm not sure what to do about that.
> > > 
> > 
> > Is this still a problem in the v2 set?
> > 
> > wake_non_conflicts walks the whole tree of requests that were blocked on
> > it,
> 
> Not in the FL_TRANSITIVE_CONFLICT case, which is the case here.
> 

Got it. Yeah, I'm not sure that the idea of FL_TRANSITIVE_CONFLICT
really works. I think you could fix this by just getting rid of that and
folding it into the FL_CONFLICT case.

In more complex situations (like the one you describe), you may end up
cycling through several blocked requests before you hit one that can get
the lock. It may slow things down some for those cases. In the more
common locking scenarios (whole file locks, different owners), I think
this will be much more efficient by avoiding so many wakeups.

-- 
Jeff Layton <jlayton@kernel.org>

