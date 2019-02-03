Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A644C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC74D20821
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbfBCODK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:03:10 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52986 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727986AbfBCNtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:49:46 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9Y-0003wN-9W; Sun, 03 Feb 2019 13:49:44 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9Y-0006xu-8d; Sun, 03 Feb 2019 14:49:44 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Carlos Maiolino" <cmaiolino@redhat.com>,
        "Dave Chinner" <david@fromorbit.com>,
        "Eric Sandeen" <sandeen@redhat.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.796020146@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 100/305] xfs: Fix xqmstats offsets in /proc/fs/xfs/xqmstat
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Carlos Maiolino <cmaiolino@redhat.com>

commit 41657e5507b13e963be906d5d874f4f02374fd5c upstream.

The addition of FIBT, RMAP and REFCOUNT changed the offsets into
__xfssats structure.

This caused xqmstat_proc_show() to display garbage data via
/proc/fs/xfs/xqmstat, once it relies on the offsets marked via macros.

Fix it.

Fixes: 00f4e4f9 xfs: add rmap btree stats infrastructure
Fixes: aafc3c24 xfs: support the XFS_BTNUM_FINOBT free inode btree type
Fixes: 46eeb521 xfs: introduce refcount btree definitions
Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
Reviewed-by: Eric Sandeen <sandeen@redhat.com>
Signed-off-by: Dave Chinner <david@fromorbit.com>
[bwh: Backported to 3.16:
 - Only the FIBT stats have been added, so start from XFSSTAT_END_FIBT_V2
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/xfs/xfs_stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/xfs/xfs_stats.c
+++ b/fs/xfs/xfs_stats.c
@@ -135,7 +135,7 @@ static int xqmstat_proc_show(struct seq_
 	int j;
 
 	seq_printf(m, "qm");
-	for (j = XFSSTAT_END_IBT_V2; j < XFSSTAT_END_XQMSTAT; j++)
+	for (j = XFSSTAT_END_FIBT_V2; j < XFSSTAT_END_XQMSTAT; j++)
 		seq_printf(m, " %u", counter_val(j));
 	seq_putc(m, '\n');
 	return 0;

