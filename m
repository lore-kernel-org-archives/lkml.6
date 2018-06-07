Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id lxiJCplCGVs9ewAAmS7hNA
	; Thu, 07 Jun 2018 14:35:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D643D607DC; Thu,  7 Jun 2018 14:35:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id AC5EF601D2;
	Thu,  7 Jun 2018 14:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AC5EF601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934021AbeFGOfE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:35:04 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40369 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934005AbeFGOe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:34:56 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbj-0005Zi-8L; Thu, 07 Jun 2018 15:09:43 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb5-0002yf-Cq; Thu, 07 Jun 2018 15:09:03 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Zygo Blaxell" <ce3g8jdj@umail.furryterror.org>,
        "David Sterba" <dsterba@suse.com>,
        "Lu Fengqi" <lufq.fnst@cn.fujitsu.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.571859639@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 190/410] btrfs: remove spurious WARN_ON(ref->count <
 0) in find_parent_nodes
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>

commit c8195a7b1ad5648857ce20ba24f384faed8512bc upstream.

Until v4.14, this warning was very infrequent:

	WARNING: CPU: 3 PID: 18172 at fs/btrfs/backref.c:1391 find_parent_nodes+0xc41/0x14e0
	Modules linked in: [...]
	CPU: 3 PID: 18172 Comm: bees Tainted: G      D W    L  4.11.9-zb64+ #1
	Hardware name: System manufacturer System Product Name/M5A78L-M/USB3, BIOS 2101    12/02/2014
	Call Trace:
	 dump_stack+0x85/0xc2
	 __warn+0xd1/0xf0
	 warn_slowpath_null+0x1d/0x20
	 find_parent_nodes+0xc41/0x14e0
	 __btrfs_find_all_roots+0xad/0x120
	 ? extent_same_check_offsets+0x70/0x70
	 iterate_extent_inodes+0x168/0x300
	 iterate_inodes_from_logical+0x87/0xb0
	 ? iterate_inodes_from_logical+0x87/0xb0
	 ? extent_same_check_offsets+0x70/0x70
	 btrfs_ioctl+0x8ac/0x2820
	 ? lock_acquire+0xc2/0x200
	 do_vfs_ioctl+0x91/0x700
	 ? __fget+0x112/0x200
	 SyS_ioctl+0x79/0x90
	 entry_SYSCALL_64_fastpath+0x23/0xc6
	 ? trace_hardirqs_off_caller+0x1f/0x140

Starting with v4.14 (specifically 86d5f9944252 ("btrfs: convert prelimary
reference tracking to use rbtrees")) the WARN_ON occurs three orders of
magnitude more frequently--almost once per second while running workloads
like bees.

Replace the WARN_ON() with a comment rationale for its removal.
The rationale is paraphrased from an explanation by Edmund Nadolski
<enadolski@suse.de> on the linux-btrfs mailing list.

Fixes: 8da6d5815c59 ("Btrfs: added btrfs_find_all_roots()")
Signed-off-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Reviewed-by: Lu Fengqi <lufq.fnst@cn.fujitsu.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/btrfs/backref.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -979,7 +979,16 @@ again:
 
 	while (!list_empty(&prefs)) {
 		ref = list_first_entry(&prefs, struct __prelim_ref, list);
-		WARN_ON(ref->count < 0);
+		/*
+		 * ref->count < 0 can happen here if there are delayed
+		 * refs with a node->action of BTRFS_DROP_DELAYED_REF.
+		 * prelim_ref_insert() relies on this when merging
+		 * identical refs to keep the overall count correct.
+		 * prelim_ref_insert() will merge only those refs
+		 * which compare identically.  Any refs having
+		 * e.g. different offsets would not be merged,
+		 * and would retain their original ref->count < 0.
+		 */
 		if (roots && ref->count && ref->root_id && ref->parent == 0) {
 			/* no parent == root of tree */
 			ret = ulist_add(roots, ref->root_id, 0, GFP_NOFS);
