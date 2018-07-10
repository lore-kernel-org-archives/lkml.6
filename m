Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186F7C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC9A208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:35:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDC9A208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389478AbeGJSfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:35:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48240 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388810AbeGJSfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:35:13 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D5C03D0B;
        Tue, 10 Jul 2018 18:34:59 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paulo Alcantara <palcantara@suse.de>,
        Aurelien Aptel <aaptel@suse.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.17 22/56] cifs: Fix infinite loop when using hard mount option
Date:   Tue, 10 Jul 2018 20:25:04 +0200
Message-Id: <20180710182504.735642315@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182503.544433950@linuxfoundation.org>
References: <20180710182503.544433950@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paulo Alcantara <paulo@paulo.ac>

commit 7ffbe65578b44fafdef577a360eb0583929f7c6e upstream.

For every request we send, whether it is SMB1 or SMB2+, we attempt to
reconnect tcon (cifs_reconnect_tcon or smb2_reconnect) before carrying
out the request.

So, while server->tcpStatus != CifsNeedReconnect, we wait for the
reconnection to succeed on wait_event_interruptible_timeout(). If it
returns, that means that either the condition was evaluated to true, or
timeout elapsed, or it was interrupted by a signal.

Since we're not handling the case where the process woke up due to a
received signal (-ERESTARTSYS), the next call to
wait_event_interruptible_timeout() will _always_ fail and we end up
looping forever inside either cifs_reconnect_tcon() or smb2_reconnect().

Here's an example of how to trigger that:

$ mount.cifs //foo/share /mnt/test -o
username=foo,password=foo,vers=1.0,hard

(break connection to server before executing bellow cmd)
$ stat -f /mnt/test & sleep 140
[1] 2511

$ ps -aux -q 2511
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root      2511  0.0  0.0  12892  1008 pts/0    S    12:24   0:00 stat -f
/mnt/test

$ kill -9 2511

(wait for a while; process is stuck in the kernel)
$ ps -aux -q 2511
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root      2511 83.2  0.0  12892  1008 pts/0    R    12:24  30:01 stat -f
/mnt/test

By using 'hard' mount point means that cifs.ko will keep retrying
indefinitely, however we must allow the process to be killed otherwise
it would hang the system.

Signed-off-by: Paulo Alcantara <palcantara@suse.de>
Cc: stable@vger.kernel.org
Reviewed-by: Aurelien Aptel <aaptel@suse.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/cifssmb.c |   10 ++++++++--
 fs/cifs/smb2pdu.c |   18 ++++++++++++------
 2 files changed, 20 insertions(+), 8 deletions(-)

--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -151,8 +151,14 @@ cifs_reconnect_tcon(struct cifs_tcon *tc
 	 * greater than cifs socket timeout which is 7 seconds
 	 */
 	while (server->tcpStatus == CifsNeedReconnect) {
-		wait_event_interruptible_timeout(server->response_q,
-			(server->tcpStatus != CifsNeedReconnect), 10 * HZ);
+		rc = wait_event_interruptible_timeout(server->response_q,
+						      (server->tcpStatus != CifsNeedReconnect),
+						      10 * HZ);
+		if (rc < 0) {
+			cifs_dbg(FYI, "%s: aborting reconnect due to a received"
+				 " signal by the process\n", __func__);
+			return -ERESTARTSYS;
+		}
 
 		/* are we still trying to reconnect? */
 		if (server->tcpStatus != CifsNeedReconnect)
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -154,7 +154,7 @@ out:
 static int
 smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon)
 {
-	int rc = 0;
+	int rc;
 	struct nls_table *nls_codepage;
 	struct cifs_ses *ses;
 	struct TCP_Server_Info *server;
@@ -165,10 +165,10 @@ smb2_reconnect(__le16 smb2_command, stru
 	 * for those three - in the calling routine.
 	 */
 	if (tcon == NULL)
-		return rc;
+		return 0;
 
 	if (smb2_command == SMB2_TREE_CONNECT)
-		return rc;
+		return 0;
 
 	if (tcon->tidStatus == CifsExiting) {
 		/*
@@ -211,8 +211,14 @@ smb2_reconnect(__le16 smb2_command, stru
 			return -EAGAIN;
 		}
 
-		wait_event_interruptible_timeout(server->response_q,
-			(server->tcpStatus != CifsNeedReconnect), 10 * HZ);
+		rc = wait_event_interruptible_timeout(server->response_q,
+						      (server->tcpStatus != CifsNeedReconnect),
+						      10 * HZ);
+		if (rc < 0) {
+			cifs_dbg(FYI, "%s: aborting reconnect due to a received"
+				 " signal by the process\n", __func__);
+			return -ERESTARTSYS;
+		}
 
 		/* are we still trying to reconnect? */
 		if (server->tcpStatus != CifsNeedReconnect)
@@ -230,7 +236,7 @@ smb2_reconnect(__le16 smb2_command, stru
 	}
 
 	if (!tcon->ses->need_reconnect && !tcon->need_reconnect)
-		return rc;
+		return 0;
 
 	nls_codepage = load_nls_default();
 


