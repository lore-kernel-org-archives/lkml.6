Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A5BC46460
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 00:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 866F02239B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 00:56:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 866F02239B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fieldses.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbeHJDXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 23:23:51 -0400
Received: from fieldses.org ([173.255.197.46]:49490 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbeHJDXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 23:23:51 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 155CA3F4; Thu,  9 Aug 2018 20:56:26 -0400 (EDT)
Date:   Thu, 9 Aug 2018 20:56:26 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] fs/locks: change all *_conflict() functions to
 return a new enum.
Message-ID: <20180810005626.GC3915@fieldses.org>
References: <153378012255.1220.6754153662007899557.stgit@noble>
 <153378028114.1220.3708291796442871726.stgit@noble>
 <20180809130959.GH23873@fieldses.org>
 <87d0urrtvw.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d0urrtvw.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 09:40:35AM +1000, NeilBrown wrote:
> caller_fl is first and sys_fl is second.
> 
> if sys_fl, the second, is a read lock, and caller_fl, the first, is a
> write lock, they clearly conflict but any other lock that conflict
> with caller_fl (The write lock) would *not* necessarily conflict with
> the read lock.  So this situation is *not*  FL_TRANSITIVE_CONFLICT.
> 
> locks_conflict() only returns FL_TRANSITIVE_CONFLICT when sys_fl (the
> second) is a write lock, which it isn't in this case.  So I think that
> this case is handled correctly.
> posix_locks_conflict() will return FL_CONFLICT, but not
> FL_TRANSITIVE_CONFLICT.
> 
> Have I convinced you, or have I missed your point?

Eh, I was just confused.

And now I'm tempted to blame you for confusing me, but maybe that's just
my ego going defensive.

(My bruised ego suggests leaving locks_conflict and its callers alone,
and having an entirely separate function that checks this when we need
it.)

--b.
