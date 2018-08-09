Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4352C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 13:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7884921D6A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 13:00:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7884921D6A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fieldses.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732006AbeHIPYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 11:24:52 -0400
Received: from fieldses.org ([173.255.197.46]:48322 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727786AbeHIPYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 11:24:51 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 4B4331E3D; Thu,  9 Aug 2018 09:00:01 -0400 (EDT)
Date:   Thu, 9 Aug 2018 09:00:01 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     NeilBrown <neilb@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Wilck <mwilck@suse.de>
Subject: Re: [PATCH 0/4] locks: avoid thundering-herd wake-ups
Message-ID: <20180809130001.GG23873@fieldses.org>
References: <153369219467.12605.13472423449508444601.stgit@noble>
 <20180808195445.GD23873@fieldses.org>
 <20180808200912.GE23873@fieldses.org>
 <20180808212832.GF23873@fieldses.org>
 <04ffa27c29d2bff8bd9cb9b6d4ea6b6fd3969b6c.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04ffa27c29d2bff8bd9cb9b6d4ea6b6fd3969b6c.camel@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 06:50:06PM -0400, Jeff Layton wrote:
> That seems like a legit problem.
> 
> One possible fix might be to have the waiter on (1,2) walk down the
> entire subtree and wake up any waiter that is waiting on a lock that
> doesn't conflict with the lock on which it's waiting.
> 
> So, before the task waiting on 1,2 goes back to sleep to wait on 2,2, it
> could walk down its entire fl_blocked subtree and wake up anything
> waiting on a lock that doesn't conflict with (2,2).
> 
> That's potentially an expensive operation, but:
> 
> a) the task is going back to sleep anyway, so letting it do a little
> extra work before that should be no big deal

I don't understand why cpu used by a process going to sleep is cheaper
than cpu used in any other situation.

> b) it's probably still cheaper than waking up the whole herd

Yeah, I'd like to understand this.

I feel like Neil's addressing two different performance costs:

	- the cost of waking up all the waiters
	- the cost of walking the list of waiters

Are they equally important?

If we only cared about the former, and only in simple cases, we could
walk the entire list and skip waking up only the locks that conflict
with the first one we wake.  We wouldn't need the tree.

--b.
