Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DA5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63BFD217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497651;
	bh=7B98muap6gErcBUbxRmaryGCdFAXNpdl+t96ZllC4pI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZQ41Gxl+WrHyVxImV8edmP3gxa/j1s/EISORdfW+iS8fRQY2ovO3Me1969o0r4bkl
	 kmFbeOFHnF/o865Yr1fQ92pZBM3lpvjQjHLH7kSgZJ1cfEApCDgxReubgP+9g5PQzt
	 WhxV63lF8ZwAbHwuV0MHc4g9maOm2iePbtr90aCA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731788AbfBRNr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:47:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:54052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731759AbfBRNr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:47:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51CCF21901;
        Mon, 18 Feb 2019 13:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497645;
        bh=7B98muap6gErcBUbxRmaryGCdFAXNpdl+t96ZllC4pI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LKpX79vmgHSQT3UZYC9EMhfp0SP4poiqLWPyNhU5HXrum1HcH80xyZy+Afr68xpmD
         sW0Hmj01EZJoZFDEgLQsFn4KntYdVLwoiZIH1Czy3DsJZrdRsPzzYRGI/RyIQEhvpg
         /NdDCDw9KbddvGZ0dG5IsrL41TiGjZz7V5uVLtZs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 42/92] CIFS: Fix credits calculation for cancelled requests
Date:   Mon, 18 Feb 2019 14:42:45 +0100
Message-Id: <20190218133458.644177463@linuxfoundation.org>
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

[ Upstream commit 8a26f0f781f56d3016b34a2217e346973d067e7b ]

If a request is cancelled, we can't assume that the server returns
1 credit back. Instead we need to wait for a response and process
the number of credits granted by the server.

Create a separate mid callback for cancelled request, parse the number
of credits in a response buffer and add them to the client's credits.
If the didn't get a response (no response buffer available) assume
0 credits granted. The latter most probably happens together with
session reconnect, so the client's credits are adjusted anyway.

Signed-off-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifsglob.h  |  1 +
 fs/cifs/transport.c | 28 ++++++++++++++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index 38ab0fca49e1..7a4fae0dc566 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -1426,6 +1426,7 @@ struct mid_q_entry {
 	int mid_state;	/* wish this were enum but can not pass to wait_event */
 	unsigned int mid_flags;
 	__le16 command;		/* smb command code */
+	unsigned int optype;	/* operation type */
 	bool large_buf:1;	/* if valid response, is pointer to large buf */
 	bool multiRsp:1;	/* multiple trans2 responses for one request  */
 	bool multiEnd:1;	/* both received */
diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
index d51064c1ba42..4dbf62bb51b2 100644
--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -785,6 +785,24 @@ cifs_noop_callback(struct mid_q_entry *mid)
 {
 }
 
+static void
+cifs_cancelled_callback(struct mid_q_entry *mid)
+{
+	struct TCP_Server_Info *server = mid->server;
+	unsigned int optype = mid->optype;
+	unsigned int credits_received = 0;
+
+	if (mid->mid_state == MID_RESPONSE_RECEIVED) {
+		if (mid->resp_buf)
+			credits_received = server->ops->get_credits(mid);
+		else
+			cifs_dbg(FYI, "Bad state for cancelled MID\n");
+	}
+
+	DeleteMidQEntry(mid);
+	add_credits(server, credits_received, optype);
+}
+
 int
 compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 		   const int flags, const int num_rqst, struct smb_rqst *rqst,
@@ -860,6 +878,7 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 		}
 
 		midQ[i]->mid_state = MID_REQUEST_SUBMITTED;
+		midQ[i]->optype = optype;
 		/*
 		 * We don't invoke the callback compounds unless it is the last
 		 * request.
@@ -894,15 +913,20 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 
 	for (i = 0; i < num_rqst; i++) {
 		rc = wait_for_response(ses->server, midQ[i]);
-		if (rc != 0) {
+		if (rc != 0)
+			break;
+	}
+	if (rc != 0) {
+		for (; i < num_rqst; i++) {
 			cifs_dbg(VFS, "Cancelling wait for mid %llu cmd: %d\n",
 				 midQ[i]->mid, le16_to_cpu(midQ[i]->command));
 			send_cancel(ses->server, &rqst[i], midQ[i]);
 			spin_lock(&GlobalMid_Lock);
 			if (midQ[i]->mid_state == MID_REQUEST_SUBMITTED) {
 				midQ[i]->mid_flags |= MID_WAIT_CANCELLED;
-				midQ[i]->callback = DeleteMidQEntry;
+				midQ[i]->callback = cifs_cancelled_callback;
 				cancelled_mid[i] = true;
+				credits[i] = 0;
 			}
 			spin_unlock(&GlobalMid_Lock);
 		}
-- 
2.19.1



