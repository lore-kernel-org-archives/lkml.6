Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CDDC0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D36215EA
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGMpuj7j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D36215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731512AbeKLIRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:17:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:60278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731159AbeKLIRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:32 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0E4C21707;
        Sun, 11 Nov 2018 22:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975256;
        bh=Zzgy0UV74fkKKeeHYCw6tGKVg9Emy2iOw58hTB/Xgw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZGMpuj7jukVJoQxhUgGLE/88ce3WJAM6U8VWUXJoDV04lsM+xtwXj+191rPcWD1aC
         7B9gSnZ3hVnZaCyW7tqdDl+Ras8C7uU22mYjcvA0i8o9AB5kHku9ZGX6kAiEsCNy2U
         o50H6uQMjFSI3NUm3/7KkzlIsVkn5seCBmGMba+c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 130/361] cifs: fix a credits leak for compund commands
Date:   Sun, 11 Nov 2018 14:17:57 -0800
Message-Id: <20181111221638.508291509@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ronnie Sahlberg <lsahlber@redhat.com>

[ Upstream commit cb5c2e63948451d38c977685fffc06e23beb4517 ]

When processing the mids for compounds we would only add credits based on
the last successful mid in the compound which would leak credits and
eventually triggering a re-connect.

Fix this by splitting the mid processing part into two loops instead of one
where the first loop just waits for all mids and then counts how many
credits we were granted for the whole compound.

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/cifs/transport.c |   57 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 20 deletions(-)

--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -786,7 +786,7 @@ compound_send_recv(const unsigned int xi
 	int i, j, rc = 0;
 	int timeout, optype;
 	struct mid_q_entry *midQ[MAX_COMPOUND];
-	unsigned int credits = 1;
+	unsigned int credits = 0;
 	char *buf;
 
 	timeout = flags & CIFS_TIMEOUT_MASK;
@@ -851,17 +851,20 @@ compound_send_recv(const unsigned int xi
 
 	mutex_unlock(&ses->server->srv_mutex);
 
-	for (i = 0; i < num_rqst; i++) {
-		if (rc < 0)
-			goto out;
+	if (rc < 0)
+		goto out;
 
-		if ((ses->status == CifsNew) || (optype & CIFS_NEG_OP))
-			smb311_update_preauth_hash(ses, rqst[i].rq_iov,
-						   rqst[i].rq_nvec);
+	/*
+	 * Compounding is never used during session establish.
+	 */
+	if ((ses->status == CifsNew) || (optype & CIFS_NEG_OP))
+		smb311_update_preauth_hash(ses, rqst[0].rq_iov,
+					   rqst[0].rq_nvec);
 
-		if (timeout == CIFS_ASYNC_OP)
-			goto out;
+	if (timeout == CIFS_ASYNC_OP)
+		goto out;
 
+	for (i = 0; i < num_rqst; i++) {
 		rc = wait_for_response(ses->server, midQ[i]);
 		if (rc != 0) {
 			cifs_dbg(FYI, "Cancelling wait for mid %llu\n",
@@ -877,10 +880,21 @@ compound_send_recv(const unsigned int xi
 			}
 			spin_unlock(&GlobalMid_Lock);
 		}
+	}
+
+	for (i = 0; i < num_rqst; i++)
+		if (midQ[i]->resp_buf)
+			credits += ses->server->ops->get_credits(midQ[i]);
+	if (!credits)
+		credits = 1;
+
+	for (i = 0; i < num_rqst; i++) {
+		if (rc < 0)
+			goto out;
 
 		rc = cifs_sync_mid_result(midQ[i], ses->server);
 		if (rc != 0) {
-			add_credits(ses->server, 1, optype);
+			add_credits(ses->server, credits, optype);
 			return rc;
 		}
 
@@ -901,23 +915,26 @@ compound_send_recv(const unsigned int xi
 		else
 			resp_buf_type[i] = CIFS_SMALL_BUFFER;
 
-		if ((ses->status == CifsNew) || (optype & CIFS_NEG_OP)) {
-			struct kvec iov = {
-				.iov_base = resp_iov[i].iov_base,
-				.iov_len = resp_iov[i].iov_len
-			};
-			smb311_update_preauth_hash(ses, &iov, 1);
-		}
-
-		credits = ses->server->ops->get_credits(midQ[i]);
-
 		rc = ses->server->ops->check_receive(midQ[i], ses->server,
 						     flags & CIFS_LOG_ERROR);
 
 		/* mark it so buf will not be freed by cifs_delete_mid */
 		if ((flags & CIFS_NO_RESP) == 0)
 			midQ[i]->resp_buf = NULL;
+
+	}
+
+	/*
+	 * Compounding is never used during session establish.
+	 */
+	if ((ses->status == CifsNew) || (optype & CIFS_NEG_OP)) {
+		struct kvec iov = {
+			.iov_base = resp_iov[0].iov_base,
+			.iov_len = resp_iov[0].iov_len
+		};
+		smb311_update_preauth_hash(ses, &iov, 1);
 	}
+
 out:
 	/*
 	 * This will dequeue all mids. After this it is important that the


