Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FB4C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412C120815
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbfBCN72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:59:28 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53624 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728300AbfBCNtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:49:55 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9e-0003tl-Mp; Sun, 03 Feb 2019 13:49:50 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9a-00072A-Dg; Sun, 03 Feb 2019 14:49:46 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Joel Becker" <jlbec@evilplan.org>,
        "Joseph Qi" <jiangqi903@gmail.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Changkuo Shi" <shi.changkuo@h3c.com>,
        "Mark Fasheh" <mark@fasheh.com>,
        "Changwei Ge" <ge.changwei@h3c.com>,
        "Junxiao Bi" <junxiao.bi@oracle.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.162911693@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 133/305] ocfs2: fix a misuse a of brelse after
 failing ocfs2_check_dir_entry
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

From: Changwei Ge <ge.changwei@h3c.com>

commit 29aa30167a0a2e6045a0d6d2e89d8168132333d5 upstream.

Somehow, file system metadata was corrupted, which causes
ocfs2_check_dir_entry() to fail in function ocfs2_dir_foreach_blk_el().

According to the original design intention, if above happens we should
skip the problematic block and continue to retrieve dir entry.  But
there is obviouse misuse of brelse around related code.

After failure of ocfs2_check_dir_entry(), current code just moves to
next position and uses the problematic buffer head again and again
during which the problematic buffer head is released for multiple times.
I suppose, this a serious issue which is long-lived in ocfs2.  This may
cause other file systems which is also used in a the same host insane.

So we should also consider about bakcporting this patch into linux
-stable.

Link: http://lkml.kernel.org/r/HK2PR06MB045211675B43EED794E597B6D56E0@HK2PR06MB0452.apcprd06.prod.outlook.com
Signed-off-by: Changwei Ge <ge.changwei@h3c.com>
Suggested-by: Changkuo Shi <shi.changkuo@h3c.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Joseph Qi <jiangqi903@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ocfs2/dir.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/fs/ocfs2/dir.c
+++ b/fs/ocfs2/dir.c
@@ -1906,8 +1906,7 @@ static int ocfs2_dir_foreach_blk_el(stru
 				/* On error, skip the f_pos to the
 				   next block. */
 				ctx->pos = (ctx->pos | (sb->s_blocksize - 1)) + 1;
-				brelse(bh);
-				continue;
+				break;
 			}
 			if (le64_to_cpu(de->inode)) {
 				unsigned char d_type = DT_UNKNOWN;

