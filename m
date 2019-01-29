Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB130C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98DB22086C
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762301;
	bh=mphIRPgHB26QiReI0/c8OtQbSK+Wk46wRHH8IMRmzOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aHu3ZgmXRof3OwcGHdLT3J+KY6y65o8ri+U+DN8H5odnUH9ZyF702Rw7tG62bC0m1
	 XeL+k8FK0ow6jhhAUAD1P+Frk30g52iQxaxfys6G5WDgJoo+WbQzSk40EQvW0ztqLn
	 6TD6YHbHrUExsbZOqu2qitieeS5+QNQ4IKI5pRHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbfA2LpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:45:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:35304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730134AbfA2Loz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:44:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94F452086C;
        Tue, 29 Jan 2019 11:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762294;
        bh=mphIRPgHB26QiReI0/c8OtQbSK+Wk46wRHH8IMRmzOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KeVRhoTMloHJacPHL+LcRL4Ki5UABoIbnTQZpMkT8NSyj0PxE1bR3jq0B7jI01YDr
         WVtcwTMwJyC8NeWRXcUYY8SCbnDPK6kzV/UTn2E9bbxMMb4WCyqxpBWTNVV5DVVVNu
         HdCVBz93f3+0OeV+z36/cL8SkzXJcikUdQnLU4Q4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Shilovsky <pshilov@microsoft.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.19 056/103] CIFS: Do not reconnect TCP session in add_credits()
Date:   Tue, 29 Jan 2019 12:35:33 +0100
Message-Id: <20190129113204.039112727@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
References: <20190129113159.567154026@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Shilovsky <pshilov@microsoft.com>

commit ef68e831840c40c7d01b328b3c0f5d8c4796c232 upstream.

When executing add_credits() we currently call cifs_reconnect()
if the number of credits is zero and there are no requests in
flight. In this case we may call cifs_reconnect() recursively
twice and cause memory corruption given the following sequence
of functions:

mid1.callback() -> add_credits() -> cifs_reconnect() ->
-> mid2.callback() -> add_credits() -> cifs_reconnect().

Fix this by avoiding to call cifs_reconnect() in add_credits()
and checking for zero credits in the demultiplex thread.

Cc: <stable@vger.kernel.org>
Signed-off-by: Pavel Shilovsky <pshilov@microsoft.com>
Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/connect.c |   21 +++++++++++++++++++++
 fs/cifs/smb2ops.c |   32 +++++++++++++++++++++++++-------
 2 files changed, 46 insertions(+), 7 deletions(-)

--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -533,6 +533,21 @@ server_unresponsive(struct TCP_Server_In
 	return false;
 }
 
+static inline bool
+zero_credits(struct TCP_Server_Info *server)
+{
+	int val;
+
+	spin_lock(&server->req_lock);
+	val = server->credits + server->echo_credits + server->oplock_credits;
+	if (server->in_flight == 0 && val == 0) {
+		spin_unlock(&server->req_lock);
+		return true;
+	}
+	spin_unlock(&server->req_lock);
+	return false;
+}
+
 static int
 cifs_readv_from_socket(struct TCP_Server_Info *server, struct msghdr *smb_msg)
 {
@@ -545,6 +560,12 @@ cifs_readv_from_socket(struct TCP_Server
 	for (total_read = 0; msg_data_left(smb_msg); total_read += length) {
 		try_to_freeze();
 
+		/* reconnect if no credits and no requests in flight */
+		if (zero_credits(server)) {
+			cifs_reconnect(server);
+			return -ECONNABORTED;
+		}
+
 		if (server_unresponsive(server))
 			return -ECONNABORTED;
 		if (cifs_rdma_enabled(server) && server->smbd_conn)
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -34,6 +34,7 @@
 #include "cifs_ioctl.h"
 #include "smbdirect.h"
 
+/* Change credits for different ops and return the total number of credits */
 static int
 change_conf(struct TCP_Server_Info *server)
 {
@@ -41,17 +42,15 @@ change_conf(struct TCP_Server_Info *serv
 	server->oplock_credits = server->echo_credits = 0;
 	switch (server->credits) {
 	case 0:
-		return -1;
+		return 0;
 	case 1:
 		server->echoes = false;
 		server->oplocks = false;
-		cifs_dbg(VFS, "disabling echoes and oplocks\n");
 		break;
 	case 2:
 		server->echoes = true;
 		server->oplocks = false;
 		server->echo_credits = 1;
-		cifs_dbg(FYI, "disabling oplocks\n");
 		break;
 	default:
 		server->echoes = true;
@@ -64,14 +63,15 @@ change_conf(struct TCP_Server_Info *serv
 		server->echo_credits = 1;
 	}
 	server->credits -= server->echo_credits + server->oplock_credits;
-	return 0;
+	return server->credits + server->echo_credits + server->oplock_credits;
 }
 
 static void
 smb2_add_credits(struct TCP_Server_Info *server, const unsigned int add,
 		 const int optype)
 {
-	int *val, rc = 0;
+	int *val, rc = -1;
+
 	spin_lock(&server->req_lock);
 	val = server->ops->get_credits_field(server, optype);
 	*val += add;
@@ -95,8 +95,26 @@ smb2_add_credits(struct TCP_Server_Info
 	}
 	spin_unlock(&server->req_lock);
 	wake_up(&server->request_q);
-	if (rc)
-		cifs_reconnect(server);
+
+	if (server->tcpStatus == CifsNeedReconnect)
+		return;
+
+	switch (rc) {
+	case -1:
+		/* change_conf hasn't been executed */
+		break;
+	case 0:
+		cifs_dbg(VFS, "Possible client or server bug - zero credits\n");
+		break;
+	case 1:
+		cifs_dbg(VFS, "disabling echoes and oplocks\n");
+		break;
+	case 2:
+		cifs_dbg(FYI, "disabling oplocks\n");
+		break;
+	default:
+		cifs_dbg(FYI, "add %u credits total=%d\n", add, rc);
+	}
 }
 
 static void


