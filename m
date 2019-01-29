Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF245C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF8BC2086C
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762764;
	bh=nwT3rq+crU4ZFJMx/8Qr7ZZIRt27XwLYX/wl/wsWqkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Mx8S2cwX322OvHUrJ1RDV8VJORNVK90wcQ/P5sS4QHSLJbzCPcXJavgvqZpDoNM9U
	 LrAWxRrsobwODoQ420naRt+nyt7fITXA7lY/WPS/D48Mfn+ndO5BqaR4tXYtcW8QST
	 M6NI+9IuOAmVZ6QuNXb0BPIJ3VPJx2nEnyx5knVY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732160AbfA2Lwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:52:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:44550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731038AbfA2Lwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:52:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0745E2083B;
        Tue, 29 Jan 2019 11:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762760;
        bh=nwT3rq+crU4ZFJMx/8Qr7ZZIRt27XwLYX/wl/wsWqkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mhrGDO4QuRovvF/hw9st1I013xV+LwBE0CDr6q8EawhjNAAy5H4aCaTUQHPiLgkIf
         CMpdouI6Ohi712dMM8jgZVrOjH81QIsfgnZgGddFf5M4bgb8O4E/YRHPdhG6usuODI
         X+anq4iVdAfRs7TxJXoKyNHFn3Jrw9k/V8wkWBB0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Shilovsky <pshilov@microsoft.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.9 23/44] CIFS: Do not reconnect TCP session in add_credits()
Date:   Tue, 29 Jan 2019 12:36:18 +0100
Message-Id: <20190129113141.826517383@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113139.826927690@linuxfoundation.org>
References: <20190129113139.826927690@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -518,6 +518,21 @@ server_unresponsive(struct TCP_Server_In
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
@@ -530,6 +545,12 @@ cifs_readv_from_socket(struct TCP_Server
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
 
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -30,6 +30,7 @@
 #include "smb2glob.h"
 #include "cifs_ioctl.h"
 
+/* Change credits for different ops and return the total number of credits */
 static int
 change_conf(struct TCP_Server_Info *server)
 {
@@ -37,17 +38,15 @@ change_conf(struct TCP_Server_Info *serv
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
@@ -60,14 +59,15 @@ change_conf(struct TCP_Server_Info *serv
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
@@ -91,8 +91,26 @@ smb2_add_credits(struct TCP_Server_Info
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


