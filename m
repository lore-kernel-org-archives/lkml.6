Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD86BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651132145D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1cA9okx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 651132145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390905AbeKTDSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:18:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:57042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390145AbeKTDSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:18:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7793520851;
        Mon, 19 Nov 2018 16:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646441;
        bh=JjX099bOTShLhZGfRYEpbUoWT11WHrFwmiO9vjnJ9IQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f1cA9okxZdDnZ0WBAdcwtGp7/B0y19VOBsDRR/NwCBXNORz6lNLf6nIXjqy5bDP0Z
         ZLsA0DmdKVU5tpizoYRCxUplUyojs+lRS6f+l91pbIQNUYVAwuvOXN/IBHFqiM+Txg
         tYfWa5MuPsKnO1zflgBdmfJfN9bCBZWY1vE41Vss=
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
Subject: [PATCH 4.9 43/83] ocfs2: fix a misuse a of brelse after failing ocfs2_check_dir_entry
Date:   Mon, 19 Nov 2018 17:29:09 +0100
Message-Id: <20181119162621.009961569@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.046511542@linuxfoundation.org>
References: <20181119162612.046511542@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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


