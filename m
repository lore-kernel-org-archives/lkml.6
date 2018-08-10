Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E26C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 02:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65A70223B7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 02:52:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65A70223B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fieldses.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeHJFUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 01:20:39 -0400
Received: from fieldses.org ([173.255.197.46]:49666 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725725AbeHJFUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 01:20:39 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 7AD663F4; Thu,  9 Aug 2018 22:52:51 -0400 (EDT)
Date:   Thu, 9 Aug 2018 22:52:51 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5 - V2] locks: avoid thundering-herd wake-ups
Message-ID: <20180810025251.GO23873@fieldses.org>
References: <153378012255.1220.6754153662007899557.stgit@noble>
 <20180809173245.GM23873@fieldses.org>
 <87lg9frxyc.fsf@notabene.neil.brown.name>
 <20180810002922.GA3915@fieldses.org>
 <871sb7rnul.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871sb7rnul.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 11:50:58AM +1000, NeilBrown wrote:
> You're good at this game!

Everybody's got to have a hobby, mine is pathological posix locking
cases....

> So, because a locker with the same "owner" gets a free pass, you can
> *never* say that any lock which conflicts with A also conflicts with B,
> as a lock with the same owner as B will never conflict with B, even
> though it conflicts with A.
> 
> I think there is still value in having the tree, but when a waiter is
> attached under a new blocker, we need to walk the whole tree beneath the
> waiter and detach/wake anything that is not blocked by the new blocker.

If you're walking the whole tree every time then it might as well be a
flat list, I think?

--b.
