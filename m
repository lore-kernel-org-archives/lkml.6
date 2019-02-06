Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D272C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 23:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 730DA218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 23:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfBFX0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 18:26:40 -0500
Received: from icebox.esperi.org.uk ([81.187.191.129]:36954 "EHLO
        mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfBFX0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 18:26:39 -0500
X-Greylist: delayed 4516 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Feb 2019 18:26:39 EST
Received: from loom (nix@sidle.srvr.nix [192.168.14.8])
        by mail.esperi.org.uk (8.15.2/8.15.2) with ESMTP id x16LvpO0001523;
        Wed, 6 Feb 2019 21:57:51 GMT
From:   Nix <nix@esperi.org.uk>
To:     linux-bcache@vger.kernel.org, linux-xfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: bcache on XFS: metadata I/O (dirent I/O?) not getting cached at all?
Emacs:  because Hell was full.
Date:   Wed, 06 Feb 2019 22:11:21 +0000
Message-ID: <87h8dgefee.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-DCC--Metrics: loom 1102; Body=3 Fuz1=3 Fuz2=3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So I just upgraded to 4.20 and revived my long-turned-off bcache now
that the metadata corruption leading to mount failure on dirty close may
have been identified (applying Tang Junhui's patch to do so)... and I
spotted something a bit disturbing. It appears that XFS directory and
metadata I/O is going more or less entirely uncached.

Here's some bcache stats before and after a git status of a *huge*
uncached tree (Chromium) on my no-writeback readaround cache. It takes
many minutes and pounds the disk with massively seeky metadata I/O in
the process:

Before:

stats_total/bypassed: 48.3G
stats_total/cache_bypass_hits: 7942
stats_total/cache_bypass_misses: 861045
stats_total/cache_hit_ratio: 3
stats_total/cache_hits: 16286
stats_total/cache_miss_collisions: 25
stats_total/cache_misses: 411575
stats_total/cache_readaheads: 0

After:
stats_total/bypassed: 49.3G
stats_total/cache_bypass_hits: 7942
stats_total/cache_bypass_misses: 1154887
stats_total/cache_hit_ratio: 3
stats_total/cache_hits: 16291
stats_total/cache_miss_collisions: 25
stats_total/cache_misses: 411625
stats_total/cache_readaheads: 0

Huge increase in bypassed reads, essentially no new cached reads. This
is... basically the optimum case for bcache, and it's not caching it!

From my reading of xfs_dir2_leaf_readbuf(), it looks like essentially
all directory reads in XFS appear to bcache as a single non-readahead
followed by a pile of readahead I/O: bcache bypasses readahead bios, so
all directory reads (or perhaps all directory reads larger than a single
block) are going to be bypassed out of hand.

This seems... suboptimal, but so does filling up the cache with
read-ahead blocks (particularly for non-metadata) that are never used.
Anyone got any ideas, 'cos I'm currently at a loss: XFS doesn't appear
to let us distinguish between "read-ahead just in case but almost
certain to be accessed" (like directory blocks) and "read ahead on the
offchance because someone did a single-block file read and what the hell
let's suck in a bunch more".

As it is, this seems to render bcache more or less useless with XFS,
since bcache's primary raison d'etre is precisely to cache seeky stuff
like metadata. :(
