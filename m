Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2B5C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31312054F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570638;
	bh=b63rn5zrfSrglP5NW29Mj53bJXUkert5UqavPUgvP8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=frIjPIXoyKIOlefLpalV5HGi28NLPnuW4K68S3EqmQD4BPzfMXNFXB1GJSoFYOfyL
	 BU9h/tm1SCHa1n0lv9mxAFqeiMboV1Plo16UvicA3sU0GV+k0Vqzq9rl5JPZUpjfz2
	 1OxL9790a7CQQ6/NF5+bneCZFoahGC19UnyL/NAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387428AbfAOQn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:43:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:33416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727935AbfAOQnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:43:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1360920645;
        Tue, 15 Jan 2019 16:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570631;
        bh=b63rn5zrfSrglP5NW29Mj53bJXUkert5UqavPUgvP8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lKhmnxVegqdahsJrxkf+4cCS8WuKVXmIwxYzqaKQUeqcasUvJOXWBKlCYzfwdWkAg
         uLw1/OJ2DExAMN33cmkGvkgL0fDFRLubspMcCI+spew9DPxnK8h0g5IfsIuRdKJzBJ
         SQVIV/cqLuemeMQXNwtvOpSfonysu04CeRUcDZLA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.20 15/57] CIFS: Fix credit computation for compounded requests
Date:   Tue, 15 Jan 2019 17:35:56 +0100
Message-Id: <20190115154911.586066420@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154910.734892368@linuxfoundation.org>
References: <20190115154910.734892368@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Shilovsky <pshilov@microsoft.com>

commit 8544f4aa9dd19a04d1244dae10feecc813ccf175 upstream.

In SMB3 protocol every part of the compound chain consumes credits
individually, so we need to call wait_for_free_credits() for each
of the PDUs in the chain. If an operation is interrupted, we must
ensure we return all credits taken from the server structure back.

Without this patch server can sometimes disconnect the session
due to credit mismatches, especially when first operation(s)
are large writes.

Signed-off-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/transport.c |   59 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 18 deletions(-)

--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -793,7 +793,8 @@ compound_send_recv(const unsigned int xi
 	int i, j, rc = 0;
 	int timeout, optype;
 	struct mid_q_entry *midQ[MAX_COMPOUND];
-	unsigned int credits = 0;
+	bool cancelled_mid[MAX_COMPOUND] = {false};
+	unsigned int credits[MAX_COMPOUND] = {0};
 	char *buf;
 
 	timeout = flags & CIFS_TIMEOUT_MASK;
@@ -811,13 +812,31 @@ compound_send_recv(const unsigned int xi
 		return -ENOENT;
 
 	/*
-	 * Ensure that we do not send more than 50 overlapping requests
-	 * to the same server. We may make this configurable later or
-	 * use ses->maxReq.
+	 * Ensure we obtain 1 credit per request in the compound chain.
+	 * It can be optimized further by waiting for all the credits
+	 * at once but this can wait long enough if we don't have enough
+	 * credits due to some heavy operations in progress or the server
+	 * not granting us much, so a fallback to the current approach is
+	 * needed anyway.
 	 */
-	rc = wait_for_free_request(ses->server, timeout, optype);
-	if (rc)
-		return rc;
+	for (i = 0; i < num_rqst; i++) {
+		rc = wait_for_free_request(ses->server, timeout, optype);
+		if (rc) {
+			/*
+			 * We haven't sent an SMB packet to the server yet but
+			 * we already obtained credits for i requests in the
+			 * compound chain - need to return those credits back
+			 * for future use. Note that we need to call add_credits
+			 * multiple times to match the way we obtained credits
+			 * in the first place and to account for in flight
+			 * requests correctly.
+			 */
+			for (j = 0; j < i; j++)
+				add_credits(ses->server, 1, optype);
+			return rc;
+		}
+		credits[i] = 1;
+	}
 
 	/*
 	 * Make sure that we sign in the same order that we send on this socket
@@ -833,8 +852,10 @@ compound_send_recv(const unsigned int xi
 			for (j = 0; j < i; j++)
 				cifs_delete_mid(midQ[j]);
 			mutex_unlock(&ses->server->srv_mutex);
+
 			/* Update # of requests on wire to server */
-			add_credits(ses->server, 1, optype);
+			for (j = 0; j < num_rqst; j++)
+				add_credits(ses->server, credits[j], optype);
 			return PTR_ERR(midQ[i]);
 		}
 
@@ -881,17 +902,16 @@ compound_send_recv(const unsigned int xi
 			if (midQ[i]->mid_state == MID_REQUEST_SUBMITTED) {
 				midQ[i]->mid_flags |= MID_WAIT_CANCELLED;
 				midQ[i]->callback = DeleteMidQEntry;
-				spin_unlock(&GlobalMid_Lock);
-				add_credits(ses->server, 1, optype);
-				return rc;
+				cancelled_mid[i] = true;
 			}
 			spin_unlock(&GlobalMid_Lock);
 		}
 	}
 
 	for (i = 0; i < num_rqst; i++)
-		if (midQ[i]->resp_buf)
-			credits += ses->server->ops->get_credits(midQ[i]);
+		if (!cancelled_mid[i] && midQ[i]->resp_buf
+		    && (midQ[i]->mid_state == MID_RESPONSE_RECEIVED))
+			credits[i] = ses->server->ops->get_credits(midQ[i]);
 
 	for (i = 0; i < num_rqst; i++) {
 		if (rc < 0)
@@ -899,8 +919,9 @@ compound_send_recv(const unsigned int xi
 
 		rc = cifs_sync_mid_result(midQ[i], ses->server);
 		if (rc != 0) {
-			add_credits(ses->server, credits, optype);
-			return rc;
+			/* mark this mid as cancelled to not free it below */
+			cancelled_mid[i] = true;
+			goto out;
 		}
 
 		if (!midQ[i]->resp_buf ||
@@ -947,9 +968,11 @@ out:
 	 * This is prevented above by using a noop callback that will not
 	 * wake this thread except for the very last PDU.
 	 */
-	for (i = 0; i < num_rqst; i++)
-		cifs_delete_mid(midQ[i]);
-	add_credits(ses->server, credits, optype);
+	for (i = 0; i < num_rqst; i++) {
+		if (!cancelled_mid[i])
+			cifs_delete_mid(midQ[i]);
+		add_credits(ses->server, credits[i], optype);
+	}
 
 	return rc;
 }


