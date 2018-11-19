Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC086C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94087223CE
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqN8IrXj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94087223CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405682AbeKTDZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:25:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:39086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404909AbeKTDZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:25:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2B3D22353;
        Mon, 19 Nov 2018 17:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646891;
        bh=0cPqpbne3ogzzuKa0MHeibYGHRIr11p1wE0KEJXiJ8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aqN8IrXjo1ZdF3anoIBjj2W5IuX/54wWF+bMIxGRUZS/2n8O2iqzTzZef1VhNxNtU
         mO7g2GNMgMOQtC7jv31Qe3eLy1o45ewCUXITodlvLRQH2ljErcYCr+hq8eLpV/y0t/
         9ztb3RVprLLmxtGXVctgbP58urtFvdPpxXn7pJfM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Changwei Ge <ge.changwei@h3c.com>,
        Changkuo Shi <shi.changkuo@h3c.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Joseph Qi <jiangqi903@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.4 130/160] ocfs2: fix a misuse a of brelse after failing ocfs2_check_dir_entry
Date:   Mon, 19 Nov 2018 17:29:29 +0100
Message-Id: <20181119162642.951287467@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162630.031306128@linuxfoundation.org>
References: <20181119162630.031306128@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ocfs2/dir.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/fs/ocfs2/dir.c
+++ b/fs/ocfs2/dir.c
@@ -1896,8 +1896,7 @@ static int ocfs2_dir_foreach_blk_el(stru
 				/* On error, skip the f_pos to the
 				   next block. */
 				ctx->pos = (ctx->pos | (sb->s_blocksize - 1)) + 1;
-				brelse(bh);
-				continue;
+				break;
 			}
 			if (le64_to_cpu(de->inode)) {
 				unsigned char d_type = DT_UNKNOWN;


