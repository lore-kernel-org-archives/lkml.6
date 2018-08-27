Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7361BC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 22:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311A5208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 22:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 311A5208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbeH1ChX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 22:37:23 -0400
Received: from nautica.notk.org ([91.121.71.147]:54355 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727180AbeH1ChV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 22:37:21 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 371C0C01A; Tue, 28 Aug 2018 00:48:41 +0200 (CEST)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     v9fs-developer@lists.sourceforge.net
Cc:     Dominique Martinet <dominique.martinet@cea.fr>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>
Subject: [PATCH 2/2] 9p: clear dangling pointers in p9stat_free
Date:   Tue, 28 Aug 2018 00:48:28 +0200
Message-Id: <1535410108-20650-2-git-send-email-asmadeus@codewreck.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1535410108-20650-1-git-send-email-asmadeus@codewreck.org>
References: <000000000000af648b057456e234@google.com>
 <1535410108-20650-1-git-send-email-asmadeus@codewreck.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dominique Martinet <dominique.martinet@cea.fr>

p9stat_free is more of a cleanup function than a 'free' function as it
only frees the content of the struct; there are chances of use-after-free
if it is improperly used (e.g. p9stat_free called twice as it used to be
possible to)

Clearing dangling pointers makes the function idempotent and safer to use.

Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
Reported-by: syzbot+d4252148d198410b864f@syzkaller.appspotmail.com
Cc: Eric Van Hensbergen <ericvh@gmail.com>
Cc: Latchesar Ionkov <lucho@ionkov.net>
---
 net/9p/protocol.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/9p/protocol.c b/net/9p/protocol.c
index 4a1e1dd30b52..ee32bbf12675 100644
--- a/net/9p/protocol.c
+++ b/net/9p/protocol.c
@@ -46,10 +46,15 @@ p9pdu_writef(struct p9_fcall *pdu, int proto_version, const char *fmt, ...);
 void p9stat_free(struct p9_wstat *stbuf)
 {
 	kfree(stbuf->name);
+	stbuf->name = NULL;
 	kfree(stbuf->uid);
+	stbuf->uid = NULL;
 	kfree(stbuf->gid);
+	stbuf->gid = NULL;
 	kfree(stbuf->muid);
+	stbuf->muid = NULL;
 	kfree(stbuf->extension);
+	stbuf->extension = NULL;
 }
 EXPORT_SYMBOL(p9stat_free);
 
-- 
2.17.1

