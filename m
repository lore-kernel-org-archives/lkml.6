Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C25AC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F0B20823
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Udd6uvwj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04F0B20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbeKAIHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:07:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:54688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728646AbeKAIHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:07:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4121620664;
        Wed, 31 Oct 2018 23:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027219;
        bh=wr2K4d3ejnl+MunT9gDCKKo+1pwJpXM5250ZUzNYomA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Udd6uvwj412rFGLTdDMBeTcP3nzuu0jX5w8fAldmbpNKtfO5g0rOHrTjXip+Fll++
         UnP12UGRBgfGe8VAXi6FSLVOqJVtkxF/lQDp84Ov9Pov2Irmrxpr4luwCLObKlXXxS
         QPnXCzsGGJdQQn8VileX45BEpQljw5YITbghMaC8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 085/146] cifs: fix a credits leak for compund commands
Date:   Wed, 31 Oct 2018 19:04:40 -0400
Message-Id: <20181031230541.28822-85-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 fs/cifs/transport.c | 57 +++++++++++++++++++++++++++++----------------
 1 file changed, 37 insertions(+), 20 deletions(-)

diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
index b48f43963da6..333729cf46cd 100644
--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -786,7 +786,7 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 	int i, j, rc = 0;
 	int timeout, optype;
 	struct mid_q_entry *midQ[MAX_COMPOUND];
-	unsigned int credits = 1;
+	unsigned int credits = 0;
 	char *buf;
 
 	timeout = flags & CIFS_TIMEOUT_MASK;
@@ -851,17 +851,20 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 
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
@@ -877,10 +880,21 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
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
 
@@ -901,23 +915,26 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
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
 	}
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
+	}
+
 out:
 	/*
 	 * This will dequeue all mids. After this it is important that the
-- 
2.17.1

