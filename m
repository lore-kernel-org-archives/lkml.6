Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BDEC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B50421A33
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yavo2PGd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B50421A33
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbeHHTHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 15:07:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:56178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbeHHTHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 15:07:55 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DAD321A32;
        Wed,  8 Aug 2018 16:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533746844;
        bh=0m5imcOdgFyRwFXCgeEsLJbS+YW/T8BXC6kvFCX4kv8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Yavo2PGd7mVR2+w3MWWO4Txgc/Y1Lb3dGwNxFMZwWIKTql0BCYfRegYYH1og0R5mq
         w1vOznk0zWzAn7qKCKIiTnyZ+UdMOhDc0JtDRrO0h4ok87QNysR1cv6HyMO8psBFz0
         O4bpGK3UB0JANOIkMYRkvSea7/Y1kpcOOrPnLQ9o=
Message-ID: <ea503e6a6f26dfb344fda02c765ae87de65ed025.camel@kernel.org>
Subject: Re: [PATCH 0/4] locks: avoid thundering-herd wake-ups
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Wilck <mwilck@suse.de>
Date:   Wed, 08 Aug 2018 12:47:22 -0400
In-Reply-To: <153369219467.12605.13472423449508444601.stgit@noble>
References: <153369219467.12605.13472423449508444601.stgit@noble>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-08 at 11:51 +1000, NeilBrown wrote:
> If you have a many-core machine, and have many threads all wanting to
> briefly lock a give file (udev is known to do this), you can get quite
> poor performance.
> 
> When one thread releases a lock, it wakes up all other threads that
> are waiting (classic thundering-herd) - one will get the lock and the
> others go to sleep.
> When you have few cores, this is not very noticeable: by the time the
> 4th or 5th thread gets enough CPU time to try to claim the lock, the
> earlier threads have claimed it, done what was needed, and released.
> With 50+ cores, the contention can easily be measured.
> 
> This patchset creates a tree of pending lock request in which siblings
> don't conflict and each lock request does conflict with its parent.
> When a lock is released, only requests which don't conflict with each
> other a woken.
> 
> Testing shows that lock-acquisitions-per-second is now fairly stable even
> as number of contending process goes to 1000.  Without this patch,
> locks-per-second drops off steeply after a few 10s of processes.
> 
> There is a small cost to this extra complexity.
> At 20 processes running a particular test on 72 cores, the lock
> acquisitions per second drops from 1.8 million to 1.4 million with
> this patch.  For 100 processes, this patch still provides 1.4 million
> while without this patch there are about 700,000.
> 
> NeilBrown
> 
> ---
> 
> NeilBrown (4):
>       fs/locks: rename some lists and pointers.
>       fs/locks: allow a lock request to block other requests.
>       fs/locks: change all *_conflict() functions to return bool.
>       fs/locks: create a tree of dependent requests.
> 
> 
>  fs/cifs/file.c                  |    2 -
>  fs/locks.c                      |  142 +++++++++++++++++++++++++--------------
>  include/linux/fs.h              |    5 +
>  include/trace/events/filelock.h |   16 ++--
>  4 files changed, 103 insertions(+), 62 deletions(-)
> 

Nice work! I looked over this and I think it looks good.

I made an attempt to fix this issue several years ago, but my method
sucked as it ended up penalizing the unlocking task too much. This is
much cleaner and should scale well overall, I think.

I'll put this in -next soon and we can aim for merge in v4.20.

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>

