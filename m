Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14A3C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B442A20844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:51:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B442A20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbeIGVdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:33:13 -0400
Received: from nautica.notk.org ([91.121.71.147]:38094 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbeIGVdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:33:01 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 7BC17C01C; Fri,  7 Sep 2018 18:51:14 +0200 (CEST)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Dominique Martinet <dominique.martinet@cea.fr>
Subject: [PATCH 3/4] 9p: p9dirent_read: check network-provided name length
Date:   Fri,  7 Sep 2018 18:50:56 +0200
Message-Id: <1536339057-21974-4-git-send-email-asmadeus@codewreck.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1536339057-21974-1-git-send-email-asmadeus@codewreck.org>
References: <1536339057-21974-1-git-send-email-asmadeus@codewreck.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dominique Martinet <dominique.martinet@cea.fr>

strcpy to dirent->d_name could overflow the buffer, use strscpy to check
the provided string length and error out if the size was too big.

While we are here, make the function return an error when the pdu
parsing failed, instead of returning the pdu offset as if it had been a
success...

Addresses-Coverity-ID: 139133 ("Copy into fixed size buffer")
Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
---
 net/9p/protocol.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/9p/protocol.c b/net/9p/protocol.c
index b4d80c533f89..462ba144cb39 100644
--- a/net/9p/protocol.c
+++ b/net/9p/protocol.c
@@ -623,13 +623,19 @@ int p9dirent_read(struct p9_client *clnt, char *buf, int len,
 	if (ret) {
 		p9_debug(P9_DEBUG_9P, "<<< p9dirent_read failed: %d\n", ret);
 		trace_9p_protocol_dump(clnt, &fake_pdu);
-		goto out;
+		return ret;
 	}
 
-	strcpy(dirent->d_name, nameptr);
+	ret = strscpy(dirent->d_name, nameptr, sizeof(dirent->d_name));
+	if (ret < 0) {
+		p9_debug(P9_DEBUG_ERROR,
+			 "On the wire dirent name too long: %s\n",
+			 nameptr);
+		kfree(nameptr);
+		return ret;
+	}
 	kfree(nameptr);
 
-out:
 	return fake_pdu.offset;
 }
 EXPORT_SYMBOL(p9dirent_read);
-- 
2.17.1

