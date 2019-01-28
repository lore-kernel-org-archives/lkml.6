Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF59FC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B8321736
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfA1JQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 04:16:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:58400 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726654AbfA1JQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 04:16:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5677FAD17;
        Mon, 28 Jan 2019 09:16:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F21CF1E3FEF; Mon, 28 Jan 2019 10:16:27 +0100 (CET)
Date:   Mon, 28 Jan 2019 10:16:27 +0100
From:   Jan Kara <jack@suse.cz>
To:     valdis.kletnieks@vt.edu
Cc:     Pavel Machek <pavel@ucw.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>, vbabka@suse.cz,
        aarcange@redhat.com, rientjes@google.com, mhocko@kernel.org,
        zi.yan@cs.rutgers.edu, hannes@cmpxchg.org, jack@suse.cz
Subject: Re: [regression -next0117] What is kcompactd and why is he eating
 100% of my cpu?
Message-ID: <20190128091627.GA27972@quack2.suse.cz>
References: <20190126200005.GB27513@amd>
 <12171.1548557813@turing-police.cc.vt.edu>
 <20190127141556.GB9565@techsingularity.net>
 <20190127160027.GA9340@amd>
 <13417.1548624994@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <13417.1548624994@turing-police.cc.vt.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun 27-01-19 16:36:34, valdis.kletnieks@vt.edu wrote:
> On Sun, 27 Jan 2019 17:00:27 +0100, Pavel Machek said:
> > > > I've noticed this as well on earlier kernels (next-20181224 to 20190115)
> > > > Some more info:
> > > > 1) echo 3 > /proc/sys/vm/drop_caches  unwedges kcompactd in 1-3 seconds.
> > > This aspect is curious as it indicates that kcompactd could potentially
> > > be infinite looping but it's not something I've experienced myself. By
> > > any chance is there a preditable reproduction case for this?
> >
> > I seen it exactly once, so not sure how reproducible this is. x86-32
> > machine, running chromium browser, so yes, there was some swapping
> > involved.
> 
> I don't have a surefire replicator, but my laptop (x86_64, so it's not a 32-bit
> only issue) triggers it fairly often, up to multiple times a day. Doesn't seem to
> be just the Chrome browser that triggers it - usually I'm doing other stuff as
> well, like a compile or similar.  The fact that 'drop_caches' clears it  makes me
> wonder if we're hitting a corner case where cache data isn't being automatically
> cleared and clogging something up.

So my buffer_migrate_page_norefs() is certainly buggy in its current
incarnation (as a result block device page cache is not migratable at all).
I've sent Andrew a patch over week ago but so far it got ignored. The patch
is attached, can you give it a try whether it changes something for you?
Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--J2SCkAp4GZ/dPZZf
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-mm-migrate-Make-buffer_migrate_page_norefs-actually-.patch"

From 59ab3a8504c35e2215af6c251bdb2a8a1caca1dd Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Wed, 16 Jan 2019 11:02:48 +0100
Subject: [PATCH] mm: migrate: Make buffer_migrate_page_norefs() actually
 succeed

Currently, buffer_migrate_page_norefs() was constantly failing because
buffer_migrate_lock_buffers() grabbed reference on each buffer. In fact,
there's no reason for buffer_migrate_lock_buffers() to grab any buffer
references as the page is locked during all our operation and thus
nobody can reclaim buffers from the page. So remove grabbing of buffer
references which also makes buffer_migrate_page_norefs() succeed.

Fixes: 89cb0888ca14 "mm: migrate: provide buffer_migrate_page_norefs()"
Signed-off-by: Jan Kara <jack@suse.cz>
---
 mm/migrate.c | 5 -----
 1 file changed, 5 deletions(-)

Andrew, can you please merge this patch? Sadly my previous testing only tested
that page migration in general didn't get broken but I forgot to test whether
the new migrate page callback actually results in more successful migrations
for block device pages. So the bug got only revealed by customer testing. Now
I've reproduced the workload internally and verified that the patch indeed
fixes the issue.

diff --git a/mm/migrate.c b/mm/migrate.c
index a16b15090df3..712b231a7376 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -709,7 +709,6 @@ static bool buffer_migrate_lock_buffers(struct buffer_head *head,
 	/* Simple case, sync compaction */
 	if (mode != MIGRATE_ASYNC) {
 		do {
-			get_bh(bh);
 			lock_buffer(bh);
 			bh = bh->b_this_page;
 
@@ -720,18 +719,15 @@ static bool buffer_migrate_lock_buffers(struct buffer_head *head,
 
 	/* async case, we cannot block on lock_buffer so use trylock_buffer */
 	do {
-		get_bh(bh);
 		if (!trylock_buffer(bh)) {
 			/*
 			 * We failed to lock the buffer and cannot stall in
 			 * async migration. Release the taken locks
 			 */
 			struct buffer_head *failed_bh = bh;
-			put_bh(failed_bh);
 			bh = head;
 			while (bh != failed_bh) {
 				unlock_buffer(bh);
-				put_bh(bh);
 				bh = bh->b_this_page;
 			}
 			return false;
@@ -818,7 +814,6 @@ static int __buffer_migrate_page(struct address_space *mapping,
 	bh = head;
 	do {
 		unlock_buffer(bh);
-		put_bh(bh);
 		bh = bh->b_this_page;
 
 	} while (bh != head);
-- 
2.16.4


--J2SCkAp4GZ/dPZZf--
