Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B63C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EDDE21EFC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:32:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EDDE21EFC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fieldses.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732658AbeHIT6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 15:58:38 -0400
Received: from fieldses.org ([173.255.197.46]:48832 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730839AbeHIT6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 15:58:37 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id CD5C81E3A; Thu,  9 Aug 2018 13:32:45 -0400 (EDT)
Date:   Thu, 9 Aug 2018 13:32:45 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5 - V2] locks: avoid thundering-herd wake-ups
Message-ID: <20180809173245.GM23873@fieldses.org>
References: <153378012255.1220.6754153662007899557.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153378012255.1220.6754153662007899557.stgit@noble>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think there's also a problem with multiple tasks sharing the same
lock owner.

So, all locks are exclusive locks for the same range.  We have four
tasks.  Tasks 1 and 4 share the same owner, the others' owners are
distinct.

	- Task 1 gets a lock.
	- Task 2 gets a conflicting lock.
	- Task 3 gets another conflicting lock.  So now we the tree is
		3->2->1.
	- Task 1's lock is released.
	- Before task 2 is scheduled, task 4 acquires a new lock.
	- Task 2 waits on task 4's lock, we now have
		3->2->4.

Task 3 shouldn't be waiting--the lock it's requesting has the same owner
as the lock task 4 holds--but we fail to wake up task 3.

--b.
