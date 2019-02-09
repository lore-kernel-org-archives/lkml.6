Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DC0C282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E440420643
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738531;
	bh=Zerpn27eNAW9SvlpQ6VEUadW3AyyOcHCFUSs5i5kM0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EWNRbdryv2a8XfubFjh2x0M/8fFTt9c3VBXUvCSU2F2JakG5Xn4dyC6SNe5xIr4kC
	 LucQLyLLkUB+bR0X1Th7OOMRKKFSpfiI0Jx2A3N2X6i00Y6QZuXaEHwwDBm6twh/8D
	 LclZ2+oYITUwpaVRDAIfW4x2p6aC2MYsZ0NICvjU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbfBISz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:55:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:33502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727713AbfBISsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:48:33 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CF8D2192C;
        Sat,  9 Feb 2019 18:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738112;
        bh=Zerpn27eNAW9SvlpQ6VEUadW3AyyOcHCFUSs5i5kM0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yHrZjJmBTTR6aN8ScsF/60uDg39Cl/Co2zjHlJU+4lr/zP3d0H0UtCI8urqZK2d/j
         llSFwGTlG/kJZpmfcx8vlu684cZ4k2I0rlUFHRySIBl+B8S9q4oDeiQU83lSlYwHmA
         /HMF6199E1b8z2D8rT/u7G0s6xioxUqUQwTuP3uM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, linux-cifs@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 39/42] CIFS: Fix credits calculation for cancelled requests
Date:   Sat,  9 Feb 2019 13:47:31 -0500
Message-Id: <20190209184734.125935-39-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190209184734.125935-1-sashal@kernel.org>
References: <20190209184734.125935-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Shilovsky <pshilov@microsoft.com>

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

