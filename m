Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B01C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 04:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E25420C0A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 04:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E25420C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbeJILVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 07:21:04 -0400
Received: from nautica.notk.org ([91.121.71.147]:37492 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbeJILVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 07:21:03 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id DE4C4C01A; Tue,  9 Oct 2018 06:06:07 +0200 (CEST)
From:   Dominique Martinet <asmadeus@codewreck.org>
Cc:     Dominique Martinet <dominique.martinet@cea.fr>,
        v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Tomas Bortoli <tomasbortoli@gmail.com>
Subject: [PATCH 2/2] 9p/trans_fd: put worker reqs on destroy
Date:   Tue,  9 Oct 2018 06:05:56 +0200
Message-Id: <1539057956-23741-2-git-send-email-asmadeus@codewreck.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1539057956-23741-1-git-send-email-asmadeus@codewreck.org>
References: <20181009020949.GA29622@nautica>
 <1539057956-23741-1-git-send-email-asmadeus@codewreck.org>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dominique Martinet <dominique.martinet@cea.fr>

p9_read_work/p9_write_work might still hold references to a req after
having been cancelled; make sure we put any of these to avoid potential
request leak on disconnect.

Fixes: 728356dedeff8 ("9p: Add refcount to p9_req_t")
Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
Cc: Eric Van Hensbergen <ericvh@gmail.com>
Cc: Latchesar Ionkov <lucho@ionkov.net>
Cc: Tomas Bortoli <tomasbortoli@gmail.com>
---
Noticed we could leak a ref while looking at the syzbot report,
this should be safe enough after the work has been cancelled...
Probably.

 net/9p/trans_fd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index a0317d459cde..f868cf6fba79 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -876,7 +876,15 @@ static void p9_conn_destroy(struct p9_conn *m)
 
 	p9_mux_poll_stop(m);
 	cancel_work_sync(&m->rq);
+	if (m->rreq) {
+		p9_req_put(m->rreq);
+		m->rreq = NULL;
+	}
 	cancel_work_sync(&m->wq);
+	if (m->wreq) {
+		p9_req_put(m->wreq);
+		m->wreq = NULL;
+	}
 
 	p9_conn_cancel(m, -ECONNRESET);
 
-- 
2.19.1

