Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521C3C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED75820819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED75820819
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbeKESLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:11:37 -0500
Received: from nautica.notk.org ([91.121.71.147]:34367 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbeKESLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:11:37 -0500
Received: by nautica.notk.org (Postfix, from userid 1001)
        id EEB72C009; Mon,  5 Nov 2018 09:52:55 +0100 (CET)
From:   Dominique Martinet <asmadeus@codewreck.org>
Cc:     Dominique Martinet <dominique.martinet@cea.fr>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH] 9p/net: put a lower bound on msize
Date:   Mon,  5 Nov 2018 09:52:48 +0100
Message-Id: <1541407968-31350-1-git-send-email-asmadeus@codewreck.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <20181102223908.GA9565@nautica>
References: <20181102223908.GA9565@nautica>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dominique Martinet <dominique.martinet@cea.fr>

If the requested msize is too small (either from command line argument
or from the server version reply), we won't get any work done.
If it's *really* too small, nothing will work, and this got caught by
syzbot recently (on a new kmem_cache_create_usercopy() call)

Just set a minimum msize to 4k in both code paths, until someone
complains they have a use-case for a smaller msize.

We need to check in both mount option and server reply individually
because the msize for the first version request would be unchecked
with just a global check on clnt->msize.

Reported-by: syzbot+0c1d61e4db7db94102ca@syzkaller.appspotmail.com
Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
Cc: Eric Van Hensbergen <ericvh@gmail.com>
Cc: Latchesar Ionkov <lucho@ionkov.net>
---
 net/9p/client.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/net/9p/client.c b/net/9p/client.c
index 2c9a17b9b46b..b1163ebdc622 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -181,6 +181,12 @@ static int parse_opts(char *opts, struct p9_client *clnt)
 				ret = r;
 				continue;
 			}
+			if (r < 4096) {
+				p9_debug(P9_DEBUG_ERROR,
+					 "msize should be at least 4k\n");
+				ret = -EINVAL;
+				continue;
+			}
 			clnt->msize = option;
 			break;
 		case Opt_trans:
@@ -983,10 +989,18 @@ static int p9_client_version(struct p9_client *c)
 	else if (!strncmp(version, "9P2000", 6))
 		c->proto_version = p9_proto_legacy;
 	else {
+		p9_debug(P9_DEBUG_ERROR,
+			 "server returned an unknown version: %s\n", version);
 		err = -EREMOTEIO;
 		goto error;
 	}
 
+	if (msize < 4096) {
+		p9_debug(P9_DEBUG_ERROR,
+			 "server returned a msize < 4096: %d\n", msize);
+		err = -EREMOTEIO;
+		goto error;
+	}
 	if (msize < c->msize)
 		c->msize = msize;
 
@@ -1043,6 +1057,13 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
 	if (clnt->msize > clnt->trans_mod->maxsize)
 		clnt->msize = clnt->trans_mod->maxsize;
 
+	if (clnt->msize < 4096) {
+		p9_debug(P9_DEBUG_ERROR,
+			 "Please specify a msize of at least 4k\n");
+		err = -EINVAL;
+		goto free_client;
+	}
+
 	err = p9_client_version(clnt);
 	if (err)
 		goto close_trans;
-- 
2.19.1

