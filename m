Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829A7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5190421903
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497656;
	bh=9JfRpJg4emlrBtcRK2kebCM+Vw04xAAp3y3ROKRI3B8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NSj19RT4VW4QgyvJX+eyLVUDe3k+FYJQMhA/6GmKp0597hy9gGwDoVYh/kDI+g9qe
	 XerojmAxyuhi0OcnI/nZJtX/JQDQa0NuoKHdJ5NnnybG4gXa8EmPS5WeRA4GkAip4w
	 fwCQDm+7YTZcm9aMfDfBKH9ChPpNfDkdUpIYJgeA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730239AbfBRNre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:47:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:54118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729940AbfBRNra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:47:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 125EA2190C;
        Mon, 18 Feb 2019 13:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497648;
        bh=9JfRpJg4emlrBtcRK2kebCM+Vw04xAAp3y3ROKRI3B8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dmt+UQJ7w0vKCw48HAaYCukgUPtC+IIW6kz41OxruXHjgg3gKcYZR3TPTvFBsByAQ
         zku7onCs95iwKGkPHc3NvrAQVz0NTzxftQz6E+IexVI7UOpK95FaWA1uoooXcAnLbJ
         EKVvTad6cCRCiaFqJuMHC78yXt42n/R91zQYgKKY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 43/92] CIFS: Move credit processing to mid callbacks for SMB3
Date:   Mon, 18 Feb 2019 14:42:46 +0100
Message-Id: <20190218133458.725921250@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
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

[ Upstream commit ee258d79159afed52ca9372aeb9c1a51e89b32ee ]

Currently we account for credits in the thread initiating a request
and waiting for a response. The demultiplex thread receives the response,
wakes up the thread and the latter collects credits from the response
buffer and add them to the server structure on the client. This approach
is not accurate, because it may race with reconnect events in the
demultiplex thread which resets the number of credits.

Fix this by moving credit processing to new mid callbacks that collect
credits granted by the server from the response in the demultiplex thread.

Signed-off-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/transport.c | 51 ++++++++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
index 4dbf62bb51b2..0dab276eced8 100644
--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -781,12 +781,7 @@ cifs_setup_request(struct cifs_ses *ses, struct smb_rqst *rqst)
 }
 
 static void
-cifs_noop_callback(struct mid_q_entry *mid)
-{
-}
-
-static void
-cifs_cancelled_callback(struct mid_q_entry *mid)
+cifs_compound_callback(struct mid_q_entry *mid)
 {
 	struct TCP_Server_Info *server = mid->server;
 	unsigned int optype = mid->optype;
@@ -799,10 +794,23 @@ cifs_cancelled_callback(struct mid_q_entry *mid)
 			cifs_dbg(FYI, "Bad state for cancelled MID\n");
 	}
 
-	DeleteMidQEntry(mid);
 	add_credits(server, credits_received, optype);
 }
 
+static void
+cifs_compound_last_callback(struct mid_q_entry *mid)
+{
+	cifs_compound_callback(mid);
+	cifs_wake_up_task(mid);
+}
+
+static void
+cifs_cancelled_callback(struct mid_q_entry *mid)
+{
+	cifs_compound_callback(mid);
+	DeleteMidQEntry(mid);
+}
+
 int
 compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 		   const int flags, const int num_rqst, struct smb_rqst *rqst,
@@ -880,11 +888,14 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 		midQ[i]->mid_state = MID_REQUEST_SUBMITTED;
 		midQ[i]->optype = optype;
 		/*
-		 * We don't invoke the callback compounds unless it is the last
-		 * request.
+		 * Invoke callback for every part of the compound chain
+		 * to calculate credits properly. Wake up this thread only when
+		 * the last element is received.
 		 */
 		if (i < num_rqst - 1)
-			midQ[i]->callback = cifs_noop_callback;
+			midQ[i]->callback = cifs_compound_callback;
+		else
+			midQ[i]->callback = cifs_compound_last_callback;
 	}
 	cifs_in_send_inc(ses->server);
 	rc = smb_send_rqst(ses->server, num_rqst, rqst, flags);
@@ -898,8 +909,20 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 
 	mutex_unlock(&ses->server->srv_mutex);
 
-	if (rc < 0)
+	if (rc < 0) {
+		/* Sending failed for some reason - return credits back */
+		for (i = 0; i < num_rqst; i++)
+			add_credits(ses->server, credits[i], optype);
 		goto out;
+	}
+
+	/*
+	 * At this point the request is passed to the network stack - we assume
+	 * that any credits taken from the server structure on the client have
+	 * been spent and we can't return them back. Once we receive responses
+	 * we will collect credits granted by the server in the mid callbacks
+	 * and add those credits to the server structure.
+	 */
 
 	/*
 	 * Compounding is never used during session establish.
@@ -932,11 +955,6 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 		}
 	}
 
-	for (i = 0; i < num_rqst; i++)
-		if (!cancelled_mid[i] && midQ[i]->resp_buf
-		    && (midQ[i]->mid_state == MID_RESPONSE_RECEIVED))
-			credits[i] = ses->server->ops->get_credits(midQ[i]);
-
 	for (i = 0; i < num_rqst; i++) {
 		if (rc < 0)
 			goto out;
@@ -995,7 +1013,6 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 	for (i = 0; i < num_rqst; i++) {
 		if (!cancelled_mid[i])
 			cifs_delete_mid(midQ[i]);
-		add_credits(ses->server, credits[i], optype);
 	}
 
 	return rc;
-- 
2.19.1



