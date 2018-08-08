Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED686C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 20:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B20CA21797
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 20:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B20CA21797
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fieldses.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731064AbeHHWa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 18:30:27 -0400
Received: from fieldses.org ([173.255.197.46]:47106 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729661AbeHHWa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 18:30:27 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 7AA083F4; Wed,  8 Aug 2018 16:09:12 -0400 (EDT)
Date:   Wed, 8 Aug 2018 16:09:12 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Wilck <mwilck@suse.de>
Subject: Re: [PATCH 0/4] locks: avoid thundering-herd wake-ups
Message-ID: <20180808200912.GE23873@fieldses.org>
References: <153369219467.12605.13472423449508444601.stgit@noble>
 <20180808195445.GD23873@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180808195445.GD23873@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 03:54:45PM -0400, J. Bruce Fields wrote:
> On Wed, Aug 08, 2018 at 11:51:07AM +1000, NeilBrown wrote:
> > If you have a many-core machine, and have many threads all wanting to
> > briefly lock a give file (udev is known to do this), you can get quite
> > poor performance.
> > 
> > When one thread releases a lock, it wakes up all other threads that
> > are waiting (classic thundering-herd) - one will get the lock and the
> > others go to sleep.
> > When you have few cores, this is not very noticeable: by the time the
> > 4th or 5th thread gets enough CPU time to try to claim the lock, the
> > earlier threads have claimed it, done what was needed, and released.
> > With 50+ cores, the contention can easily be measured.
> > 
> > This patchset creates a tree of pending lock request in which siblings
> > don't conflict and each lock request does conflict with its parent.
> > When a lock is released, only requests which don't conflict with each
> > other a woken.
> 
> Are you sure you aren't depending on the (incorrect) assumption that "X
> blocks Y" is a transitive relation?
> 
> OK I should be able to answer that question myself, my patience for
> code-reading is at a real low this afternoon....

In other words, is there the possibility of a tree of, say, exclusive
locks with (offset, length) like:

	(0, 2) waiting on (1, 2) waiting on (2, 2) waiting on (0, 4)

and when waking (0, 4) you could wake up (2, 2) but not (0, 2), leaving
a process waiting without there being an actual conflict.

--b.
