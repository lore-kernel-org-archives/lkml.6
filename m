Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6259C4646D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 02:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E2721BF3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 02:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71E2721BF3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbeHIE3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 00:29:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:60380 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725757AbeHIE3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 00:29:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 93DDEAB99;
        Thu,  9 Aug 2018 02:07:25 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date:   Thu, 09 Aug 2018 12:04:41 +1000
Subject: [PATCH 0/5 - V2] locks: avoid thundering-herd wake-ups
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Message-ID: <153378012255.1220.6754153662007899557.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds "wake_non_conflicts()" to wake up
any waiters that are being added beneath a lock that they
don't actually conflict with, even though they conflict with a parent
which conflict with the top-level blocker.
Thanks for Bruce for highlighting this issue.

This series hasn't been tested beyond compile-test.

Original description:
If you have a many-core machine, and have many threads all wanting to
briefly lock a give file (udev is known to do this), you can get quite
poor performance.

When one thread releases a lock, it wakes up all other threads that
are waiting (classic thundering-herd) - one will get the lock and the
others go to sleep.
When you have few cores, this is not very noticeable: by the time the
4th or 5th thread gets enough CPU time to try to claim the lock, the
earlier threads have claimed it, done what was needed, and released.
With 50+ cores, the contention can easily be measured.

This patchset creates a tree of pending lock request in which siblings
don't conflict and each lock request does conflict with its parent.
When a lock is released, only requests which don't conflict with each
other a woken.

Testing shows that lock-acquisitions-per-second is now fairly stable even
as number of contending process goes to 1000.  Without this patch,
locks-per-second drops off steeply after a few 10s of processes.

There is a small cost to this extra complexity.
At 20 processes running a particular test on 72 cores, the lock
acquisitions per second drops from 1.8 million to 1.4 million with
this patch.  For 100 processes, this patch still provides 1.4 million
while without this patch there are about 700,000.

NeilBrown


---

NeilBrown (5):
      fs/locks: rename some lists and pointers.
      fs/locks: allow a lock request to block other requests.
      fs/locks: change all *_conflict() functions to return a new enum.
      fs/locks: split out __locks_wake_one()
      fs/locks: create a tree of dependent requests.


 fs/cifs/file.c                  |    2 
 fs/locks.c                      |  228 ++++++++++++++++++++++++++++++---------
 include/linux/fs.h              |    5 +
 include/trace/events/filelock.h |   16 +--
 4 files changed, 186 insertions(+), 65 deletions(-)

--
Signature

